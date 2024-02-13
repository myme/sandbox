.PHONY: clean

CXX_FLAGS := -Wall -Wextra -Wpedantic -std=c++20

hello: hello.cpp
	$(CXX) $(CXX_FLAGS) -o $@ $<

clean:
	rm -f compile_commands.json hello *.o
