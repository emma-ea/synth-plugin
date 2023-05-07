package com.plugin_codelab.plugin_codelab;

import android.os.Build;

import androidx.annotation.NonNull;

import java.util.ArrayList;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/** PluginCodelabPlugin */
public class PluginCodelabPlugin implements FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;
  private Synth synth;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "plugin_codelab");
    channel.setMethodCallHandler(this);
    synth = new SynthImpl();
    synth.start();
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    switch(call.method) {
      case "getPlatformVersion":
        result.success("Android >> " + Build.VERSION.RELEASE);
        break;
      case "onKeyDown":
        try {
          ArrayList arguments = (ArrayList) call.arguments;
          int numKeysDown = synth.keyDown((Integer) arguments.get(0));
          result.success(numKeysDown);
        } catch (Exception ex) {
          result.error("-1", ex.getMessage(), ex.getStackTrace());
        }
        break;
      case "onKeyUp":
        try {
          ArrayList arguments = (ArrayList) call.arguments;
          int numKeysDown = synth.keyUp((Integer) arguments.get(0));
          result.success(numKeysDown);
        } catch (Exception ex) {
          result.error("-1", ex.getMessage(), ex.getStackTrace());
        }
        break;
      default:
        result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }
}
