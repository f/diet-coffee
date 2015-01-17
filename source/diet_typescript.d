module diet_typescript;

auto partition = 0;

version (Have_vibe_d)
{
    static this()
    {
        import vibe.templ.diet, std.functional;
        registerDietTextFilter("typescript", &memoize!filterTypeScript);
    }
}

string filterTypeScript(string script, size_t indent)
in { assert(indent > 0); }
body
{
    partition++;
    version (Have_vibe_d)
    {
        import vibe.core.log;
        logDebug("compiling typescript");
    }
    import std.array, std.process, std.file, std.random, std.conv;

    string inputFile = "INLINE-TYPESCRIPT-" ~ to!string(partition) ~ ".ts";
    string outputFile = "/tmp/tsc-diet-compile-" ~ to!string(partition) ~ ".js";
    write(inputFile, script);
    auto pipes = pipeShell("tsc " ~ inputFile ~ " --out " ~ outputFile, Redirect.stderrToStdout | Redirect.stdout);
    scope(exit) wait(pipes.pid);
    foreach (line; pipes.stdout.byLine) logWarn(line.idup);

    string[] compiled = readText(outputFile).split("\n");
    remove(outputFile);
    remove(inputFile);

    auto indent_string = "\n";
    while (indent-- > 0) indent_string ~= '\t';
    auto res = appender!string();
    res ~= indent_string[0 .. $-1]~"<script type=\"text/javascript\">";
    res ~= indent_string~"//<![CDATA[";
    foreach (line; compiled) {
        res ~= indent_string~line;
    }
    res ~= indent_string~"//]]>";
    res ~= indent_string[0 .. $-1]~"</script>";

    return res.data;
}

unittest
{
    import std.algorithm;
    assert(filterTypeScript("3 + 2", 1).canFind("3 + 2"));
    assert(filterTypeScript("var foo = (a) => 2 * a", 1).canFind("foo = function (a)"));
}
