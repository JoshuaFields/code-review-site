function normalizeIndexWrapperHeights(wrapperClass) {
  var largest = 0;

  $(wrapperClass).each(function() {
    //console.log($(this).height);
    if ($(this).height() > largest ) {
      largest = $(this).height();
    }
  });
  console.log("greatest height = " + String(largest));
  $(wrapperClass).height(largest);
}

var indexWrapperClass = ".tutorial-thumbnail-wrapper";

if ($(indexWrapperClass).length) {
  normalizeIndexWrapperHeights(indexWrapperClass);
  $(window).resize(function(){
    normalizeIndexWrapperHeights(indexWrapperClass);
  });
}
