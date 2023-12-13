---
title: "Getting threejs up and stumbling"
slug: "threes"
description: "Learning the javascript/npm ecosystem, one library at the time"
date: "2021-09-14"
draft: false
tags:
  - devbot
  - three.js
cover:
  image: "images/three_cover.png" # image path/url
  alt: "The count counting to three" # alt text
  # caption: "" # display caption under cover
  # relative: true # when using page bundles set this to true
  # hidden: false # only hide on current single page
---

Most of the time I tend to stumble in a side-project. I stumbled into vue, stumbled into nuxt and at this moment, I decided to check out a bit of threejs. Initially, I thought this was a case of just using `npm i three` and start developing, but boy, whas I wrong. <!--more-->  
In that regard: this isn't a post about getting threejs up and running. For that matter I actually made a [small repository](https://github.com/JensPenny/threejs_scaffolding) based on [another scaffolding project](https://github.com/brandflugan/three-js-webpack-boilerplate) I found.  
No, this is a post about learning of tooling and stuff I pretty much took for granted. Namely the bundling, and all the other weird config files you may find in a typical javascript project.

### Putting the i in install

..there was the assumption that I could just npm my problems away, just like I did in literally all other vue projects (including this blog by the way). So I started with that. What followed was a deluge of errors: some easier to fix (make your node project a module pls), some entirely cryptic for a node beginner like me. I was not going to force my way into this thing building, so I'd better take a step back and see how the cookie gets made.

### Putting the webpack in build

A bit miffed that my brute force approach didn't work, I started reading [the official threejs documentation](https://threejs.org/docs/#manual/en/introduction/Installation).

> You can install three.js with npm and modern build tools, or get started quickly with just static hosting or a CDN. For most users, installing from npm is the best choice.

Alright! At least I'm already making the -**BEST**- choices.

> All methods of installing three.js depend on ES modules (see Eloquent JavaScript: ECMAScript Modules), which allow you to include only the parts of the library needed in the final project.

I have actually read this book, but I reread the part about modules like a good programmer. This line kind of gives it away:

> So it is not uncommon for the code that you find in an NPM package or that runs on a web page to have gone through multiple stages of transformation—converted from modern JavaScript to historic JavaScript, from ES module format to CommonJS, bundled, and minified. We won’t go into the details of these tools in this book since they tend to be boring and change rapidly. Just be aware that the JavaScript code you run is often not the code as it was written.

This actually triggered the slow part of my brain. Of course some weird build process had to run to actually compile this. I did an advent of code in pure javascript, and you can get pretty far with just typing random stuff into an html page (or in a dev console, like some colleagues do), but you can't just faceroll npm / prettier / whatever and just expect the stuff to work. For my nuxt-escapades I also needed a nuxt.config.js, so this will probably have something else.

> When installing from npm, you'll almost always use some sort of bundling tool to combine all of the packages your project requires into a single JavaScript file. While any modern JavaScript bundler can be used with three.js, the most popular choice is webpack.

Alright website, **_you win_**. I will dutifully learn about webpack, read the docs, and then find a github repo where I can reassemble and base the webpack.config.js file from.

From there on out it was pretty simple. I just updated all npm modules, created a webpack-4 file for a webpack-5 project, learned that some keyword (devserver:{ contentBase:...) was renamed (devserver:{ static :{ directory... ), and could just npm start again.  
I still don't know everything, like the plugin system for webpack, but I'm actually glad I powered through this to at least get this working. The result is the scaffolding project that I now use for small three.js applications.
