
Shuffle = window.shuffle

make_vid = ->
	$("<div class='vid'>").appendTo(".vid-grid")

for i in [1..12]
	make_vid()

$grid = $(".vid-grid")

Shuffle.ShuffleItem.Css.INITIAL.zIndex = "0"
Shuffle.ShuffleItem.Css.INITIAL.opacity = "0"
Shuffle.ShuffleItem.Css.VISIBLE.after.zIndex = "2"
Shuffle.ShuffleItem.Css.VISIBLE.after.opacity = "1"

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
		if $vid.is ":visible:not(.removed)"
			$vid.addClass("removed")
			setTimeout ->
				$new_vid = make_vid().insertAfter($vid)
				shuffle.remove($vid)
				shuffle.add($new_vid)
			, 1000
	, 2000 + Math.random() * 2000
