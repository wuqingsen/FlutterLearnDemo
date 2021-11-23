package com.example.flutter_app_new.asr_plugin;

import android.Manifest;
import android.app.Activity;
import android.content.pm.PackageManager;

import androidx.annotation.NonNull;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

import java.util.ArrayList;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

/**
 * wuqingsen on 11/18/21
 * Mailbox:807926618@qq.com
 * annotation:
 */
public class AsrPlugin implements MethodChannel.MethodCallHandler {
    ResultStateful resultStateful;

    private final static String TAG = "wqs ASR-";
    private final Activity activity;
    private AsrManager asrManager;

    public AsrPlugin(PluginRegistry.Registrar registrar) {
        this.activity = registrar.activity();
    }

    public static void registerWith(PluginRegistry.Registrar registrar) {
        MethodChannel channel = new MethodChannel(registrar.messenger(), "asr-plugin");
        AsrPlugin instance = new AsrPlugin(registrar);
        channel.setMethodCallHandler(instance);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall methodCall,
                             @NonNull MethodChannel.Result result) {
        initPermission();
        switch (methodCall.method) {
            case "start":
                resultStateful = ResultStateful.of(result);
                start(methodCall, resultStateful);
                break;
            case "stop":
                stop(methodCall, result);
                break;
            case "cancel":
                cancel(methodCall, result);
                break;
            default:
                result.notImplemented();

        }
    }

    private void start(MethodCall methodCall,
                       ResultStateful resultStateful) {
        if (activity == null) {
            resultStateful.error("activity is null", null, null);
            return;
        }
        if (getAsrManager() != null) {
            getAsrManager().start(methodCall.arguments
                    instanceof Map ? (Map) methodCall.arguments : null);
        } else {
            resultStateful.error("getAsrManager is null", null, null);
        }
    }

    private void stop(MethodCall methodCall,
                      MethodChannel.Result resultStateful) {
        if (asrManager != null) {
            asrManager.stop();
        }
    }

    private void cancel(MethodCall methodCall,
                        MethodChannel.Result resultStateful) {
        if (asrManager != null) {
            asrManager.cancel();
        }
    }

    @NonNull
    private AsrManager getAsrManager() {
        if (asrManager == null) {
            if (activity != null && activity.isFinishing()) {
                asrManager = new AsrManager(activity, onAsrListener);
            }
        }
        return asrManager;
    }

    private OnAsrListener onAsrListener = new OnAsrListener() {
        @Override
        public void onAsrReady() {

        }

        @Override
        public void onAsrBegin() {

        }

        @Override
        public void onAsrEnd() {

        }

        @Override
        public void onAsrPartialResult(String[] results, RecogResult recogResult) {

        }

        @Override
        public void onAsrOnlineNluResult(String nluResult) {

        }

        @Override
        public void onAsrFinalResult(String[] results, RecogResult recogResult) {
            if (resultStateful != null) {
                resultStateful.success(results[0]);
            }
        }

        @Override
        public void onAsrFinish(RecogResult recogResult) {

        }

        @Override
        public void onAsrFinishError(int errorCode, int subErrorCode, String descMessage, RecogResult recogResult) {
            if (resultStateful != null) {
                resultStateful.error(descMessage, null, null);
            }
        }

        @Override
        public void onAsrLongFinish() {

        }

        @Override
        public void onAsrVolume(int volumePercent, int volume) {

        }

        @Override
        public void onAsrAudio(byte[] data, int offset, int length) {

        }

        @Override
        public void onAsrExit() {

        }

        @Override
        public void onOfflineLoaded() {

        }

        @Override
        public void onOfflineUnLoaded() {

        }
    };

    /**
     * android 6.0 以上需要动态申请权限
     */
    private void initPermission() {
        String permissions[] = {Manifest.permission.RECORD_AUDIO,
                Manifest.permission.ACCESS_NETWORK_STATE,
                Manifest.permission.INTERNET,
                Manifest.permission.WRITE_EXTERNAL_STORAGE
        };

        ArrayList<String> toApplyList = new ArrayList<String>();

        for (String perm : permissions) {
            if (PackageManager.PERMISSION_GRANTED != ContextCompat.checkSelfPermission(activity, perm)) {
                toApplyList.add(perm);
                //进入到这里代表没有权限.

            }
        }
        String tmpList[] = new String[toApplyList.size()];
        if (!toApplyList.isEmpty()) {
            ActivityCompat.requestPermissions(activity, toApplyList.toArray(tmpList), 123);
        }

    }
}
