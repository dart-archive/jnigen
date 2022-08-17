package com.example;

public class Example {
    static final boolean staticFinalField = true;

    Example(int instanceField) {
        this.instanceField = instanceField;
    }

    static String staticField = "hello";
    static String getStaticField() {
        return staticField;
    }

    int instanceField;
    int getInstanceField() {
        return instanceField;
    }

    public static class Aux extends Example {
        static int nothing = 0;
        static Example getAnExample() {
            return new Example();
        }
    }
}
