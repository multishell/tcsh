# $Id: Makefile,v 1.42 1992/11/20 08:56:38 christos Exp $
#	Makefile	4.3	6/11/83
#
# C Shell with process control; VM/UNIX VAX Makefile
# Bill Joy UC Berkeley; Jim Kulp IIASA, Austria
#
# With an input editor, command completion, etc. and ported to all sorts of
# things; Paul Placeway, CIS Dept., Ohio State University
#
SHELL=/bin/sh
VERSION=6.03
BUILD=tcsh
#BUILD=jump	# Build tcsh.a and link it with jump table libraries (linux)
#BUILD=nojump	# Build tcsh.a and link it with shared libraries (linux)
#BUILD=static	# Build tcsh.a and link it with static libraries (linux)

################################################################
## CFLAGS.  For various -D things, see config.h
################################################################
#
# These are the default suffixes from .c to .o and -c to get there
# but to use the global optimizer on the mips boxes, see below
#
SUF=o
CF=-c

INCLUDES=-I. -I..

LFLAGS=$(INCLUDES)
#LFLAGS=$(INCLUDES) -Zn10000		# hpux lint


#CFLAGS= $(INCLUDES) -g			# debug
#CFLAGS= $(INCLUDES) -O			# production
#CFLAGS= $(INCLUDES) 			# Broken optimizers....

#CFLAGS= -g -pg $(INCLUDES) -DPROF
#CFLAGS= -O -pg $(INCLUDES) -DPROF

# gcc 1.00-1.37
#CFLAGS=-O $(INCLUDES) -finline-functions -fstrength-reduce 

# gcc 1.37-1.40
#CFLAGS=-O $(INCLUDES) -fcombine-regs -finline-functions -fstrength-reduce 
# add -msoft-float for 68881 machines.

# gcc 2.0
# On the sparc, don't use -O2; it breaks setjmp() and vfork()
#CFLAGS=-O $(INCLUDES)

# gcc-2.1
CFLAGS=-O2 $(INCLUDES)

# gcc 2.1 on linux
#CFLAGS=-O6 -fomit-frame-pointer $(INCLUDES)

#hpux 8.0
#CFLAGS= $(INCLUDES) +O3 -Aa

# Ultrix 4.2a
#CFLAGS= $(INCLUDES) -O -Olimit 2000

# for silicon graphics (and other mips compilers) -- use the
# global optimizer! (-O3).
# On SGI 4.0+ you need to add -D__STDC__ too.
#CFLAGS= -O3 $(INCLUDES) 
#CF=-j
#SUF=u
#.SUFFIXES: .u 				## Ultrix needs that

# mips systems
# CFLAGS= $(INCLUDES) -O -systype bsd43 -Wf,-XNd5000 -Wf,-XNp6000 -Olimit 2000

# for at&t machines
#CFLAGS= -O -Ksd $(INCLUDES)

# Stardent Titan
#CFLAGS = $(INCLUDES) -O -43

# Stardent Stellar or sunos4 w/o gcc
#CFLAGS = $(INCLUDES) -O4

# Dnix 5.3
#CFLAGS = -O -X7

# Apollo's with cc [apollo builtins don't work with gcc]
# and apollo should not define __STDC__ if it does not have
# the standard header files. RT's (aos4.3) need that too;
# you might want to skip the -O on the rt's... Not very wise.
# AIX/ESA needs -D_IBMESA on command line (this may disappear by GA)
#DFLAGS=-U__STDC__ 
#DFLAGS=-D_IBMESA
# On aix2.2.1 we need more compiler space.
#DFLAGS=-Nd4000 -Nn3000
# AU/X 2.0 needs a flag for POSIX (read the config file)
#DFLAGS=-Zp
# Tektronix 4300 running UTek 4.0 (BSD 4.2) needs:
#DFLAGS = -DUTek
# VMS_POSIX needs:
#DFLAGS=-D_VMS_POSIX
# DEC/osf-1 on the alpha
#DFLAGS=-D_BSD
DFLAGS=


