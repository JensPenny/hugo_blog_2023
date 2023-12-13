---
title: Developer hostile documentation
description: A tale of spoons and drills
createdAt: "2022-11-14"
draft: true #needs reread
tags:
  - devbot
---

<!-- of gewoon titel wijzigen naar kritiek op belgische healthcare std? -->

Some documentation is clearly better than other. But what actually makes 'bad' documentation? Is it build issues? Incompleteness? Pretty moving gifs in a blog post?<!--more-->
The thing is that it's easier to say what not to do than what to do, but for the sake of discussion I'll at least try. The first example I will use is the documentation for the belgian medication database, that I had the joy to learn to know deeply due to a [small personal project](https://github.com/JensPenny/SamToSqlite). The documentation for these files can be found at [the sam portal site](https://www.samportal.be/nl/sam/documentation).

The second example are the documentation for the [dm+d documentation](https://services.nhsbsa.nhs.uk/dmd-browser/help-page) and a couple of [NHS services](https://digital.nhs.uk/services/electronic-prescription-service/developer-resources-for-eps). I haven't implemented these, but I can read and compare the two.

There are multiple things wrong with the SAM-model:

- The conceptual model does not really map on the actual documentation. For example: an AMPP signifies an **A**ctual **M**edicinal **P**roduct **P**ackaging. There are multiple actors that contribute information here, but instead of uniformizing this information the AMPP gets spread out over 4 tables, each with their own _validFrom_ and _validTo_ dates.
- This means that the documentation diverges from the actual files and their parsing.
- The data is repeated a lot, which inflates the size of the XML. Good luck when trying to pull this in memory without skipping irrelevant parts.

There are more things wrong with the data, but I'll keep it at this for now. The issue is that we should expect better than token implementations. Things are improving, and all software is patched together at some level, but I dare anyone to try and make sense of this export.
