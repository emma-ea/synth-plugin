import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:plugin_codelab/plugin_codelab.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight]).then((value) {
    runApp(const MyApp());
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _pluginCodelabPlugin = PluginCodelab();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String platformVersion;

    try {
      platformVersion =
          await _pluginCodelabPlugin.getPlatformVersion() ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  void _onKeyUp(int key) {
    print('key up: $key');
    _pluginCodelabPlugin.onKeyUp(key);
  }

  void _onKeyDown(int key) {
    print('key down: $key');
    _pluginCodelabPlugin.onKeyDown(key);
  }

  _KeyType _setKey() {
    if (_prevKeyWhite) {
      _prevKeyWhite = false;
      return _KeyType.black;
    } else {
      _prevKeyWhite = true;
      return _KeyType.white;
    }
  }

  bool _prevKeyWhite = false;

  Widget _makeKey({required _KeyType keyType, required int key}) {
    return AnimatedContainer(
      height: 200,
      width: 44,
      duration: const Duration(seconds: 2),
      curve: Curves.easeIn,
      child: Material(
        color: keyType == _KeyType.white
            ? Colors.white
            : const Color.fromARGB(255, 60, 60, 80),
        child: InkWell(
          onTap: () => _onKeyUp(key),
          onTapDown: (details) => _onKeyDown(key),
          onTapCancel: () => _onKeyUp(key),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.redAccent,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Running on: $_platformVersion\n'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for (int key = 60; key <= 71; key++)
                      _makeKey(keyType: _setKey(), key: key)
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum _KeyType { black, white }
