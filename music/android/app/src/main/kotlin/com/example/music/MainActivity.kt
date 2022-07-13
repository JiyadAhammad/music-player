package com.example.music

import android.Manifest
import android.content.pm.PackageManager
import android.os.Build
import android.os.Bundle
import android.os.Environment
import android.os.PersistableBundle
import android.util.Log
import android.view.View
import android.widget.Toast
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File

private const val CHANNEL = "search_files_in_storage/search"

class MainActivity: FlutterActivity() {

    private val requestCode = 100

    override fun onCreate(savedInstanceState: Bundle?, persistentState: PersistableBundle?) {

        super.onCreate(savedInstanceState, persistentState)
        // requestPermissionAndListFiles();
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result ->
            if(call.method == "search")
            {
               var _result = requestPermissionAndListFiles();
                if(!_result){
                result.error("401", "No READ_EXTERNAL_STORAGE permission","")
                    return@setMethodCallHandler
                }

                else{
                    Log.i("FILE_CHECKING","Searching for "+call.arguments);
                   var _r =  listExternalStorage(call.arguments as List<String>)
                    if(_r == null)
                    {
                        result.error("404", "FAILED if (Environment.MEDIA_MOUNTED == state || Environment.MEDIA_MOUNTED_READ_ONLY == state)","")
                        return@setMethodCallHandler
                    }else{
                        result.success(_r);
                    }

                }
            }

        }
    }

    private fun requestPermissionAndListFiles():Boolean {
        Log.e("PERMISSION" , "getting permission status")
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M && checkSelfPermission(Manifest.permission.READ_EXTERNAL_STORAGE) != PackageManager.PERMISSION_GRANTED) {
            //requestPermissions(arrayOf(Manifest.permission.READ_EXTERNAL_STORAGE), requestCode)
            return false;
        } else {
            return true;
        }
    }

    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<out String>, grantResults: IntArray) {
        if (requestCode == this.requestCode) {
            if (grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                // Permission is granted
               // listExternalStorage()
            } else {
                Toast.makeText(this, "Until you grant the permission, I cannot list the files", Toast.LENGTH_SHORT)
                        .show()
            }
        }
    }

    private fun listExternalStorage(query:List<String>):List<String>? {
        val state = Environment.getExternalStorageState()

        if (Environment.MEDIA_MOUNTED == state || Environment.MEDIA_MOUNTED_READ_ONLY == state) {

            return listFiles(Environment.getExternalStorageDirectory(),query)
        }else{
            return null;
        }
    }

    /**
     * Recursively list files from a given directory.
     */
    private fun listFiles(directory: File,query:List<String>):List<String> {
        var foundList = arrayListOf<String>()
        val files = directory.listFiles()
        if (files != null) {
            for (file in files) {
                if (file != null) {
                    if (file.isDirectory) {
                        foundList.addAll( listFiles(file,query))
                    } else {
                        var path = file.absolutePath;
                        Log.w("FILE_CHECKING",path + "\n")
                        query.forEach { extension->
                           if( path.endsWith(extension))
                           {
                               foundList.add(path);
                           }
                        }
                    }
                }
            }
        }
        return  foundList
    }
    }

