
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

$grid.on "mousedown", ".vid", (e)->
	e.preventDefault()
	$vid = $(e.target).closest(".vid")
	return if $vid.find(".ripple:not(.canceled)").length
	$ripple = $("<div class='ripple'>").appendTo($vid)
	
	$ripple.css
		left: e.offsetX
		top: e.offsetY
		transitionDuration: "750ms"
		transitionTimingFunction: "cubic-bezier(0.250, 0.460, 0.450, 0.940)"
		transform: "scale(0)"
		opacity: 0
	$ripple.css
		transform: "scale(10)"
		opacity: 0.7
	
	$vid.on "click", ->
		return if $ripple.hasClass("canceled")
		$ripple.css
			transform: "scale(15)"
			# background: "#DB4437"
			opacity: 1
		$vid.off "mouseleave"
	
	$vid.on "mouseleave", ->
		$ripple.addClass "canceled"
		$ripple.css
			opacity: 0

$grid.click ".vid", (e)->
	$vid = $(e.target).closest(".vid")
	return unless $vid.find(".ripple:not(.canceled)").length
	
	$vid.addClass("flagged")
	
	setTimeout ->
		if $vid.is ":visible"
			shuffle.remove($vid)
	, 2000
