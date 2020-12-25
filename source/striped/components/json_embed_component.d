module striped.components.json_embed_component;

mixin template JSONEmbedComponent()
{
    import std.json : JSONType;
    import std.string : format;
    import std.variant : Algebraic;

    mixin template embeddable(ObjectType, string propertyName, string jsonAttributeName = propertyName)
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
                    else if (ptr.type == JSONType.object)
                    {
                        result = ObjectType(*ptr);
                    }
                    else
                    {
                        assert(0); // TODO: Add error message.
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
