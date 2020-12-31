package com.example.androidfractal;

import android.util.Log;
import android.view.Choreographer;
import android.view.Choreographer.FrameCallback;

public class FpsCounter {
    static long lastTime = 0;
    public static long calculatingTime = 0;
    static int frames = 0;
    static private FrameCallback frameCallback = new FrameCallback() {
        @Override
        public void doFrame(long _t) {
            long newTime = System.currentTimeMillis();
            if(newTime - lastTime > 20000) {
                double fps = (double)(frames) / 20;
                double averageCalculatingTime = (double)(calculatingTime) / frames;
                frames = 0;
                calculatingTime = 0;
                lastTime = newTime;
                Log.i("custom", "FPS: " + fps + ", calculatingTime: " + averageCalculatingTime);
            }
            frames += 1;
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
