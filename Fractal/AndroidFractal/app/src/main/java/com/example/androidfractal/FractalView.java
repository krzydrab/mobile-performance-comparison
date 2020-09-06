package com.example.androidfractal;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.graphics.Rect;
import android.util.AttributeSet;
import android.util.Log;
import android.view.View;

import androidx.annotation.Nullable;

import static java.lang.Math.cos;
import static java.lang.Math.sin;
import static java.util.Collections.max;

public class FractalView extends View {

    private Paint paint;
    private long startTime;
    private int imageWidth;
    private int imageHeight;
    private int[] colors;

    public FractalView(Context context, @Nullable AttributeSet attrs) {
        super(context, attrs);
        init();

        this.startTime = System.currentTimeMillis();
    }

    private void init() {
        this.paint = new Paint();
        this.paint.setStyle(Paint.Style.FILL);
        this.paint.setColor(Color.BLACK);
    }

    private void initColorsArray() {
        // To get size from the template
        // this.imageHeight = (int) getMeasuredHeight();
        // this.imageWidth = (int) getMeasuredWidth();
        this.imageWidth = 300;
        this.imageHeight = 300;
        Log.i("custom", "size: " + this.imageHeight + " x " + this.imageWidth);
        this.colors = new int[imageHeight * imageWidth];
    }

    protected void onDraw(Canvas canvas) {
        if (colors == null) {
            initColorsArray();
        }

        long t0 = System.currentTimeMillis();

        double minRe = -2.0;
        double maxRe= 2.0;
        double minIm = -1.5;
        double maxIm = 1.5;

        double reFactor = (maxRe-minRe)/(imageWidth-1);
        double imFactor = (maxIm-minIm)/(imageHeight-1);

        long elapsedTime = System.currentTimeMillis() - startTime;
        double k_re = 0.0 + sin(elapsedTime * 0.001) * 0.4;
        double k_im = -0.5+ cos(elapsedTime * 0.001) * 0.4;
        int maxIterations = 30;
        int colorsOffset = 0;


        for(int y = 0; y < imageHeight; ++y) {
            // Map image coordinates to c on complex plane
            double c_im = maxIm - y*imFactor;
            double c_re = minRe;

            for(int x = 0; x < imageWidth; ++x, c_re += reFactor) {
                // Z[0] = c
                double Z_re = c_re;
                double Z_im = c_im;

                // Set default color
                colors[colorsOffset] = 0;

                for(int n = 0; n < maxIterations; ++n) {
                    // Z[n+1] = Z[n]^2 + K
                    // Z[n]^2 = (Z_re + Z_im*i)^2
                    //        = Z_re^2 + 2*Z_re*Z_im*i + (Z_im*i)^2
                    //        = Z_re^2 Z_im^2 + 2*Z_re*Z_im*i
                    double Z_re2 = Z_re * Z_re;
                    double Z_im2 = Z_im * Z_im;

                    if(Z_re2 + Z_im2 > 4) {
                        colors[colorsOffset] = Math.min(50 + n * 9, 255) << 16;
                        break;
                    }

                    Z_im = 2*Z_re*Z_im + k_im;
                    Z_re = Z_re2 - Z_im2 + k_re;
                }

                colorsOffset += 1;
            }
        }
        Bitmap bitmap = Bitmap.createBitmap(colors, imageWidth, imageHeight, Bitmap.Config.RGB_565);
        Rect dst = new Rect(0, 0, getMeasuredWidth(), getMeasuredHeight());
        canvas.drawBitmap(bitmap, null, dst, this.paint);
        Log.i("custom", "fractal view draw time: " + (System.currentTimeMillis() - t0));

        this.invalidate();
    }
}
