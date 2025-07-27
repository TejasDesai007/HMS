<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container-fluid">
        <a class="navbar-brand" href="Home"><i class="fas fa-Hotel"></i> Apex Hotels</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="roomsDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        Rooms
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="roomsDropdown">
                        <li><a class="dropdown-item" href="Rooms">Add New Room</a></li>
                        <li><a class="dropdown-item" href="RoomsList">Room List</a></li>
                        <li><a class="dropdown-item" href="RoomsType">Type&Price</a></li>
                    </ul>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="bookingsDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        Bookings
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="bookingsDropdown">
                        <li><a class="dropdown-item" href="BookForGuest">Add Bookings</a></li>
                        <li><a class="dropdown-item" href="BookingsList">Bookings</a></li>
                    </ul>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="guestsDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        Guests
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="guestsDropdown">
                        <li><a class="dropdown-item" href="Guests">Add Guest Info</a></li>
                        <li><a class="dropdown-item" href="GuestList">Guests List</a></li>
                    </ul>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="Logout" title="Logout">
                        Logout <i class="fas fa-sign-out-alt"></i>
                    </a>
                </li>
            </ul>
            <%
                String strFname = String.valueOf(session.getAttribute("UserName"));
            %>
            
            <label class="justify-content-end mb-0"><h6>Hii <%=strFname%>!</h6></label>
                
            
        </div>
    </div>
</nav>

<!-- Bootstrap JS and necessary JS for dropdown -->
<!-- Option 1: Bootstrap Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>

