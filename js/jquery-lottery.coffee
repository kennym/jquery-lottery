#
# Name    : jquery-lottery
# Author  : Kenny Meyer, www.kennymeyer.net, @meyerkenny
# Version : 0.1
# Repo    : <repo url>
# Website : <website url>
#

jQuery ->
  $.lottery = ( element, options ) ->
    # current state
    state = ''

    # Timer
    @timerHandle
    # Main
    @mainDiv = $( "<div class='lottery-plugin' />")

    # plugin settings
    @settings = {}

    # jQuery version of DOM element attached to the plugin
    @$element = $ element

    # set current state
    @setState = ( _state ) -> state = _state

    #get current state
    @getState = -> state

    # get particular plugin setting
    @getSetting = ( key ) ->
      @settings[ key ]

    # call one of the plugin setting functions
    @callSettingFunction = ( name, args = [] ) ->
      @settings[name].apply( this, args )

    @mixNames = (interval) ->
      if @timerHandle
        console.log "Timer already running"
      else
        @timerHandle = window.setInterval =>
          @mainDiv.empty()
          randomIndex = Math.floor(Math.random() * @listItems.length)
          @mainDiv.append $("<p class='lottery-option'>" + @listItems[randomIndex] + "</p>")
          console.log randomIndex
        , 100

    @stopLottery = ->
      console.log? "Ended"
      window.clearInterval(@timerHandle)
      $('p.lottery-option').css("color", "green")

    @startLottery = ->
      @$element.replaceWith @mainDiv

      @mixNames()

      window.setTimeout =>
        @stopLottery()
      , 5000

    @startButtonPressed = =>
      @startLottery()

    @setupListeners = ->
      $("button.start-lottery").bind 'click', @startButtonPressed

    @init = ->
      @settings = $.extend( {}, @defaults, options )

      @setState 'ready'

      @listItems = []
      _.each $( @$element ).find("li"), (elem) =>
        @listItems.push $(elem).text()

      @$element.html $("<button class='start-lottery'>Start</button>")

      @setupListeners()

    # initialise the plugin
    @init()

    # make the plugin chainable
    this

  # default plugin settings
  $.lottery::defaults =
     # TODO:
     #options: ["A", "B", "C"]  # List of options to iterate over

  $.fn.lottery = ( options ) ->
    this.each ->
      if $( this ).data( 'lottery' ) is undefined
        plugin = new $.lottery( this, options )
        $( this).data( 'lottery', plugin )

