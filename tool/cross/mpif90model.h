/*
 * Copyright (C) by Argonne National Laboratory
 *     See COPYRIGHT in top-level directory
 */

#ifndef MPIR_F90_INCLUDED
#define MPIR_F90_INCLUDED

/* Get the parameters that define the integer and real data models
 * for Fortran 90.  These are needed to implement the MPI_Type_create_f90_xxx
 * functions, which are available in C, F90, and C++ (but not in Fortran 77,
 * because these are part of the extended Fortran support).
 *
 * These use the Fortran 90 terms precision and range which have the
 * following meanings:
 *
 * precision - number of digits to ??? (FIXME: exact definition)
 * range - number of decimal digits (exponent range for reals)
 */

/* Real and double model:
 * precision and range for reals and for doubles
 * The value is two "precision, range", as integers
 */
#define MPIR_F90_REAL_MODEL           6 , 37
#define MPIR_F90_DOUBLE_MODEL         15 , 307
/* integer model:
 * a single integer, giving the value of the range
 */
#define MPIR_F90_INTEGER_MODEL        9

#define MPIR_F90_ALL_INTEGER_MODELS   2 , 1, 4 , 2, 9 , 4, 18 , 8,
/* integer model map:
 * a set of triples of integers, giving the maximum range for
 * each 'kind', as in the Fortran 90 declaration
 * integer(kind=k) .  That is,
 *
 * r1,k1,s1,  r2,k2,s2 ...
 *
 * where kind ki has range ri and is si bytes long
 *
 * This can be used to find a Fortran 90 integer type with a given range.
 *
 */
#define MPIR_F90_INTEGER_MODEL_MAP    {  2 , 1 , 1 }, {  4 , 2 , 2 }, {  9 , 4 , 4 }, {  18 , 8 , 8 },

#endif
