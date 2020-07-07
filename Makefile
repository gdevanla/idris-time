DEFAULT: CTimespec.idr
	 idris CTimespec.idr -o idris-time

clean:
	rm -f idris-time idris-time.ibc
