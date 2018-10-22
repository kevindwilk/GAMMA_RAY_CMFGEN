! This subroutine is to have a quick thing that reads in the input parameters
! so that they aren't hardwired into the code
!
! Created Oct. 12th, 2015
!
! Edited 25 Sept, 2017 : Changed USE MOD_GAMMA_V2 to USE
! 			 MOD_GAMRAY_CNTRL_VARIABLES
!
	SUBROUTINE RD_GAMRAY_CNTRL_V2(FILENAME)
	USE MOD_RD_GAMRAY_CNTRL_VARIABLES
	IMPLICIT NONE
!
	INTEGER :: I,J,K,L
	INTEGER :: IOS
	INTEGER :: LUER
	INTEGER :: ERROR_LU
	EXTERNAL :: ERROR_LU
!
	CHARACTER(LEN=30) :: FILENAME
	CHARACTER(LEN=140) :: STRING
	CHARACTER(LEN=40) :: STRING1,STRING2
!
	LUER=ERROR_LU()
!
	OPEN(UNIT=7,FILE=FILENAME,STATUS='OLD',ACTION='READ',IOSTAT=IOS)
	IF(IOS .NE. 0)THEN
	  WRITE(LUER,'(A,A)')'Error reading file ',FILENAME
	  WRITE(LUER,*)'IOSTAT:',IOS
	  STOP
	END IF
	CHEB_ORDER=8
	ANG_MULT=2
	GAM_IT=1
	GRAY_LINE_MIN=50
	GRAY_TAIL_MIN1=2000
	GRAY_TAIL_MIN2=1000
	GRAY_TAIL_MIN3=500
	GRAY_TAIL_MIN4=100
	NU_GRID_MAX=20000
	V_GAUSS=100.0D0
	V_INF=1.0D+03
	V_TAIL=5.0D+02
	V_LINE=20.0D0
	V_BETWEEN=2.5D+03
	BLUE_GAUSS=15.0D0
	RED_GAUSS=15.0D0
	COMP_TAIL_SPLIT_FRAC=0.05D0
	NORM_GAM_LINES=.FALSE.
	GRID_MIN_PTS=.FALSE.
