module striped.components.json_field_component;

mixin template JSONFieldComponent()
{
    import std.json : JSONValue, JSONType;
    import std.string : format;

    mixin template field(FieldType, string propertyName, string jsonAttributeName = propertyName)
    {
        import std.traits : isAssignable;

        static if (isAssignable!(FieldType, typeof(null)))
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
                    static if (is(T == JSONValue))
                    {
                        result = *value;
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