################################################################
## LDLAGS.  Define something here if you need to
################################################################
LDFLAGS= 			## The simplest, suitable for all.
#LDFLAGS= -s			## Stripped. Takes less space on disk.
#LDFLAGS= -s -n			## Pure executable. Spares paging over
# 				## the network for machines with local
#				## swap but external /usr/local/bin .
#LDFLAGS= -s -n -Bstatic	## Without dynamic links. (SunOS)
#LDFLAGS= -Wl,-s,-n		## Stripped, shared text (Unicos)

################################################################
## LIBES.  Pick one, or roll your own.
################################################################
LIBES= -ltermcap 		## BSD style things, hpux
#LIBES= -ltermc			## emx under OS/2
#LIBES= -ltermcap -lsec		## Tek XD88/10 (UTekV) with PW_SHADOW
#LIBES= -ltermcap -lsec		## Motorola MPC (sysV88) with PW_SHADOW
#LIBES= -ltermcap -lcs		## Mach
#LIBES= -lcurses		## Sys V3 w/o networking (and Sys V4)
#LIBES= -lcurses -lc /usr/ucblib/libucb.a ## Sys V4 with BSDTIMES
#LIBES= -lcurses		## Sys V4 w/o BSDTIMES or Solaris 2
#LIBES= -lcurses -lnet		## Sys V3 with networking
#LIBES= -lcurses -ldir		## Sys V2 w/o networking [needs directory lib]
#LIBES= -lcurses -ldir -lnet	## Sys V2 with networking [needs directory lib]
#LIBES= -lcurses -lsocket -lbsd	## Amdahl UTS 2.1
#LIBES= -lcurses -lbsd		## For Irix3.1 on SGI-IRIS4D or ETA10
#LIBES= -lcurses -lsun -lbsd -lc_s ## For Irix3.3 on SGI-IRIS4D (w/ yp)
#LIBES= -lcurses -lbsd -lc_s	## For Irix3.3 on SGI-IRIS4D (wo/ yp)
#LIBES= -lcurses -lbsd		## For aix on an IBM 370 or rs6000 or ps2
#LIBES= -lcurses		## For aix on the rt
#LIBES= -lcurses -lcposix	## ISC 2.2 
#LIBES= -lcposix -lc_s -lcurses -linet ## ISC 2.2 with networking
#LIBES= -lcurses -linet -lsec -lc_s  ## ISC 2.0.2 with networking
#LIBES= -lcurses -lsec -lc_s    ## ISC 2.0.2 without networking
#LIBES= -ltermcap -ldir -lx	## Xenix 386 style things
#LIBES= -lcurses -lintl		## SCO SysVR3.2v2.0
#LIBES= -lcurses -lintl -lsocket ## SCO+ODT1.1
#LIBES= -lposix -ltermcap	## A/UX 2.0
#LIBES= -ltermcap -lbsd		## DEC osf1 on the alpha
#LIBES= -ltermcap -lseq		## Sequent's Dynix
#LIBES= -lcurses -lsocket	## Intel's hypercube and ns32000 based Opus.
#LIBES= -ldirent -lcurses       ## att3b1 stk cc w/o shared lib & directory lib
#LIBES= -shlib -ldirent -lcurses ## att3b1 gcc1.40 w/ shared lib & directory lib
#LIBES=				## Minix, VMS_POSIX
#LIBES= -lcurses		## For a stellar
#LIBES= -lcurses -lnsl -lsocket -lc /usr/ucblib/libucb.a ## Stardent Vistra
#LIBES= -ltermcap -lndir -lsocket -ljobs ## masscomp RTU6.0
#LIBES= -ltermcap -lauth        ## for Ultrix with Enhanced Security


# The difficult choice of a c-compiler...
# First, you should try your own c-compiler. 
# Gcc -traditional is also a safe choice. 
# If you think that you have good include files try gcc -Wall...
# If you want to take out -traditional, make sure that your sys/ioctl.h
# is fixed correctly, otherwise you'll be stopped for tty input, or you
# will lose the editor and job control.

