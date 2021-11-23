package com.example.flutter_app_new.asr_plugin;

import android.util.Log;

import androidx.annotation.Nullable;

import io.flutter.plugin.common.MethodChannel;

/**
 * wuqingsen on 11/18/21
 * Mailbox:807926618@qq.com
 * annotation:
 */
public class ResultStateful implements MethodChannel.Result {
    private final static String TAG = "wqs ASR-ResultStateful-";
    private MethodChannel.Result result;
    private boolean called;

    public static ResultStateful of(MethodChannel.Result result) {
        return new ResultStateful(result);
    }

    private ResultStateful(MethodChannel.Result result) {
        this.result = result;
    }


    @Override
    public void success(@Nullable Object o) {
        if (called) {
            Log.e(TAG, "success: 错误");
            return;
        }
        called = true;
        result.success(o);
    }

    @Override
    public void error(String s, @Nullable String s1, @Nullable Object o) {

        if (called) {
            Log.e(TAG, "success: 错误");
            return;
        }
        called = true;
        result.error(s, s1, o);
    }

    @Override
    public void notImplemented() {

        if (called) {
            Log.e(TAG, "success: 错误");
            return;
        }
        called = true;
        result.notImplemented();
    }
}
