# $Id: Makefile,v 1.6 90/12/12 08:23:27 christos Exp $
#	Makefile	4.3	6/11/83
#
# C Shell with process control; VM/UNIX VAX Makefile
# Bill Joy UC Berkeley; Jim Kulp IIASA, Austria
#
# With an input editor, command completion, etc. and ported to all sorts of
# things; Paul Placeway, CIS Dept., Ohio State University
#
SHELL=/bin/sh
VERSION=6.00
BUILD=tcsh

################################################################
## CLAGS.  For various -D things, see config.h
################################################################
#
# These are the default suffixes from .c to .o and -c to get there
# but to use the global optimizer on the mips boxes, see below
#
SUF=o
CF=-c

LFLAGS=-I.
#LFLAGS=-Zn10000			# hpux lint

#CFLAGS= -I. -O
#CFLAGS= -I. -g

#CFLAGS= -g -pg -I. -DPROF
#CFLAGS= -O -pg -I. -DPROF

# gcc 1.37-
#CFLAGS=-O -I. -finline-functions -fstrength-reduce 

# gcc 1.37+
#CFLAGS=-O -I. -fcombine-regs -finline-functions -fstrength-reduce #-msoft-float
CFLAGS=-O -I. -finline-functions -fstrength-reduce #-msoft-float

#CFLAGS= -O -I. -fvolatile

# for silicon graphics (and other mips compilers) -- use the
# global optimizer! (-O3).
#CFLAGS= -O3 -I. 
#CF=-j
#SUF=u
#.SUFFIXES: .u 				## Ultrix needs that

# for at&t machines
#CFLAGS= -O -Ksd -I.

# for convexen
#CFLAGS= -I. -ext -tm c1

# Stardent Titan
#CFLAGS = -I. -O -43

################################################################
## LDLAGS.  Define something here if you need to
################################################################
LDFLAGS=

################################################################
## LIBES.  Pick one, or roll your own.
################################################################
LIBES= -ltermcap		## BSD style things
#LIBES= -ltermcap -lcs		## Mach
#LIBES= -lcurses		## Sys V3 w/o networking
#LIBES= -lcurses -lnet		## Sys V3 with networking
#LIBES= -lcurses -ldir		## Sys V2 w/o networking [needs directory lib]
#LIBES= -lcurses -ldir -lnet	## Sys V2 with networking [needs directory lib]
#LIBES= -lcurses -lbsd		## For Irix3.1 on SGI-IRIS4D
#LIBES= -lcurses -lsun -lbsd -lc_s ## For Irix3.3 on SGI-IRIS4D (w/ yp)
#LIBES= -lcurses -lbsd -lc_s	## For Irix3.3 on SGI-IRIS4D (wo/ yp)
#LIBES= -lcurses -lbsd		## or for aix on an IBM 370 or rs6000 or ps2
#LIBES= -lcurses -lcposix	## ISC 2.2 
#LIBES= -lposix -ltermcap	## A/UX 2.0
#LIBES= -ltermcap -lseq		## Sequent's Dynix
#LIBES= -lcurses -lsocket	## Intel's hypercube

# The difficult choice of a c-compiler...
# First, you should try your own c-compiler. 
# Gcc -traditional is also a safe choice. 
# If you think that you have good include files try gcc -Wall...
# If you want to take out -traditional, make sure that your sys/ioctl.h
# is fixed correctly, otherwise you'll be stopped for tty input!
CC=	gcc -Wall 
#CC=	cc
#CC=	occ
ED=	-ed
AS=	-as
RM=	-rm
CXREF=	/usr/ucb/cxref
VGRIND=	csh /usr/ucb/vgrind
CTAGS=	/usr/ucb/ctags
#XSTR= /usr/ucb/xstr
SCCS=	/usr/local/sccs
PARALLEL=12				# Make the multi-max run fast.
#P=&					# Use Sequent's parallel make
P=
DESTDIR=/usr/local/bin
MANSECT=1
DESTMAN=/usr/local/man/man${MANSECT}
FTPAREA=/usr/spool/ftp

ASSRCS=	sh.c sh.dir.c sh.dol.c sh.err.c sh.exec.c sh.char.c \
	sh.exp.c sh.file.c sh.func.c sh.glob.c sh.hist.c sh.init.c \
	sh.lex.c sh.misc.c sh.parse.c sh.print.c sh.proc.c sh.sem.c \
	sh.set.c sh.time.c sh.char.h sh.dir.h sh.proc.h sh.h 
PSSRCS= sh.decls.h glob.c glob.h
SHSRCS= ${ASSRCS} ${PSSRCS}
SHOBJS=	sh.${SUF} sh.dir.${SUF} sh.dol.${SUF} sh.err.${SUF} sh.exec.${SUF} \
	sh.char.${SUF} sh.exp.${SUF} sh.func.${SUF} sh.glob.${SUF} \
	sh.hist.${SUF} sh.init.${SUF} sh.lex.${SUF} sh.misc.${SUF} \
	sh.parse.${SUF} sh.print.${SUF} sh.proc.${SUF} sh.sem.${SUF} \
	sh.set.${SUF} sh.time.${SUF} glob.${SUF}

TWSRCS= tw.decls.h tw.h tw.help.c tw.init.c tw.parse.c tw.spell.c
TWOBJS=	tw.help.${SUF} tw.init.${SUF} tw.parse.${SUF} tw.spell.${SUF}

