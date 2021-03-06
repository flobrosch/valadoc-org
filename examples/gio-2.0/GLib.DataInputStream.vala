public static void write_data (DataOutputStream dos) throws GLib.IOError {
	dos.put_int16 (int16.MIN);
	dos.put_int32 (int32.MIN);
	dos.put_int64 (int64.MIN);

	dos.put_uint16 (uint16.MAX);
	dos.put_uint32 (uint32.MAX);
	dos.put_uint64 (uint64.MAX);

	dos.put_byte ('c');
	dos.put_string ("Northwest Passage");
	dos.put_byte ('\0');

	dos.put_string ("Barrett's Privateers");
	dos.put_byte ('\0');
}

public static void read_data (DataInputStream dis) throws GLib.IOError {
	stdout.printf ("%d (Expected: %d)\n", dis.read_int16 (), int16.MIN);
	stdout.printf ("%d (Expected: %d)\n", dis.read_int32 (), int32.MIN);
	stdout.printf ("%"+int64.FORMAT+" (Expected: %"+int64.FORMAT+")\n", dis.read_int64 (), int64.MIN);

	stdout.printf ("%u (Expected: %u)\n", dis.read_uint16 (), uint16.MAX);
	stdout.printf ("%u (Expected: %u)\n", dis.read_uint32 (), uint32.MAX);
	stdout.printf ("%"+uint64.FORMAT+" (Expected: %"+uint64.FORMAT+")\n", dis.read_uint64 (), uint64.MAX);

	stdout.printf ("%c\n", dis.read_byte ());

	stdout.printf ("%s\n", dis.read_upto ("\0", 1, null));
	dis.read_byte (); // Consume '\0'

	stdout.printf ("%s\n", dis.read_upto ("\0", 1, null));
	dis.read_byte (); // Consume '\0'
}

public static async void read_data_async (DataInputStream dis) throws GLib.IOError {
	stdout.printf ("%d (Expected: %d)\n", dis.read_int16 (), int16.MIN);
	stdout.printf ("%d (Expected: %d)\n", dis.read_int32 (), int32.MIN);
	stdout.printf ("%"+int64.FORMAT+" (Expected: %"+int64.FORMAT+")\n", dis.read_int64 (), int64.MIN);

	stdout.printf ("%u (Expected: %u)\n", dis.read_uint16 (), uint16.MAX);
	stdout.printf ("%u (Expected: %u)\n", dis.read_uint32 (), uint32.MAX);
	stdout.printf ("%"+uint64.FORMAT+" (Expected: %"+uint64.FORMAT+")\n", dis.read_uint64 (), uint64.MAX);

	stdout.printf ("%c\n", dis.read_byte ());

	stdout.printf ("%s\n", yield dis.read_upto_async ("\0", 1, Priority.DEFAULT, null, null));
	dis.read_byte (); // Consume '\0'

	stdout.printf ("%s\n", yield dis.read_upto_async ("\0", 1, Priority.DEFAULT, null, null));
	dis.read_byte (); // Consume '\0'
}

public static int main (string[] args) {
	try {
		// Create a file that can only be accessed by the current user:
		File file = File.new_for_path ("my-test.bin");
		FileIOStream ios = file.create_readwrite (FileCreateFlags.PRIVATE);

		// Write data:
		DataOutputStream dos = new DataOutputStream (ios.output_stream);
		write_data (dos);

		// Reset fp, read data:
		ios.seek (0, SeekType.SET);
		DataInputStream dis = new DataInputStream (ios.input_stream);
		read_data (dis);

		// Reset fp, read data async:
		ios.seek (0, SeekType.SET);

		MainLoop loop = new MainLoop ();
		read_data_async.begin (dis, () => {
			loop.quit ();
		});

		loop.run ();
	} catch (Error e) {
		stdout.printf ("Error: %s\n", e.message);
	}

	return 0;
}
