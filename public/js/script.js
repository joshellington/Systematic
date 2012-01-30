


var app = function() {

  var that = this;

  function set(obj, text) {
    $(obj).text(text);
  };

  this.init = function() {
    set($('.section.js h4'), 'Enabled');
    that.browserSize();
    
    if ( Modernizr.cookies ) {
      set($('.section.cookies h4'), 'Enabled');
    }

    if ( swfobject.hasFlashPlayerVersion('1') ) {
      var playerVersion = swfobject.getFlashPlayerVersion();
      set($('.section.flash h4'), playerVersion.major + "." + playerVersion.minor + "." + playerVersion.release);
    }
  };

  this.browserSize = function() {
    set($('.section.screen-resolution h4'), screen.width + 'x' + screen.height);
    set($('.section.browser-size h4'), window.innerWidth + 'x' + window.innerHeight);
  };

};

app = new app();

$(function() {
  
  app.init();

  $(window).resize(function() {
    // app.browserSize();
  });

});
