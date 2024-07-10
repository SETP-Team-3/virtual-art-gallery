<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Artwork extends Model {
    use HasFactory;

    protected $table = 'artwork';
    protected $fillable = ['title', 'description', 'price', 'image', 'artist_id'];

    public function artist() {
        return $this->belongsTo(User::class, 'id');
    }

    public function buyer() {
        return $this->belongsTo(User::class, 'id');
    }
}
