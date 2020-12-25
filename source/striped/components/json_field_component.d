module striped.components.json_field_component;

mixin template JSONFieldComponent()
{
    import std.json : JSONValue, JSONType;
    import std.string : format;
    import std.typecons : Nullable;

    mixin template field(T, string propertyName, string jsonAttributeName = propertyName)
    {
        mixin(`
            @property
            Nullable!(T) %s() const
            {
                typeof(return) result;

                if (const value = %s in _object)
                {
                    result = value.get!(T);
                }

                return result;
            }
        `.format(
            propertyName,
            jsonAttributeName.stringof
        ));

        mixin(`
            @property
            void %s(T value)
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
