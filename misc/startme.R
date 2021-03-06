###############################################################################
#
#	project scripts that can be run from command line, without re-building the package all the time,
# 	because the R files are re-loaded below
#
# usage from R:
#> setwd("/Users/Oliver/git/big.phylo"); source("misc/startme.R")
# usage from bash:
#> cd /Users/Oliver/git/big.phylo/pkg
#> Rscript misc/startme.R 
#
#
###############################################################################
args <- commandArgs()
if(!any(args=='--args'))
	args<- vector("numeric",0)
if(any(args=='--args'))
	args<- args[-(1:match("--args", args)) ]

#the package directory (local working copy of the code, not the installed package directory within the R directory 
CODE.HOME	<<- "/Users/Oliver/git/big.phylo"
#CODE.HOME	<<- "/work/or105/libs/big.phylo"

#the home directory of all projects
HOME		<<- "/Users/Oliver/git/big.phylo/prjct"
#HOME		<<- "/work/or105/UKCA_1309"
#HOME		<<- "/work/or105/ATHENA_2013"

DEBUG		<<- 0		#If 1, a dump file is created that can be loaded and computations can be inspected at the point of error.
LIB.LOC		<<- NULL
#LIB.LOC	<<- paste(CODE.HOME,"../",sep='')
EPS			<<- 1e-12	#Machine precision	

#the default script to be called if -exe is not specified on the command line	
#default.fun	<- "my.make.documentation"
default.fun		<- 'prog.remove.resistancemut'
default.fun 	<- "pipeline.ExaML.bootstrap.per.proc"
###############################################################################
#	select script specified with -exe on the command line. If missing, start default script 'default.fun'.
argv<- list()
if(length(args))
{
	tmp<- na.omit(sapply(args,function(arg)
					{
						switch(substr(arg,2,4),
								exe= return(substr(arg,6,nchar(arg))),
								NA)
					}))
	if(length(tmp)!=0)
	{
		if(length(tmp)>1) stop("hivclu.startme.R: duplicate -exe")
		else default.fun<- switch(tmp[1],
					ROXYGENIZE				= "package.roxygenize",
					MAKE.RDATA				= "package.generate.rdafiles",
					BOOTSTRAPSEQ			= "prog.examl.getbootstrapseq",
					RM.RESISTANCE			= "prog.remove.resistancemut",
					EXAML.NPROC				= "pipeline.ExaML.bootstrap.per.proc",
					)
	}
	tmp<- na.omit(sapply(args,function(arg)
					{
						switch(substr(arg,2,10),
								code.home= return(substr(arg,12,nchar(arg))),
								NA)
					}))	
	if(length(tmp)!=0)	CODE.HOME<<- tmp[1]
	tmp<- na.omit(sapply(args,function(arg)
					{
						switch(substr(arg,2,6),
								debug= 1,
								NA)
					}))		
	if(length(tmp)!=0)	DEBUG<<- tmp[1]	
	argv<<- args
}
###############################################################################
#	re-load all R files
require(data.table)
print(CODE.HOME)
function.list<-c(list.files(path= paste(CODE.HOME,"R",sep='/'), pattern = ".R$", all.files = FALSE,
				full.names = TRUE, recursive = FALSE),paste(CODE.HOME,"misc","prjcts.R",sep='/'))
sapply(function.list,function(x){ source(x,echo=FALSE,print.eval=FALSE, verbose=FALSE) })
###############################################################################
#	run script
#stop()
if(DEBUG)	options(error= my.dumpframes)	
cat(paste("\nbig.phylo: ",ifelse(DEBUG,"debug",""),"call",default.fun,"\n"))
do.call(default.fun,list()) 	
cat("\nbig.phylo: ",ifelse(DEBUG,"debug","")," end\n")
