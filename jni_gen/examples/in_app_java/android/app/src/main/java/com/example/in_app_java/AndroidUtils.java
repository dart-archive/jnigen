package com.example.in_app_java;

import androidx.annotation.Keep;
import android.app.Activity;
import android.content.Context;
import android.widget.Toast;

@Keep
public class AndroidUtils {
  static void showToast(
      Activity mainActivity, CharSequence text, int duration) {
	mainActivity.runOnUiThread(() ->
		Toast.makeText(mainActivity, text, duration).show());
  }
}
