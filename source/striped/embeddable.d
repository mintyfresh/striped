module striped.embeddable;

mixin template Embeddable()
{
    import std.json : JSONValue;

    import striped.components.json_embed_component;
    import striped.components.json_field_component;

    mixin JSONEmbedComponent;
    mixin JSONFieldComponent;

private:
    JSONValue _object = JSONValue((string[string]).init);

public:
    this(JSONValue object)
    {
        _object = object;
    }
}
