
$(document).on("ready", function(){
  $("body").on("click", ".disable", function(event){
    console.log($(this).parents(".custom-field"));
    $(this).parents(".custom-field").remove();
  });
});

