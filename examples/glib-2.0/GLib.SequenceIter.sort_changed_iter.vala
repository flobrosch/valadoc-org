public static int main (string[] args) {
	Sequence<string> seq = new Sequence<string> ();
	// Sorted data:
	seq.append ("1. Lorem");
	seq.append ("2. ipsum");
	seq.append ("4. sit");
	seq.append ("5. amet");


	seq.append ("3. dolor");
	SequenceIter<string> iter = seq.get_end_iter ().prev ();
	iter.sort_changed_iter ((a, b) => {
		return strcmp (a.get (), b.get ());
	});

	// Output:
	//  ``1. Lorem``
	//  ``2. ipsum``
	//  ``3. dolor``
	//  ``4. sit``
	//  ``5. amet``
	seq.foreach ((item) => {
		stdout.printf ("%s\n", item);
	});

	return 0;
}
