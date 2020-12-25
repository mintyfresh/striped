module striped.object;

mixin template StripeObject(string jsonDataField)
{
    import std.json : JSONValue;
    import std.typecons : Nullable;

    mixin template field(T, string propertyName, string jsonAttributeName = propertyName)
    {
        @property
        Nullable!(T) opDispatch(string method : propertyName)() const
        {
            typeof(return) result;

            if (const value = jsonAttributeName in __traits(getMember, this, jsonDataField))
            {
                result = value.get!(T);
            }

            return result;
        }

        @property
        void opDispatch(string method : propertyName)(T value)
        {
            __traits(getMember, this, jsonDataField)[jsonAttributeName] = JSONValue(value);
        }

        @property
        void opDispatch(string method : propertyName)(typeof(null))
        {
            __traits(getMember, this, jsonDataField)[jsonAttributeName] = JSONValue(null);
        }
    }
}
