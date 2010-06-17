TheatreDigsBooker = {}

TheatreDigsBooker.DigImages = {
  init: function(){
    $('.small-image').click(TheatreDigsBooker.DigImages.update_main_image);
  },
  
  update_main_image: function(){
    $('#large-image').attr("src", $(this).attr("src").replace("thumb", "large"));
    $('.small-image').removeClass("selected")
    $(this).addClass('selected')
  }
}

$(document).ready(
  function(){
    for (key in TheatreDigsBooker) {
      if(typeof TheatreDigsBooker[key]["init"] === "function" && $("body").hasClass("with-js-" + key)) {
        TheatreDigsBooker[key].init();
      }
    }
  }
);