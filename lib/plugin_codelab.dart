
import 'plugin_codelab_platform_interface.dart';

class PluginCodelab {
  Future<String?> getPlatformVersion() {
    return PluginCodelabPlatform.instance.getPlatformVersion();
  }

  Future<int?> onKeyDown(int key) {
    return PluginCodelabPlatform.instance.onKeyDown(key);
  }

  Future<int?> onKeyUp(int key) {
    return PluginCodelabPlatform.instance.onKeyUp(key);
  }

}
