#include <graphical_cube.h>
#include <iostream>

int main() {
    GraphicalRubikCube<3> cube = GraphicalRubikCube<3>(L"Rubik Cube", 512, 512);
    
    cube.RotateFace(LEFT, CLOCKWISE, 0);
    std::cout << cube << std::endl << std::endl;
    cube.RotateFace(TOP, COUNTERCLOCKWISE, 1);
    std::cout << cube << std::endl;
    
    while(cube.ShouldContinue()) {
        cube.UpdateFrame();
    }
    
    return 0;
}