# The -B tells gcc to use /bin/ld. This is to avoid using the gnu ld, which
# on the suns does not know how to make dynamically linked binaries.
CC=	gcc -Wall -B/bin/	
#CC=	gcc -m486 -Wall # Generate code for Intel 486 (linux)
#CC=	cc
#CC=	occ
#CC=	acc
#CC=	c89	# For VMS/POSIX
#CC=	/bin/cc	# For suns, w/o gcc and SVR4
#CC=	/usr/lib/sun.compile/cc  # FPS 500 (+FPX) with Sun C compiler
#CC=	scc 	# Alliant fx2800
ED=	ed
AS=	as
RM=	rm
CXREF=	/usr/ucb/cxref
VGRIND=	csh /usr/ucb/vgrind
CTAGS=	/usr/ucb/ctags
#XSTR= /usr/ucb/xstr
SCCS=	/usr/local/sccs
PARALLEL=12				# Make the multi-max run fast.
#P=&					# Use Sequent's parallel make
P=
DESTDIR=/usr/local
MANSECT=1
DESTBIN=${DESTDIR}/bin
DESTMAN=${DESTDIR}/man/man${MANSECT}
# DESTMAN=${DESTDIR}/catman/man${MANSECT}	 # A/UX
# DESTMAN=${DESTDIR}/usr/share/man/man${MANSECT} # Stardent Vistra (SysVR4)
# DESTMAN=/usr/catman/1l			 # Amiga unix (SysVR4)
FTPAREA=/usr/spool/ftp

ASSRCS=	sh.c sh.dir.c sh.dol.c sh.err.c sh.exec.c sh.char.c \
	sh.exp.c sh.file.c sh.func.c sh.glob.c sh.hist.c sh.init.c \
	sh.lex.c sh.misc.c sh.parse.c sh.print.c sh.proc.c sh.sem.c \
	sh.set.c sh.time.c sh.char.h sh.dir.h sh.proc.h sh.h 
PSSRCS= sh.decls.h glob.c glob.h mi.termios.c mi.wait.h mi.varargs.h ma.setp.c \
	vms.termcap.c
SHSRCS= ${ASSRCS} ${PSSRCS}
SHOBJS=	sh.${SUF} sh.dir.${SUF} sh.dol.${SUF} sh.err.${SUF} sh.exec.${SUF} \
	sh.char.${SUF} sh.exp.${SUF} sh.func.${SUF} sh.glob.${SUF} \
	sh.hist.${SUF} sh.init.${SUF} sh.lex.${SUF} sh.misc.${SUF} \
	sh.parse.${SUF} sh.print.${SUF} sh.proc.${SUF} sh.sem.${SUF} \
	sh.set.${SUF} sh.time.${SUF} glob.${SUF} mi.termios.${SUF} \
	ma.setp.${SUF} vms.termcap.${SUF}

TWSRCS= tw.decls.h tw.h tw.help.c tw.init.c tw.parse.c tw.spell.c \
	tw.comp.c
TWOBJS=	tw.help.${SUF} tw.init.${SUF} tw.parse.${SUF} tw.spell.${SUF} \
	tw.comp.${SUF}

EDSRCS= ed.chared.c ed.decls.h ed.defns.c ed.h ed.init.c ed.inputl.c \
	ed.refresh.c ed.screen.c ed.xmap.c ed.term.c ed.term.h
EDOBJS=	ed.chared.${SUF} ed.refresh.${SUF} ed.screen.${SUF} ed.init.${SUF} \
	ed.inputl.${SUF} ed.defns.${SUF} ed.xmap.${SUF} ed.term.${SUF}

TCSRCS= tc.alloc.c tc.bind.c tc.const.c tc.decls.h tc.disc.c \
	tc.func.c tc.os.c tc.os.h tc.printf.c tc.prompt.c \
	tc.sched.c tc.sig.c tc.sig.h tc.str.c sh.types.h tc.vers.c tc.wait.h \
	tc.who.c tc.h
TCOBJS=	tc.alloc.${SUF} tc.bind.${SUF} tc.const.${SUF} tc.disc.${SUF} \
	tc.func.${SUF} tc.os.${SUF} tc.printf.${SUF} \
	tc.prompt.${SUF} tc.sched.${SUF} tc.sig.${SUF} tc.str.${SUF} \
	tc.vers.${SUF} tc.who.${SUF} 

