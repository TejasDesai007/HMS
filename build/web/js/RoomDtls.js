$(document).ready(function () {

    // Initialize Select2 for the select element
    $('.select2').select2({
        width: '100%' // Make sure the select dropdown takes full width
    });

    // Listen for changes on the room type select
    $('#slcRoomType').change(function () {
        setRoomPrice(); // Set room price when room type changes
    });

    $('#txtRoomNo').on('blur', function () {
        // Get the value of the input field
        const roomno = $(this).val();

        // Send data to the backend using AJAX
        $.ajax({
            url: 'ValidateRoomNo', // Backend endpoint URL
            type: 'POST', // HTTP method
            async: true,
            data: {roomno: $("#txtRoomNo").val()}, // Data to send
            success: function (response) {
                // Handle success response
                
                if (response.trim() === "Exist" && $('#txtRoomId').val().trim() === "") {
                    // Show the validation label with Bootstrap red class
                    $('#lblValidateRooms').removeClass('d-none');
                } else {
                    // Hide the label if the room does not exist
                    $('#lblValidateRooms').addClass('d-none');
                }
            },
            error: function (xhr, status, error) {
                // Handle error response
                $('#response').text('An error occurred: ' + error);
            }
        });
    });
    // Form validation before submission
    $('#frmRoomsDtls').on('submit', function (e) {
        // Check if Room No is valid and does not exist
        if ($('#txtRoomNo').val().trim() === "") {
            alert("Room No is required.");
            $('#txtRoomNo').focus();
            e.preventDefault(); // Prevent form submission
            return false;
        }

        // Check if Room Type is selected
        if ($('#slcRoomType').val() === "") {
            alert("Please select a Room Type.");
            $('#slcRoomType').focus();
            e.preventDefault(); // Prevent form submission
            return false;
        }

        // Check if Room Price is provided
        if ($('#txtRoomPrice').val().trim() === "") {
            alert("Room Price is required.");
            $('#txtRoomPrice').focus();
            e.preventDefault(); // Prevent form submission
            return false;
        }

        // Check if Room Description is provided
        if ($('#txtRoomdscrpt').val().trim() === "") {
            alert("Room Description is required.");
            $('#txtRoomdscrpt').focus();
            e.preventDefault(); // Prevent form submission
            return false;
        }

        // If the room number already exists, prevent form submission
        if ($('#lblValidateRooms').is(':visible') && $('#txtRoomId').val().trim() === "") {
            alert("The room number already exists.");
            e.preventDefault(); // Prevent form submission
            return false;
        }
        

        // If all validation passes, allow form submission
        return true;
    });
});

function setRoomPrice() {
    var selectedOption = document.getElementById('slcRoomType').selectedOptions[0];

    // Check if the element exists before accessing
    var priceElement = document.getElementById('txtRoomPrice');
    if (priceElement) {
        var price = selectedOption.getAttribute('data-price'); // Get the price from the data attribute
        priceElement.value = price; // Set the room price in the textbox
    } else {
        console.error('Element with id "txtRoomPrice" not found');
    }
}