!
	OPEN(UNIT=7,FILE='GAMMA_MODEL',STATUS='UNKNOWN',ACTION='WRITE')
	STRING=''
	DO WHILE(1 .EQ. 1)
	  STRING1=''
	  STRING2=''
	  READ(7,'(A)',END=100)STRING
	  K=INDEX(STRING,'[')
	  STRING1=ADJUSTL(STRING(1:K-1))
	  STRING1=TRIM(STRING1)
	  J=INDEX(STRING,']')
	  STRING2=STRING(K+1:J-1)
	  STRING2=ADJUSTL(STRING2)
	  STRING2=TRIM(STRING2)
	  IF(TRIM(STRING2) .EQ. 'CHEB_ORDER')THEN
	    READ(STRING1,*)CHEB_ORDER
	    WRITE(7,'(1X,I2,T25,1X,A)')CHEB_ORDER,TRIM(STRING2)
	  ELSE IF(TRIM(STRING2) .EQ. 'NU_GRID_MAX')THEN
	    READ(STRING1,*)NU_GRID_MAX
	    WRITE(7,'(1X,I5,T25,1X,A)')NU_GRID_MAX,TRIM(STRING2)
	  ELSE IF(TRIM(STRING2) .EQ. 'GRAY_LINE_MIN')THEN
	    READ(STRING1,*)GRAY_LINE_MIN
	    WRITE(7,'(1X,I4,T25,1X,A)')GRAY_LINE_MIN,TRIM(STRING2)
	  ELSE IF(TRIM(STRING2) .EQ. 'GRAY_TAIL_MIN1')THEN
	    READ(STRING1,*)GRAY_TAIL_MIN1
	    WRITE(7,'(1X,I4,T25,1X,A)')GRAY_TAIL_MIN1,TRIM(STRING2)
	  ELSE IF(TRIM(STRING2) .EQ. 'GRAY_TAIL_MIN2')THEN
	    READ(STRING1,*)GRAY_TAIL_MIN2
	    WRITE(7,'(1X,I4,T25,1X,A)')GRAY_TAIL_MIN2,TRIM(STRING2)
	  ELSE IF(TRIM(STRING2) .EQ. 'GRAY_TAIL_MIN3')THEN
	    READ(STRING1,*)GRAY_TAIL_MIN3
	    WRITE(7,'(1X,I4,T25,1X,A)')GRAY_TAIL_MIN3,TRIM(STRING2)
	  ELSE IF(TRIM(STRING2) .EQ. 'GRAY_TAIL_MIN4')THEN
	    READ(STRING1,*)GRAY_TAIL_MIN4
	    WRITE(7,'(1X,I4,T25,1X,A)')GRAY_TAIL_MIN4,TRIM(STRING2)
	  ELSE IF(TRIM(STRING2) .EQ. 'V_GAUSS')THEN
	    READ(STRING1,*)V_GAUSS
	    WRITE(7,'(1X,ES16.6,T25,1X,A)')V_GAUSS,TRIM(STRING2)
	  ELSE IF(TRIM(STRING2) .EQ. 'V_INF')THEN
	    READ(STRING1,*)V_INF
	    WRITE(7,'(1X,ES16.6,T25,1X,A)')V_INF,TRIM(STRING2)
	  ELSE IF(TRIM(STRING2) .EQ. 'V_LINE')THEN
	    READ(STRING1,*)V_LINE
	    WRITE(7,'(1X,ES16.6,T25,1X,A)')V_LINE,TRIM(STRING2)
	  ELSE IF(TRIM(STRING2) .EQ. 'V_TAIL')THEN
	    READ(STRING1,*)V_TAIL
	    WRITE(7,'(1X,ES16.6,T25,1X,A)')V_TAIL,TRIM(STRING2)
	  ELSE IF(TRIM(STRING2) .EQ. 'V_BETWEEN')THEN
	    READ(STRING1,*)V_BETWEEN
	    WRITE(7,'(1X,ES16.6,T25,1X,A)')V_BETWEEN,TRIM(STRING2)
	  ELSE IF(TRIM(STRING2) .EQ. 'BLUE_GAUSS')THEN
	    READ(STRING1,*)BLUE_GAUSS
	    WRITE(7,'(1X,ES16.6,T25,1X,A)')BLUE_GAUSS,TRIM(STRING2)
	  ELSE IF(TRIM(STRING2) .EQ. 'RED_GAUSS')THEN
	    READ(STRING1,*)RED_GAUSS
	    WRITE(7,'(1X,ES16.6,T25,1X,A)')RED_GAUSS,TRIM(STRING2)
	  ELSE IF(TRIM(STRING2) .EQ. 'ANG_MULT')THEN
	    READ(STRING1,*)ANG_MULT
	    WRITE(7,'(1X,I2,T25,1X,A)')ANG_MULT,TRIM(STRING2)
	  ELSE IF(TRIM(STRING2) .EQ. 'GAM_IT')THEN
	    READ(STRING1,*)GAM_IT
	    WRITE(7,'(1X,I2,T25,1X,A)')GAM_IT,TRIM(STRING2)
	  ELSE IF(TRIM(STRING2) .EQ. 'NORM_GAM')THEN
	    READ(STRING1,*)NORM_GAM_LINES
	    WRITE(7,'(1X,L1,T25,1X,A)')NORM_GAM_LINES,TRIM(STRING2)
	  ELSE IF(TRIM(STRING2) .EQ. 'TAIL_SPLIT_FRAC')THEN
	    READ(STRING1,*)COMP_TAIL_SPLIT_FRAC
	    WRITE(7,'(1X,ES16.6,T25,1X,A)')COMP_TAIL_SPLIT_FRAC,TRIM(STRING2)
	  ELSE IF(TRIM(STRING2) .EQ. 'USE_MIN_PTS_GRAY_LINES')THEN
	    READ(STRING1,*)GRID_MIN_PTS
	    WRITE(7,'(1X,L1,T25,1X,A)')GRID_MIN_PTS,TRIM(STRING2)
	  ELSE
	    WRITE(7,*)'Error: Unknown option in ',FILENAME
	    STOP
	  END IF
	END DO
100 CONTINUE
	CLOSE(UNIT=7)
	END SUBROUTINE