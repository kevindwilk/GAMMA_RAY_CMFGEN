	PROGRAM TST_GET_INDX
	USE GET_INDX_INTERFACE
	IMPLICIT NONE
C
	INTEGER, PARAMETER :: N=200
	REAL*8 XD,XVECD(N)
	REAL*8 VALD
	REAL*4 XS,XVECS(N)
	REAL*4 VALS
	INTEGER I
C
	DO I=1,N
	  XVECD(I)=I	
	  XVECS(I)=I*2
	END DO
C
	VALD=100.0D0
	VALS=100.0
	WRITE(2,*)GET_INDX(VALD,XVECD,N)
	WRITE(2,*)GET_INDX(VALS,XVECS,N)
C
	STOP
	END
