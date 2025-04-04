CMAKE useful flags 

* set DEBUG level

	available options are `Debug`, `Rlease`, `RelWithDebInfo`, `MinSizeRel`

	```sh
	cmake -DCMAKE_BUILD_TYPE {Debug, Release, RelWithDebInfo, MinSizeRel}
	```

* verbose output

	Cmake itslef verbose info

	```sh
	cmake --debug-output
	or 
	cmake --trace
	```

	if you want to see building verbose log, set `CMAKE_VERBOSE_MAKEFILE` to `ON`

	```sh
	cmake -DCMAKE_VERBOSE_MAKEFILE=ON
	```

	



