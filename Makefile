BUILD_DIR = ./bin
LIB_CPP_FILES = ./src/*.cpp
LIB_LINKING_PATH = -L$(BUILD_DIR)

CC=g++
CFlags=-Wall

all: buildLibs buildmain			# Make all

$(BUILD_DIR)/%.o: src/%.cpp
	$(CC) $(CFlags) -c $^ -o $@

#libmyFuncs.dylib:						# Compiling .dylib from the .o files THIS ALSO WORKS
#	$(CC) -dynamiclib $(CFlags) $(LIB_CPP_FILES) -o $(BUILD_DIR)/$@

libmyFuncs.dylib:						# Compiling .dylib from the .o files
	$(CC) $(CFlags) -fPIC -shared $(LIB_CPP_FILES) -o $(BUILD_DIR)/$@

libmyFuncsStatic.a: $(BUILD_DIR)/addInts.o $(BUILD_DIR)/multInts.o
	ar rcs $(BUILD_DIR)/$@ $^

buildLibs: libmyFuncs.dylib libmyFuncsStatic.a


#### Building executables ####
main: main.cpp							# Compiling executable linking to individual .o files
	$(CC) $(CFlags) -Iinclude -o $@ main.cpp $(BUILD_DIR)/*.o

mainDylib: main.cpp libmyFuncs.dylib	# Compiling executable that links to dylib
	$(CC) $(CFlags) -Iinclude -o $@ main.cpp $(BUILD_DIR)/libmyFuncs.dylib

mainStatic: libmyFuncsStatic.a
	$(CC) $(CFlags) -static -o main main.o $(LIB_LINKING_PATH) -lmyFuncsStatic.a

buildmain: main mainDylib mainStatic

clean: 									# Deleting files
	rm -r main mainDylib $(BUILD_DIR)/*