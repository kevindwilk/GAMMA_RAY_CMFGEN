	INTEGER FUNCTION COUNT_OCCUR(STRING,SUB)
	CHARACTER(LEN=*)STRING
	CHARACTER(LEN=*)SUB
	INTEGER J,K
!
	K=1
	COUNT_OCCUR=0
!
	J=1
	DO WHILE(1 .EQ. 1)
	  K=INDEX(STRING(K:),SUB)
	  IF(K .EQ. 0)RETURN
	  COUNT_OCCUR=COUNT_OCCUR+1
	  K=K+J
	  J=K
	END DO
!
	RETURN
	END  
