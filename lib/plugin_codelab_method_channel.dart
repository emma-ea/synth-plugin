import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'plugin_codelab_platform_interface.dart';

/// An implementation of [PluginCodelabPlatform] that uses method channels.
class MethodChannelPluginCodelab extends PluginCodelabPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('plugin_codelab');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<int?> onKeyDown(int key) async {
    final int? numNotesOn = await methodChannel.invokeMethod('onKeyDown', [key]);
    return numNotesOn;
  }

  @override
  Future<int?> onKeyUp(int key) async {
    final int? numNotesOn = await methodChannel.invokeMethod('onKeyUp', [key]);
    return numNotesOn;
  }

}
