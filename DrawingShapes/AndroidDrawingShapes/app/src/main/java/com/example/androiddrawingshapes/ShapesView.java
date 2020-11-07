package com.example.androiddrawingshapes;

import android.content.Context;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.LinearGradient;
import android.graphics.Paint;
import android.graphics.RadialGradient;
import android.graphics.Shader;
import android.util.AttributeSet;
import android.util.Log;
import android.view.View;

import androidx.annotation.Nullable;

public class ShapesView extends View {
    enum MODE { OVALS, RECTS };

    MODE mode = MODE.RECTS;
    int numberOfShapes = 1000;

    int width = 0;
    int height = 0;
    int ovalRadius = 0;
    int rectSize = 0;
    RadialGradient gradient;

    public ShapesView (Context context, @Nullable AttributeSet attrs) {
        super(context, attrs);
    }

    @Override
    protected void onMeasure(int widthMeasureSpec, int heightMeasureSpec) {
        Log.i("custom", "onMeasure");
        int width = MeasureSpec.getSize(widthMeasureSpec);
        int height = MeasureSpec.getSize(heightMeasureSpec);

        this.width = (int)(width * 0.8);
        this.height = (int)(height * 0.8);
        this.ovalRadius = (int) (width * 0.1 * 0.5);
        this.rectSize = (int) (width * 0.1);

        int yellow = Color.argb(30, 255, 255, 0);
        int red = Color.argb(100, 255, 0, 0);
        this.gradient = new RadialGradient(
            this.ovalRadius,
            this.ovalRadius,
            this.ovalRadius,
            red,
            yellow,
            Shader.TileMode.REPEAT
        );
        setMeasuredDimension(width, height);
    }

    protected void drawOvals(Canvas canvas) {
        Paint paint = new Paint();
        paint.setStyle(Paint.Style.FILL);

        paint.setShader(gradient);

        for(int i = 0 ; i < this.numberOfShapes; i++) {
            int left = (int)(Math.random() * (this.width - this.ovalRadius * 2));
            int top = (int)(Math.random() * (this.height - this.ovalRadius * 2));
            canvas.save();
            canvas.translate(left, top);
            canvas.drawOval(0, 0, this.ovalRadius * 2, this.ovalRadius * 2, paint);
            canvas.restore();
        }
    }

    protected void drawRects(Canvas canvas) {
        Paint paint = new Paint();
        paint.setStyle(Paint.Style.STROKE);

        for(int i = 0 ; i < this.numberOfShapes; i++) {
            int left = (int)(Math.random() * (this.width - this.rectSize));
            int top = (int)(Math.random() * (this.height - this.rectSize));
            float angle = (float)(Math.floor((Math.random() * 360)));
            canvas.save();
            canvas.translate(left, top);
            canvas.rotate(angle);
            canvas.drawRect(0, 0, this.rectSize, this.rectSize, paint);
            canvas.restore();
        }
    }

    protected void onDraw(Canvas canvas) {
        if(mode == MODE.RECTS) {
            this.drawRects(canvas);
        }
        else if(mode == MODE.OVALS) {
            this.drawOvals(canvas);
        }

        this.invalidate();
    }
}
