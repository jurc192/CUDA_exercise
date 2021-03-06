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
        h_vec_res[i] = 0;
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
    cudaError_t err;
    err = cudaMemcpy(d_vec_a, h_vec_a, arr_bytes, cudaMemcpyHostToDevice);
    if (err != cudaSuccess) {
        std::cout << cudaGetErrorString(err) << "\n";
        std::cout << "Failed at cudaMemcpy D2H at" << __FILE__ << " line: " << __LINE__ << "\n";
    }

    // Kernel launch
    square<<<1, ARR_SIZE>>>(d_vec_a, d_vec_res);

    // Transfer data from GPU to CPU
    err = cudaMemcpy(h_vec_res, d_vec_res, arr_bytes, cudaMemcpyDeviceToHost);
    if ( err != cudaSuccess) {
        std::cout << cudaGetErrorString(err) << "\n";
        std::cout << "Failed at cudaMemcpy D2H at" << __FILE__ << " line: " << __LINE__ << "\n";
    }


    std::cout << "h_vec_res:\n";
    for (int i=0; i< ARR_SIZE; i++) {
        std::cout << h_vec_res[i] << "\n";
    }

    // Free GPU memory
    cudaFree(d_vec_a);
    cudaFree(d_vec_res);

    // Freeing host memory produces some weird crap -> investigate and/or do c++ style
    
    return 0;
}