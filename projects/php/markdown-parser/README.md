Created in 2016.

# Markdown parser

Create a parser that takes a given input and converts it to some output using some of the standard MarkDown components and some special flavor.

Parser has the following components:
* The paragraph behaviour is the same as in the normal MarkDown (Read up on it [here](https://daringfireball.net/projects/markdown/syntax#p))
* `[linked text](URL)` that will be converted to `<a href="URL">linked text</a>`
* `# Some text` that will be converted to `<h1>Some text</h1>`
* `## Some text #2` that will be converted to `<h2>Some text #2</h2>`
* `___EAT___` that will be converted to `<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/0/03/Broccoli_and_cross_section_edit.jpg/320px-Broccoli_and_cross_section_edit.jpg" title="Broccoli is yummy!" alt="A lovely picture of broccoli" />`
