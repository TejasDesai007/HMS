$(document).ready(function () {
    // Any initialization code can go here
});

function DeleteType(typeid) {
    if (confirm("Are you sure you want to delete this type?")) {
        $.ajax({
            url: 'DeleteType', // Replace with the actual URL of your backend endpoint
            type: 'POST',       // Use POST or DELETE based on your backend API
            data: { typeid: typeid }, // Send typeid as data
            success: function (response) {
                 if (response.includes("Deleted Successfully")) {
                    alert("Type deleted successfully!");
                    location.reload(); // Refresh the page to reflect changes
                } else if (response.includes("No record found")) {
                    alert("No record found with the given type ID.");
                } else {
                    alert(response.trim());
                }
            },
            error: function (xhr, status, error) {
                // Handle error response
                alert("An error occurred while deleting the type: " + error);
                console.error(xhr.responseText);
            }
        });
    }
}
