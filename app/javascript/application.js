// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "chartkick"
import "Chart.bundle"
// Loads all Semantic javascripts
//= require semantic-ui
//= require semantic-ui/modal
//= require semantic-ui/dropdown


$(document).ready(function(){
    $(".pk").hide();
    $(".pk2").click(function(){
        $(".pk").show();
        $(".pk2").hide();
    });

    $(".pk").click(function(){
        $(".pk").hide();
        $(".pk2").show();
    });

    $(".sk").hide();
    $(".sk2").click(function(){
        $(".sk").show();
        $(".sk2").hide();
    });

    $(".sk").click(function(){
        $(".sk").hide();
        $(".sk2").show();
    });

})




$(document).ready(function(){
    $(".pass").click(function(){
        alert("ko");
    })
})