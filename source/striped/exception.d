module striped.exception;

class StripeException : Exception
{
    @nogc @safe
    this(string msg, string file = __FILE__, size_t line = __LINE__, Throwable nextInChain = null) pure nothrow
    {
        super(msg, file, line, nextInChain);
    }
}
