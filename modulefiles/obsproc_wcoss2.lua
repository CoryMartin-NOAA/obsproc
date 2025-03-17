help([[
Load environment to build obsproc on WCOSS2
]])

PrgEnv_intel_ver=os.getenv("PrgEnv_intel_ver")
intel_ver=os.getenv("intel_ver")
cmake_ver=os.getenv("cmake_ver")
craype_ver=os.getenv("craype_ver")
cray_mpich_ver=os.getenv("cray_mpich_ver")

prepend_path("MODULEPATH", "/apps/ops/test/spack-stack-1.6.0-nco/envs/nco-intel-19.1.3.304/install/modulefiles/Core")

-- load("envvar")
load(pathJoin("PrgEnv-intel", PrgEnv_intel_ver))
load(pathJoin("stack-intel/19.1.3.304"))
load(pathJoin("stack-cray-mpich/8.1.9"))
load(pathJoin("cmake", cmake_ver))
load(pathJoin("craype", craype_ver))

-- Load common modules for this package
load("obsproc_common")

whatis("Description: obsproc build environment")
