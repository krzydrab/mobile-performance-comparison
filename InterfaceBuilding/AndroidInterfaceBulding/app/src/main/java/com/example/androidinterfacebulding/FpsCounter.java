package com.example.androidinterfacebulding;

import android.util.Log;
import android.view.Choreographer;
import android.view.Choreographer.FrameCallback;

public class FpsCounter {
    static long lastTime = 0;
    static int frames = 0;
    static private FrameCallback frameCallback = new FrameCallback() {
        @Override
        public void doFrame(long _t) {
            long newTime = System.currentTimeMillis();
            if(newTime - lastTime > 1000) {
                double fps = frames;
                frames = 0;
                lastTime = newTime;
                Log.i("custom", "FPS: " + fps);
            }
            frames += 1;
//            long newTime = System.currentTimeMillis();
//            double fps = 1000.0 / (newTime - lastTime);
//            Log.i("custom", "FPS: " + fps);
//            lastTime = newTime;
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