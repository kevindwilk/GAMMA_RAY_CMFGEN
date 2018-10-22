	SUBROUTINE COMP_VAR_JREC(JREC,dJRECdT,JPHOT,
	1                  JREC_CR,JPHOT_CR,BPHOT_CR,
	1                  RJ,EMHNUKT,T,NU,FQW,TWOHCSQ,HDKT,ND,COMP_NEW_CONT)
	IMPLICIT NONE
C
	INTEGER ND
	REAL*8 JREC(ND)
	REAL*8 dJRECdT(ND)
	REAL*8 JPHOT(ND)
	REAL*8 JREC_CR(ND)
	REAL*8 JPHOT_CR(ND)
	REAL*8 BPHOT_CR(ND)
	REAL*8 RJ(ND)
	REAL*8 EMHNUKT(ND)
	REAL*8 T(ND)
	REAL*8 NU
	REAL*8 FQW
	REAL*8 HDKT,TWOHCSQ
	LOGICAL COMP_NEW_CONT
C
	REAL*8 T1,T2
	INTEGER I
C
	IF(COMP_NEW_CONT)THEN
	  JREC(:)=0.0D0
	  dJRECdT(:)=0.0D0
	  JPHOT(:)=0.0D0
	  JREC_CR(:)=0.0D0
	  JPHOT_CR(:)=0.0D0
	  BPHOT_CR(:)=0.0D0
	END IF
C
	T1=TWOHCSQ*(NU**3)
	DO I=1,ND
	  T2=(T1+RJ(I))*EMHNUKT(I)*FQW/NU
	  JREC(I)=JREC(I)+T2
	  dJRECdT(I)=dJRECdT(I)+T2*HDKT*NU/T(I)/T(I)
	  JPHOT(I)=JPHOT(I)+RJ(I)*FQW/NU
	  JREC_CR(I)=JREC_CR(I)+T2*NU
	  JPHOT_CR(I)=JPHOT_CR(I)+RJ(I)*FQW
	  BPHOT_CR(I)=BPHOT_CR(I)+T1*FQW*EMHNUKT(I)/(1.0D0-EMHNUKT(I))
	END DO
C
	RETURN
	END