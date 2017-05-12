---
layout: post
title:  "Thoughts after one semester"
date:   2017-05-12 14:43:36 -0700
categories:
permalink: /post/:year/:month/:day/:slug
---
Well, so far the blog for this project is mighty sparse. We used Tin in the Spring semester for the course Programming for Media Arts. Here are some thoughts about the framework based on that experience.

Overall, the semester was a solid success. However, there are many, many things to improve.

#### Generics are confusing to beginners

It was a mistake to make so much use of Swift Generics. A primary motivation in the use of so many generic types was to reduce the number of type decisions that students might need to make, and to thus reduce some friction (or confusion) from the use of some methods. It did not turn out that way. In reality, it simply replaced one possible error (using the wrong type) with another error (using inconsistent types). And its possible that the error message for using the wrong type is easier to understand than the error message for inconsistent types used with a generic function.

#### CGFloat causes unecessary extra confusion

Its very easy to end up with a CGFloat value, because of use of an api that uses CGFloat, then have other values that are Double or Int because of default type inference. This was a very common cause of confusion, and it feels very unnecesary.

Since the floating point type for type inference is Double, I'm currently thinking that the correct answer is to use Double whenever possible. This possibly wouldn't be the correct answer if peformance was the primary concern. However, our primary concern is simplicity and clarity for new programmers.

#### Too much code in a view isn't flexible

I think it was wrong to put the setup and update methods into TView, a subclass of NSView. Originally, it felt like this led to a pattern that matched Processing, and provided such a simple workflow for an interactive program. Upon further reflection, it looks like we should look at other examples in macOS frameworks, such as NSViewController or perhaps SKScene. In fact, it seems obvious now that perhaps following some conventions, or at least directions of SpriteKit might be a wise.

The apis should make it easy to write a few lines of code to specify the creation of a window at a certain size. It would be best to avoid the need to open a storyboard. The need to open Main.storyboard, and navigate to several different locations to edit a handful of attributes opens up a large number of details. In our class, it felt like a huge early reveal of complexity. It requires quite a bit of explaination to coherently describe this big new apparatus. And then we really are not going to use that mechanism.

#### Too much tin.blah
I think it was wrong to bundle the drawing functions inside the Tin object, instead of making a collection of global functions. Again, the intention was to simplify their use bundling them with this object. However, instead I think that this was initially confusing to many students. Of course, I can't truly be certain that the global functions would be less confusing - but that is my current impression.


#### What's next?
I'm planning to experiment with a branch that addresses all of these issues, so that I can do tests to see how possible solutions feel.