PVSRCS= Makefile Makefile.vms
AVSRCS= Fixes MAKEDIFFS MAKESHAR NewThings README FAQ \
	WishList config_f.h eight-bit.me glob.3 patchlevel.h \
	pathnames.h tcsh.man Ported src.desc Imakefile imake.config \
	README.imake complete.tcsh vmsreadme.txt termcap.vms
VHSRCS=${PVSRCS} ${AVSRCS}

CONFSRCS=config/config.* 

ALLSRCS=  ${SHSRCS} ${TWSRCS} ${EDSRCS} ${TCSRCS} ${VHSRCS}
DISTSRCS= ${PSSRCS} ${TWSRCS} ${EDSRCS} ${TCSRCS} ${AVSRCS}


OBJS= ${SHOBJS} ${TWOBJS} ${EDOBJS} ${TCOBJS}


all: ${BUILD}

tcsh:$(P) ${OBJS} 
	rm -f tcsh core
	${CC} -o tcsh ${LDFLAGS} ${CFLAGS} ${OBJS} ${LIBES}

# Linux distribution
jump: tcsh.a
	${CC} ${LDFLAGS} ${CFLAGS} -o tcsh tcsh.a ${LIBES}

nojump: tcsh.a
	${CC} ${LDFLAGS} -nojump ${CFLAGS} -o tcsh tcsh.a ${LIBES}

static: tcsh.a
	${CC} ${LDFLAGS} -static ${CFLAGS} -o tcsh tcsh.a ${LIBES}

tcsh.a:$(P) ${OBJS}
	$(LD) -x -r -o tcsh.a ${OBJS}

tcsh.ps: tcsh.man
	rm -f tcsh.ps
	-ptroff -man tcsh.man > tcsh.ps


.c.${SUF}:
	${CC} ${CF} ${CFLAGS} ${DFLAGS} $<

# _VMS_POSIX #module addition
#.c.${SUF}:
#	@(echo '#module '`echo $< | sed -e 's/\./_/g'`; cat $<) > $*..c
#	@echo ${CC} ${CF} ${CFLAGS} ${DFLAGS} $*.c
#	@${CC} ${CF} ${CFLAGS} ${DFLAGS} $*..c
#	@mv $*..o $*.o
#	@rm -f $*..c


# Don't do any special massaging of C files for sharing of strings!!
# it causes weird segmentation faults on some systems.
#.c.o:
#	${CC} -E ${CFLAGS} $*.c | ${XSTR} -c -
#	${CC} ${CF} ${CFLAGS} x.c 
#	mv -f x.o $*.o
#	rm -f x.c

#ed.init.o: ed.init.c
#	${CC} -E ${CFLAGS} $*.c | ${XSTR} -c -
#	${CC} -R ${CF} ${CF} x.c 
#	mv -f x.o $*.o
#	rm -f x.c

#strings.o: strings
#	${XSTR}
#	${CC} -c -R xs.c
#	mv -f xs.o strings.o
#	rm -f xs.c

##.DEFAULT:
##	${SCCS} get $<

##.DEFAULT:
##	co $<

ed.defns.h: ed.defns.c
	@rm -f $@
	@echo '/* Do not edit this file, make creates it. */' > $@
	@echo '#ifndef _h_ed_defns' >> $@
	@echo '#define _h_ed_defns' >> $@
	grep '[FV]_' ed.defns.c | grep '^#define' >> $@
	@echo '#endif /* _h_ed_defns */' >> $@

sh.err.h: sh.err.c
	@rm -f $@
	@echo '/* Do not edit this file, make creates it. */' > $@
	@echo '#ifndef _h_sh_err' >> $@
	@echo '#define _h_sh_err' >> $@
	grep 'ERR_' sh.err.c | grep '^#define' >> $@
	@echo '#endif /* _h_sh_err */' >> $@

tc.const.h: tc.const.c sh.char.h config.h config_f.h sh.types.h sh.err.h
	@rm -f $@
	@echo '/* Do not edit this file, make creates it. */' > $@
	${CC} -E $(INCLUDES) ${DFLAGS} tc.const.c | grep 'Char STR' | \
	    sed -e 's/Char \([a-zA-Z0-9_]*\)\(.*\)/extern Char \1[];/' | \
	    sort >> $@

