$(document).ready(function () {
    // Fetch the room list as soon as the document is ready
    loadBookingList();

    // Listen for the Enter key on each textbox (input[type="text"])
    $('#inputTable input[type="text"]').on('keydown', function (event) {
        // Check if the key pressed is the Enter key (key code 13)
        if (event.keyCode === 13) {
            event.preventDefault();  // Prevent form submission or other default actions

            // Collect data from labels (headers) and textboxes (input fields) into JSON
            var data = {};

            // Loop through each row to collect label-textbox pairs
            $('#inputTable thead tr').each(function () {
                // Iterate over each td in the row
                $(this).find('td').each(function () {
                    var label = $(this).find('label').text().trim();  // Get the label text
                    var textbox = $(this).find('input[type="text"]'); // Get the associated textbox
                    if (textbox.length > 0) {
                        data[label] = textbox.val(); // Add label-textbox pair to JSON object
                    }
                });
            });
            console.log(JSON.stringify(data));

            // Send the JSON object to the backend using AJAX
            $.ajax({
                url: 'BookingsListInnr', // URL of the servlet to process the data
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(data), // Convert the JSON object to a string
                success: function (response) {
                    // On success, populate the table with the returned data
                    populateTable(response);
                },
                error: function (xhr, status, error) {
                    console.error('Error:', error);
                }
            });
        }
    });

    // Function to load the room list when the page loads
    function loadBookingList() {
        $.ajax({
            url: 'BookingsListInnr', // URL to get all rooms when the page is loaded
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({}), // Send an empty object to get all rooms
            success: function (response) {
                // On success, populate the table with the returned data
                populateTable(response);
            },
            error: function (xhr, status, error) {
                console.error('Error loading room list:', error);
            }
        });
    }
    function deleteBookings(bookingid) {
        if (confirm('Are you sure you want to delete this guest?')) {
            $.ajax({
                url: 'DeleteBookings',
                type: 'POST',
                contentType: 'application/x-www-form-urlencoded',
                data: {bookingid: bookingid}, // Send roomid as a regular POST parameter
                success: function (response) {
                    alert(response.trim());
                    loadBookingList(); // Reload the room list after deletion
                },
                error: function (xhr) {
                    alert('Error: ' + xhr.responseText);
                }
            });
        }
    }

    // Function to populate the table with data from the backend
    function populateTable(data) {
        var table = $('#inputTable tbody');
        table.empty(); // Clear any previous results
        console.log(data);
        // Ensure the response is parsed correctly
        if (Array.isArray(data)) {
            // Iterate over the returned data and add rows to the table
            data.forEach(function (item) {
                var row = '<tr>';
                row += '<td class="text-center">' + item.index + '</td>'; // Empty column for actions (like buttons, etc.)
                if (!item.check_out) {
                    row += '<td class="text-center">' +
                            '<a href="BookForGuest?bookingid=' + item.bookingid + '" class="btn btn-primary btn-sm"><i class="fas fa-edit"></i></a>' +
                            '</td>';
                } else {
                    row += '<td class="text-center"></td>';

                }
                row += '<td class="text-center">' +
                        '<button class="btn btn-danger btn-sm" onclick="deleteBookings(\'' + item.bookingid + '\')">' +
                        '<i class="fas fa-trash"></i></button>' +
                        '</td>';

                // Check if check_out exists to show or hide the Checkout button
                if (!item.check_out) { // If check_out is empty or null
                    row += '<td class="text-center">' +
                            '<a href="Checkout?bookingid=' + item.bookingid + '" class="btn btn-success btn-sm">Checkout <i class="fas fa-sign-out-alt"></i></a>' +
                            '</td>';
                } else {
                    row += '<td class="text-center"></td>'; // Empty column if check_out exists
                }

                row += '<td class="text-center">' + item.GuestName + '</td>';
                row += '<td class="text-center">' + item.room_no + '</td>';
                row += '<td class="text-center">' + item.totalBill + '</td>';
                row += '<td class="text-center">' + item.check_in + '</td>';
                row += '<td class="text-center">' + item.check_out + '</td>';
                row += '<td class="text-center">' + item.createdBy + '</td>';
                row += '</tr>';
                table.append(row);
            });
        }
    }
    window.deleteBookings = deleteBookings;
});
