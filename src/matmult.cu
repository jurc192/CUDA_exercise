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
    d_out[i] = d_in[ndx] * d_in[ndx];
}


int main()
{
    // Allocate array @CPU RAM
    float *h_vec_a = new float[ARR_SIZE];
    float *h_vec_res = new float[ARR_SIZE];

    // Initialize array @CPU
    for (int i=0; i<ARR_SIZE; i++) {
        h_vec_a[i] = (float)i;
    }

    // Allocate arrays @GPU
    float *d_vec_a;
    float *d_vec_res;
    cudaMalloc((void **) &d_vec_a, ARR_SIZE * sizeof(float));       // Kako to deluje točno
    cudaMalloc((void **) &d_vec_res, ARR_SIZE * sizeof(float));


    // Transfer data from CPU to GPU
    cudaMemcpy(d_vec_a, h_vec_a, ARR_SIZE*sizeof(float), cudaMemcpyHostToDevice);

    // Kernel launch
    sqare<<<1, ARR_SIZE>>>(d_vec_a, d_vec_res);

    // Transfer data from GPU to CPU
    cudaMemcpy(h_vec_res, d_vec_res, ARR_SIZE*sizeof(float), cudaMemcpyDeviceToHost);

    // Delete array
    delete[] vec_a;
    delete[] vec_res;

    return 0;
}