csh.prof: ${OBJS} sh.prof.${SUF} mcrt0.${SUF}
	rm -f csh.prof
	ld -X mcrt0.${SUF} ${OBJS} -o csh.prof ${LIBES} -lc

sh.prof.${SUF}:
	cp sh.c sh.prof.c
	${CC} ${CF} ${CFLAGS} -DPROF sh.prof.c

lint: tc.const.h ed.defns.h
	lint ${LFLAGS} sh*.c tw*.c ed*.c tc.*.c ${LIBES}

alint: tc.const.h ed.defns.h
	alint ${LFLAGS} sh*.c tw*.c ed*.c tc.*.c ${LIBES}

print:
	@pr READ_ME
	@pr makefile makefile.*
	@(size -l a.out; size *.${SUF}) | pr -h SIZES
	@${CXREF} sh*.c | pr -h XREF
	@ls -l | pr 
	@pr sh*.h [a-rt-z]*.h sh*.c alloc.c

vprint:
	@pr -l84 READ_ME TODO
	@pr -l84 makefile makefile.*
	@(size -l a.out; size *.${SUF}) | pr -l84 -h SIZES
	@${CXREF} sh*.c | pr -l84 -h XREF
	@ls -l | pr -l84
	@${CXREF} sh*.c | pr -l84 -h XREF
	@pr -l84 sh*.h [a-rt-z]*.h sh*.c alloc.c

vgrind:
	@cp /dev/null index
	@for i in *.h; do vgrind -t -h "C Shell" $$i >/crp/bill/csh/$$i.t; done
	@for i in *.c; do vgrind -t -h "C Shell" $$i >/crp/bill/csh/$$i.t; done
	@vgrind -t -x -h Index index >/crp/bill/csh/index.t

install: tcsh 
	-mv -f ${DESTBIN}/tcsh  ${DESTBIN}/tcsh.old
	cp tcsh ${DESTBIN}/tcsh
	-strip ${DESTBIN}/tcsh
	chmod 555 ${DESTBIN}/tcsh

manpage: tcsh.man
	-rm -f ${DESTMAN}/tcsh.${MANSECT}
	cp tcsh.man ${DESTMAN}/tcsh.${MANSECT}
	chmod 444 ${DESTMAN}/tcsh.${MANSECT}

# Amiga Unix
#manpage: tcsh.man
#        compress tcsh.man
#	cp tcsh.man.Z ${DESTMAN}/tcsh.Z
#	chmod 444 ${DESTMAN}/tcsh.Z

# Apple A/UX
#manpage: tcsh.man
#	-rm -f ${DESTMAN}/tcsh.${MANSECT}.Z
#	nroff -man tcsh.man | compress > ${DESTMAN}/tcsh.${MANSECT}.Z
#	chmod 444 ${DESTMAN}/tcsh.${MANSECT}.Z

clean:
	${RM} -f a.out strings x.c xs.c tcsh tcsh.a _MAKE_LOG core
	${RM} -f *.${SUF} sh.prof.c ed.defns.h tc.const.h sh.err.h

veryclean: clean
	${RM} -f *~ #*

tags:	/tmp
	${CTAGS} sh*.c

tar:
	rm -f tcsh-${VERSION}.tar.Z
	rm -rf tcsh-${VERSION} 
	mkdir tcsh-${VERSION} tcsh-${VERSION}/config
	cp ${ALLSRCS} tcsh-${VERSION}
	cp ${CONFSRCS} tcsh-${VERSION}/config
	tar cvf - tcsh-${VERSION} | compress > tcsh-${VERSION}.tar.Z
	rm -rf tcsh-${VERSION}

