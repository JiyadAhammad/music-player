package com.example.music

import android.Manifest
import android.annotation.SuppressLint
import android.content.pm.PackageManager
import android.os.Build
import android.provider.MediaStore
import android.util.Log
import androidx.annotation.RequiresApi
import com.example.music_sample.MusicModalList
import com.google.gson.Gson
import com.google.gson.GsonBuilder
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.util.*
import kotlin.collections.ArrayList

private const val CHANNEL = "search_files_in_storage/search"

class MainActivity : FlutterActivity() {

        private val requestCode = 100

        @SuppressLint("NewApi")
        override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
                super.configureFlutterEngine(flutterEngine)
                MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
                                .setMethodCallHandler { call, result ->
                                        if (call.method == "search") {
                                                var _result = requestPermissionAndListFiles()
                                                if (!_result) {
                                                        result.error(
                                                                        "401",
                                                                        "No READ_EXTERNAL_STORAGE permission",
                                                                        ""
                                                        )
                                                        return@setMethodCallHandler
                                                } else {
                                                        Log.i(
                                                                        "FILE_CHECKING",
                                                                        "Searching for " +
                                                                                        call.arguments
                                                        )
                                                        var _r = getAllAudio()
                                                        if (_r == null) {
                                                                result.error(
                                                                                "404",
                                                                                "FAILED if (Environment.MEDIA_MOUNTED == state || Environment.MEDIA_MOUNTED_READ_ONLY == state)",
                                                                                ""
                                                                )
                                                                return@setMethodCallHandler
                                                        } else {
                                                                result.success(_r)
                                                        }
                                                }
                                        }
                                }
        }

        private fun requestPermissionAndListFiles(): Boolean {
                Log.e("PERMISSION", "getting permission status")
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M &&
                                                checkSelfPermission(
                                                                Manifest.permission
                                                                                .READ_EXTERNAL_STORAGE
                                                ) != PackageManager.PERMISSION_GRANTED
                ) {
                        // requestPermissions(arrayOf(Manifest.permission.READ_EXTERNAL_STORAGE),
                        // requestCode)
                        return false
                } else {
                        return true
                }
        }

        @SuppressLint("Recycle", "Range")
        @RequiresApi(Build.VERSION_CODES.R)
        private fun getAllAudio(): String {
                val templistclass = ArrayList<MusicModalList>()
              
                val selection = MediaStore.Audio.Media.IS_MUSIC + " != 0"
                val projection =
                                arrayOf(
                                                MediaStore.Audio.Media.`_ID`,
                                                MediaStore.Audio.Media.TITLE,
                                                MediaStore.Audio.Media.ALBUM,
                                                MediaStore.Audio.Media.ARTIST,
                                                MediaStore.Audio.Media.DURATION,
                                                MediaStore.Audio.Media.DATE_ADDED,
                                                MediaStore.Audio.Media.DATA,
                                                MediaStore.Audio.Media.ALBUM_ARTIST
                                )

                val cursor =
                                this.contentResolver.query(
                                                MediaStore.Audio.Media.EXTERNAL_CONTENT_URI,
                                                projection,
                                                selection,
                                                null,
                                                MediaStore.Audio.Media.DATE_ADDED + " DESC",
                                                null
                                )
                if (cursor != null) {
                        if (cursor.moveToFirst())
                                        do {
                                                val titleC =
                                                                cursor.getString(
                                                                                cursor.getColumnIndex(
                                                                                                MediaStore.Audio
                                                                                                                .Media
                                                                                                                .TITLE
                                                                                )
                                                                )
                                                var idC =
                                                                cursor.getString(
                                                                                cursor.getColumnIndex(
                                                                                                MediaStore.Audio
                                                                                                                .Media
                                                                                                                .`_ID`
                                                                                )
                                                                )
                                                val albumC =
                                                                cursor.getString(
                                                                                cursor.getColumnIndex(
                                                                                                MediaStore.Audio
                                                                                                                .Media
                                                                                                                .ALBUM
                                                                                )
                                                                )
                                                val artistC =
                                                                cursor.getString(
                                                                                cursor.getColumnIndex(
                                                                                                MediaStore.Audio
                                                                                                                .Media
                                                                                                                .ARTIST
                                                                                )
                                                                )
                                                val pathC =
                                                                cursor.getString(
                                                                                cursor.getColumnIndex(
                                                                                                MediaStore.Audio
                                                                                                                .Media
                                                                                                                .DATA
                                                                                )
                                                                )
                                                val durationC =
                                                                cursor.getString(
                                                                                cursor.getColumnIndex(
                                                                                                MediaStore.Audio
                                                                                                                .Media
                                                                                                                .DURATION
                                                                                )
                                                                )
                                                // String albumImage =
                                                // String.valueOf(ContentUris.withAppendedId(Uri.parse("content://media/external/audio/albumart"),idC));
                                                //                    val albumImage
                                                // =Uri.parse("content://media/external/audio/albumart")
                                                //                    val  images:Uri=
                                                // ContentUris.withAppendedId(albumImage ,idC )
                                                //                    tempListMapMusic.put("id",idC)
                                                //
                                                // tempListMapMusic.put("title",titleC)
                                                //
                                                // tempListMapMusic.put("album",albumC)
                                                //
                                                // tempListMapMusic.put("artist",artistC)
                                                //
                                                // tempListMapMusic.put("path",pathC)
                                                //
                                                // templistFinal.add(tempListMapMusic)

                                                var music =
                                                                MusicModalList(
                                                                                id = idC,
                                                                                title = titleC,
                                                                                albums = albumC,
                                                                                artist = artistC,
                                                                                path = pathC,
                                                                                duration = durationC
                                                                )

                                                templistclass.add(music)

                                                //
                                                //// //
                                                //                    title.add(titleC)
                                                //                    id.add(idC)
                                                //                    album.add(albumC)
                                                //                    artist.add(artistC)
                                                //                    pathss.add(pathC)
                                                //                    //
                                                // imagess.add(bitmap.toString())
                                                //                    durationk.add(durationC)

                                        } while (cursor.moveToNext())
                        //            tempList.put("title", title)
                        //            tempList.put("id", id)
                        //            tempList.put("album", album)
                        //            tempList.put("artist", artist)
                        //            tempList.put("path", pathss)
                        //            tempList.put("image", imagess)
                        //            tempList.put("duration", durationk)

                        cursor.close()

                        //
                        //
                        //
                        //            tempList.put("title",id)

                        //            val gson = Gson()
                        //            Log.i("array", tempList.toString())
                        //            val musicsssss=FinaljList(musicMymusic = templistclass)
                        //            val musicssssjson=JSONArray(musicsssss)
                        //
                        //
                        //            println("last array hashmap in kotlin $musicssssjson")
                }
                //        val gson = Gson()
                //        val gsonPretty = GsonBuilder().setPrettyPrinting().create()
                //        val tutMap: ArrayList<MusicModalList> = templistclass
                //        println("musiclist3" + tutMap.toString())
                //        val jsonTutMap = gson.toJson(templistclass)
                //        println("musiclist" + jsonTutMap)

                //        val jsonTutMapPretty = gsonPretty.toJson(jsonTutMap)
                //        println("musiclist1$jsonTutMapPretty")
                //
                // val json1=JSONObject()
                //        val gson2 = GsonBuilder().create()
                //        val myCustomArray = gson2.toJsonTree(myMusicSampleSongs).asJsonArray
                //
                //
                //
                //        println("jasonexample kotlin" + myCustomArray)

                //        val a = finaljList(musicMymusic = myCustomArray)

                //        val listdata = arrayListOf<String>()
                //
                //        val gson3 = Gson()
                //        val arrayTutorialType = object : TypeToken<Array<MusicModalList>>()
                // {}.type
                //        var tutorials: Array<MusicModalList> = gson3.fromJson(myCustomArray,
                // arrayTutorialType)
                //        tutorials.forEachIndexed { idx, tut -> listdata.add(tut.toString()) }
                //        println("new array string $listdata")

                //
                //        val json =
                //            """{"title": "Kotlin Tutorial", "author": "bezkoder", "categories" :
                // ["Kotlin","Basic"]}"""
                //
                //       val mapType = object : TypeToken<Map<String, Any>>() {}.type
                //
                //
                //
                //        val myMusicSampleSongs=FinaljList(musicMymusic=templistclass)
                //        val myMusicjson =JSONArray(myMusicSampleSongs)
                //
                //
                //        val gson2 = GsonBuilder().create()
                //        val myCustomArray = gson2.toJsonTree(myMusicjson).asJsonArray
                //
                //
                //
                //        println("jasonexample kotlin$myCustomArray")

                //        val gson10 = Gson()
                //        val mapType2 = object : TypeToken<Map<String, Any>>() {}.type
                //        var tutorialMap: Map<String, Any> =
                // gson10.fromJson(myMusicjson.getString(1), object : TypeToken<Map<String, Any>>()
                // {}.type)
                //        tutorialMap.forEach { println(it) }

                //
                val gson = Gson()
                val gsonPretty = GsonBuilder().setPrettyPrinting().create()
                val tut = templistclass
                val jsonTut: String = gson.toJson(tut)
                // println(jsonTut)

                //        val jsonTutPretty: String = gsonPretty.toJson(tut)
                //        println(jsonTutPretty)

                return jsonTut

                //        return gson2.fromJson(
                //            myCustomArray,
                //            object : TypeToken<Map<String, Any>>() {}.type
                //        )

        }
}
