
P1
	- Repair missing content on the frontpage and indexes
	- Think about what to do with media (images, then video and audio)
	- Cucumber tests. Write some.
	- Fix error handling of bad open() responses - 4xx, 5xx
	- Write a view helper to emulate mod_include for embedding JS/CSS inline from the ./public directory
		- ... or invent a rack middleware to expand <script> tags
	- Implement a post-load content using ?secondary and ?embed
	- Make upscaling images connection speed dependent
	
P2
	- The sub-indexes (Eg, Scotland Politics, Scotland Business) are missing
	- Redraw the sectional navigation & search to be more like the NY Times.
	- Implement JAMMIT to optimize the assets
	- Write a Rake file to deploy & test
	
DONE
	- Add .nolayout to all requests (to remove the layout)
	- Repair missing/unstructured content on the articles - puff boxes etc.
	- Add util methods to News module to filter cps v5 and non-news links.


	