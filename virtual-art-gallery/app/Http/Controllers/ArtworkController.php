<?php
namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Artwork;

class ArtworkController extends Controller {
    public function index() {
        $artworks = Artwork::all();
        return view('artworks.index', compact('artworks'));
    }

    public function create() {
        return view('artworks.create');
    }

    public function store(Request $request) {
        $request->validate([
            'title' => 'required',
            'description' => 'required',
            'price' => 'required|numeric',
            'image' => 'required|image|max:2048',
            'id' => 'required|exists:user,id'
        ]);

        $imagePath = $request->file('image')->store('artwork_images', 'public');

        Artwork::create([
            'title' => $request->title,
            'description' => $request->description,
            'price' => $request->price,
            'image_path' => $imagePath,
            'id' => $request->id
        ]);

        return redirect()->route('artworks.index')->with('success', 'Artwork created successfully.');
    }
}
