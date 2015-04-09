$( document ).on("page:load", function() {
    $(".upvote-img, .downvote-img").click(function () {
        var path = $(this).attr("path");
        var reviewID = $(this).attr("reviewID");
        $.post(path, function (data) {
            $("#review-" + reviewID).text(data);
        });
        return false;
    });
});
