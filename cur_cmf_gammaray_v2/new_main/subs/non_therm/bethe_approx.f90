	SUBROUTINE BETHE_APPROX(Q,NL,NUP,XKT,dXKT,NKT,ID,DPTH_INDX,FAST_METHOD)
	USE MOD_CMFGEN
	IMPLICIT NONE
!
	INTEGER ID
	INTEGER DPTH_INDX
	INTEGER NKT
	INTEGER NL,NUP
	REAL*8 Q(NKT)
	REAL*8 XKT(NKT)
	REAL*8 dXKT(NKT)
!
	LOGICAL FAST_METHOD
!
	REAL*8, PARAMETER :: PI=3.141592653589793238462643D0
	REAL*8, PARAMETER :: A0 = 0.529189379D-8    		!Bohr radius in cm
	REAL*8, PARAMETER :: Hz_TO_EV=4.1356691D0
	REAL*8, PARAMETER :: COL_CONST=13.6D0*8.0D0*PI*PI*A0*A0/1.732D0
!
	REAL*8 GBAR
	REAL*8 X
	REAL*8 T1,T2
	REAL*8 dE
	REAL*8 dE_eV
!
	INTEGER IKT
!
	Q=0.0D0
	GBAR=0.2D0
!
	dE=ATM(ID)%EDGEXzV_F(NL)-ATM(ID)%EDGEXzV_F(NUP)
	IF(dE .LE. 0)RETURN
	dE_eV=Hz_to_eV*dE
	T2=3.28978D0/dE
	IF(FAST_METHOD)THEN
	  GBAR=0.2
	  T1=3.28978D0*COL_CONST*GBAR*ATM(ID)%AXzV_F(NL,NUP)*ATM(ID)%XzV_F(NL,DPTH_INDX)/dE
	  DO IKT=1,NKT
	    IF(XKT(IKT) .GE. dE_eV)THEN
	      Q(IKT)=T1*dXKT(IKT)/XKT(IKT)
	    END IF
	  END DO
	ELSE
	  GBAR=0.2
	  T1=3.28978D0*COL_CONST*ATM(ID)%AXzV_F(NL,NUP)*ATM(ID)%XzV_F(NL,DPTH_INDX)/dE
	  DO IKT=1,NKT
	    IF(XKT(IKT) .GE. dE_eV)THEN
	      Q(IKT)=T1*GBAR*dXKT(IKT)/XKT(IKT)
	    END IF
	  END DO
	END IF
!
	RETURN
	END      
