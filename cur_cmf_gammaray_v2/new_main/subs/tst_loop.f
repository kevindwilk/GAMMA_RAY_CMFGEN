	PROGRAM TST_LOOP
	IMPLICIT NONE
!
	INTEGER, PARAMETER :: NT=1400
	INTEGER, PARAMETER :: NB=3
	INTEGER, PARAMETER :: ND=100
!
	REAL*8 VJ(NT,NB,ND)
	REAL*8 VJ_SUM(NT,NB,ND)
	REAL*8 VJ_SUM2(NT,NB,ND)
	REAL*8 RJ(ND)
	REAL*8 OLDJ(ND)
!
	INTEGER I,J,K,L
	INTEGER ISEED
!
	ISEED=-12345678
	DO L=1,ND
	  OLDJ(L)=RAN(ISEED)
	  DO K=1,NB
	    DO I=1,NT
!	       VJ(I,K,L)=0.2
	       VJ(I,K,L)=RAN(ISEED)
	    END DO
	  END DO
	END DO
	VJ_SUM(:,:,:)=0.0D0
	VJ_SUM2(:,:,:)=0.0D0
	RJ(:)=0.0D0
!
	CALL TUNE(1,'LOOP:')
	DO I=1,100
	  DO L=1,ND
	     VJ_SUM(:,:,L)=VJ_SUM(:,:,L)+VJ(:,:,L)
	     VJ_SUM2(:,:,L)=VJ_SUM2(:,:,L)-2.0D0*VJ(:,:,L)
	     RJ(L)=RJ(L)+OLDJ(L)
	  END DO
	END DO
	CALL TUNE(2,'LOOP:')
	WRITE(6,*)SUM(VJ_SUM)
	WRITE(6,*)SUM(VJ_SUM2)
!
	CALL TUNE(1,'LOOP')
	DO I=1,100
	  DO L=1,ND
	    DO K=1,NB
	      DO J=1,NT
	        VJ_SUM(J,K,L)=VJ_SUM(J,K,L)+VJ(J,K,L)
	        VJ_SUM2(J,K,L)=VJ_SUM2(J,K,L)-2.0D0*VJ(J,K,L)
	      END DO
	    END DO
	    RJ(L)=RJ(L)+OLDJ(L)
	  END DO
	END DO
	CALL TUNE(2,'LOOP')
	WRITE(6,*)SUM(VJ_SUM)
	WRITE(6,*)SUM(VJ_SUM2)
!
	CALL TUNE(1,'LOOP2')
	DO I=1,100
	  DO L=1,ND
	    DO K=1,NB
	      DO J=1,NT
	        VJ_SUM(J,K,L)=VJ_SUM(J,K,L)+VJ(J,K,L)
	        VJ_SUM2(J,K,L)=VJ_SUM2(J,K,L)-2.0D0*VJ(J,K,L)
	      END DO
	    END DO
	    RJ(L)=RJ(L)+OLDJ(L)
	  END DO
	END DO
	CALL TUNE(2,'LOOP2')
!
	CALL TUNE(1,'LOOP2:')
	DO I=1,100
	  DO L=1,ND
	     VJ_SUM(:,:,L)=VJ_SUM(:,:,L)+VJ(:,:,L)
	     VJ_SUM2(:,:,L)=VJ_SUM2(:,:,L)-2.0D0*VJ(:,:,L)
	     RJ(L)=RJ(L)+OLDJ(L)
	  END DO
	END DO
	CALL TUNE(2,'LOOP2:')
!
!
	CALL TUNE(3,' ')
!
	STOP
	END