EDSRCS= ed.chared.c ed.decls.h ed.defns.c ed.h ed.init.c ed.inputl.c \
	ed.refresh.c ed.screen.c ed.xmap.c
EDOBJS=	ed.chared.${SUF} ed.refresh.${SUF} ed.screen.${SUF} ed.init.${SUF} \
	ed.inputl.${SUF} ed.defns.${SUF} ed.xmap.${SUF}

TCSRCS= tc.alloc.c tc.bind.c tc.const.c tc.decls.h tc.disc.c \
	tc.func.c tc.os.c tc.os.h tc.printf.c tc.prompt.c \
	tc.sched.c tc.sig.c tc.sig.h tc.str.c sh.types.h tc.vers.c tc.wait.h \
	tc.who.c tc.h
TCOBJS=	tc.alloc.${SUF} tc.bind.${SUF} tc.const.${SUF} tc.disc.${SUF} \
	tc.func.${SUF} tc.os.${SUF} tc.printf.${SUF} \
	tc.prompt.${SUF} tc.sched.${SUF} tc.sig.${SUF} tc.str.${SUF} \
	tc.vers.${SUF} tc.who.${SUF} 

PVSRCS= Makefile
AVSRCS= Fixes MAKEDIFFS NewThings README FAQ WishList \
	 config_f.h eight-bit.me glob.3 patchlevel.h \
	 pathnames.h tcsh.man
VHSRCS=${PVSRCS} ${AVSRCS}

CONFSRCS=config/config.*

ALLSRCS=  ${SHSRCS} ${TWSRCS} ${EDSRCS} ${TCSRCS} ${VHSRCS}
DISTSRCS= ${PSSRCS} ${TWSRCS} ${EDSRCS} ${TCSRCS} ${AVSRCS}


OBJS= ${SHOBJS} ${TWOBJS} ${EDOBJS} ${TCOBJS}


all: ${BUILD}

tcsh:$(P) ${OBJS} 
	rm -f tcsh core
	${CC} ${LDFLAGS} ${CFLAGS} ${OBJS} -o tcsh ${LIBES}

tcsh.ps: tcsh.1
	rm -f tcsh.ps
	-ptroff -man tcsh.1 > tcsh.ps


.c.${SUF}:
	${CC} ${CF} ${CFLAGS} $<

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
	egrep '[FV]_' ed.defns.c | egrep '^#define' >> $@
	@echo '#endif /* _h_ed_defns */' >> $@

sh.err.h: sh.err.c
	@rm -f $@
	@echo '/* Do not edit this file, make creates it. */' > $@
	@echo '#ifndef _h_sh_err' >> $@
	@echo '#define _h_sh_err' >> $@
	egrep 'ERR_' sh.err.c | egrep '^#define' >> $@
	@echo '#endif /* _h_sh_err */' >> $@

tc.const.h: tc.const.c sh.char.h config.h config_f.h sh.types.h sh.err.h
	@rm -f $@
	@echo '/* Do not edit this file, make creates it. */' > $@
	${CC} -E -I. tc.const.c | egrep 'Char STR' | \
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
	-mv  ${DESTDIR}/tcsh  ${DESTDIR}/tcsh.old
	cp tcsh ${DESTDIR}/tcsh
	strip ${DESTDIR}/tcsh
	chmod 555 ${DESTDIR}/tcsh

manpage: tcsh.man
	cp tcsh.man ${DESTMAN}/tcsh.${MANSECT}
	chmod 444 ${DESTMAN}/tcsh.${MANSECT}

clean:
	${RM} -f a.out strings x.c xs.c tcsh _MAKE_LOG core
	${RM} -f *.${SUF} sh.prof.c ed.defns.h tc.const.h sh.err.h

veryclean: clean
	${RM} -f *~ #*

tags:	/tmp
	${CTAGS} sh*.c

tar:
	rm -f tcsh.tar.Z
	rm -rf tcsh-${VERSION} 
	mkdir tcsh-${VERSION} tcsh-${VERSION}/config
	cp ${ALLSRCS} tcsh-${VERSION}
	cp ${CONFSRCS} tcsh-${VERSION}/config
	tar cvf - tcsh-${VERSION} | compress > tcsh-${VERSION}.tar.Z
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

tc.h: tc.const.h tc.decls.h tc.os.h tc.sig.h
sh.h: sh.types.h sh.char.h sh.err.h sh.dir.h sh.proc.h pathnames.h \
      sh.decls.h tc.h
tw.h: tw.decls.h
ed.h: ed.decls.h

# ed.h
EDINC=sh.${SUF} sh.func.${SUF} sh.lex.${SUF} sh.print.${SUF} sh.proc.${SUF} \
      sh.set.${SUF} tc.bind.${SUF} tc.os.${SUF} tc.prompt.${SUF} \
      tc.sched.${SUF} tw.parse.${SUF}
${EDOBJS} ${EDINC} : ed.h

# sh.h
${OBJS}: config.h sh.h

# tw.h:
TWINC=ed.chared.${SUF} ed.inputl.${SUF} sh.exec.${SUF} sh.func.${SUF} \
      sh.set.${SUF} tc.func.${SUF}
${TWOBJS} ${TWINC}: tw.h

# glob.h
glob.${SUF} sh.glob.${SUF}: glob.h

# ed.defns.h
EDDINC=tc.bind.${SUF} tc.func.${SUF} tc.os.${SUF}
${EDOBJS} ${EDDINC}: ed.defns.h
