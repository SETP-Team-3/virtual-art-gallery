<!DOCTYPE html>
<html>
<head>
    <title>Artworks</title>
</head>
<body>
    <h1>Artworks</h1>
    @if (session('success'))
        <div>{{ session('success') }}</div>
    @endif
    <ul>
        @foreach ($artworks as $artwork)
            <li>{{ $artwork->title }} - {{ $artwork->price }}</li>
        @endforeach
    </ul>
</body>
</html>
