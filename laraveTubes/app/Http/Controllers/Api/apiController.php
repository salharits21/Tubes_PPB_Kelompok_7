<?php

namespace App\Http\Controllers\Api;

use App\Models\User;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Hash;

class apiController extends Controller
{
    // Handle Register
    public function register(Request $request)
    {
        // Validasi input
        $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|email|unique:users,email',
            'password' => 'required|string|min:6|confirmed',
        ]);

        // Membuat user baru
        $user = User::create([
            'name' => $request->name,
            'email' => $request->email,
            'password' => Hash::make($request->password),
        ]);

        // Mengembalikan response JSON
        return response()->json([
            'message' => 'Registrasi berhasil!',
            'user' => $user
        ], 201);
    }

    // Handle Login
    public function login(Request $request)
    {
        // Validasi input
        $request->validate([
            'username_or_email' => 'required|string',
            'password' => 'required|string',
        ]);

        // Cari user berdasarkan email atau username
        $user = User::where('email', $request->username_or_email)
            ->orWhere('name', $request->username_or_email)
            ->first();

        if ($user && Hash::check($request->password, $user->password)) {
            // Berhasil login
            return response()->json([
                'message' => 'Login berhasil',
                'user' => $user,
            ], 200);
        }

        return response()->json([
            'message' => 'Email/Username atau password salah'
        ], 401);
    }
}
