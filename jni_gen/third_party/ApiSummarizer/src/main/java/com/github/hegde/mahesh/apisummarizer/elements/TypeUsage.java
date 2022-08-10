package com.github.hegde.mahesh.apisummarizer.elements;

import java.util.List;

public class TypeUsage {
    public enum Kind {
        DECLARED,
        TYPE_VARIABLE,
        WILDCARD,
        ARRAY,
        INTERSECTION,
        PRIMITIVE,
    }

    // Could've made made it just a type hierarchy
    // But client code parsing JSON often needs to know the type beforehand.
    public String shorthand;
    public Kind kind;
    public ReferredType type;

    public abstract static class ReferredType {}

    public static class PrimitiveType extends ReferredType {
        public String name;

        // TODO: Is this required? The shorthand will be always same as name for a primitive type.
        public PrimitiveType(String name) {
            this.name = name;
        }
    }

    public static class DeclaredType extends ReferredType {
        public String binaryName;
        public String simpleName;
        public List<TypeUsage> params;

        public DeclaredType(String binaryName, String simpleName, List<TypeUsage> params) {
            this.binaryName = binaryName;
            this.simpleName = simpleName;
            this.params = params;
        }
    }

    public static class TypeVar extends ReferredType {
        public String name;

        public TypeVar(String name) {
            this.name = name;
        }
    }

    public static class Wildcard extends ReferredType {
        public TypeUsage extendsBound, superBound;

        public Wildcard(TypeUsage extendsBound, TypeUsage superBound) {
            this.extendsBound = extendsBound;
            this.superBound = superBound;
        }
    }

    public static class Intersection extends ReferredType {
        public List<TypeUsage> types;

        public Intersection(List<TypeUsage> types) {
            this.types = types;
        }
    }

    public static class Array extends ReferredType {
        public TypeUsage type;

        public Array(TypeUsage type) {
            this.type = type;
        }
    }
}
