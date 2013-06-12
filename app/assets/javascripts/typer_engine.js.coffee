$ ->
	unsplit = null
	typing = null
	currentTime = null
	wordTimer = null
	wpm = null
	charsTyped = null
	times = null
	incorrectchars = null
	alphabet = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"," "]

	setup = (w) ->	
		unsplit = w
		text = unsplit.split(" ")
		html = ""
		typing = false
		currentTime = 0
		wordTimer = null
		wpm = null
		charsTyped = 0
		times = []
		incorrectchars = 0
		$("body").html "<div class='typeable'></div><span class='wpm'> 0 wpm </span><span class='wordTimer'></span><br><span class='incorrectchars'></span>"
		for word in text
			html += "<p class='word'>"
			for character in word
				if character.toLowerCase() in alphabet
					html += "<span class='char'>#{character}</span>"
				else
					html += "#{character}"
			html += "</p>"
			if word != text[text.length-1]
				html += "<p class='word'><span class='char'> </span></p>"

		$(".typeable").html html
		$(document).keypress (e) -> keypress(e)

	averageWPM = ->
		t = 0
		for time in times
			t += 6000/time
		Math.floor(t/times.length)

	resetTimer = ->
		if typing
			times.push currentTime/2
			$(".list").text times
		clearInterval wordTimer
		wordTimer = null
		currentTime = 0
		wordTimer = setInterval ( -> currentTime += 1 ), 10

	stop = ->
		clearInterval wordTimer
		wordTimer = null
		currentTime = 0
		$(".wpm").text "Your average wpm was #{averageWPM()}"
		if !master
			$(".incorrectchars").text "You have a(n) #{Math.floor(100*(incorrectchars/unsplit.length))}% error rate"
		typing = false
		$("body").append("<span class='verse_msg'></span><br><a href='/'>Go Home</a> or <a href='#{window.location}'>Type this verse again</a>")
		if (!master and incorrectchars == 0) or (master and averageWPM() > master_val)
			$.ajax "/verse_completions",
			    type: "POST"
			    data: 
			    	verse_completion:
			             wpm: averageWPM()
			             verse_id: vid
			             user_id: uid
			             master: true
			    success: ->
			    	if master
			    		$(".verse_msg").append("<br>You have passed off on this verse.")
			    	else
				    	$(".verse_msg").append("<br>Your WPM for this verse was added to your average.")
		else if master and averageWPM() < master_val
			$(".verse_msg").append("<br>To master this verse, you will need a WPM of over #{master_val}")
		else
			$(".verse_msg").append("<br>You will need to complete the verse with no errors to pass off on it.")

	keypress = (e) ->
		char = String.fromCharCode(e.keyCode)

		if char.toLowerCase() not in alphabet
			return

		if char == " "
			e.preventDefault()

		if char.toLowerCase() == $(".word:not(.typed) .char:not(.typed)").first().text().toLowerCase()
			if !typing
				resetTimer()
				typing = true

			$(".word:not(.typed) .char:not(.typed)").first().addClass("typed")

			charsTyped += 1
			if charsTyped == 12
				charsTyped = 0
				resetTimer()
				$(".wpm").text "#{Math.floor(6000/times[times.length-1])} wpm"
		else if !master
			if typing and char.toLowerCase() != $(".word:not(.typed) .char:not(.typed)").first().text().toLowerCase()
				incorrectchars += 1
				$(".incorrectchars").text("#{incorrectchars} incorrect characters typed")

		if typing and $(".word:not(.typed)").first().find(".char:not(.typed)").length == 0
			$(".word:not(.typed)").first().addClass("typed")
			if $(".word:not(.typed)").length == 0
				stop()

	setup($(".verse").html())
		
