package com.example.androidalgorithms;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Spinner;
import android.widget.TextView;

import com.example.androidalgorithms.algorithms.AckermannFunction;
import com.example.androidalgorithms.algorithms.GaussElimination;
import com.example.androidalgorithms.algorithms.SelectSort;
import com.example.androidalgorithms.testers.AckermannFunctionTester;
import com.example.androidalgorithms.testers.AlgorithmTester;
import com.example.androidalgorithms.testers.GaussEliminationTester;
import com.example.androidalgorithms.testers.SelectSortTester;

public class MainActivity extends AppCompatActivity implements AdapterView.OnItemSelectedListener {

    private enum Algorithm { SelectSort, AckermannFunction, GaussElimination };
    private Algorithm algorithm = Algorithm.SelectSort;

    public void onStartBtnClicked(View view) {
        AlgorithmTester tester = buildTester();
        AlgorithmTester.Result[] results = tester.testAll(0, 9);
        String strResult = "";
        for(int i = 0 ; i < results.length; i++) {
            double timeInSec = results[i].time / 1000000000.0;
            strResult += String.format("%s : %f s \n", results[i].description, timeInSec);
        }

        Log.i("custom", strResult);
        TextView textView = findViewById(R.id.timeText);
        textView.setText(strResult);
    }

    protected AlgorithmTester buildTester() {
        AlgorithmTester tester;
        switch (this.algorithm) {
            case AckermannFunction:
                tester = new AckermannFunctionTester();
                break;
            case GaussElimination:
                tester = new GaussEliminationTester();
                break;
            case SelectSort:
            default:
                tester = new SelectSortTester();
                break;
        }
        return tester;
    }

    protected void initSelectBox() {
        Algorithm[] algorithms = Algorithm.values();
        String[] algorithmNames = new String[algorithms.length];
        for (int i = 0; i < algorithms.length; i++) {
            algorithmNames[i] = algorithms[i].name();
        }
        Spinner dropdown = (Spinner) findViewById(R.id.algorithmSpinner);
        ArrayAdapter<String> adapter = new ArrayAdapter<>(
                this,
                android.R.layout.simple_spinner_dropdown_item, algorithmNames
        );
        dropdown.setAdapter(adapter);
        dropdown.setOnItemSelectedListener(this);
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        initSelectBox();
    }

    @Override
    public void onItemSelected(AdapterView<?> adapterView, View view, int pos, long l) {
        String selectedValue = adapterView.getItemAtPosition(pos).toString();
        this.algorithm = Algorithm.valueOf(selectedValue);
    }

    @Override
    public void onNothingSelected(AdapterView<?> adapterView) {
        // do nothing
    }
}
