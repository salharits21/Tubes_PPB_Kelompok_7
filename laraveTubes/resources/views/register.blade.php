<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register</title>
    <link rel="stylesheet" href="{{ asset('css/style-register.css') }}">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;700&display=swap" rel="stylesheet">
    <style>
        .error { color: red; font-size: 14px; }
        .success { color: green; font-size: 14px; margin-bottom: 10px; }
    </style>
</head>
<body background="{{ asset('asset/Background.jpg') }}">
    <div id="register">
        <form action="{{ route('register.submit') }}" method="POST" id="registerForm">
            @csrf
            <div id="input">
                <table>
                    <tr>
                        <td>
                            <h2 id="regtext">Register</h2>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="name">Username</label>
                            <div>
                                <input type="text" id="name" name="name" value="{{ old('name') }}" >
                                @error('name')
                                    <div class="error">{{ $message }}</div>
                                @enderror
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="email">Email</label>
                            <div>
                                <input type="text" id="email" name="email" value="{{ old('email') }}" >
                                @error('email')
                                    <div class="error">{{ $message }}</div>
                                @enderror
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="pass">Password</label>
                            <div>
                                <input type="password" id="pass" name="password" >
                                @error('password')
                                    <div class="error">{{ $message }}</div>
                                @enderror
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="conpass">Konfirmasi Password</label>
                            <div>
                                <input type="password" id="conpass" name="password_confirmation" >
                                @error('password_confirmation')
                                    <div class="error">{{ $message }}</div>
                                @enderror
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <button type="submit">Register</button>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div id="arehave">Already have an account? <a href="{{ url('/login') }}">Login</a></div>
                        </td>
                    </tr>
                </table>
            </div>
        </form>
    </div>
</body>
</html>
