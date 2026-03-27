#!/bin/bash

export VERSION=$(cat $SRC_DIR/VERSION)

mkdir -p  $SRC_DIR/build
pushd $SRC_DIR/build

export FC=gfortran
export FFLAGS="-Ofast -ffree-line-length-512"

$PYTHON -m numpy.f2py -c --quiet -m _fastmul $SRC_DIR/src/lcsolver/fastmul.f90 --backend meson
$PYTHON -m numpy.f2py -c --quiet -m _evolution_chained2 $SRC_DIR/src/lcsolver/evolution_chained2.f90 --backend meson
$PYTHON -m numpy.f2py -c --quiet -m _evolution_chained2_kicked $SRC_DIR/src/lcsolver/evolution_chained2_kicked.f90 --backend meson
$PYTHON -m numpy.f2py -c --quiet -m _evolution $SRC_DIR/src/lcsolver/evolution.f90 --backend meson
$PYTHON -m numpy.f2py -c --quiet -m _evolution2 $SRC_DIR/src/lcsolver/evolution2.f90 --backend meson
$PYTHON -m numpy.f2py -c --quiet -m _local_op $SRC_DIR/src/lcsolver/local_op.f90 --backend meson


cp *.so $SRC_DIR/lcsolver

popd

$PYTHON setup.py install