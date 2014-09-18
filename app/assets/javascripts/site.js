$(document).ready (function (){

  // $('#search-navbar').affix({
  //     offset: {
  //       top: 80
  //     , bottom: function () {
  //         return (this.bottom = $('.footer').outerHeight(true))
  //       }
  //     }
  // })

  // $('#search-navbar').affix({
  //   offset: { top: $('#search-navbar').offset().top }
  // })

  // $('#nav-wrapper').height($("#nav").height());



  // $('#search-navbar').attr('data-offset-top', 80);

  // alert( 'navbar height: ' + $('#navbar').height());
  // alert( 'image-holder height: ' + (window.outerHeight - ( $('#navbar').height() ) ) );

  // var headerHeight = $('#myCarousel').css('max-height', (window.outerHeight - ( $('#navbar').height() * 2 )  ) );

  //var headerHeight = (window.outerHeight - ( $('#navbar').height() * 2 )  ) ;

  setHeaderSize();




  // $('#image-holder').css('height', (window.outerHeight - ( $('#navbar').height() ) ) );

  // resize header on widow resize
  var resizerId;

  $(window).resize(function() {
    clearTimeout(resizerId);
    resizerId = setTimeout(setHeaderSize, 500);
  });


});

function getScreenWidth() {
  var _width = $(window).width();
  return _width;
}

function setHeaderSize() {
  var _headerHeight = (window.outerHeight - ( $('#navbar').height() * 2 )  ) ;
  $('#carousel').css('max-height', _headerHeight );
  $('.image-holder').css('height', _headerHeight );
}

function getScreenWidth() {
  var _width = $(window).width();
  return _width;
}

// $(document).scroll(function () {
// else {;
//   $('#main-container').css("padding-top","0px");
// }

// });