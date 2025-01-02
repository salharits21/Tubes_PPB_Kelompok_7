<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <title>Login</title>
    <link rel="stylesheet" href="{{ asset('css/style-login.css') }}">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:ital,opsz,wght@0,14..32,100..900;1,14..32,100..900&display=swap" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        const form = document.querySelector('form');
        const usernameInput = document.getElementById('name');
        const passwordInput = document.getElementById('pass');

        form.addEventListener('submit', function(e) {
            e.preventDefault(); // Hentikan pengiriman form
            let isValid = true;

            // Hapus pesan kesalahan sebelumnya
            document.querySelectorAll('.error').forEach(el => el.remove());

            // Validasi Username
            if (!usernameInput.value.trim()) {
                showError(usernameInput, 'Username is required.');
                isValid = false;
            }

            // Validasi Password
            if (!passwordInput.value.trim()) {
                showError(passwordInput, 'Password is required.');
                isValid = false;
            } else if (passwordInput.value.length < 6) {
                showError(passwordInput, 'Password must be at least 6 characters.');
                isValid = false;
            }

            if (isValid) {
                // Kirim permintaan AJAX ke server untuk memeriksa kredensial
                $.ajax({
                    url: '/login-check',
                    method: 'post',
                    data: {
                        name: usernameInput.value,
                        pass: passwordInput.value,
                        _token: $('meta[name="csrf-token"]').attr('content') // CSRF token
                    },
                    success: function(response) {
                        if (response.success) {
                            form.submit(); // Jika login berhasil, kirim formulir
                        } else {
                            // Tampilkan pesan kesalahan jika login gagal
                            showError(usernameInput, response.message);
                        }
                    },
                    error: function(xhr) {
                        var response = JSON.parse(xhr.responseText); // Parsing JSON
                        if (response.success === false) {
                            // Tampilkan pesan kesalahan di bawah input yang sesuai
                            if (response.message === 'Username not found') {
                                showError(usernameInput, 'Username not found');
                            } else if (response.message === 'Incorrect password') {
                                showError(passwordInput, 'Incorrect password');
                            } else {
                                showError(usernameInput, 'Invalid credentials');
                            }
                        }
                    }

                });


            }
        });

        function showError(input, message) {
            const error = document.createElement('div');
            error.className = 'error';
            error.style.color = 'red';
            error.style.marginTop = '5px';
            error.textContent = message;
            input.parentNode.appendChild(error);
        }
    });
</script>

<body background="{{ asset('asset/Background.jpg') }}">
    <div id="register">
        @if ($errors->any())
        <div style="color: red; margin-bottom: 20px;">
            <ul>
                @foreach ($errors->all() as $error)
                <li>{{ $error }}</li>
                @endforeach
            </ul>
        </div>
        @endif
        <form action="{{ url('login') }}" method="POST">
            @csrf
            <div id="input">
                <table>
                    <tr>
                        <td>
                            <h2 id="regtext">Login</h2>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="name">Username</label>
                            <div>
                                <input type="text" id="name" name="name">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="pass">Password</label>
                            <div>
                                <input type="password" id="pass" name="pass">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <button type="submit">Login</button>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div id="arehave">Don't have an account? <a href="{{ route('register') }}">Register</a></div>
                        </td>
                    </tr>
                </table>
            </div>
        </form>
    </div>
</body>

</html>