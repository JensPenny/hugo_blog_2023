---
title: "Sandbox"
description: "Doing what is necessary"
date: "2021-07-02"
slug: "sandbox"
draft: true
tags:
  - devbot
  - dadbod
  - test
---

# Testing zone

`testor crestor`

```js
const http = require("http");
const bodyParser = require("body-parser");

http
  .createServer((req, res) => {
    bodyParser.parse(req, (error, body) => {
      res.end(body);
    });
  })
  .listen(3000);
```

Here's a simple footnote,[^1] and here's a longer one.[^bignote]

[^1]: This is the first footnote.
[^bignote]: Here's one with multiple paragraphs and code.

    Indent paragraphs to include them in the footnote.

    `{ my code }`

    Add as many paragraphs as you like.

| Code                        | Meaning English                   | System | Code            | Comments                                                           |
| --------------------------- | --------------------------------- | ------ | --------------- | ------------------------------------------------------------------ |
| 1                           | 5 ml                              | ucum   | 5.mL            | Deprecate – 2 times 5 ml is clumsy to use                          |
| 2                           | amp.                              | snomed | 732978007       |                                                                    |
| 3                           | applic.                           | snomed | 732980001       |                                                                    |
| 4                           | caps.                             | snomed | 732937005       |                                                                    |
| 5                           | compr.                            | snomed | 732936001       | Tablet                                                             |
| 6                           | dosis                             | snomed | 604181000001109 | Unit dose                                                          |
| 7                           | drops                             | snomed | 732994000       |                                                                    |
| 8                           | flac.                             | snomed | 733026001       | vial                                                               |
| 9                           | implant                           | snomed | 732996003       |                                                                    |
| 10                          | perfusion                         | snomed |                 | is this a dose form?                                               |
| 11                          | inhal.                            | snomed |                 | Inhaler or inhalation?                                             |
| 12                          | insert                            | snomed | 732998002       |                                                                    |
| 13                          | chewing gum                       | snomed | 732989000       |                                                                    |
| 14                          | compress(es)                      | snomed | 732993006       | Dressing                                                           |
| 15                          | lav.                              | snomed |                 | Unknown what this means                                            |
| 16                          | ml                                | ucum   | ml              |                                                                    |
| 17                          | ov.                               |        |                 | Unknown what this means                                            |
| 18                          | pearl(s)                          | snomed | 733008004       | Pillule                                                            |
| 19                          | pastille                          | snomed | 733004002       |                                                                    |
| 20                          | patch                             | snomed | 733005001       |                                                                    |
| 21                          | cart.                             | snomed | 732988008       |                                                                    |
| 22                          | pen                               | snomed | 733006000       |                                                                    |
| 23                          | puff(s)                           | snomed |                 | use dose form? Or inhaler?                                         |
| 24                          | sponge                            | snomed | 733014006       |                                                                    |
| 00025 (deprecated)          | stylo                             | snomed |                 | deprecate                                                          |
| 26                          | suppo                             | snomed | 733019001       |                                                                    |
| 27                          | tube                              | snomed | 733024003       |                                                                    |
| 28                          | wick                              | snomed | 733023009       | used thread, could be tampon?                                      |
| 29                          | bag                               | snomed | 732982009       |                                                                    |
| 30                          | bag(s)                            | snomed | 732982009       | deprecate?                                                         |
| cm                          | centimeter                        | ucum   | cm              |                                                                    |
| dropsperminute (deprecated) | drops per minute                  |        |                 | Deprecate – posology                                               |
| gm                          | gram                              | ucum   |                 |                                                                    |
| internationalunits          | international units               | ucum   | iU              |                                                                    |
| mck/h (deprecated)          | microgram per hour                |        |                 | Deprecate – posology                                               |
| mck/kg/minute (deprecated)  | microgram per kilogram per minute |        |                 | Deprecate – posology                                               |
| measure (deprecated)        | measure                           |        |                 | Deprecate – posology                                               |
| mg/h (deprecated)           | milligram per hour                |        |                 | Deprecate – posology                                               |
| ml/h (deprecated)           | milliliter per hour               |        |                 | Deprecate – posology                                               |
| tbl                         | tablespoon                        | ucum   | [tbs_m]         | Metric tablespoon                                                  |
| tsp                         | teaspoon                          | ucum   | [tsp_m]         | Metric teaspoon                                                    |
| unt/h (deprecated)          | units per hour                    |        |                 | Deprecate – posology                                               |
| mg                          | milligram                         | ucum   | mg              |                                                                    |
| mg/ml (deprecated)          | milligram per milliliter          |        |                 | Deprecate – posology                                               |
| meq                         | milli-equivalent                  | ucum   | meq             |                                                                    |
| miu                         | miu                               | ucum   | m[iU]           |                                                                    |
| iu                          | iu                                | ucum   | iU              | international unit                                                 |
| mmol                        | millimol                          | ucum   | mmol            |                                                                    |
| effervescent-tablet         | effervescent tablet               | snomed | 732936001       | Tablet – fhir dose form might have something closer                |
| micrograms                  | micrograms                        | ucum   | ug              | Translate to mcg in display! Gets confused with mg or ng otherwise |
| bandage                     | bandage                           | snomed | 733005001       | patch                                                              |
| piece                       | piece                             | snomed | 604181000001109 | Unit dose                                                          |
| box                         | box                               | snomed |                 | Deprecate? When do you administer a box?                           |
| liter                       | liter                             | ucum   | L               |                                                                    |
| syringe                     | syringe                           | snomed | 733020007       |                                                                    |
| ampoule                     | ampoule                           | snomed | 732978007       |                                                                    |
| bottle                      | bottle                            | snomed | 732986007       |                                                                    |
| syringe-ampoule             | syringe ampoule                   | snomed |                 | Deprecate or create – unclear what this is                         |
