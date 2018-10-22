	PROGRAM TST_WR
	IMPLICIT NONE
	INTEGER, PARAMETER :: N=1020
	INTEGER, PARAMETER :: ND=1600
	INTEGER, PARAMETER :: LU=10
	INTEGER, PARAMETER :: ISIX=6
	INTEGER I,J
	REAL*8 F(N,ND)
!
	DO I=1,ND
	  DO J=1,N
	    F(J,I)=J+(I-1)*N
	  END DO
	END DO
!
	CALL WR2D_V2(F,N,ND,'Testing WR','#',.TRUE.,LU)
	CALL WR2D_V2(F,N,ND,'Testing WR','#',.FALSE.,11)
!
	STOP
	END
