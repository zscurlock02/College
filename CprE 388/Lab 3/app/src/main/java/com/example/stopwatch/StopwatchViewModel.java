package com.example.stopwatch;

import androidx.lifecycle.MutableLiveData;
import androidx.lifecycle.ViewModel;

import java.util.Timer;
import java.util.TimerTask;

public class StopwatchViewModel extends ViewModel {

    private long startTime = 0;
    private boolean isRunning = false;
    private long elapsedTime = 0;

    private Timer timer;

    private MutableLiveData<String> elapsedTimeDisplay = new MutableLiveData<>();

    public MutableLiveData<String> getElapsedTimeDisplay(){
        return elapsedTimeDisplay;
    }

    public void start(){
        if(!isRunning){
            startTime = System.currentTimeMillis() - elapsedTime;
            isRunning = true;

            timer = new Timer();
            timer.schedule(new TimerTask(){
               @Override
               public void run(){
                   long currentTime = System.currentTimeMillis();
                   elapsedTime = currentTime - startTime;
                   updateElapsedTimeDisplay(elapsedTime);
               }
            }, 0, 10);
        }
    }

    public void stop(){
        if(isRunning){
            isRunning = false;
            if(timer != null){
                timer.cancel();
            }
        }
    }

    public void reset(){
        isRunning = false;
        elapsedTime = 0;
        updateElapsedTimeDisplay(elapsedTime);

        startTime = System.currentTimeMillis();

        if(timer != null){
            timer.cancel();
        }
    }

    private void updateElapsedTimeDisplay(long milliseconds) {
        long hours = milliseconds / 3600000;
        long minutes = (milliseconds % 3600000) / 60000;
        long seconds = (milliseconds % 60000) / 1000;
        long tenths = (milliseconds % 1000) / 100;

        String elapsedTimeString = String.format("%02d:%02d:%02d.%d", hours, minutes, seconds, tenths);
        elapsedTimeDisplay.postValue(elapsedTimeString);
    }
}
