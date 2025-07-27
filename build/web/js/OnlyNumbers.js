function allowOnlyNumbers(event) {

    if ($.inArray(event.keyCode, [8, 46, 9, 27, 13]) !== -1 ||
            (event.keyCode >= 48 && event.keyCode <= 57) ||
            (event.keyCode >= 96 && event.keyCode <= 105)) {
        return;
    } else {
        event.preventDefault();
    }
}

function allowOnlyNumbersAndDecimal(event) {
    const keyCode = event.keyCode || event.which;
    const inputValue = event.target.value; // Get the current value of the input field
    if (
            keyCode === 8 || keyCode === 46 || keyCode === 9 || keyCode === 27 || keyCode === 13 || // allowed control keys
            (keyCode >= 48 && keyCode <= 57) || // numbers 0-9 on the top row
            (keyCode >= 96 && keyCode <= 105) || 
            keyCode === 109 || keyCode === 189 
            ) {
        return; 
    }

    
    if (keyCode === 190 && inputValue.indexOf('.') !== -1) {
        event.preventDefault(); // Block the second dot
    } else if (keyCode === 190) {
        return; // Allow the first dot
    } else {
        event.preventDefault(); // Block any other characters
    }
}



function handleDateInput(event) {
            const input = event.target;

            // Allow navigation/editing keys
            const allowedKeys = ["Backspace", "ArrowLeft", "ArrowRight", "Tab", "Delete"];
            if (allowedKeys.includes(event.key)) {
                return; // Allow these keys
            }

            // Prevent non-numeric characters
            if (!/^[0-9]$/.test(event.key)) {
                event.preventDefault();
                return;
            }

            // Format the value dynamically
            let value = input.value.replace(/\D/g, ""); // Remove non-numeric characters

            if (value.length > 2) {
                value = value.slice(0, 2) + "-" + value.slice(2);
            }
            if (value.length > 5) {
                value = value.slice(0, 5) + "-" + value.slice(5);
            }

            input.value = value.slice(0, 10); // Limit to 10 characters
        }