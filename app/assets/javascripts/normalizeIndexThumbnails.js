function normalizeIndexWrapperHeights(wrapperClass) {
  var largest = 0;

  $(wrapperClass).each(function() {
    if ($(this).height() > largest ) {
      largest = $(this).height();
    }
  });
  $(wrapperClass).height(largest);
}

var indexWrapperClass = ".tutorial-thumbnail-wrapper";

if ($(indexWrapperClass).length) {
  normalizeIndexWrapperHeights(indexWrapperClass);
}
