# ****************************** Makefile setup ****************************** #
.PHONY: all run clean mrproper
.SECONDARY:


# *********************************** Paths ********************************** #
INC=include
SRC=src
OBJ=obj
BIN=bin
LIB=lib


# ****************************** Libraries setup ***************************** #
IRRLICHT_HOME = $(LIB)/irrlicht
IRRLICHT_NAME = Irrlicht
IRRLICHT_PATH = $(IRRLICHT_HOME)/lib/Linux/lib$(IRRLICHT_NAME).a
IRRLICHT_INCLUDE_PATH = $(IRRLICHT_HOME)/include
IRRLICHT_CXXFLAGS = -I$(IRRLICHT_INCLUDE_PATH) -I/usr/X11R6/include
IRRLICHT_CLFLAGS = -L$(IRRLICHT_HOME)/lib/Linux -L/usr/X11R6/lib -lIrrlicht \
		   -lGL -lXxf86vm -lXext -lX11 -lXcursor


# ************************** Compile/link parameters ************************* #
CXX = g++
CXXFLAGS = -I$(INC) $(IRRLICHT_CXXFLAGS) -c
CL = g++
CLFLAGS = $(IRRLICHT_CLFLAGS)


# **************************** General parameters **************************** #
EXEC = $(BIN)/main
EXEC_PARAMS = 


# ******************************* General rules ****************************** #
all: $(EXEC)


run: $(EXEC)
	./$(EXEC) $(EXEC_PARAMS)


# ******************************* Dependencies ******************************* #
$(BIN)/main: $(OBJ)/main.o $(OBJ)/tools.o $(IRRLICHT_PATH)
	@echo "Linking executable..."
	$(CL) $(CLFLAGS) -o $@ $^


$(OBJ)/main.o: $(SRC)/main.cpp $(INC)/graphical_cube.h
	@echo "Compiling main program..."
	$(CXX) $(CXXFLAGS) -o $@ $<


$(INC)/graphical_cube.h: $(INC)/rubik.h $(IRRLICHT_INCLUDE_PATH)/irrlicht.h
	touch $@


$(INC)/rubik.h: $(INC)/tools.h
	touch $@


$(OBJ)/tools.o: $(SRC)/tools.cpp $(INC)/tools.h
	$(CXX) $(CXXFLAGS) -o $@ $<

.PHONY: $(IRRLICHT_PATH)
$(IRRLICHT_PATH):
	cd $(IRRLICHT_HOME)/source/Irrlicht; make


# *********************************** Utils ********************************** #
clean:
	-rm $(OBJ)/*


mrproper: clean
	-rm $(EXEC)
