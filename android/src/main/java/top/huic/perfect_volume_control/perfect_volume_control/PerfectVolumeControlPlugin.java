package top.huic.perfect_volume_control.perfect_volume_control;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.media.AudioManager;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/**
 * PerfectVolumeControlPlugin
 */
public class PerfectVolumeControlPlugin implements FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private MethodChannel channel;

    /**
     * 音频管理器
     */
    private AudioManager audioManager;

    /**
     * 隐藏系统音量图标
     */
    private Boolean hideUI = false;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "perfect_volume_control");
        channel.setMethodCallHandler(this);
        audioManager = (AudioManager) flutterPluginBinding.getApplicationContext().getSystemService(Context.AUDIO_SERVICE);

        // 注册音量监听
        VolumeReceiver volumeReceiver = new VolumeReceiver();
        IntentFilter filter = new IntentFilter();
        filter.addAction("android.media.VOLUME_CHANGED_ACTION");
        flutterPluginBinding.getApplicationContext().registerReceiver(volumeReceiver, filter);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        switch (call.method) {
            case "getVolume":
                this.getVolume(call, result);
                break;
            case "setVolume":
                this.setVolume(call, result);
                break;
            case "hideUI":
                this.hideUI(call, result);
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
    }

    /**
     * 获得音量
     */
    public void getVolume(@NonNull MethodCall call, @NonNull Result result) {
        int max = audioManager.getStreamMaxVolume(AudioManager.STREAM_MUSIC);
        int current = audioManager.getStreamVolume(AudioManager.STREAM_MUSIC);
        result.success((double) current / (double) max);
    }

    /**
     * 设置音量
     */
    public void setVolume(@NonNull MethodCall call, @NonNull Result result) {
        Double volume = call.argument("volume");
        if (volume == null) {
            result.error("-1", "Volume cannot be empty", "Volume cannot be empty");
            return;
        }
        int max = audioManager.getStreamMaxVolume(AudioManager.STREAM_MUSIC);
        audioManager.setStreamVolume(AudioManager.STREAM_MUSIC, (int) Math.round(max * volume), hideUI ? AudioManager.FLAG_REMOVE_SOUND_AND_VIBRATE : AudioManager.FLAG_SHOW_UI);
        result.success(null);
    }

    /**
     * 隐藏UI
     */
    public void hideUI(@NonNull MethodCall call, @NonNull Result result) {
        this.hideUI = call.argument("hide");
        result.success(null);
    }

    /**
     * 音量监听
     */
    private class VolumeReceiver extends BroadcastReceiver {
        @Override
        public void onReceive(Context context, Intent intent) {
            if (intent.getAction().equals("android.media.VOLUME_CHANGED_ACTION")) {
                int max = audioManager.getStreamMaxVolume(AudioManager.STREAM_MUSIC);
                int current = audioManager.getStreamVolume(AudioManager.STREAM_MUSIC);
                channel.invokeMethod("volumeChangeListener", (double) current / (double) max);
            }
        }
    }
}
