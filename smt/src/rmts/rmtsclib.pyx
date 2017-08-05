from libcpp.vector cimport vector
from cpython cimport array
import numpy as np
cimport numpy as np


cdef extern from "rmts.hpp":
  cdef cppclass RMTS:
    RMTS() except +
    void setup(int nx, double * lower, double * upper)
    void compute_ext_dist(int n, int nterm, double * x, double * dx)
    void compute_quadrature_points(int n, int * nelem_list, double * x)


cdef extern from "rmtb.hpp":
  cdef cppclass RMTB:
    RMTB() except +
    void setup(int nx, double * lower, double * upper, int * order_list, int * ncp_list)


cdef class PyRMTS:

    cdef RMTS *thisptr
    def __cinit__(self):
        self.thisptr = new RMTS()
    def __dealloc__(self):
        del self.thisptr
    def setup(self, int nx, np.ndarray[double] lower, np.ndarray[double] upper):
        self.thisptr.setup(nx, &lower[0], &upper[0])
    def compute_ext_dist(self, int n, int nterm, np.ndarray[double] x, np.ndarray[double] dx):
        self.thisptr.compute_ext_dist(n, nterm, &x[0], &dx[0])
    def compute_quadrature_points(self, int n, np.ndarray[int] nelem_list, np.ndarray[double] x):
        self.thisptr.compute_quadrature_points(n, &nelem_list[0], &x[0])


cdef class PyRMTB:

    cdef RMTB *thisptr
    def __cinit__(self):
        self.thisptr = new RMTB()
    def __dealloc__(self):
        del self.thisptr
    def setup(self, int nx,
            np.ndarray[double] lower, np.ndarray[double] upper,
            np.ndarray[int] order_list, np.ndarray[int] ncp_list):
        self.thisptr.setup(nx, &lower[0], &upper[0], &order_list[0], &ncp_list[0])
