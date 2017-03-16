DEST:= $(R_LIBS_USER)/big.phylo
DEST:= $(subst ~,$(HOME),$(DEST))
EXTERNAL_CODE:= $(DEST)/ext
MISC_CODE:= $(DEST)/misc
CWD= $$(pwd)

all:	
	echo "current directory is "$(CWD)
	echo "destination directory for external code is "$(EXTERNAL_CODE)
	echo $(PVT_EXISTS)			
	mkdir -p $(EXTERNAL_CODE)
	@echo "*********************************************** "
	@echo "********* MAKE RDATA files ******************** "
	@echo "*********************************************** "	
	make rdata	
	@echo "*********************************************** "
	@echo "********* BUILDING misc *********************** "
	@echo "*********************************************** "	
	make misc
	@echo "*********************************************** "
	@echo "********* BUILDING jModelTest ***************** "
	@echo "*********************************************** "	
	make jmodeltest		
	@echo "*********************************************** "
	@echo "********* BUILDING FastTree ******************* "
	@echo "*********************************************** "	
	make fasttree		
	@echo "*********************************************** "
	@echo "********* BUILDING LSD ********************** "
	@echo "*********************************************** "	
	make lsd	
	@echo "*********************************************** "
	@echo "********* BUILDING PhyD* ********************** "
	@echo "*********************************************** "	
	make phyd		
	@echo "*********************************************** "
	@echo "********* BUILDING standard-RAxML ************* "
	@echo "*********************************************** "	
	make ExaML-raxml	
	@echo "*********************************************** "
	@echo "********* BUILDING ExaML-parsimonator ********* "
	@echo "*********************************************** "	
	make EXAML-parsimonator
	@echo "*********************************************** "
	@echo "********* BUILDING ExaML ********************** "
	@echo "*********************************************** "	
	make examl		

jmodeltest:
	echo $(CWD)
	tar -xzf ../inst/jmodeltest-2.1.10.tar.gz	
	mv $(CWD)/jmodeltest-2.1.10 $(EXTERNAL_CODE)

fasttree:
	echo $(CWD)	
	curl "http://microbesonline.org/fasttree/FastTree.c" -o FastTree.c
	gcc -Wall -O3 -finline-functions -funroll-loops -o FastTree FastTree.c -lm
	mv $(CWD)/FastTree $(EXTERNAL_CODE)
	rm FastTree.c

phyd:
	echo $(CWD)	
	tar -xzf ../inst/PhyDstar.tar.gz
	mv $(CWD)/PhyDstar/PhyDstar.jar $(EXTERNAL_CODE)
	rm -rf PhyDstar	

lsd:
	echo $(CWD)
	wget https://github.com/tothuhien/lsd-0.3beta/archive/master.zip
	unzip master.zip
	make -C lsd-0.3beta-master/src
	mv $(CWD)/lsd-0.3beta-master/src/lsd $(EXTERNAL_CODE)/lsd
	rm -rf lsd-0.3beta-master master.zip

ExaML-raxml:
	echo $(CWD)
	wget https://github.com/stamatak/standard-RAxML/archive/master.zip
	unzip master.zip
	make -C standard-RAxML-master -f Makefile.SSE3.gcc
	mv $(CWD)/standard-RAxML-master/raxmlHPC-SSE3 $(EXTERNAL_CODE)/ExaML-raxml
	rm -rf standard-RAxML-master master.zip

EXAML-parsimonator:	
	echo $(CWD)
	wget https://github.com/stamatak/Parsimonator-1.0.2/archive/master.zip
	unzip master.zip
	make -C Parsimonator-1.0.2-master -f Makefile.SSE3.gcc
	mv $(CWD)/Parsimonator-1.0.2-master/parsimonator-SSE3 $(EXTERNAL_CODE)/ExaML-parsimonator 	
	rm -rf Parsimonator-1.0.2-master master.zip

examl:	
	echo $(CWD)
	wget https://github.com/stamatak/ExaML/archive/master.zip
	unzip master.zip
	make -C ExaML-master/parser -f Makefile.SSE3.gcc
	mv $(CWD)/ExaML-master/parser/parse-examl $(EXTERNAL_CODE)/ExaML-parser
	make -C ExaML-master/examl -f Makefile.SSE3.gcc
	mv $(CWD)/ExaML-master/examl/examl $(EXTERNAL_CODE)/ExaML-examl
	rm -rf ExaML-master master.zip
	mv $(EXTERNAL_CODE)/ExaML-examl $(EXTERNAL_CODE)/examl

make misc:	
	mkdir -p $(MISC_CODE)
	cp ../misc/*.R $(MISC_CODE)

make roxygen:
	echo $(CWD)
	Rscript ../misc/startme.R -exe=ROXYGENIZE -code.home=$(CWD)/..

make rdata:
	echo $(CWD)
	Rscript ../misc/startme.R -exe=MAKE.RDATA -code.home=$(CWD)/..	
