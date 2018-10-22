	PROGRAM TST_1
	IMPLICIT NONE
!
	INTEGER, PARAMETER :: IONE=1
	INTEGER  N,I,J
	REAL*8, ALLOCATABLE :: D(:,:,:)
!
	READ(5,*)N
	ALLOCATE (D(N,N,2))
!
	DO I=1,N
	  DO J=1,N
	    D(J,I,1)=J+(I-1)*N
	  END DO
	END DO
!
	CALL WRITE_D_MAT(D(:,:,1),N,IONE)
	CALL WRITE_D_MAT(D,N,IONE+1)
!
	STOP
	END
