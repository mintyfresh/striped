module striped.object;

import striped.exception;

import std.json;
import std.string;

class StripeJSONException : StripeException
{
private:
    JSONValue _value;
    JSONType  _expectedType;

public:
    this(JSONValue value, JSONType expectedType = JSONType.object,
         string file = __FILE__, size_t line = __LINE__, Throwable nextInChain = null)
    {
        const actualType = value.type;
        const message    = "Expected JSON type to be `%s`, but got `%s`".format(expectedType, actualType);

        super(message, file, line, nextInChain);

        _value        = value;
        _expectedType = expectedType;
    }

    @property
    JSONValue value() const
    {
        return _value;
    }

    @property
    JSONType expectedType() const
    {
        return _expectedType;
    }
}

class StripeObjectTypeException : StripeException
{
private:
    JSONValue _value;
    string  _expectedType;

public:
    this(JSONValue value, string expectedType,
         string file = __FILE__, size_t line = __LINE__, Throwable nextInChain = null)
    {
        const actualType = value["object"].str;
        const message    = "Excepted Stripe object to be `%s`, but got `%s`".format(expectedType, actualType);

        super(message, file, line, nextInChain);

        _value        = value;
        _expectedType = expectedType;
    }

    @property
    JSONValue value() const
    {
        return _value;
    }

    @property
    string expectedType() const
    {
        return _expectedType;
    }
}

mixin template StripeObject(string _stripeObjectType)
{
    import std.exception : enforce;
    import std.json : JSONValue, JSONType;
    import std.string : format;
    import std.typecons : Nullable;
    import std.variant : Algebraic;

    import striped.client;

private:
    StripeClient _client;
    string       _id;
    JSONValue    _object;

public:
    static immutable stripeObjectType = _stripeObjectType;

    @disable this();

    this(StripeClient client)
    {
        _client = client;
        _object = JSONValue(["object": stripeObjectType]);
    }

    this(StripeClient client, JSONValue object)
    in
    {
        enforce(object.type == JSONType.object, new StripeJSONException(object, JSONType.object));
        enforce(object["object"].str == stripeObjectType, new StripeObjectTypeException(object, stripeObjectType));
    }
    do
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

    mixin template expandable(ObjectType, string propertyName, string jsonAttributeName = propertyName)
    {
        mixin(`
            @property
            Algebraic!(string, ObjectType, typeof(null)) %s() const
            {
                typeof(return) result;

                if (auto ptr = %s in _object)
                {
                    if (ptr.type == JSONType.null_)
                    {
                        result = null;
                    }
                    else if (ptr.type == JSONType.string)
                    {
                        result = ptr.str;
                    }
                    else if (ptr.type == JSONType.object)
                    {
                        result = ObjectType(_client, *ptr);
                    }
                    else
                    {
                        assert(0); // TODO: Add helpful error message.
                    }
                }
                else
                {
                    result = null;
                }

                return result;
            }
        `.format(
            propertyName,
            jsonAttributeName.stringof
        ));
    }
}

version (unittest)
{
    import std.exception;
    import std.json;
    import std.variant : visit;

    import striped.client;

    struct TestObject
    {
        mixin StripeObject!("test");

        mixin expandable!(TestObject, "expandable");
    }
}

unittest
{
    const client = StripeClient("sk_test_1");

    TestObject(client, parseJSON("[]")).assertThrown!(StripeJSONException);
}

unittest
{
    const client = StripeClient("sk_test_1");

    TestObject(client, parseJSON(`
        {
            "id": "to_12345",
            "object": "charge"
        }
    `)).assertThrown!(StripeObjectTypeException);
}

unittest
{
    const client = StripeClient("sk_test_1");
    const object = TestObject(client, parseJSON(`
        {
            "id": "to_12345",
            "object": "test",
            "expandable": "ex_12345"
        }
    `));

    assert(object.expandable == "ex_12345");
}

unittest
{
    const client = StripeClient("sk_test_1");
    const object = TestObject(client, parseJSON(`
        {
            "id": "to_12345",
            "object": "test"
        }
    `));

    assert(object.expandable == null);
}

unittest
{
    const client = StripeClient("sk_test_1");
    const object = TestObject(client, parseJSON(`
        {
            "id": "to_12345",
            "object": "test",
            "expandable": null
        }
    `));

    assert(object.expandable == null);
}

unittest
{
    const client = StripeClient("sk_test_1");
    const object = TestObject(client, parseJSON(`
        {
            "id": "to_12345",
            "object": "test",
            "expandable": {
                "id": "ex_12345",
                "object": "test"
            }
        }
    `));

    object.expandable.visit!(
        (string) { assert(0, "Incorrect expandable type."); },
        (TestObject expandable) {
            assert(expandable.id == "ex_12345");
            assert(expandable.stripeObjectType == "test");
        }
    );
}
