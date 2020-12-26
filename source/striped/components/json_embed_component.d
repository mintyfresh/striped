module striped.components.json_embed_component;

mixin template JSONEmbedComponent()
{
    import std.json : JSONType;
    import std.string : format;
    import std.variant : Algebraic;

    mixin template embeddable(ObjectType, string propertyName, string jsonAttributeName = propertyName)
    {
        alias EmbeddableType = Algebraic!(ObjectType, typeof(null));

        mixin(`
            @property
            EmbeddableType %s() const
            {
                typeof(return) result = void;

                if (auto ptr = %s in _object)
                {
                    result = buildEmbeddableObject(*ptr);
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

        EmbeddableType buildEmbeddableObject(JSONValue value) const
        {
            import std.string : format;
            import std.traits : isArray, isSomeString;

            switch (value.type)
            {
                case JSONType.null_:
                    return EmbeddableType(null);

                static if (isArray!(ObjectType) && !isSomeString!(ObjectType))
                {
                    case JSONType.array:
                        import std.algorithm : map;
                        import std.array : array;
                        import std.traits : ForeachType;

                        return EmbeddableType(
                            value.array
                                 .map!((element) => ForeachType!(ObjectType)(_client, element))
                                 .array
                        );
                }
                else
                {
                    case JSONType.object:
                        return EmbeddableType(ObjectType(value));
                }

                default:
                    assert(0, "Unsupported data type for `%s`. Got: JSON %s.".format(propertyName, value.type));
            }
        }
    }
}
