package com.github.hegde.mahesh.apisummarizer.elements;

public class JavaDocComment {
    public String comment;

    // TODO: Escape HTML tags, and optionally convert the familiar ones to markdown.

    // TODO: Build a detailed tree representation of JavaDocComment
    // which can be processed by tools in other languages as well.

    public JavaDocComment(String comment) {
        this.comment = comment;
    }
}
