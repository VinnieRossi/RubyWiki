# RubyWiki
A small game that determines how many links you must click from a given wiki page to another wiki page

## How it works
I currently use two variables. One lists the starting page, and the other lists the ending page.
Using Nokogiri, I visit the original page and grab all of the links off the starting page. If the ending page link isn't
found in the array, I then visit every link within the array and add all of its' links to the array.

As expected, it takes a very long time to complete. This is due to having to navigate to the page and download/parse the html.
It can currently process roughly 1k links/second. For some of the deeper depths, this ends up being about 9 minutes (570k links).
Some pages have 1k links alone, so the expansion of the array is pretty crazy.

I want to end up having the entire path from the start page to the end page, but that will probably require a tree. I'll get to it later.