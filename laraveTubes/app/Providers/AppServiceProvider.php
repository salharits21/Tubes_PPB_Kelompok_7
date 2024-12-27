<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;
use Illuminate\Support\Facades\Route;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     *
     * @return void
     */
    public function register()
    {
        //
    }

    /**
     * Bootstrap any application services.
     *
     * @return void
     */
    public function boot()
    {
        // Pastikan rute api.php dimuat
        Route::prefix('api')->middleware('api')->namespace($this->app->getNamespace().'Http\Controllers\Api')->group(base_path('routes/api.php'));
    }
}
