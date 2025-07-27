$(document).ready(function () {
    $("#frmLoginCrdt").submit(function (event) {
        event.preventDefault(); // Prevent default form submission

        const formData = $(this).serialize(); // Serialize form data

        $.ajax({
            url: "ValidateCredentials", // Target JSP
            type: "POST",
            data: formData,
            dataType: "json", // Expect JSON response
            success: function (response) {
                if (response.status === "success") {
                    window.location.href = response.redirect; // Redirect on success
                } else if (response.status === "error") {
                    $("#errorMessage").text(response.message).show(); // Show error message
                }
            },
            error: function () {
                $("#errorMessage")
                    .text("An unexpected error occurred. Please try again.")
                    .show();
            },
        });
    });
});
