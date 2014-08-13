## Treetop Bot Templating

This repo is an in-process bot I'm working on that's not good yet but is about sticking computer graphics jaron into imagistic poetry.

It's also a project I'm using to learn about Treetop, the Ruby Parser Expression Grammar (PEG) library. I followed <a href="http://thingsaaronmade.com/blog/a-quick-intro-to-writing-a-parser-using-treetop.html">this excellent blog post</a> to get started.

So I collected a bunch of computer graphics jargon. I divided the words up into different files depending on their parts of speech: adj.txt, n.txt, v.txt. (Probably this could be done automatically with some part of speech tagging code.) Then my goal was to be able to create template sentences, extracted from poems, that I could use to generate new sentences by replacing words with my computer graphics jargon.

So I'd take a sentence like:

     Rage, rage against the dying of the light.

Mark it up with parts of speech like so:

    <v:Rage>, <v:rage> against the <v:dying> of the <n:light>.

Where I've marked out the words I might want to replace with their part of speech and their original value.

And then be able to swap in a word from my jaron lists with the appropraite POS to end up with something like this:

     Reflectance, radiance against the detection of the luma.

In code, then, the goal is to parse this format and return a structure that makes it easy to build a new sentence, knowing when you've got a tag and what POS/original word it was in that case.

And this is exactly what I've implemented here. The three files relevant to parsing are parser.rb (a helper class), node_extensions.rb (some node class sub-types with simple methods on them), and postemplate_parser.treetop (the grammar). parser.rb has the ruby code that calls Treetop with the other two files in order to produce a parser. You can see that parser in action in generate.rb which uses the results of parsing to generate new sentences.

Anyway, this is not generating the coolest ever text right now because it's a work-in-progress. But it is an example of how to use Treetop for something basic, but useful that's not parsing Lisp like all the examples show.

### Treetop Gotcha

The biggest gotcha on which I got stuck while working on this is that the order of rules in your grammar file matters a lot! Treetop applies the rules in the order that you define them. So if you have a low-level rule that will match lots of stuff near the top, once its starts being matched none of the other rules will even run. Therefore you need to have the most general/composite rules at the top and work down towards the more specific rules. No one ever seems to really say that in the blog posts/documentation I looked at though so I'm saying it here.
