module striped.object;

import std.json;
import std.string;

mixin template StripeObject(string stripeObjectType = null)
{
    import std.exception : enforce;
    import std.json : JSONValue, JSONType;
    import std.string : format;
    import std.variant : Algebraic;

    import striped.client;
    import striped.components.json_embed_component;
    import striped.components.json_field_component;
    import striped.exception;

    mixin JSONEmbedComponent;
    mixin JSONFieldComponent;

private:
    StripeClient _client;
    JSONValue    _object;

public:
    @disable this();

    this(StripeClient client)
    {
        _client = client;
        
        static if (stripeObjectType)
        {
            _object = JSONValue(["object": stripeObjectType]);
        }
        else
        {
            _object = JSONValue((string[string]).init);
        }
    }

    this(StripeClient client, JSONValue object)
    in
    {
        enforce(object.type == JSONType.object, new StripeJSONException(object, JSONType.object));

        static if (stripeObjectType)
        {
            enforce(object["object"].str == stripeObjectType, new StripeObjectTypeException(object, stripeObjectType));
        }
    }
    do
    {
        _client = client;
        _object = object;
    }

    mixin template identifier()
    {
        @property
        string id() const
        {
            auto ptr = "id" in _object;

            return ptr ? ptr.str : null;
        }

        @property
        bool isPersisted() const
        {
            return id !is null;
        }
    }

    mixin template expandable(ObjectType, string propertyName, string jsonAttributeName = propertyName)
    {
        alias T = Algebraic!(string, ObjectType, typeof(null));

        mixin(`
            @property
            T %s() const
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
    import striped.exception;

    struct TestObject
    {
        mixin StripeObject!("test");

        mixin identifier;
        mixin field!(string, "object");
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
            assert(expandable.object == "test");
        }
    );
}
