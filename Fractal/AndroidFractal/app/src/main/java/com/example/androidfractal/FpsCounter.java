package com.example.androidfractal;

import android.util.Log;
import android.view.Choreographer;
import android.view.Choreographer.FrameCallback;

public class FpsCounter {
    static long lastTime = 0;
    static private FrameCallback frameCallback = new FrameCallback() {
        @Override
        public void doFrame(long _t) {
            long newTime = System.currentTimeMillis();
            double fps = 1000.0 / (newTime - lastTime);
            Log.i("custom", "FPS: " + fps);
            lastTime = newTime;
            Choreographer.getInstance().postFrameCallback(frameCallback);
        }
    };

    static public void start() {
        Choreographer.getInstance().postFrameCallback(frameCallback);
    }

    static public void stop() {
        Choreographer.getInstance().removeFrameCallback(frameCallback);
    }
}
