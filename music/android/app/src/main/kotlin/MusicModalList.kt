package com.example.music_sample
data class MusicModalList(
        val id: String,
        val title: String,
        val albums: String,
        val artist: String,
        val duration: String,
        val path: String,
)

class FinaljList(
        var musicMymusic: List<MusicModalList>,
)
