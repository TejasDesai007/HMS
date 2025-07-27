$(document).ready(function () {
            $("#frmGuestDtls").on("submit", function (e) {
                // Clear previous error messages
                $(".text-danger").remove();

                // Validation flag
                let isValid = true;

                // Helper function to show errors
                function showError(input, message) {
                    $(input).after(`<span class="text-danger">${message}</span>`);
                    isValid = false;
                }

                // Validate Last Name
                if ($("#txtLName").val().trim() === "") {
                    showError("#txtLName", "Last Name is required.");
                }

                // Validate First Name
                if ($("#txtFName").val().trim() === "") {
                    showError("#txtFName", "First Name is required.");
                }

                // Validate Address Line 1
                if ($("#txtAddress1").val().trim() === "") {
                    showError("#txtAddress1", "Address Line 1 is required.");
                }

                // Validate City
                if ($("#txtCity").val().trim() === "") {
                    showError("#txtCity", "City is required.");
                }

                // Validate State
                if ($("#txtState").val().trim() === "") {
                    showError("#txtState", "State is required.");
                }

                // Validate Country
                if ($("#txtCountry").val().trim() === "") {
                    showError("#txtCountry", "Country is required.");
                }

                // Validate Pincode
                const pincode = $("#txtPincode").val().trim();
                if (pincode === "") {
                    showError("#txtPincode", "Pincode is required.");
                } else if (!/^\d+$/.test(pincode)) {
                    showError("#txtPincode", "Pincode must be numeric.");
                }

                // Validate Phone
                const phone = $("#txtPhone").val().trim();
                if (phone === "") {
                    showError("#txtPhone", "Phone number is required.");
                } else if (!/^\d{10}$/.test(phone)) {
                    showError("#txtPhone", "Phone number must be 10 digits.");
                }

                // Prevent form submission if validation fails
                if (!isValid) {
                    e.preventDefault();
                }
            });

            // Allow only numbers in pincode and phone fields
            $("#txtPincode, #txtPhone").on("keydown", function (e) {
                if (e.key.length === 1 && !/\d/.test(e.key)) {
                    e.preventDefault();
                }
            });
        });
