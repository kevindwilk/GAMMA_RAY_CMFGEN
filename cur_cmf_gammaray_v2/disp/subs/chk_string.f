	SUBROUTINE CHK_STRING(STRING,LUIN,TST_STR,PROG)
	IMPLICIT NONE
C
	INTEGER LUIN,ERROR_LU
	CHARACTER*(*) TST_STR,PROG
	CHARACTER*(*) STRING
	EXTERNAL ERROR_LU
C
	READ(LUIN,'(A)')STRING
	IF( INDEX(STRING,TST_STR) .EQ. 0)THEN
	  WRITE(ERROR_LU(),*)'Invalid format : '//TST_STR//
	1                    ' not found in '//PROG//' read'
	  STOP
	END IF
C
	RETURN
	END
