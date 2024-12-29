---
title: "Updating Hugo on Digitalocean Spaces"
description: "Digitalocean spaces and out-of-date buildpacks"
date: "2024-12-30"
slug: "updating-hugo-on-digitalocean"
tags:
  - "devbot"
  - "hosting"
draft: false
showToc: true
TocOpen: false
hidemeta: false
comments: false
# canonicalURL: "https://canonical.url/to/page"
# disableHLJS: false # to disable highlightjs
disableShare: false
hideSummary: false
searchHidden: true
ShowReadingTime: true
ShowBreadCrumbs: true
ShowPostNavLinks: true
ShowWordCount: true
ShowRssButtonInSectionTermList: true
UseHugoToc: true
# cover:
#   image: "<image path/url>" # image path/url
#   alt: "<alt text>" # alt text
#   caption: "<text>" # display caption under cover
#   relative: false # when using page bundles set this to true
#   hidden: true # only hide on current single page
# editPost:
#   URL: "https://github.com/<path_to_repo>/content"
#   Text: "Suggest Changes" # edit text
#   appendFilePath: true # to append file path to Edit link
---

Once in a blue moon I check if older projects still work.
When updating this blog, I got greeted by this message: 

<img src="images/error-mail.png"></img>

Damn you `My Team`, and the unwillingness to fix these errors.</br>
Either way: I'm putting some time aside to fix this while the daughters watch Frozen, so let's get to it. They're building a snowman already.

## Checking if there is a new build pack

Normally, updating the default build pack should fix this. So lets see if there is a new one:
<img src="images/buildpack-version.png"></img>

Alrighty! Let's check the hugo version we are running.
The command `hugo version` yields `hugo v0.140.1-a9b0b95ef402a1cc70bc5386d649d947e2bcc027+extended`. 
There might be some confusion on the versioning, but 1.9.1 is **not** the version of hugo.</br>
It is the version of the build pack. This version uses `hugo v0.125.2` as last available version.

## The solution

Digitalocean apps get built in one of two ways:
1. Use a default build pack
2. Include a docker image that builds your site

After this issue with build packs, I know I will always include a dockerfile to get this built.

``` dockerfile
FROM hugomods/hugo:exts

COPY . /src
# Build commands: https://gohugo.io/commands/hugo_build/
RUN hugo build --minify 
```

We use the hugomods images, since these look pretty comprehensive.
There is nothing holding you back from using alpine and installing hugo yourself though. 
The `hugo:exts` image has a lot of extra's like postCSS also included, so this should cover most cases.
`docker build .` builds your site.

## Deploying the dockerfile

