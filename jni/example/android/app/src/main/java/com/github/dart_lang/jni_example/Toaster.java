package com.github.dart_lang.jni_example;

import android.app.Activity;
import android.content.Context;
import android.widget.Toast;
import androidx.annotation.Keep;

@Keep
class Toaster {
  static Toaster makeText(
      Activity mainActivity, Context context, CharSequence text, int duration) {
    Toaster toast = new Toaster();
    toast.mainActivity = mainActivity;
    toast.context = context;
    toast.text = text;
    toast.duration = duration;
    return toast;
  }

  void show() {
    mainActivity.runOnUiThread(() -> Toast.makeText(context, text, duration).show());
  }

  Activity mainActivity;
  Context context;
  CharSequence text;
  int duration;
}
