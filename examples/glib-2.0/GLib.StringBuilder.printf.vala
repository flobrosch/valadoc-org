public static int main (string[] args) {
	// Output: ``hello, world!``
	StringBuilder builder = new StringBuilder ("foo bar foobar");
	builder.printf ("%s,%s!\n", "hello", "world");
	stdout.puts (builder.str);
	return 0;
}
