c
	FUNCTION SPACING(XMIN,XMAX)
	IMPLICIT NONE
	REAL*4 INTVAL(0:10)
	REAL*4 XMIN,XMAX
	REAL*4 SPACING
	INTEGER INDX
	DATA INTVAL/2*0.2,4*0.5,3*1.0,2*2.0/
!
! Altered 27-Oct-2016: Changed treatement ofXMAX=XMIN.
!                        Inserted IMPLICIT NONE.
!
	IF(XMAX .EQ. XMIN)THEN
	  XMAX=1.1*XMAX
	  XMIN=0.9*XMIN
	END IF
	SPACING=LOG10(ABS(XMAX-XMIN))
	INDX=INT(SPACING+1024)-1024
	SPACING=INTVAL(-INT(10*(INDX-SPACING)))*10.0**INDX
	IF(XMAX .LT. XMIN)SPACING=-SPACING
C
	RETURN
	END
!
! 
!
!
	INTEGER FUNCTION NDEC(XINC)
	IMPLICIT NONE
!
! Function to estimate the numer of digits to be used when labeling
! graph axes.
!
! Altered 31-May-2000 : Method changed to overcome rounding problems.
!
	REAL*4 XINC
	INTEGER ITMP
	CHARACTER*10 STRING
C
	IF(XINC .EQ. 0)THEN
	  NDEC=0
	ELSE IF(ABS(XINC) .GT. 1.0E+05)THEN
	  NDEC=1
	ELSE IF(ABS(XINC) .LT. 1.0E-05)THEN
	  NDEC=2
	ELSE
	  ITMP=NINT(XINC*1.0D+04)
	  WRITE(STRING,'(I10)')ITMP
	  NDEC=5
	  IF(ABS(XINC) .LT. 1.0D-02 .AND. STRING(10:10) .NE. '0')THEN
	    NDEC=4
	  ELSE IF(STRING(9:9) .NE. '0')THEN
	    NDEC=3
	  ELSE IF(STRING(8:8) .NE. '0')THEN
	    NDEC=2
	  ELSE IF(STRING(7:7) .NE. '0')THEN
	    NDEC=1
	  ELSE
	    NDEC=0
	  END IF
	END IF
!
	RETURN
	END