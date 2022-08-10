package com.github.hegde.mahesh.apisummarizer.disasm;

import com.github.hegde.mahesh.apisummarizer.elements.DeclKind;
import com.github.hegde.mahesh.apisummarizer.elements.TypeUsage;
import com.github.hegde.mahesh.apisummarizer.util.SkipMethodException;
import com.github.hegde.mahesh.apisummarizer.util.SkipTypeException;
import org.objectweb.asm.Type;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import static org.objectweb.asm.Opcodes.*;
import static org.objectweb.asm.Type.ARRAY;
import static org.objectweb.asm.Type.OBJECT;

class TypeUtils {
    public static String binaryName(String internalName) {
        return Type.getObjectType(internalName).getClassName();
    }

    public static String parentName(Type type) {
        return type.getClassName().split("\\$")[0];
    }

    public static String packageName(Type type) {
        var className = type.getClassName();
        var last = className.lastIndexOf(".");
        if (last != -1) {
            return className.substring(0, last);
        }
        return null;
    }

    public static String qualifiedName(Type type) {
        return type.getClassName().replace('$', '.');
    }

    public static String simpleName(Type type) {
        var internalName = type.getClassName();
        if (type.getInternalName().length() == 1) {
            return type.getClassName();
        }
        var components = internalName.split("[/$]");
        if (components.length == 0) {
            throw new SkipTypeException("Cannot derive simple name: " + internalName);
        }
        return components[components.length - 1];
    }

    public static TypeUsage typeUsage(Type type, String signature) {
        var usage = new TypeUsage();
        usage.shorthand = type.getClassName();
        switch (type.getSort()) {
            case OBJECT:
                usage.kind = TypeUsage.Kind.DECLARED;
                usage.type = new TypeUsage.DeclaredType(type.getClassName(),
                        TypeUtils.simpleName(type),null);
                break;
            case ARRAY:
                usage.kind = TypeUsage.Kind.ARRAY;
                usage.type = new TypeUsage.Array(TypeUtils.typeUsage(type.getElementType(), null));
                break;
            default:
                usage.kind = TypeUsage.Kind.PRIMITIVE;
                usage.type = new TypeUsage.PrimitiveType(type.getClassName());
        }
        // TODO: generics
        return usage;
    }

    public static Set<String> access(int access) {
        var result = new HashSet<String>();
        for (var ac : acc.entrySet()) {
            if ((ac.getValue() & access) != 0) {
                result.add(ac.getKey());
            }
        }
        return result;
    }

    private static final Map<String, Integer> acc = new HashMap<>();

    static {
        acc.put("static", ACC_STATIC);
        acc.put("private", ACC_PRIVATE);
        acc.put("protected", ACC_PROTECTED);
        acc.put("public", ACC_PUBLIC);
        acc.put("abstract", ACC_ABSTRACT);
        acc.put("final", ACC_FINAL);
        acc.put("native", ACC_NATIVE);
        // TODO: Add rest of them which matter;
    }

    static DeclKind declKind(int access) {
        if ((access & ACC_ENUM) != 0) return DeclKind.ENUM;
        if ((access & ACC_INTERFACE) != 0) return DeclKind.INTERFACE;
        if ((access & ACC_ANNOTATION) != 0) return DeclKind.ANNOTATION_TYPE;
        return DeclKind.CLASS;
    }

    static String defaultParamName(Type type) {
        switch (type.getSort()) {
            case ARRAY:
                return defaultParamName(type.getElementType()) + 's';
            case OBJECT:
                return simpleName(type);
            case Type.METHOD:
                throw new SkipMethodException("unexpected method type" + type);
            default: // Primitive type
                var typeCh = type.getInternalName().charAt(0);
                return String.valueOf(Character.toLowerCase(typeCh));
        }
    }
}