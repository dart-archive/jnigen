package com.github.hegde.mahesh.apisummarizer;

import com.github.hegde.mahesh.apisummarizer.doclet.SummarizerDoclet;
import com.github.hegde.mahesh.apisummarizer.elements.ClassDecl;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;

public class DocletSummarizerTests {
    private List<ClassDecl> parsedDecls;
    private final Map<String, ClassDecl> classesByName = new HashMap<>();

    @Before
    public void setUp() {
        var opts = new Main.SummarizerOptions();
        opts.sourcePaths = "src/test/resources/";
        // javadoc tool API is quite inflexible, in that we cannot pass an doclet object, but a class
        // So any state we want to access from it has to be either serialized or saved in static fields.
        // This means we lose lot of control over loading of files etc..
        // Here, TestDoclet simply stores the result in a static variable which we can get and check later.
        Main.runDocletWithClass(SummarizerDoclet.TestDoclet.class, List.of("com.example.Example"), opts);
        parsedDecls = SummarizerDoclet.TestDoclet.getClassDecls();
        for (var decl : parsedDecls) {
            classesByName.put(decl.binaryName, decl);
        }
    }

    @Test
    public void checkNumberOfClasses() {
        Assert.assertEquals(2, parsedDecls.size());
    }

    @Test
    public void checkNamesOfClasses() {
        var names = parsedDecls.stream()
                .map(decl -> decl.binaryName)
                .collect(Collectors.toSet());
        assertTrue(names.contains("com.example.Example"));
        assertTrue(names.contains("com.example.Example$Aux"));
    }

    @Test
    public void checkNumberOfFieldsAndMethods() {
        var example = classesByName.get("com.example.Example");
        assertEquals("Example", example.simpleName);
        assertEquals(3, example.fields.size());
        assertEquals(3, example.methods.size());
    }
}
