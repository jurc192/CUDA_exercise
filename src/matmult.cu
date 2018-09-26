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
    cudaMalloc((void **) &d_vec_a, arr_bytes);       // Kako to deluje točno
    cudaMalloc((void **) &d_vec_res, arr_bytes);


    // Transfer data from CPU to GPU
    cudaMemcpy(d_vec_a, h_vec_a, arr_bytes, cudaMemcpyHostToDevice);

    // Kernel launch
    square<<<1, ARR_SIZE>>>(d_vec_a, d_vec_res);

    // Transfer data from GPU to CPU
    cudaMemcpy(h_vec_res, d_vec_res, arr_bytes, cudaMemcpyDeviceToHost);

    // Delete array
    delete[] h_vec_a;
    delete[] h_vec_res;
    
    cudaFree(d_vec_a);
    cudaFree(d_vec_res);
    delete d_vec_a;
    delete d_vec_res;

    return 0;
}