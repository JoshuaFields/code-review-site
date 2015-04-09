$( document ).ready(function() {
  console.log("document.ready runs");
  function populateStars() {
    console.log("populateStars runs");
    $( ".stars-holder" ).each(function() {
      console.log("stars holder found");
      var val = parseFloat($(this).html());
      console.log("number parsed");
      // Make sure that the value is in 0 - 5 range, multiply to get width
      var size = Math.max(0, (Math.min(5, val))) * 16;
      console.log("width determined");
      // Create stars holder
      var $span = $("<span />").width(size);
      console.log("stars holder created");
      // Replace the numerical value with stars
      $(this).html($span);
      console.log("value replaced");
    });
  }

  populateStars();
});
