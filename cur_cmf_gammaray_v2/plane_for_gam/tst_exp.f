	PROGRAM TST_EXP
!
	IMPLICIT NONE
	REAL*8 EXPINT,EXPN,EXPI
	EXTERNAL EXPINT,EXPN,EXPI
!
	REAL*8 X
	REAL*8 T1,T2
	INTEGER N
!
	WRITE(6,'(A)',ADVANCE='NO')'N & X values:'
	READ(5,*)N,X
!
	T1=EXPINT(N,X)
	T2=EXPN(N,X)
	WRITE(6,*)T1,T2,EXPI(X)
!
	STOP
	END
