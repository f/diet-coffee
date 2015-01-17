# Diet plugin for TypeScript
![Screenshot](http://i.imgur.com/ehwuLWo.png)
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
    title Hello, TypeScript
  body
    :typescript
      class HelloWorld {
        constructor(id: number, name: string) {
           console.log("Hello world!");
        }
      }

      var typing = new TypeCheckDemo("hello", 1);
```

See [example](https://github.com/f/diet-typescript/tree/master/example) for a complete vibe.d app.
