package com.plugin_codelab.plugin_codelab;

public interface Synth {
    void start();
    void end();
    int keyDown(int key);
    int keyUp(int key);
}
