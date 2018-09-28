/*
    My very first program in c++
    square a vector
*/
#include <iostream>

#define ARR_SIZE    64

/* Kernel - square the array */
__global__
void square(float *d_in, float *d_out)
{
    int ndx = threadIdx.x;
    d_out[ndx] = d_in[ndx] * d_in[ndx];
}


int main()
{
    // Allocate array @CPU RAM
    float h_vec_a[ARR_SIZE];
    float h_vec_res[ARR_SIZE];

    // Initialize array @CPU
    for (int i=0; i<ARR_SIZE; i++) {
        h_vec_a[i] = (float)i;
    }


    // Allocate arrays @GPU
    float *d_vec_a;
    float *d_vec_res;
    const long arr_bytes = ARR_SIZE * sizeof(float);
    
    if (cudaMalloc((void **) &d_vec_a, arr_bytes) != cudaSuccess) {
        std::cout << "Failed at cudaMalloc vec_a\n";
    }
    
    if (cudaMalloc((void **) &d_vec_res, arr_bytes) != cudaSuccess) {
        std::cout << "Failed at cudaMalloc vec_res\n";
    }


    // Transfer data from CPU to GPU
    if (cudaMemcpy(d_vec_a, h_vec_a, arr_bytes, cudaMemcpyHostToDevice) != cudaSuccess) {
        std::cout << "Failed at cudaMemcpy H2D\n";
    }

    // Kernel launch
    square<<<1, ARR_SIZE>>>(d_vec_a, d_vec_res);

    // Transfer data from GPU to CPU
    if (cudaMemcpy(h_vec_res, d_vec_res, arr_bytes, cudaMemcpyDeviceToHost) != cudaSuccess) {
        std::cout << "Failed at cudaMemcpy D2H\n";
    }

    // Delete array
    delete[] h_vec_a;
    delete[] h_vec_res;
    
    // cudaFree(d_vec_a);
    // cudaFree(d_vec_res);
    delete d_vec_a;
    delete d_vec_res;

    return 0;
}