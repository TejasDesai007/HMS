$(document).ready(function () {
//    alert("called");
    $('#txtTypePrice').on('keyup', function () {
        // Replace any non-numeric character with an empty string
       
        this.value = this.value.replace(/[^0-9.]/g, '');

        // Ensure only one decimal point
        if ((this.value.match(/\./g) || []).length > 1) {
            this.value = this.value.substring(0, this.value.lastIndexOf('.'));
        }
    });
});