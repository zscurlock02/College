package com.example.tko_chess;

import org.junit.After;
import org.junit.Before;
import org.junit.FixMethodOrder;
import org.junit.Rule;
import org.junit.Test;
import org.junit.internal.runners.JUnit4ClassRunner;
import org.junit.runner.RunWith;


import androidx.lifecycle.Lifecycle;
import androidx.test.espresso.intent.Intents;
import androidx.test.ext.junit.rules.ActivityScenarioRule;
import androidx.test.filters.LargeTest;
import androidx.test.internal.runner.junit4.AndroidJUnit4ClassRunner;


import static androidx.test.espresso.Espresso.onView;
import static androidx.test.espresso.action.ViewActions.click;
import static androidx.test.espresso.action.ViewActions.closeSoftKeyboard;
import static androidx.test.espresso.action.ViewActions.typeText;
import static androidx.test.espresso.assertion.ViewAssertions.matches;
import static androidx.test.espresso.matcher.ViewMatchers.withId;
import static androidx.test.espresso.matcher.ViewMatchers.withText;
import static org.hamcrest.core.StringEndsWith.endsWith;
import static androidx.test.espresso.intent.Intents.intended;
import static androidx.test.espresso.intent.matcher.IntentMatchers.hasComponent;
import android.util.Log;

import org.junit.runner.RunWith;
import org.junit.runners.MethodSorters;

import java.nio.charset.Charset;
import java.util.Random;

@FixMethodOrder(MethodSorters.NAME_ASCENDING)
@RunWith(AndroidJUnit4ClassRunner.class)
public class RegisterActivityTest {

    private static final int SIMULATED_DELAY_MS = 500;
    @Rule
    public ActivityScenarioRule<LogInActivity> activityRule = new ActivityScenarioRule<>(LogInActivity.class);

    @Before
    public void before(){
        Intents.init();
    }
    @After
    public void after(){
        Intents.release();
    }

    @Test
    public void RegistrationTest(){

        Random rand = new Random();
        int upperbound = 99999999;
        int lowerbound = 10000000;
        int int_random = rand.nextInt(upperbound - lowerbound + 1) + lowerbound;
        String username = String.valueOf(int_random);
        String password = String.valueOf(int_random);

        try{
            Thread.sleep(SIMULATED_DELAY_MS);
        }catch (InterruptedException e){
        }

        onView(withId(R.id.toRegisterBtn)).perform(click());

        try{
            Thread.sleep(SIMULATED_DELAY_MS);
        }catch (InterruptedException e){
        }

        onView(withId(R.id.RegUsernameText)).perform(typeText(username), closeSoftKeyboard());
        onView(withId(R.id.RegPasswordText)).perform(typeText(password), closeSoftKeyboard());
        onView(withId(R.id.ConfirmPasswordText)).perform(typeText(password), closeSoftKeyboard());

        try{
            Thread.sleep(SIMULATED_DELAY_MS);
        }catch (InterruptedException e){
        }

        onView(withId(R.id.RegisterBtn)).perform(click());

        try{
            Thread.sleep(SIMULATED_DELAY_MS);
        }catch (InterruptedException e){
        }

        onView(withId(R.id.MenuToLoginBtn)).perform(click());

        try{
            Thread.sleep(SIMULATED_DELAY_MS);
        }catch (InterruptedException e){
        }

        onView(withId(R.id.UsernameText)).perform(typeText(username), closeSoftKeyboard());
        onView(withId(R.id.PasswordText)).perform(typeText(password), closeSoftKeyboard());

        try{
            Thread.sleep(SIMULATED_DELAY_MS);
        }catch (InterruptedException e){
        }
        onView(withId(R.id.LoginButton)).perform(click());

        try{
            Thread.sleep(SIMULATED_DELAY_MS);
        }catch (InterruptedException e){
        }

        onView(withId(R.id.MenuToProfileBtn)).perform(click());

        intended(hasComponent(ProfileActivity.class.getCanonicalName()));

        try{
            Thread.sleep(SIMULATED_DELAY_MS);
        }catch (InterruptedException e){
        }
    }
}
