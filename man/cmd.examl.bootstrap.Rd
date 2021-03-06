% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/bigphylo.cmd.R
\name{cmd.examl.bootstrap}
\alias{cmd.examl.bootstrap}
\title{Generate the ExaML boostrap shell command, one bootstrap per processor.}
\usage{
cmd.examl.bootstrap(indir, infile, bs.from = 0, bs.to = 99, bs.n = bs.to -
  bs.from + ifelse(bs.from == 0, 1, 0), outdir = indir,
  prog.mpi = "mpiexec", prog.bscreate = PR.EXAML.BSCREATE,
  prog.parser = PR.EXAML.PARSER, prog.starttree = PR.EXAML.STARTTREE,
  prog.examl = PR.EXAML.EXAML, opt.bootstrap.by = "codon",
  args.examl = "-m GAMMA -D", args.parser = "-m DNA",
  prog.supportadder = PR.EXAML.BS, tmpdir.prefix = "examl", resume = 1,
  verbose = 1)
}
\arguments{
\item{indir}{Directory of the sequences in file \code{infile}}

\item{infile}{File name to an DNAbin matrix. The file name must end in \code{.R}}

\item{bs.from}{Iteration number of bootstrap calculations. Defaults to \code{0}.}

\item{bs.to}{Final iteration number of this call to \code{pipeline.ExaML.bootstrap.per.proc}. Defaults to \code{bs.n}.}

\item{bs.n}{Total number of boostrap iterations. Defaults to \code{500}.}

\item{outdir}{Output directory for the bootstrap calculations}

\item{verbose}{Flag to run function in verbose mode.}
}
\value{
Character string
}
\description{
Internal code.
}

