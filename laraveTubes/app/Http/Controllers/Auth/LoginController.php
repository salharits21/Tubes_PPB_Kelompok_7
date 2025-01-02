<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Models\User;
use Illuminate\Support\Facades\Hash;

class LoginController extends Controller
{
    public function showLoginForm()
    {
        return view('login');
    }

    public function login(Request $request)
    {
        // Validate input
        $request->validate([
            'name' => 'required|string',
            'pass' => 'required|string|min:6',
        ]);

        // Check if user exists and password matches
        $user = User::where('name', $request->name)->first();

        if ($user && Hash::check($request->pass, $user->password)) {
            Auth::login($user);  // Log the user in
            return redirect()->route('dashboard'); // Redirect to home or dashboard
        }

        return back()->withErrors(['name' => 'Invalid credentials']); // Invalid login
    }

    // Tambahkan metode loginCheck di sini
    public function loginCheck(Request $request)
    {
        // Validasi input
        $request->validate([
            'name' => 'required|string',
            'pass' => 'required|string|min:6',
        ]);

        // Cari user berdasarkan nama
        $user = User::where('name', $request->name)->first();

        // Cek apakah password cocok
        if ($user && Hash::check($request->pass, $user->password)) {
            // Login pengguna
            Auth::login($user);
            return response()->json(['success' => true]);  // Jika login berhasil
        }

        // Jika login gagal, tentukan mana yang salah (username atau password)
        $errorMessage = 'Invalid credentials';  // Pesan default

        if (!$user) {
            $errorMessage = 'Username not found';
        } else {
            $errorMessage = 'Incorrect password';
        }

        return response()->json(['success' => false, 'message' => $errorMessage], 401);
    }
}
