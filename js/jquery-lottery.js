
jQuery(function() {
  $.lottery = function(element, options) {
    var state,
      _this = this;
    state = '';
    this.timerHandle;
    this.mainDiv = $("<div class='lottery-plugin' />");
    this.settings = {};
    this.$element = $(element);
    this.setState = function(_state) {
      return state = _state;
    };
    this.getState = function() {
      return state;
    };
    this.getSetting = function(key) {
      return this.settings[key];
    };
    this.callSettingFunction = function(name, args) {
      if (args == null) {
        args = [];
      }
      return this.settings[name].apply(this, args);
    };
    this.mixNames = function(interval) {
      var _this = this;
      if (this.timerHandle) {
        return console.log("Timer already running");
      } else {
        return this.timerHandle = window.setInterval(function() {
          var randomIndex;
          _this.mainDiv.empty();
          randomIndex = Math.floor(Math.random() * _this.listItems.length);
          _this.mainDiv.append($("<p class='lottery-option'>" + _this.listItems[randomIndex] + "</p>"));
          return console.log(randomIndex);
        }, 100);
      }
    };
    this.stopLottery = function() {
      if (typeof console.log === "function") {
        console.log("Ended");
      }
      window.clearInterval(this.timerHandle);
      return $('p.lottery-option').css("color", "green");
    };
    this.startLottery = function() {
      var _this = this;
      this.$element.replaceWith(this.mainDiv);
      this.mixNames();
      return window.setTimeout(function() {
        return _this.stopLottery();
      }, 5000);
    };
    this.startButtonPressed = function() {
      return _this.startLottery();
    };
    this.setupListeners = function() {
      return $("button.start-lottery").bind('click', this.startButtonPressed);
    };
    this.init = function() {
      var _this = this;
      this.settings = $.extend({}, this.defaults, options);
      this.setState('ready');
      this.listItems = [];
      $(this.$element).find("li").each(function(index, elem) {
        return _this.listItems.push($(elem).text());
      });
      this.$element.html($("<button class='start-lottery'>Start</button>"));
      return this.setupListeners();
    };
    this.init();
    return this;
  };
  return $.lottery.prototype.defaults = $.fn.lottery = function(options) {
    return this.each(function() {
      var plugin;
      if ($(this).data('lottery') === void 0) {
        plugin = new $.lottery(this, options);
        return $(this).data('lottery', plugin);
      }
    });
  };
});
