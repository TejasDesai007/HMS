$(document).ready(function () {
    // Fetch the room list as soon as the document is ready
    loadBookingList();

    // Listen for the Enter key on each textbox (input[type="text"])
    $('#inputTable input[type="text"]').on('keydown', function (event) {
        if (event.keyCode === 13) { // Enter key
            event.preventDefault();  // Prevent form submission

            var data = {};

            // Collect label-textbox pairs from the table header
            $('#inputTable thead tr').each(function () {
                $(this).find('td').each(function () {
                    var label = $(this).find('label').text().trim();
                    var textbox = $(this).find('input[type="text"]');
                    if (textbox.length > 0) {
                        data[label] = textbox.val();
                    }
                });
            });
            console.log(JSON.stringify(data));

            // Send AJAX to backend
            $.ajax({
                url: 'BookingsListInnr',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(data),
                success: function (response) {
                    populateTable(response);
                },
                error: function (xhr, status, error) {
                    console.error('Error:', error);
                }
            });
        }
    });

    // Load all bookings when page loads
    function loadBookingList() {
        $.ajax({
            url: 'BookingsListInnr',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({}),
            success: function (response) {
                populateTable(response);
            },
            error: function (xhr, status, error) {
                console.error('Error loading room list:', error);
            }
        });
    }

    // Delete booking with confirmation
    function deleteBookings(bookingid) {
        if (confirm('Are you sure you want to delete this guest?')) {
            $.ajax({
                url: 'DeleteBookings',
                type: 'POST',
                contentType: 'application/x-www-form-urlencoded',
                data: { bookingid: bookingid },
                success: function (response) {
                    alert(response.trim());
                    loadBookingList(); // Reload after deletion
                },
                error: function (xhr) {
                    alert('Error: ' + xhr.responseText);
                }
            });
        }
    }

    // Confirm checkout before proceeding
    function confirmCheckout(bookingid) {
        if (confirm('Are you sure you want to checkout this guest?')) {
            // Proceed with checkout via redirect
            window.location.href = 'Checkout?bookingid=' + bookingid;
        }
        return false; // Prevent default link click
    }

    // Populate the table with backend data
    function populateTable(data) {
        var table = $('#inputTable tbody');
        table.empty();
        console.log(data);

        if (Array.isArray(data)) {
            data.forEach(function (item) {
                var row = '<tr>';
                row += '<td class="text-center">' + item.index + '</td>';

                // Edit button
                if (!item.check_out) {
                    row += '<td class="text-center">' +
                           '<a href="BookForGuest?bookingid=' + item.bookingid + '" class="btn btn-primary btn-sm">' +
                           '<i class="fas fa-edit"></i></a>' +
                           '</td>';
                } else {
                    row += '<td class="text-center"></td>';
                }

                // Delete button
                row += '<td class="text-center">' +
                       '<button class="btn btn-danger btn-sm" onclick="deleteBookings(\'' + item.bookingid + '\')">' +
                       '<i class="fas fa-trash"></i></button>' +
                       '</td>';

                // Checkout button with confirmation
                if (!item.check_out) {
                    row += '<td class="text-center">' +
                           '<a href="#" class="btn btn-success btn-sm" onclick="return confirmCheckout(\'' + item.bookingid + '\');">' +
                           'Checkout <i class="fas fa-sign-out-alt"></i></a>' +
                           '</td>';
                } else {
                    row += '<td class="text-center"></td>';
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

    // Expose delete and checkout functions to global scope
    window.deleteBookings = deleteBookings;
    window.confirmCheckout = confirmCheckout;
});