shar:	
	rm -f tcsh-*.shar
	rm -rf tcsh-${VERSION} 
	mkdir tcsh-${VERSION} tcsh-${VERSION}/config 
	cp ${ALLSRCS} tcsh-${VERSION}
	cp ${CONFSRCS} tcsh-${VERSION}/config
	MAKESHAR -v -n tcsh-${VERSION} tcsh-${VERSION} \
		 tcsh-${VERSION}/* tcsh-${VERSION}/config/*
	rm -rf tcsh-${VERSION}

tcsh-${VERSION}.tar.Z:
	rm -rf tcsh-${VERSION} 
	rm -f tcsh-${VERSION}.tar tcsh-${VERSION}.tar.Z DIFFS.[123]
	mkdir tcsh-${VERSION}
	./MAKEDIFFS bsd
	mv DIFFS.1 DIFFS.2 DIFFS.3 tcsh-${VERSION}
	cp ${DISTSRCS} tcsh-${VERSION}
	mkdir tcsh-${VERSION}/config
	cp ${CONFSRCS} tcsh-${VERSION}/config
	cp Makefile tcsh-${VERSION}/Makefile.new
	tar cvf - tcsh-${VERSION} | compress > tcsh-${VERSION}.tar.Z
	rm -rf tcsh-${VERSION}

tcsh.tahoe-${VERSION}.tar.Z:
	rm -rf tcsh.tahoe-${VERSION} 
	rm -f tcsh.tahoe-${VERSION}.tar tcsh.tahoe-${VERSION}.tar.Z DIFFS.[123]
	mkdir tcsh.tahoe-${VERSION}
	./MAKEDIFFS tahoe
	mv DIFFS.1 DIFFS.2 DIFFS.3 tcsh.tahoe-${VERSION}
	cp ${DISTSRCS} tcsh.tahoe-${VERSION}
	mkdir tcsh.tahoe-${VERSION}/config
	cp ${CONFSRCS} tcsh.tahoe-${VERSION}/config
	cp Makefile tcsh.tahoe-${VERSION}/Makefile.new
	tar cvf - tcsh.tahoe-${VERSION} | compress > tcsh.tahoe-${VERSION}.tar.Z
	rm -rf tcsh.tahoe-${VERSION}

tcsh.reno-${VERSION}.tar.Z:
	rm -rf tcsh.reno-${VERSION} 
	rm -f tcsh.reno-${VERSION}.tar tcsh.reno-${VERSION}.tar.Z DIFFS.[123]
	mkdir tcsh.reno-${VERSION}
	./MAKEDIFFS reno
	mv DIFFS.1 DIFFS.2 DIFFS.3 tcsh.reno-${VERSION}
	cp ${DISTSRCS} tcsh.reno-${VERSION}
	mkdir tcsh.reno-${VERSION}/config
	cp ${CONFSRCS} tcsh.reno-${VERSION}/config
	cp Makefile tcsh.reno-${VERSION}/Makefile.new
	tar cvf - tcsh.reno-${VERSION} | compress > tcsh.reno-${VERSION}.tar.Z
	rm -rf tcsh.reno-${VERSION}

ftp: tcsh-${VERSION}.tar.Z tcsh.tahoe-${VERSION}.tar.Z
	cp tcsh-${VERSION}.tar.Z tcsh.tahoe-${VERSION}.tar.Z ${FTPAREA}
	cp tcsh.man ${FTPAREA}

#
# Dependencies
#
config.h: config_f.h

TCH=tc.h tc.const.h tc.decls.h tc.os.h tc.sig.h
SHH=sh.h sh.types.h sh.char.h sh.err.h sh.dir.h sh.proc.h pathnames.h \
    sh.decls.h ${TCH}
TWH=tw.h tw.decls.h
EDH=ed.h ed.decls.h

# EDH
EDINC=sh.${SUF} sh.func.${SUF} sh.lex.${SUF} sh.print.${SUF} sh.proc.${SUF} \
      sh.set.${SUF} tc.bind.${SUF} tc.os.${SUF} tc.prompt.${SUF} \
      tc.sched.${SUF} tw.parse.${SUF}
${EDOBJS} ${EDINC} : ${EDH}

# SHH
${OBJS}: config.h ${SHH}

# TWH
TWINC=ed.chared.${SUF} ed.inputl.${SUF} sh.exec.${SUF} sh.func.${SUF} \
      sh.set.${SUF} tc.func.${SUF}
${TWOBJS} ${TWINC}: ${TWH}

# glob.h
glob.${SUF} sh.glob.${SUF}: glob.h

# ed.defns.h
EDDINC=tc.bind.${SUF} tc.func.${SUF} tc.os.${SUF}
${EDOBJS} ${EDDINC}: ed.defns.h
