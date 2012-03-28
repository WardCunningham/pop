Here we reformat XHTML from an epub document to JSON and publish it as an instance of the Smallest Federated Wiki.

Like Wiki?
==========

You will want to look at the structure of the `convert.rb` script.
It consists of helper functions that create fragments of JSON for various paragraph types.
It includes Nokogiri parsing and queries that reads one specific document.
This will only suggest how you might crack the style codes used should you have a similar need.

Like Agile?
===========

The first wiki was built for sharing and enlarging a body of patterns.
We're promoting Joseph Bergin's Agile Software: Patterns of Practice by creating a new wiki about his book.
Federation, enabled by CC licensing, was the missing element of the first pattern wiki.
