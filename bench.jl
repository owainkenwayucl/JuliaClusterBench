using Pkg
Pkg.activate()
Pkg.instantiate()

using SystemBench, LinearAlgebra, LinearAlgebra.BLAS

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

cluster = try
		cluster=readchomp(`/shared/ucl/apps/cluster-bin/whereami`)
	catch
		"Unknown"
end


BLAS.set_num_threads(OMPThreads)
actualtheads = BLAS.get_num_threads()

fname = string(cluster, "-", JOBID, "-", OMPThreads, "-", actualtheads, ".txt")

println("Running using ", actualthreads, " threads.")

res = runbenchmark();

savebenchmark(fname, res)


