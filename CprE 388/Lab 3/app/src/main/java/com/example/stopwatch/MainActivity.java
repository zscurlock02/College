package com.example.stopwatch;

import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;
import androidx.lifecycle.Observer;
import androidx.lifecycle.ViewModelProvider;

public class MainActivity extends AppCompatActivity {

    private StopwatchViewModel viewModel;
    private TextView stopwatchDisplay;
    private Button start, stop, reset;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        viewModel = new ViewModelProvider(this).get(StopwatchViewModel.class);
        stopwatchDisplay = findViewById(R.id.time_view);
        start = findViewById(R.id.start_button);
        stop = findViewById(R.id.stop_button);
        reset = findViewById(R.id.reset_button);

        viewModel.getElapsedTimeDisplay().observe(this, new Observer<String>(){
            @Override
            public void onChanged(String elapsedTime){
                stopwatchDisplay.setText(elapsedTime);
            }
        });

        start.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                viewModel.start();
                start.setEnabled(false);
                stop.setEnabled(true);
                reset.setEnabled(true);
                start.setText("Start");
            }
        });

        stop.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                viewModel.stop();
                start.setEnabled(true);
                stop.setEnabled(false);
                start.setText("Resume");
            }
        });

        reset.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                viewModel.reset();
                start.setEnabled(true);
                stop.setEnabled(false);
                reset.setEnabled(false);
            }
        });
    }
}
