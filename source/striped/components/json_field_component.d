module striped.components.json_field_component;

mixin template JSONFieldComponent()
{
    import std.json : JSONValue, JSONType;
    import std.string : format;

    mixin template field(FieldType, string propertyName, string jsonAttributeName = propertyName)
    {
        import std.traits : isAssignable, isArray, isSomeString, ForeachType;

        static if (isArray!(FieldType) && !isSomeString!(FieldType))
        {
            alias T = const(ForeachType!(FieldType))[];
        }
        else static if (isAssignable!(FieldType, typeof(null)))
        {
            alias T = FieldType;
        }
        else
        {
            import std.typecons : Nullable;

            alias T = Nullable!(FieldType);
        }

        mixin(`
            @property
            T %s() const
            {
                typeof(return) result;

                if (const value = %s in _object)
                {
                    static if (is(FieldType == JSONValue))
                    {
                        result = *value;
                    }
                    else static if (isArray!(FieldType) && !isSomeString!(FieldType))
                    {
                        import std.algorithm : map;
                        import std.array : array;

                        result = value.array
                            .map!((element) => element.get!(ForeachType!(FieldType)))
                            .array;
                    }
                    else
                    {
                        result = value.get!(FieldType);
                    }
                }

                return result;
            }
        `.format(
            propertyName,
            jsonAttributeName.stringof
        ));

        mixin(`
            @property
            void %s(FieldType value)
            {
                _object[%s] = JSONValue(value);
            }
        `.format(
            propertyName,
            jsonAttributeName.stringof
        ));

        mixin(`
            @property
            void %s(typeof(null))
            {
                _object[%s] = JSONValue(null);
            }
        `.format(
            propertyName,
            jsonAttributeName.stringof
        ));
    }
}
