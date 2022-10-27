package com.github.dart_lang.jnigen.apisummarizer.util;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.github.dart_lang.jnigen.apisummarizer.elements.ClassDecl;
import java.io.IOException;
import java.util.List;

public class JsonUtil {
  public static void writeJSON(List<ClassDecl> classes) {
    var mapper = new ObjectMapper();
    Log.timed("Writing JSON");
    mapper.enable(SerializationFeature.INDENT_OUTPUT);
    mapper.setSerializationInclusion(JsonInclude.Include.NON_EMPTY);
    try {
      mapper.writeValue(System.out, classes);
    } catch (IOException e) {
      e.printStackTrace();
    }
    Log.timed("Finished");
  }
}
