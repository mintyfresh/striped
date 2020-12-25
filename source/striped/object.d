module striped.object;

mixin template StripeObject()
{
    import std.json : JSONValue;
    import std.string : format;
    import std.typecons : Nullable;

    import striped.client;

private:
    StripeClient _client;
    string       _id;
    JSONValue    _object;

public:
    @disable this();

    this(StripeClient client)
    {
        _client = client;
        _object = JSONValue((string[string]).init);
    }

    this(StripeClient client, JSONValue object)
    {
        _client = client;
        _id     = object["id"].str;
        _object = object;
    }

    @property
    string id() const
    {
        return _id;
    }

    @property
    bool isPersisted() const
    {
        return _id !is null;
    }

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
