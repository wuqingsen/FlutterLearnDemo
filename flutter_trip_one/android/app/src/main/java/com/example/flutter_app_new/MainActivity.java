package com.example.flutter_app_new;

import android.os.Bundle;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.example.flutter_app_new.asr_plugin.AsrPlugin;

import org.devio.flutter.splashscreen.SplashScreen;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        GeneratedPluginRegistrant.registerWith(flutterEngine);
        registerSelfPlugin();

    }

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        SplashScreen.show(this, false);//全屏展示
        super.onCreate(savedInstanceState);
    }

    private void registerSelfPlugin() {
//        AsrPlugin.registerWith(registra);
    }
}
