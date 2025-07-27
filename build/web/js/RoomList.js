$(document).ready(function () {
    // Fetch the room list as soon as the document is ready
    loadRoomList();

    // Listen for the Enter key on each textbox (input[type="text"])
    $('#inputTable').on('keydown', 'input[type="text"]', function (event) {
        // Check if the key pressed is the Enter key (key code 13)
        if (event.keyCode === 13) {
            event.preventDefault(); // Prevent form submission or other default actions

            // Collect data from labels (headers) and textboxes (input fields) into JSON
            var data = {};

            // Loop through each row in the table header to collect label-textbox pairs
            $('#inputTable thead tr td').each(function () {
                var label = $(this).find('label').text().trim(); // Get the label text
                var textbox = $(this).find('input[type="text"]'); // Get the associated textbox
                if (textbox.length > 0) {
                    data[label] = textbox.val(); // Add label-textbox pair to JSON object
                }
            });

            console.log('Data sent:', JSON.stringify(data));

            // Send the JSON object to the backend using AJAX
            $.ajax({
                url: 'RoomListInnr', // URL of the servlet to process the data
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

    // Function to delete rooms
    function deleteRooms(roomid) {
        if (confirm('Are you sure you want to delete this room?')) {
            $.ajax({
                url: 'DeleteRooms',
                type: 'POST',
                contentType: 'application/x-www-form-urlencoded',
                data: { roomid: roomid }, // Send roomid as a regular POST parameter
                success: function (response) {
                    alert(response.trim());
                    loadRoomList(); // Reload the room list after deletion
                },
                error: function (xhr) {
                    alert('Error: ' + xhr.responseText);
                }
            });
        }
    }

    // Function to load the room list when the page loads
    function loadRoomList() {
        $.ajax({
            url: 'RoomListInnr', // URL to get all rooms when the page is loaded
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

    // Function to populate the table with data from the backend
    function populateTable(data) {
        var table = $('#inputTable tbody');
        table.empty(); // Clear any previous results

        // Ensure the response is an array
        if (Array.isArray(data)) {
            // Iterate over the returned data and add rows to the table
            data.forEach(function (item) {
                var row = '<tr>';
                row += '<td class="text-center">' + (item.index || '') + '</td>'; // Add the index or leave empty
                row += '<td class="text-center">' +
                       '<a href="Rooms?roomid=' + item.roomid + '" class="btn btn-primary btn-sm">' +
                       '<i class="fas fa-edit"></i></a>' +
                       '</td>';
                row += '<td class="text-center">' +
                       '<button class="btn btn-danger btn-sm" onclick="deleteRooms(\'' + item.roomid + '\')">' +
                       '<i class="fas fa-trash"></i></button>' +
                       '</td>';
                row += '<td class="text-center">' + (item.room_no || '') + '</td>';
                row += '<td class="text-center">' + (item.room_type || '') + '</td>';
                row += '<td class="text-center">' + (item.price_per_day || '') + '</td>';
                row += '<td class="text-center">' + (item.room_dscrpt || '') + '</td>';
                row += '<td class="text-center">' + (item.created_on || '') + '</td>';
                row += '<td class="text-center">' + (item.created_by || '') + '</td>';
                row += '</tr>';
                table.append(row);
            });
        } else {
            console.error('Invalid data format:', data);
        }
    }

    // Expose the deleteRooms function to the global scope (needed for inline onclick)
    window.deleteRooms = deleteRooms;
});
