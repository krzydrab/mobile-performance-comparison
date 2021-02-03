package com.example.androidinterfacebulding;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.util.Log;
import android.view.Choreographer;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.TextView;

public class MainActivity extends AppCompatActivity {
    public enum TestType { Visibility, Swap, FullRebuild, NoChange }
    public enum ComponentType { Text, Button }

    // ====== Test parameters ======
    int NUMBER_OF_ROWS = 410;
    int NUMBER_OF_CHANGES = 10;
    TestType testType = TestType.Visibility;
    ComponentType componentType = ComponentType.Button;
    // =============================

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

    private RowData[] rows;
    private int firstInvisibleItemId;

    private RowData[] generateRows() {
        RowData[] rows = new RowData[NUMBER_OF_ROWS];
        for(int i = 0 ; i < rows.length ; i++) {
            // NOTE: Button inherits from TextView that's why it works
            TextView view = this.componentType == ComponentType.Text
                ? new TextView(this)
                : new Button(this);
            rows[i] = new RowData(view);
        }
        return rows;
    };

    void randomVisiblityChange() {
        for(int i = 0 ; i < this.NUMBER_OF_CHANGES; i++) {
            int pos = (firstInvisibleItemId + i) % this.rows.length;
            this.rows[pos].visibility = true;
        }
        firstInvisibleItemId += this.NUMBER_OF_CHANGES;
        firstInvisibleItemId %= this.rows.length;
        for(int i = 0 ; i < this.NUMBER_OF_CHANGES; i++) {
            int pos = (firstInvisibleItemId + i) % this.rows.length;
            this.rows[pos].visibility = false;
        }
    }

     void randomElementsSwap() {
        int itemsToChange = this.NUMBER_OF_CHANGES;
        while(itemsToChange > 0) {
           int i = (int)(Math.random() * this.rows.length);
           int j = (int)(Math.random() * this.rows.length);
           RowData temp = rows[i];
           rows[i] = rows[j];
           rows[j] = temp;
           itemsToChange -= 1;
       }
    }

    void fullRebuild() {
        rows = generateRows();
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
                switch(testType) {
                    case Visibility:
                        that.randomVisiblityChange();
                        break;
                    case Swap:
                        that.randomElementsSwap();
                        break;
                    case FullRebuild:
                        that.fullRebuild();
                        break;
                }
                if(testType != TestType.NoChange) {
                    that.rebuildUi();
                }
                Choreographer.getInstance().postFrameCallback(that.frameCallback);
            }
        };

        Choreographer.getInstance().postFrameCallback(frameCallback);
    }
}
