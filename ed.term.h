/* $Header: /home/hyperion/mu/christos/src/sys/tcsh-6.00/RCS/ed.term.h,v 1.1 1991/10/12 04:23:51 christos Exp $ */
/*
 * ed.term.h: Local terminal header
 */
/*-
 * Copyright (c) 1980, 1991 The Regents of the University of California.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 3. All advertising materials mentioning features or use of this software
 *    must display the following acknowledgement:
 *	This product includes software developed by the University of
 *	California, Berkeley and its contributors.
 * 4. Neither the name of the University nor the names of its contributors
 *    may be used to endorse or promote products derived from this software
 *    without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
 * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
 * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
 * SUCH DAMAGE.
 */
#ifndef _h_ed_term
#define _h_ed_term

#define CONTROL(A)	((A) & 037)

#if defined(TERMIO) || defined(POSIX)
/*
 * Aix compatible names
 */
# if defined(VWERSE) && !defined(VWERASE)
#  define VWERASE VWERSE
# endif /* VWERSE && !VWERASE */

# if defined(VDISCRD) && !defined(VDISCARD)
#  define VDISCARD VDISCRD
# endif /* VDISCRD && !VDISCARD */

# if defined(VFLUSHO) && !defined(VDISCARD)
#  define VDISCARD VFLUSHO
# endif  /* VFLUSHO && VDISCARD */

# if defined(VSTRT) && !defined(VSTART)
#  define VSTART VSTRT
# endif /* VSTRT && ! VSTART */

# if defined(VSTAT) && !defined(VSTATUS)
#  define VSTATUS VSTAT
# endif /* VSTAT && ! VSTATUS */

# ifndef ONLRET
#  define ONLRET 0
# endif /* ONLRET */

# ifndef TAB3
#  ifdef OXTABS
#   define TAB3 OXTABS
#  else
#   define TAB3 0
#  endif /* OXTABS */
# endif /* !TAB3 */

# if defined(OXTABS) && !defined(XTABS)
#  define XTABS OXTABS
# endif /* OXTABS && !XTABS */

# ifndef ONLCR
#  define ONLCR 0
# endif /* ONLCR */

# ifndef IEXTEN
#  define IEXTEN 0
# endif /* IEXTEN */

# ifndef ECHOCTL
#  define ECHOCTL 0
# endif /* ECHOCTL */

# ifndef PARENB
#  define PARENB 0
# endif /* PARENB */

# ifndef EXTPROC
#  define EXTPROC 0
# endif /* EXTPROC */

# ifndef FLUSHO
#  define FLUSHO  0
# endif /* FLUSHO */


# if defined(VDISABLE) && !defined(_POSIX_VDISABLE)
#  define _POSIX_VDISABLE VDISABLE
# endif /* VDISABLE && ! _POSIX_VDISABLE */

/*
 * Work around ISC's definition of IEXTEN which is
 * XCASE!
 */
# ifdef ISC
#  if defined(IEXTEN) && defined(XCASE)
#   if IEXTEN == XCASE
#    undef IEXTEN
#    define IEXTEN 0
#   endif /* IEXTEN == XCASE */
#  endif /* IEXTEN && XCASE */
#  if defined(IEXTEN) && !defined(XCASE)
#   define XCASE IEXTEN
#   undef IEXTEN
#   define IEXTEN 0
#  endif /* IEXTEN && !XCASE */
# endif /* ISC */

/*
 * Work around convex weirdness where turning off IEXTEN makes us
 * lose all postprocessing!
 */
#if defined(convex) || defined(__convex__)
# if defined(IEXTEN) && IEXTEN != 0
#  undef IEXTEN
#  define IEXTEN 0
# endif /* IEXTEN != 0 */
#endif /* convex || __convex__ */


# else /* SGTTY */

# ifndef LPASS8
#  define LPASS8  0
# endif /* LPASS8 */

#endif /* TERMIO || POSIX */

#ifndef _POSIX_VDISABLE
# define _POSIX_VDISABLE ((unsigned char) -1)
#endif /* _POSIX_VDISABLE */

