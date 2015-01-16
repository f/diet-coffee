# Diet plugin for TypeScript

----

Compiles TypeScript in Diet templates to JavaScript and caches the result.

## Usage

To register the plugin you have to `import diet_typescript;` in your application.

```d
import vibe.d;
import diet_typescript;

//...

void hello(HTTPServerRequest req, HTTPServerResponse res)
{
    res.render!"typescript.dt"();
}
```

Now you can use the `:typescript` textfilter in your diet files.

```jade
doctype html
html
  head
    title Hello, CoffeeScript
  body
    :typescript
      window.onload = () => alert(document.title);
```

See [example](https://github.com/f/diet-typescript/tree/master/example) for a complete vibe.d app.
