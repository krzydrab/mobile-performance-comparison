package com.example.androidinterfacebulding;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.util.Log;
import android.view.Choreographer;
import android.widget.LinearLayout;
import android.widget.TextView;

public class MainActivity extends AppCompatActivity {
    int NUMBER_OF_ROWS = 50;

    class RowData {
        int id;
        double value;
        boolean visibility = true;
        TextView view;

        RowData(TextView view) {
            this.id = (int)(Math.random() * 10000);
            this.value = Math.random();
            this.view = view;
            this.view.setText(String.format("Row: %f", this.value));
        }
    }

    private RowData[] generateRows() {
        RowData[] rows = new RowData[NUMBER_OF_ROWS];
        for(int i = 0 ; i < rows.length ; i++) {
            TextView view = new TextView(this);
            rows[i] = new RowData(view);
        }
        return rows;
    };

    private RowData[] rows;

    private void randomVisiblityChange() {
        int itemsToChange = 2;

        while(itemsToChange > 0) {
            int pos = (int)(Math.random() * this.rows.length);
            this.rows[pos].visibility = !this.rows[pos].visibility;
            itemsToChange -= 1;
        }
    }

     void randomElementsSwap() {
           int itemsToChange = 2;
           while(itemsToChange > 0) {
               int i = (int)(Math.random() * this.rows.length);
               int j = (int)(Math.random() * this.rows.length);
               RowData temp = rows[i];
               rows[i] = rows[j];
               rows[j] = temp;
               itemsToChange -= 1;
           }
    }

    void rebuildUi() {
        LinearLayout layout = findViewById(R.id.linear_layout);
        layout.removeAllViews();
        for(int i = 0 ; i < rows.length ; i++) {
            if(rows[i].visibility) {
                layout.addView(rows[i].view);
            }
        }
    }

    Choreographer.FrameCallback frameCallback = null;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        FpsCounter.start();

        this.rows = generateRows();

        final MainActivity that = this;
        this.frameCallback = new Choreographer.FrameCallback() {
            @Override
            public void doFrame(long _t) {
                that.randomVisiblityChange();
                that.rebuildUi();
                Choreographer.getInstance().postFrameCallback(that.frameCallback);
            }
        };

        Choreographer.getInstance().postFrameCallback(frameCallback);
    }
}
