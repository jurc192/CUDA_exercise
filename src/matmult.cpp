/*
    My very first program in c++
    square a vector
*/
#include <iostream>

#define ARR_SIZE    64

int main()
{

    // Allocate array
    float *vec_a = new float[ARR_SIZE];
    float *vec_res = new float[ARR_SIZE];

    // Initialize array
    std::cout << "Array vec_a:\n";
    for (int i=0; i<ARR_SIZE; i++) {
        vec_a[i] = (float)i;

        std::cout << vec_a[i] << "\n";
    }

    // Square the array
    std::cout << "Array vec_res:\n";
    for (int i=0; i<ARR_SIZE; i++) {
        vec_res[i] = vec_a[i] * vec_a[i];

        std::cout << vec_res[i] << "\n";
    }

    // Delete array
    delete[] vec_a;
    delete[] vec_res;

    return 0;
}