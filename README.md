# BinFPE


`BinFPE` is a tool that detects floating-point exceptions (NaN, infinity, and subnormal quantities) in NVIDIA GPU applications using binary instrumentation. It requires no re-compilation of the application and can analyze libraries. The tool extends [NVBit](https://github.com/NVlabs/NVBit), which is provided by NVIDIA Labs to analyze binaries. We provide a patch to NVBit to build `BinFPE`.

## How to Build
We provide a Makefile to build the tool. It downloads NVBit and patches an NVBit tool to create `BinFPE`. The patch is  provided in `binfpe-nvbit.patch`.

To build `BinFPE`, simply run `make`. It will build the following shared library:
```
./nvbit_release/tools/detect_fp_exceptions/detect_fp_exceptions.so
```

## How to Use it

Simply preload the shared library `detect_fp_exceptions.so` before running the application using the Linux LD_PRELOAD variable method:
```
$ LD_PRELOAD=/path/detect_fp_exceptions.so ./application input
```
You should see the following output:
```
#FPCHECKER: Initializing...
#FPCHECKER: kernel void RAJA::internal::CudaKernelLauncherFixed...
#FPCHECKER: kernel...
```
## Error Reports

If a calculation that results in a NaN or infinity is found, you should see the following output:
```
#FPCHECKER: NaN found @ /tests/my_code/dot_product.cu:18
#FPCHECKER: INF found @ /tests/my_code/mult_matrix.cu:26
```
## Requirements

The GPU code must be compiled with the `--generate-line-info` flag (see the nvcc options [here](https://docs.nvidia.com/cuda/cuda-compiler-driver-nvcc/index.html#options-for-altering-compiler-linker-behavior-generate-line-info)).

Other requirements:
- SM compute capability: >= 3.5 && <= 8.6
- GCC version: >= 5.3.0
- CUDA version: >= 8.0 && <= 11.x
- nvcc version for tool compilation >= 10.2

## Contact
For questions, contact Ignacio Laguna <ilaguna@llnl.gov>.

To cite `BinFPE` please use

```
TBD
```

## License

`BinFPE` is distributed under the terms of the MIT license.

See LICENSE and NOTICE for details.

LLNL-CODE-XXXXXX
