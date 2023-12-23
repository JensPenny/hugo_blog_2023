---
title: "Thoughts on Diataxis"
description: "Bringing order to chaos"
date: "2023-12-23"
slug: "diataxis-thoughts"
tags:
  - "devbot"
  - "documentation"
draft: false
showToc: true
TocOpen: true
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
cover:
  image: "images/messy_desk.jpg" # image path/url
  alt: "a very messy desk" # alt text
  caption: "<text>" # display caption under cover
  relative: false # when using page bundles set this to true
  hidden: true # only hide on current single page
# editPost:
#   URL: "https://github.com/<path_to_repo>/content"
#   Text: "Suggest Changes" # edit text
#   appendFilePath: true # to append file path to Edit link
---

I have been using the [Diataxis](https://diataxis.fr/) framework to write technical documentation for a while now, and I feel like it's come to a point where it is useful to share a couple of thoughts on this. I'm not planning to re-explain all the concepts. For this you should just read the former link, or any other blog that explains the framework more in depth than I am willing to, but I do want to give an actual opinion on how it works, what it does well and what it is not.

## What is diataxis

Diataxis provides a framework that helps with the _structure_, _content_ and _style_ of technical documentation. It does this by segmenting documentation in four categories:

- Tutorials
- How-to guides
- Explanations
- References

By splitting documentation in these categories, it provides tips and examples on what to do for each type of documentation. Every type of documentation has it's own target audience and purpose, so the content for each type will differ slightly. Others, like another blog [^1] and the [official site](https://diataxis.fr/) have a more in depth explanation of the what and the how.

## How is diataxis useful

The most useful effect of applying Diataxis is that it makes you think about the **purpose** of your documentation. In return it also helps with a basic **structure** that you can use in your documentation.  
The purpose helps you focus on the content of the article. Most of the documentation I am writing at the moment are how-to guides and explanations. For a how-to page you'll tend to just focus on the **how** of solving a problem, instead of trying to explain **why** the problem exists. If while writing you feel like an explanation is in order, you can always segment it off in another page.  
The structure gives you a way to start your page, which is in a lot of ways half the battle. Once you get started and when the structure of your article is clear, filling in the segments becomes easier.

## Effects

A very noticeable effect is that you'll have a lot more pages in your wiki. It might feel that this makes information more fragmented, but in my opinion the opposite happens. Search will group relevant pages. If you then label these pages with the diataxis category it becomes peanuts to find them again.  
The second effect that is related is that your pages will be a lot smaller. I used to have the feeling that a page needs to have a lot of content to be useful, but by focussing the information in an article you'll actually find stuff faster in the end. Your pages will also grow over time.  
The most common anti-pattern to expanding these pages is that you'll be tempted to add explanations or references to pages that don't need these. This means you'll have to tend these pages like a garden. Explanations that you or others add to non-explanation-pages should be aggressively pruned.

[^1]: [Id rather be writing blog](https://idratherbewriting.com/blog/what-is-diataxis-documentation-framework#what-is-di%C3%A1taxis)
