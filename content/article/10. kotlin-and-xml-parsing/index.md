---
title: "Moving data from XML to sqlite"
description: "With kotlin, exposed and fasterXml"
slug: "kotlin-xml-parsing"
createdAt: "2022-11-12"
draft: false # needs reread
tags:
  - devbot
---

I've done a small project to parse a big xml file, and save the structured objects into a sqlite database for easier migration. <!-- more -->
The idea is that I absolutely detest xml exports, and that reasoning about data is still easier in their database-formats. Especially if you want
others to use the same data.  
The export to sqlite is because its a good, compact format, and because it migrates pretty well to other databases like postgres.

First things first: the project itself is at [this github page](https://github.com/JensPenny/SamToSqlite).  
The use-case is as follows:

- The Belgian medical database is spread over a couple of xml files as export. One of the files gets as big as 1.1Gb, since all history also gets exported.
  - They offer a delta as well, but you still need to do the full export once, and otherwise keep state for the delta, so why bother if you can do a full export fast-ish.
- This is different from a couple of other standards, where they are csv-based exports or just txt-files with reserved spots for columns.
- While the idea is to just use the objects that you need from the xml, in practice this almost always means you have to parse it, and it's cojoining xml files as well for the use-case you need.
- I have observed people writing 2-3 ways to parse this data, so I figured one more wouldn't hurt.
- Having read the docs, it's a miracle anyone gets this parsed either way, so I could assist with this as well.

So now for the actual details on technologies used:

- I used kotlin as language. The nullability-options in the language itself made checking for inconsistencies between actual xml data, and documented table structures a breeze.
- I used [exposed](https://github.com/JetBrains/Exposed) as an intermediate to the database. It exports to multiple other databases, and the DSL they use makes defining the tables easy.
- Finally, we use [fasterxml](https://github.com/FasterXML/jackson) to parse the xml part by part. Pushing 1.1Gb into memory is a bit wasteful.

1. Creating the tables
   This step can happen later as well, based on the xml and fields you're parsing.  
   For example: The reference table for WADA descriptions is as follows:  
   | Name | Type | Opt? | Description |
   |---|---|---|---|
   | Code | String(10) | No | International standard number given by the WADA institution1 that categorizes medicinal products according to harmonized anti-doping policies. Ex. : ‘A’, ‘B’, ‘AO’, ‘Hman’. |
   | Name (translations) | String(255) | No | Name of the WADA code.
   This field is translated in French, Dutch, German and English.
   French and Dutch versions are mandatory and others are optional.|
   | Description(translations) | Text | Yes | Description of the WADA Code.
   This field is translated in French, Dutch, German and English.
   French and Dutch versions are mandatory and others are optional. |

This translates to the following code-block:

```java
    //World Anti-doping Agency
    object WADA : IntIdTable("WADA") {
        val code = varchar("code", 10)

        val nameNl = varchar("nameNl", 255)
        val nameFr = varchar("nameFr", 255)
        val nameGer = varchar("nameGer", 255).nullable()
        val nameEng = varchar("nameEng", 255).nullable()

        val descriptionNl = text("descriptionNl").nullable()
        val descriptionFr = text("descriptionFr").nullable()
        val descriptionGer = text("descriptionGer").nullable()
        val descriptionEng = text("descriptionEng").nullable()
    }

        //Create table
    private fun createReferenceTables() {
        transaction {
            drop(
                ReferenceTableModel.WADA,
                inBatch = true
            )

            create(
                ReferenceTableModel.WADA,
                inBatch = true
            )
        }
    }
```

In this phase we define the tables we want, and where we will dump the data. 2. Mirroring the XML as object
Next up we define our XML as an object. As an example we'll use this XML definition:

```xml
    <Wada code="A">
        <Name>
            <ns2:Fr>A: Anabolisants, interdits en toutes circonstances.</ns2:Fr>
            <ns2:Nl>A: Anabolica, te allen tijde verboden.</ns2:Nl>
        </Name>
        <Description>
            <ns2:Fr>Ce médicament contient une substance interdite appartenant à la catégorie des anabolisants.   Ce médicament contient au moins une substance toujours interdite (que ce soit dans le cadre ou non d’une compétition). Si vous devez prendre ce médicament pour des raisons médicales, une AUT est nécessaire.</ns2:Fr>
            <ns2:Nl>Dit geneesmiddel bevat een verboden stof die deel uitmaakt van de categorie anabole middelen.  Dit geneesmiddel bevat minstens één stof die altijd verboden is (zowel binnen als buiten wedstrijdverband). Als u dit geneesmiddel om medische redenen moet nemen, is een TTN vereist.</ns2:Nl>
        </Description>
    </Wada>
```

There are a couple of jackson annotations that are useful here:

- **@JsonRootName("tag")**: defined over the data object. This will map on the root-level element that you want to map to.
- **@set:JsonProperty("tag")**: The attribute or the property that can get mapped. The set defines that this will be used as a setter. A JsonProperty can also be a subelement, but only if it doesn't have attributes or subelements of its own.
- **@set:JsonAlias("dataclass-name", "tag")**: Maps to a sub-object that you define. You can define sub-elements in this manner.
- **@set:JacksonXmlText**: A tag we use for content if there are tags with an attribute and content. For example: `<Strength unit="mg">2.000</Strength>`. The JacksonXmlText property needs to have the exact same name as the element, for some weird reason. So in this case:

```java
@set:JacksonXmlText
var Strength: String?,
```

The whole object looks like this in kotlin:

```java
@JsonRootName("Wada")
data class Wada(
    @set:JsonProperty("code")
    var code: String,

    @set:JsonAlias("TranslatedData", "Name")
    var name: TranslatedData,

    @set:JsonAlias("TranslatedData", "Description")
    var description: TranslatedData?,
)

/**
 * Holder object for common xml parts that can have translations
 */
data class TranslatedData(
    @set:JsonProperty("ns2:Nl")
    var nl: String? = null,
    @set:JsonProperty("ns2:Fr")
    var fr: String? = null,
    @set:JsonProperty("ns2:En")
    var en: String? = null,
    @set:JsonProperty("ns2:De")
    var de: String? = null,
)
```

There is a WADA object that will encompass the whole tag. Since there are more of these translated fields, I broke this off in another data class.
This data class does not need a `@JsonRootName` element, since we refer to the element that needs to be filled in in the `@set:JsonAlias` part of the definition. 3. Creating the XML Mapper
We use a couple of functions to create an xml inputfactory and xml-mapper that will fill in the data.

```java
fun createXmlInputFactory(): XMLInputFactory {
    val inputFactory = XmlFactory.builder().xmlInputFactory()
    inputFactory.setProperty(XMLInputFactory.IS_NAMESPACE_AWARE, false)
    return inputFactory
}

fun createXmlMapper(inputFactory: XMLInputFactory?): ObjectMapper {
    return XmlMapper.builder(XmlFactory(inputFactory, WstxOutputFactory()))
        .configure(MapperFeature.ACCEPT_CASE_INSENSITIVE_ENUMS, true)
        .configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false)
        .addModule(JacksonXmlModule())
        .defaultUseWrapper(false)
        .build()
        .registerKotlinModule()
}
```

This code took a while to get working, especially with creating the mapper based on the input-factory in kotlin. The properties that we define make sure that we don't fail on unmapped properties. This might be useful in some exports, but here we'd like to reliably do an export, regardless if there are new fields. We can easily add these later. 4. Mapping the data and exporting this through Exposed
I'm going to assume that you can get the tag that you need objectified out. So for wada the code looks like this:

```java
val wada = xmlMapper.readValue<Wada>(wadaString)
transaction{
    ReferenceTableModel.WADA.insert {
        it[code] = wada.code

        it[nameNl] = wada.name.nl!!
        it[nameFr] = wada.name.fr!!
        it[nameEng] = wada.name.en
        it[nameGer] = wada.name.de

        it[descriptionNl] = wada.description?.nl
        it[descriptionFr] = wada.description?.fr
        it[descriptionEng] = wada.description?.en
        it[descriptionGer] = wada.description?.de
    }
}
```

The first part maps the xml on the WADA data class. This is for a large part fasterxml-magic, but most error messages here are pretty clear.

The second part wraps an insert in an exposed-transaction, and will export this to whatever database is connected.

## The advantages

When developing this I felt that this was a pretty good way to dump xml-files in SQL through an ORM. The big part is that the nullability helps you in the mapping of the properties.  
If the table-object defines something as non-nullable, you'll get a compilation error.  
If an xml property is not optional according through the documentation, and you define the data-class s such, you'll get a Runtime error when the object gets parsed.
