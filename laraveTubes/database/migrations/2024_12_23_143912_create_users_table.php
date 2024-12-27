<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateUsersTable extends Migration
{
    /**
     * Jalankan migration untuk membuat tabel users.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('users', function (Blueprint $table) {
            $table->id();  // Kolom id (primary key)
            $table->string('name');  // Kolom name
            $table->string('email')->unique();  // Kolom email dengan constraint unique
            $table->string('password');  // Kolom password
            $table->timestamps();  // Kolom created_at dan updated_at
        });
    }

    /**
     * Undo migration (drop tabel users).
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('users');
    }
}
