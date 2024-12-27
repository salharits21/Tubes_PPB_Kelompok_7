<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\ApiController;

Route::post('/api/register', [apiController::class, 'register']);
Route::post('/api/login', [apiController::class, 'login']);


