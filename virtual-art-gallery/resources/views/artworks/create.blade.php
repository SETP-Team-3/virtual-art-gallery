<!DOCTYPE html>
<html>
<head>
    <title>Create Artwork</title>
</head>
<body>
    <h1>Create Artwork</h1>
    @if ($errors->any())
        <div>
            <ul>
                @foreach ($errors->all() as $error)
                    <li>{{ $error }}</li>
                @endforeach
            </ul>
        </div>
    @endif
    <form action="{{ route('artworks.store') }}" method="POST" enctype="multipart/form-data">
        @csrf
        <label for="title">Title:</label>
        <input type="text" id="title" name="title" value="{{ old('title') }}"><br>
        <label for="description">Description:</label>
        <textarea id="description" name="description">{{ old('description') }}</textarea><br>
        <label for="price">Price:</label>
        <input type="text" id="price" name="price" value="{{ old('price') }}"><br>
        <label for="image">Image:</label>
        <input type="file" id="image" name="image"><br>
        <label for="artist_id">Artist ID:</label>
        <input type="text" id="artist_id" name="artist_id" value="{{ old('artist_id') }}"><br>
        <button type="submit">Submit</button>
    </form>
</body>
</html>
