---
title: Poorops
description: Deploying services on a budget
slug: "poorops"
date: "2022-11-23"
draft: false
tags:
  - devbot
---

I'm a frugal person by design. I abhor recurrent costs like netflix, so it comes to no surprise that when I try to deploy new things I try to wriggle out
of any financial commitment my code asks of me. <!--more-->

Ex.

- gradle build can't build on my $6 dollar vm, so build it on github and download the fat jar (for java apps)
- the xml files are 1.2Gb big, so instead of getting a bigger machine, get into stream-parsing and hyper-focus on getting ram usage down.
- keep the other services on the vm running (nothing critical of course)

So what do you do on a budget, you start to see if there are better ways, even if they are a bit improvised.

- Solving the build-problem is easy enough. Github allows you to create a build pipeline that is gradle-enabled. Just push a new release every time you create something.
- Shifting programming from full parsing to stream-parsing is a post in itself. The work is more involved, but feels like solving an [advent of code](adventofcode.com) problem.
- The hardest part is the deployment-step. If you build locally, you know where the artifact (your jar / exe / whatever) will be built, but now you need to download it as an extra step in your chosen deployment environment.

Just suffice to say it's a lot of work, but it saves ~15$ a month. So I can't complain.
