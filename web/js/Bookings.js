$(document).ready(function () {

    // Initialize Select2 for the select element
    $('.select2').select2({
        width: '100%' // Ensure the select dropdown takes full width
    });
    $('#frmBookingDtls').on('submit', function (event) {
        validateForm(event);
    });
    // Function to calculate the total amount dynamically
    function calculateTotalAmount() {
        const pricePerDay = parseFloat($('#txtRoomPrice').val()) || 0; // Get room price
        const stayDays = parseFloat($('#txtStayDays').val()) || 0; // Get number of stay days
        const beverageCost = parseFloat($('#txtBeverage').val()) || 0; // Get beverage cost

        // Tax Calculation
        const taxPercentage = parseFloat($('#txtTaxPrc').val()) || 0; // Get tax percentage
        const taxAbsolute = (pricePerDay * stayDays) * (taxPercentage / 100); // Tax in ₹ calculated as percentage of room cost
        $('#txtTax').val(taxAbsolute.toFixed(2)); // Update Tax in ₹ field

        // Total Amount Calculation
        const totalAmount = (pricePerDay * stayDays) + taxAbsolute + beverageCost;

        // Update the Total Amount field
        $('#txtTotalAmt').val(totalAmount.toFixed(2)); // Rounded to 2 decimal places
    }

    // Add event listeners to recalculate on input changes
    const inputs = ['#txtRoomPrice', '#txtStayDays', '#txtTaxPrc', '#txtBeverage'];

    inputs.forEach((selector) => {
        $(selector).on('input', calculateTotalAmount); // Recalculate on input change
    });

    // Function to set the room price when a room is selected
    $('#slcRooms').on('change', function () {
        const selectedOption = $(this).find(':selected'); // Get the selected option

        if (selectedOption.length > 0) {
            const price = selectedOption.data('price'); // Get the price from the data attribute
            $('#txtRoomPrice').val(price); // Set the room price in the textbox
            calculateTotalAmount(); // Recalculate total amount
        } else {
            console.error('No room selected or missing data-price attribute');
        }
    });
});



function validateForm(event) {
    var isValid = true;

    // Reset previous error messages
    $('.error-message').text('');
    $('.form-control').removeClass('is-invalid');

    // Validate Select Guest
    var guest = $('#slcGuest').val();
    if (guest === '0') {
        
        $('#errGuest').text('Please select a guest.');
        isValid = false;
    }

    // Validate Select Room
    var room = $('#slcRooms').val();
    if (room === '0') {
        
        $('#errRoom').text('Please select a room.');
        isValid = false;
    }

    // Validate Room Price
    var roomPrice = $('#txtRoomPrice').val();
    if (roomPrice === '' || isNaN(roomPrice) || parseFloat(roomPrice) <= 0) {
        
        $('#errRoomPrice').text('Please enter a valid room price.');
        isValid = false;
    }

    // Validate Stay Days
    var stayDays = $('#txtStayDays').val();
    if (stayDays === '' || isNaN(stayDays) || parseInt(stayDays) <= 0) {
        
        $('#errStayDays').text('Please enter a valid number of days.');
        isValid = false;
    }

    // Validate Tax Percentage
    var taxPercentage = $('#txtTaxPrc').val();
    if (taxPercentage === '' || isNaN(taxPercentage) || parseFloat(taxPercentage) < 0) {
     
        $('#errTaxPrc').text('Please enter a valid tax percentage.');
        isValid = false;
    }

    // Validate Beverages Cost
  

    // If any validation failed, prevent form submission
    if (!isValid) {
        event.preventDefault();
    }

    return isValid;
}
