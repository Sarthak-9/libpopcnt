.PHONY: all popcnt avx2 help

COMPILER=$(notdir $(CXX))
FLAGS=-O2 -Wall -pedantic -Wextra -Werror -Wno-unused-parameter -Wno-c++11-long-long

all: test.cpp libpopcnt.h
	$(CXX) $(FLAGS) test.cpp -o test

popcnt: test.cpp libpopcnt.h
	$(CXX) $(FLAGS) -mpopcnt -DHAVE_POPCNT test.cpp -o test

avx2: test.cpp libpopcnt.h
	$(CXX) $(FLAGS) -mpopcnt -DHAVE_POPCNT -mavx2 -DHAVE_AVX2 test.cpp -o test

help:
	@echo "targets:"
	@echo "all      - Runs portable integer popcount test"
	@echo "popcnt   - Runs POPCNT popcount test"
	@echo "avx2     - Runs AVX2 popcount test"

check: all
	./test

clean:
	rm -f ./test
