import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_codelab/plugin_codelab.dart';
import 'package:plugin_codelab/plugin_codelab_platform_interface.dart';
import 'package:plugin_codelab/plugin_codelab_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockPluginCodelabPlatform
    with MockPlatformInterfaceMixin
    implements PluginCodelabPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<int?> onKeyDown(int key) => Future.value(key);

  @override
  Future<int?> onKeyUp(int key) => Future.value(key);
}

void main() {
  final PluginCodelabPlatform initialPlatform = PluginCodelabPlatform.instance;
  late PluginCodelab pluginCodelabPlugin;
  late MockPluginCodelabPlatform fakePlatform;

  setUp(() {
    pluginCodelabPlugin = PluginCodelab();
    fakePlatform = MockPluginCodelabPlatform();
    PluginCodelabPlatform.instance = fakePlatform;
  });

  test('$MethodChannelPluginCodelab is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelPluginCodelab>());
  });

  test('getPlatformVersion', () async {
    expect(await pluginCodelabPlugin.getPlatformVersion(), '42');
  });

  test('onKeyDown', () async {
    expect(await pluginCodelabPlugin.onKeyDown(60), 60);
  });

  test('onKeyUp', () async {
    expect(await pluginCodelabPlugin.onKeyUp(61), 61);
  });
}
