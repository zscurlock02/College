package com.example.tko_chess;

import org.junit.After;
import org.junit.Before;
import org.junit.FixMethodOrder;
import org.junit.Rule;
import org.junit.Test;
import org.junit.runner.OrderWith;
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

@FixMethodOrder(MethodSorters.NAME_ASCENDING)
@RunWith(AndroidJUnit4ClassRunner.class)
public class FriendsActivityTest {

	private static final int SIMULATED_DELAY_MS = 500;

	@Rule
	public ActivityScenarioRule<LogInActivity> activityRule1 = new ActivityScenarioRule<>(LogInActivity.class);

	@Before
	public void before(){
		Intents.init();
	}
	@After
	public void after(){
		Intents.release();
	}

	@Test
	public void Test1() {
		//Logs in
		String username = "tester7";
		String password = "password";

		onView(withId(R.id.UsernameText)).perform(typeText(username), closeSoftKeyboard());
		onView(withId(R.id.PasswordText)).perform(typeText(password), closeSoftKeyboard());

		onView(withId(R.id.LoginButton)).perform(click());

		try{
			Thread.sleep(SIMULATED_DELAY_MS);
		}catch (InterruptedException e){
		}

		onView(withId(R.id.MenuToFriendsBtn)).perform(click());

		try{
			Thread.sleep(SIMULATED_DELAY_MS);
		}catch (InterruptedException e){
		}

		//Views friends and sends friend request
		onView(withId(R.id.ViewFriendsBtn)).perform(click());

		onView(withId(R.id.SendFriendRequestText)).perform(typeText("tester2"), closeSoftKeyboard());

		onView(withId(R.id.SendFriendRequestBtn)).perform(click());

		onView(withId(R.id.SentFriendRequestBtn)).perform(click());
		//intended(hasComponent(MainMenuActivity.class.getCanonicalName()));
		try{
			Thread.sleep(SIMULATED_DELAY_MS);
		}catch (InterruptedException e){
		}
	}

	@Test
	public void Test2() {
		//Logs in
		String username = "tester7";
		String password = "password";

		onView(withId(R.id.UsernameText)).perform(typeText(username), closeSoftKeyboard());
		onView(withId(R.id.PasswordText)).perform(typeText(password), closeSoftKeyboard());

		onView(withId(R.id.LoginButton)).perform(click());

		try{
			Thread.sleep(SIMULATED_DELAY_MS);
		}catch (InterruptedException e){
		}

		onView(withId(R.id.MenuToFriendsBtn)).perform(click());

		try{
			Thread.sleep(SIMULATED_DELAY_MS);
		}catch (InterruptedException e){
		}

		//Views friends and sends friend request
		onView(withId(R.id.ViewFriendsBtn)).perform(click());

		onView(withId(R.id.SentFriendRequestBtn)).perform(click());
		onView(withId(R.id.ViewFriendsBtn)).perform(click());
		onView(withId(R.id.SentFriendRequestBtn)).perform(click());

		onView(withId(R.id.CancelFriendBtn)).perform(click());

		onView(withId(R.id.SendFriendRequestText)).perform(typeText("tester2"), closeSoftKeyboard());
		onView(withId(R.id.SendFriendRequestBtn)).perform(click());

		onView(withId(R.id.SentFriendRequestBtn)).perform(click());
		//intended(hasComponent(MainMenuActivity.class.getCanonicalName()));
		try{
			Thread.sleep(SIMULATED_DELAY_MS);
		}catch (InterruptedException e){
		}
	}

