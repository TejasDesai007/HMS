$(document).ready(function () {
    $("#btnRegister").on('click', function () {
        validateRegUser();
    });


    $("#txtUserNm").on("blur", function () {
        const username = $(this).val();
        if (username.trim() === '') {
            $("#lblUserNmMsg").addClass("text-danger").text("Username cannot be empty.").show();
            return;
        }
        $.ajax({
            url: "ValidatedUsername",
            type: "GET",
            data: {username: username},
            dataType: "json", // Ensure the response is parsed as JSON
            success: function (response) {
                if (response.status === "Valid") {
                    $("#lblUserNmMsg")
                            .removeClass("text-danger")
                            .addClass("text-success")
                            .text("Username is available.")
                            .removeClass("d-none");
                } else if (response.status === "Invalid") {
                    $("#lblUserNmMsg")
                            .removeClass("text-success")
                            .addClass("text-danger")
                            .text("Username is already taken.")
                            .removeClass("d-none");
                } else if (response.status === "Error") {
                    $("#lblUserNmMsg")
                            .addClass("text-danger")
                            .text("Error: " + response.message)
                            .removeClass("d-none");
                }
            },
            error: function () {
                $("#lblUserNmMsg")
                        .addClass("text-danger")
                        .text("Error checking username availability. Please try again.")
                        .removeClass("d-none");
            },
        });
    });


    $("#txtPassword").on('keyup', function () {
        if ($(this).val().length < 8) {
            $("#lblPasswordMsg").removeClass("d-none").addClass("text-danger").text("Password should be at least 8 characters.");
        } else {
            $("#lblPasswordMsg").addClass("d-none");
        }
    });
});

function validateRegUser() {
    if ($("#txtFName").val() === '') {
        alert("Enter First Name");
        return false;
    }
    if ($("#txtLName").val() === '') {
        alert("Enter Last Name");
        return false;
    }
    if ($("#txtEmail").val() === '') {
        alert("Enter Email");
        return false;
    }
    if ($("#txtPhone").val() === '') {
        alert("Enter Phone");
        return false;
    }
    if ($("#txtEmpNo").val() === '') {
        alert("Enter Employee No.");
        return false;
    }
    if ($("#selUserType").val() === '0') {
        alert("Select User Type");
        return false;
    }
    if ($("#txtUserNm").val() === '') {
        alert("Enter UserName");
        return false;
    }
    if ($("#txtPassword").val() === '') {
        alert("Enter Password");
        return false;
    }
    if ($("#txtCnfPassword").val() === '') {
        alert("Enter Confirm Password");
        return false;
    }
    if ($("#txtCnfPassword").val() !== $("#txtPassword").val()) {
        alert("Confirm Password didn't match");
        return false;
    }

    if (confirm("Are You Sure Want to Save?")) {
        $("#frmRegCrdt").submit();
    }
}
