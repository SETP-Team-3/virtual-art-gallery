<?php
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\ArtworkController;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    return view('welcome');
});

Route::get('/artworks', [ArtworkController::class, 'index'])->name('artworks.index');
Route::get('/artworks/create', [ArtworkController::class, 'create'])->name('artworks.create');
Route::post('/artworks', [ArtworkController::class, 'store'])->name('artworks.store');