	@Test
	public void Test3() {
		//Logs in
		String username = "tester2";
		String password = "password";

		onView(withId(R.id.UsernameText)).perform(typeText(username), closeSoftKeyboard());
		onView(withId(R.id.PasswordText)).perform(typeText(password), closeSoftKeyboard());

		onView(withId(R.id.LoginButton)).perform(click());

		try{
			Thread.sleep(SIMULATED_DELAY_MS);
		}catch (InterruptedException e){
		}

		onView(withId(R.id.MenuToFriendsBtn)).perform(click());

		try{
			Thread.sleep(SIMULATED_DELAY_MS);
		}catch (InterruptedException e){
		}

		//Accept and remove friend
		//Int
		onView(withId(R.id.PendingFriendRequestBtn)).perform(click());
		//int
		//onView(withId(R.id.PendingFriendRequestBtn)).perform(click());

		try{
			Thread.sleep(SIMULATED_DELAY_MS);
		}catch (InterruptedException e){
		}

		//Int
		onView(withId(R.id.AcceptFriendBtn)).perform(click());
		//intended(hasComponent(MainMenuActivity.class.getCanonicalName()));

		try{
			Thread.sleep(SIMULATED_DELAY_MS);
		}catch (InterruptedException e){
		}
	}

	@Test
	public void Test4() {
		//Logs in
		String username = "tester2";
		String password = "password";

		onView(withId(R.id.UsernameText)).perform(typeText(username), closeSoftKeyboard());
		onView(withId(R.id.PasswordText)).perform(typeText(password), closeSoftKeyboard());

		onView(withId(R.id.LoginButton)).perform(click());

		try{
			Thread.sleep(SIMULATED_DELAY_MS);
		}catch (InterruptedException e){
		}

		onView(withId(R.id.MenuToFriendsBtn)).perform(click());

		try{
			Thread.sleep(SIMULATED_DELAY_MS);
		}catch (InterruptedException e){
		}

		onView(withId(R.id.ViewFriendsBtn)).perform(click());

		try{
			Thread.sleep(SIMULATED_DELAY_MS);
		}catch (InterruptedException e){
		}

		onView(withId(R.id.RemoveFriendBtn)).perform(click());

		onView(withId(R.id.PendingFriendRequestBtn)).perform(click());
		try{
			Thread.sleep(SIMULATED_DELAY_MS);
		}catch (InterruptedException e){
		}
		onView(withId(R.id.ViewFriendsBtn)).perform(click());

		//Sends friend request to tester8 to prep for next test
		onView(withId(R.id.SendFriendRequestText)).perform(typeText("tester7"), closeSoftKeyboard());
		onView(withId(R.id.SendFriendRequestBtn)).perform(click());
		//intended(hasComponent(MainMenuActivity.class.getCanonicalName()));

		try{
			Thread.sleep(SIMULATED_DELAY_MS);
		}catch (InterruptedException e){
		}
	}

	@Test
	public void Test5() {
		//Logs in
		String username = "tester7";
		String password = "password";

		onView(withId(R.id.UsernameText)).perform(typeText(username), closeSoftKeyboard());
		onView(withId(R.id.PasswordText)).perform(typeText(password), closeSoftKeyboard());

		onView(withId(R.id.LoginButton)).perform(click());

		try{
			Thread.sleep(SIMULATED_DELAY_MS);
		}catch (InterruptedException e){
		}

		onView(withId(R.id.MenuToFriendsBtn)).perform(click());

		try{
			Thread.sleep(SIMULATED_DELAY_MS);
		}catch (InterruptedException e){
		}

		//Views friends and sends friend request
		onView(withId(R.id.ViewFriendsBtn)).perform(click());
		try{
			Thread.sleep(SIMULATED_DELAY_MS);
		}catch (InterruptedException e){
		}
		onView(withId(R.id.PendingFriendRequestBtn)).perform(click());

		try{
			Thread.sleep(SIMULATED_DELAY_MS);
		}catch (InterruptedException e){
		}

		onView(withId(R.id.DenyFriendBtn)).perform(click());

		//intended(hasComponent(MainMenuActivity.class.getCanonicalName()));

		try{
			Thread.sleep(SIMULATED_DELAY_MS);
		}catch (InterruptedException e){
		}
	}
}
