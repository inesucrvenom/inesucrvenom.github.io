---
title: Few simple functions (AWS Lambda, Python, Ansible)
image: assets/code.png
---
Learning project to grasp some new topics (serverless development, automatic deployment); while improving others (testing, handling errors and exceptions, general Python skills).

Before this assignment I didn't have a clue what AWS Lambda is or how to use it.
After roughly 3 weeks of research and work on it, I'm proud with the result.
> Repo: [mathfun](https://github.com/inesucrvenom/mathfun).

## Research flow and decisions
### To framework or not to framework...
Big part of research was to figure out how to start and how to deploy lambdas.
I've found suggestions for frameworks like serverless and chalice, but they just didn't seemed right for my case.
I had to do several trivial functions, and it just didn't make sense to have a ton of generated/imported code for such trivial tasks. Also that would imply that each function I have to implement basically becomes full project. Again, overkill in my mind. I definitely see the purpose of frameworks like these, but they looked like a bringing a moving truck for a thing that can be blown away from the table.

Second available option was to zip and upload whenever I need to deploy function. OK, that would mean have as many zip files as I have functions, and create them whenever I make changes and upload them in browser. That part looked too tedious and I wasn't looking forward to it.

After some digging I opted for Ansible. It wasn't easiest to figure out how to create zip files for each lambda function as opposed to zipping entire working directory, but I've managed to figure that out.

That enabled me to have clean deployment without hassle, and made me focus on debugging knowing that I'm not at a risk of introducing errors due to forgetting to zip something before upload and similar trivial errors.

### I want tests, but how to do that?
I overdid it, I know. It just didn't seem fair not to have same type of tests for each function implementation or between functions. :rofl:
I could remove some which test the results in the normal range, but my development was test driven in some parts, so for some cases I didn't know what to expect between my local machine and AWS, and I wanted to compare execution times.

#### D.R.Y.
I'm lazy. In terms that I'm reluctant to copy paste and edit when there's more than 3 lines to keep an eye on it, because I know errors can happen, and debugging that won't be fun.
So I've rather spend several days figuring out how I can reuse tests between different implementations for the same function. It was tricky, but it was worth it. I've ensured that not only I avoid c/p errors, but also, that it's more maintainable - be it with extending with different implementations, or using the idea for implementing new functions.

## Final thoughts
The most of the time I've needed for this project was spend on reading and thinking about decisions and reasons for them. Also, learning about new things and how they work exactly.
Once I made up my mind and had convinced myself why I want something, coding it and polishing went relatively fast.
Or in short - if project has decent documentation / how-to's / guides or tutorials plus helping teammates, it all can be incredibly faster.