#if !defined(CREPRINT) && defined(CRPRNT)
# define CREPRINT CRPRNT
#endif /* !CREPRINT && CRPRNT */
#if !defined(CDISCARD) && defined(CFLUSH)
# define CDISCARD CFLUSH
#endif /* !CDISCARD && CFLUSH */

#ifndef CINTR
# define CINTR		CONTROL('c')
#endif /* CINTR */
#ifndef CQUIT
# define CQUIT		034	/* ^\ */
#endif /* CQUIT */
#ifndef CERASE
# define CERASE		0177	/* ^? */
#endif /* CERASE */
#ifndef CKILL
# define CKILL		CONTROL('u')
#endif /* CKILL */
#ifndef CEOF
# define CEOF		CONTROL('d')
#endif /* CEOF */
#ifndef CEOL
# define CEOL		_POSIX_VDISABLE
#endif /* CEOL */
#ifndef CEOL2
# define CEOL2		_POSIX_VDISABLE
#endif /* CEOL2 */
#ifndef CSWTCH
# define CSWTCH		_POSIX_VDISABLE
#endif /* CSWTCH */
#ifndef CERASE2
# define CERASE2	_POSIX_VDISABLE
#endif /* CERASE2 */
#ifndef CSTART
# define CSTART		CONTROL('s')
#endif /* CSTART */
#ifndef CSTOP
# define CSTOP		CONTROL('q')
#endif /* CSTOP */
#ifndef CSUSP
# define CSUSP		CONTROL('z')
#endif /* CSUSP */
#ifndef CDSUSP
# define CDSUSP		CONTROL('y')
#endif /* CDSUSP */

#ifdef hpux

# ifndef CREPRINT
#  define CREPRINT	_POSIX_VDISABLE
# endif /* CREPRINT */
# ifndef CDISCARD
#  define CDISCARD	_POSIX_VDISABLE
# endif /* CDISCARD */
# ifndef CLNEXT
#  define CLNEXT	_POSIX_VDISABLE
# endif /* CLNEXT */
# ifndef CWERASE
#  define CWERASE	_POSIX_VDISABLE
# endif /* CWERASE */

#else /* !hpux */

# ifndef CREPRINT
#  define CREPRINT	CONTROL('r')
# endif /* CREPRINT */
# ifndef CDISCARD
#  define CDISCARD	CONTROL('o')
# endif /* CDISCARD */
# ifndef CLNEXT
#  define CLNEXT	CONTROL('v')
# endif /* CLNEXT */
# ifndef CWERASE
#  define CWERASE	CONTROL('w')
# endif /* CWERASE */

#endif /* hpux */

#ifndef CSTATUS
# define CSTATUS	CONTROL('t')
#endif /* CSTATUS */
#ifndef CPAGE
# define CPAGE		' '
#endif /* CPAGE */
#ifndef CPGOFF
# define CPGOFF		CONTROL('m')
#endif /* CPGOFF */
#ifndef CBRK
# ifndef masscomp
#  define CBRK		0377
# else
#  define CBRK		'\0'
# endif /* masscomp */
#endif /* CBRK */
#ifndef CMIN
# define CMIN		CEOF
#endif /* CMIN */
#ifndef CTIME
# define CTIME		CEOL
#endif /* CTIME */

#define C_INTR		 0
#define C_QUIT		 1
#define C_ERASE		 2
#define C_KILL		 3
#define C_EOF		 4
#define C_EOL		 5
#define C_EOL2		 6
#define C_SWTCH		 7
#define C_ERASE2	 8
#define C_START		 9
#define C_STOP		10
#define C_WERASE	11
#define C_SUSP		12
#define C_DSUSP		13
#define C_REPRINT	14
#define C_DISCARD	15
#define C_LNEXT		16
#define C_STATUS	17
#define C_PAGE		18
#define C_PGOFF		19
#define C_BRK		20
#define C_MIN		21
#define C_TIME		22
#define C_NCC		23
#define C_SH(A)		(1 << (A))

#endif /* _h_ed_term */
