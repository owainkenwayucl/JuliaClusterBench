using Pkg
Pkg.activate("environment")
Pkg.instantiate()

using SystemBenchmark, LinearAlgebra, LinearAlgebra.BLAS

OMPThreads = try
		parse(Int,ENV["OMP_NUM_THREADS"])
	catch
		1
end

JOBID = try
		ENV["JOB_ID"]
	catch
		"LOGIN"
end

clustername = try
		cluster=readchomp(`/shared/ucl/apps/cluster-bin/whereami`)
	catch
		"Unknown"
end


BLAS.set_num_threads(OMPThreads)
actualthreads = BLAS.get_num_threads()

fname = string(clustername, "-", JOBID, "-", OMPThreads, "-", actualthreads, ".txt")

res = runbenchmark();

savebenchmark(fname, res)


