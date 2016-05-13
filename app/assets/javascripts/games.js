$(document).on("ready page:load", function(){
  $(".search").on("click", function(event){
    $(".search").hide()
    event.preventDefault();
    var title = $("input").val()
    var console = $("select").val()
    $(".search").addClass("game-query")
    $(".selected-games ul").text("")
    $("input").val("")
    $("select")[0].selectedIndex = 0
     $.ajax({
      url: '/database',
      method: "GET",
      data: {title: title, console: console}
    }).success(function(response, setting){
      $(".new-search-btn").prepend("<button class='trick-search'>Search</button>")
      var games = response.games;
      var index;
      for (index = 0; index < games.length; ++index) { 
        var title = games[index].title
        var image = games[index].image
        var id = games[index].id
        $(".selected-games ul").append("<div class='game'>" + "<br>" + "<img src='" + image +"'>" + "<input type='hidden' value='" + id +"'>" + "<div class='desc-" + id + "'>" + "</div>" + "</div>" + "<div style='display: none;' class='hidden_name'>" + title  + "</div>" )
      };
    }).done(function(){
      $("ul .game img").click(function(event){
      event.preventDefault();
      debugger
      $(".game-info").show();
      $(".specific-game-image").text("")
      $(".specific-game-info").text("")
      var game_id = $(this).parent().find('input').val()
      var that = this
      $.ajax({
        url: '/games/:' + game_id,
        method: "GET",
        data: {game_id: game_id}
      }).success(function(response, setting){
        debugger
        var id = response.game.id
        var image = response.game.image
        var title = response.game.title
        var release_date = response.game.release_date
        var game_link = response.game.link
        var log_line = response.game.log_line
        var alias = response.game.alias
        var console = response.game.console
        $(".specific-game-image").prepend("<img src='" + image +"'>")
        $(".specific-game-info").append("<strong> Title: </strong>" + "<a href='" + game_link + "' target='_blank'>" + title + "</a>" + "<br>")
        $(".specific-game-info").append("<strong> Console: </strong> " + console + "<br>")
        $(".specific-game-info").append("<strong> Release Date: </strong> " + release_date + "<br>")
        $(".specific-game-info").append("<strong> Summary: </strong> " + log_line + "<br>")
        });
      })
    });
  })
  

  $("body").on("click", ".trick-search", (function(event){ 
    event.preventDefault();
    var title = $("input").val()
    var console = $("select").val()
    $(".selected-games ul").text("")
    $("input").val("")
    $("select")[0].selectedIndex = 0
     $.ajax({
      url: '/game_query',
      method: "GET",
      data: {title: title, console: console}
    }).success(function(response, setting){
      var games = response.games;
      var index;
      for (index = 0; index < games.length; ++index) { 
        var title = games[index].title
        var image = games[index].image
        $(".selected-games ul").append("<div class='game'>" + "<br>" + "<img src='" + image +"'>" + "<div style='display: none;' class='hidden_name'>" + title + "</div>" )
      };
    }).done(function(){
      $("ul .game img").click(function(event){
      event.preventDefault();
      $(".game-info").show();
      $(".specific-game-image").text("")
      $(".specific-game-info").text("")
      var title = $(this).parent().find(".hidden_name").text()
      debugger
      // var title = 
      var that = this
      $.ajax({
        url: '/show',
        method: "GET",
        data: {title: title}
      }).success(function(response, setting){
        debugger
        var id = response.game.id
        var image = response.game.image
        var title = response.game.title
        var release_date = response.game.release_date
        var game_link = response.game.link
        var log_line = response.game.log_line
        var alias = response.game.alias
        var console = response.game.console
        $(".specific-game-image").prepend("<img src='" + image +"'>")
        $(".specific-game-info").append("<strong> Title: </strong>" + "<a href='" + game_link + "' target='_blank'>" + title + "</a>" + "<br>")
        $(".specific-game-info").append("<strong> Console: </strong> " + console + "<br>")
        $(".specific-game-info").append("<strong> Release Date: </strong> " + release_date + "<br>")
        $(".specific-game-info").append("<strong> Summary: </strong> " + log_line + "<br>")
        });






})
});
})
)
})
// $(document).on("ready page:load", function(){
//   $(".game-info").hide();
//   $(".search").one("click", function(event){
//     event.preventDefault();
//     var title = $("input").val()
//     var console = $("select").val()
//     $(".search").addClass("game-query")
//     $(".selected-games ul").text("")
//     $("input").val("")
//     $("select")[0].selectedIndex = 0
//      $.ajax({
//       url: '/database',
//       method: "GET",
//       data: {title: title, console: console}
//     }).success(function(response, setting){
//       debugger
//       var games = response.games;
//       var index;
//       for (index = 0; index < games.length; ++index) { 
//         var title = games[index].title
//         var image = games[index].image
//         var id = games[index].id
//         $(".selected-games ul").append("<div class='game'>" + "<br>" + "<img src='" + image +"'>" + "<input type='hidden' value='" + id +"'>" + "<div class='desc-" + id + "'>" + "</div>" + "</div>" + "<div style='display: none;' class='hidden_name'>" + title  + "</div>" )
//       };
//     }).done(function(){
//       $("ul .game img").click(function(event){
//       event.preventDefault();
//       debugger
//       $(".game-info").show();
//       $(".specific-game-image").text("")
//       $(".specific-game-info").text("")
//       var game_id = $(this).parent().find('input').val()
//       var that = this
//       $.ajax({
//         url: '/games/:' + game_id,
//         method: "GET",
//         data: {game_id: game_id}
//       }).success(function(response, setting){
//         debugger
//         var id = response.game.id
//         var image = response.game.image
//         var title = response.game.title
//         var release_date = response.game.release_date
//         var game_link = response.game.link
//         var log_line = response.game.log_line
//         var alias = response.game.alias
//         var console = response.game.console
//         $(".specific-game-image").prepend("<img src='" + image +"'>")
//         $(".specific-game-info").append("<strong> Title: </strong>" + "<a href='" + game_link + "' target='_blank'>" + title + "</a>" + "<br>")
//         $(".specific-game-info").append("<strong> Console: </strong> " + console + "<br>")
//         $(".specific-game-info").append("<strong> Release Date: </strong> " + release_date + "<br>")
//         $(".specific-game-info").append("<strong> Summary: </strong> " + log_line + "<br>")
//         });
//       })
//     });
//   })
// })




