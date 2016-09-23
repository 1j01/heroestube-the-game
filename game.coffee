
Shuffle = window.shuffle

mkvid = ->
	vid = document.createElement("div")
	vid.className = "vid"
	# flag = document.createElement("div")
	# flag.className = "flag"
	# flag.textContent = "✓"
	# vid.appendChild(flag)
	document.querySelector(".vid-grid").appendChild(vid)

for i in [0..10]
	mkvid()

$grid = $(".vid-grid")

shuffle = new Shuffle $grid[0],
	itemSelector: '.vid'
	speed: 250
	easing: 'ease'
	gutterWidth: 40

points = 0

$grid.click ".vid", (e)->
	$vid = $(e.target).closest(".vid")
	
	$vid.addClass("flagged")
	
	setTimeout ->
		shuffle.remove($vid)
	, 2000
