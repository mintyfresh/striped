module striped.exception;

import std.json;
import std.format;

class StripeException : Exception
{
    @nogc @safe
    this(string msg, string file = __FILE__, size_t line = __LINE__, Throwable nextInChain = null) pure nothrow
    {
        super(msg, file, line, nextInChain);
    }
}

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
