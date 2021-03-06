	SUBROUTINE DETERM_REDDENING(OBS_SPEC,OBS_NU,NOBS,
	1                  FIT_SPEC,FIT_NU,NFIT,
	1                  R_MIN,R_MAX)
	IMPLICIT NONE
!
	INTEGER NOBS,NFIT
	REAL*8 OBS_SPEC(NOBS),OBS_NU(NOBS)
	REAL*8 FIT_SPEC(NFIT),FIT_NU(NFIT)
	REAL*8 R_MIN,R_MAX
!
	REAL*8 RHS(2)
	REAL*8 MAT(2,2)
!
	REAL*8, ALLOCATABLE :: NU_ST(:)
	REAL*8, ALLOCATABLE :: NU_END(:)
	REAL*8, ALLOCATABLE :: LAM_ST(:)
	REAL*8, ALLOCATABLE :: LAM_END(:)
	REAL*8, ALLOCATABLE :: OBS(:)
	REAL*8, ALLOCATABLE :: FIT(:)
	REAL*8, ALLOCATABLE :: WEIGHT(:)
	REAL*8, ALLOCATABLE :: GAL_RED_LAW(:)
	REAL*8, ALLOCATABLE :: GAL_RED_LAW_SAVE(:)
!
	INTEGER IOS
	INTEGER I,K,L
	INTEGER LST,LEND
	REAL*8 R_EXT
	REAL*8 RAX,RBX
	REAL*8 T1,T2
	REAL*8 EBMV
	REAL*8 LOG_DIST
	REAL*8 CHI_SQ
	REAL*8 ANG_TO_HZ
!
	REAL*8 CHI_SQ_SVE
	REAL*8 EBMV_SVE
	REAL*8 DIST_SVE
	REAL*8 R_SVE
!
	REAL*8 SPEED_OF_LIGHT
	EXTERNAL SPEED_OF_LIGHT
!
	INTEGER NUM_BNDS
	INTEGER GET_INDX_DP
	EXTERNAL GET_INDX_DP
!
	CHI_SQ_SVE=1.0D+200
	ANG_TO_HZ=SPEED_OF_LIGHT()*1.0D-07      !10^8/10^15
!
	OPEN(UNIT=10,FILE='RED_BANDS',STATUS='OLD',ACTION='READ',IOSTAT=IOS)
	  IF(IOS .NE. 0)THEN
	    WRITE(6,*)'Error opening RED_BANDS -- must be in same directory as issuing PLT_SPEC command'
	    RETURN
	  END IF
	  READ(10,*)NUM_BNDS
	  ALLOCATE (LAM_ST(NUM_BNDS))
	  ALLOCATE (LAM_END(NUM_BNDS))
	  ALLOCATE (WEIGHT(NUM_BNDS))
	  DO I=1,NUM_BNDS
	    READ(10,*)LAM_ST(I),LAM_END(I),WEIGHT(I)
	  END DO
	CLOSE(UNIT=10)
!
	ALLOCATE (NU_ST(NUM_BNDS))
	ALLOCATE (NU_END(NUM_BNDS))
	ALLOCATE (OBS(NUM_BNDS))
	ALLOCATE (FIT(NUM_BNDS))
	ALLOCATE (GAL_RED_LAW(NUM_BNDS))
	ALLOCATE (GAL_RED_LAW_SAVE(NUM_BNDS))
!
	DO I=1,NUM_BNDS
	  NU_ST(I)=ANG_TO_HZ/LAM_ST(I)
	  NU_END(I)=ANG_TO_HZ/LAM_END(I)
	END DO
!
	DO I=1,NUM_BNDS
	  OBS(I)=0.0D0
	  LST=GET_INDX_DP(NU_ST(I),OBS_NU,NOBS)
	  LEND=GET_INDX_DP(NU_END(I),OBS_NU,NOBS)
	  DO L=MIN(LST,LEND),MAX(LST,LEND)
	    OBS(I)=OBS(I)+OBS_SPEC(L)
	  END DO
	  OBS(I)=OBS(I)/(ABS(LST-LEND)+1) 
	END DO
!
	DO I=1,NUM_BNDS
	  FIT(I)=0.0D0
	  LST=GET_INDX_DP(NU_ST(I),FIT_NU,NFIT)
	  LEND=GET_INDX_DP(NU_END(I),FIT_NU,NFIT)
	  DO L=MIN(LST,LEND),MAX(LST,LEND)
	    FIT(I)=FIT(I)+FIT_SPEC(L)
	  END DO
	  FIT(I)=FIT(I)/(ABS(LST-LEND)+1) 
	END DO
!
	WRITE(6,*)' '
	WRITE(6,'(A,4(6X,A))')'  I',' Lam(st)','Lam(end)','  OBS(I)','  MOD(I)'
	DO I=1,NUM_BNDS
	  WRITE(6,'(I3,4ES14.4)')I,LAM_ST(I),LAM_END(I),OBS(I),FIT(I)
	END DO
!
	WRITE(6,'(A)')
	WRITE(6,'(5(8X,A))')'     R','     d','E(B-V)',' Chi^2','dCHI^2'
!
! Peform the minization. We loop over R_EXT.
!
	DO L=1,NINT(1+(R_MAX-R_MIN)/0.05)
	  R_EXT=R_MIN+(L-1)*0.05D0
!
! Get Galactic reddenining curve.
!
	  DO I=1,NUM_BNDS
	    T1=(LAM_ST(I)+LAM_END(I))/2.0D0
	    T1=10000.0/T1                    !1/Lambda(um)
	   IF(T1 .LT. 1.1)THEN
	      RAX=0.574*(T1**1.61)
	      RBX=-0.527*(T1**1.61)
	    ELSE IF(T1. LT. 3.3)THEN
	      T2=T1-1.82
	      RAX=1+T2*(0.17699-T2*(0.50447+T2*(0.02427-T2*(0.72085
	1                 +T2*(0.01979-T2*(0.77530-0.32999*T2))))))
	      RBX=T2*(1.41338+T2*(2.28305+T2*(1.07233-T2*(5.38434
	1                +T2*(0.62251-T2*(5.30260-2.09002*T2))))))
	    ELSE IF(T1 .lT. 5.9)THEN
	      RAX=1.752-0.316*T1-0.104/((T1-4.67)**2+0.341)
	      RBX=-3.090+1.825*T1+1.206/((T1-4.62)**2+0.263)
	    ELSE IF(T1 .LT. 8.0)THEN
  	      T2=T1-5.9
	      RAX=1.752-0.316*T1-0.104/((T1-4.67)**2+0.341) -
	1                       T2*T2*(0.04773+0.009779*T2)
	      RBX=-3.090+1.825*T1+1.206/((T1-4.62)**2+0.263)+
	1                       T2*T2*(0.2130+0.1207*T2)
	    ELSE IF(T1 .LT. 10)THEN
	      T2=T1-8
	      RAX=-1.073-T2*(0.628-T2*(0.137-0.070*T2))
	      RBX=13.670+T2*(4.257-T2*(0.420-0.374*T2))               
	    ELSE 
	      T1=10
	      T2=T1-8
	      RAX=-1.073-T2*(0.628-T2*(0.137-0.070*T2))
	      RBX=13.670+T2*(4.257-T2*(0.420-0.374*T2))
	    END IF
            GAL_RED_LAW(I)=R_EXT*(RAX+RBX/R_EXT)
	  END DO
!
	  GAL_RED_LAW(1:NUM_BNDS)=0.921D0*GAL_RED_LAW(1:NUM_BNDS)
	  MAT=0.0D0
	  RHS=0.0D0
	  DO I=1,NUM_BNDS
	    RHS(1)=RHS(1)-WEIGHT(I)*2.0D0*LOG(OBS(I)/FIT(I))
	    RHS(2)=RHS(2)-WEIGHT(I)*LOG(OBS(I)/FIT(I))*GAL_RED_LAW(I)
	    MAT(1,1)=MAT(1,1)+WEIGHT(I)*4.0D0
	    MAT(1,2)=MAT(1,2)+WEIGHT(I)*2.0D0*GAL_RED_LAW(I)
	    MAT(2,1)=MAT(2,1)+WEIGHT(I)*2.0D0*GAL_RED_LAW(I)
	    MAT(2,2)=MAT(2,2)+WEIGHT(I)*GAL_RED_LAW(I)*GAL_RED_LAW(I)
	  END DO
!
! Determine parameters:
!                  Log d(kpc) and E(B-V)
!
	  I=2
	  CALL SIMQ(MAT,RHS,I,K)
!
! Get fit value.
!
	  LOG_DIST=RHS(1)
	  EBMV=RHS(2)
	  CHI_SQ=0.0D0
	  DO I=1,NUM_BNDS
	    T1=WEIGHT(I)*(LOG(OBS(I)/FIT(I))+2*LOG_DIST+GAL_RED_LAW(I)*EBMV)**2
	    CHI_SQ=CHI_SQ+T1
	  END DO
	  WRITE(6,'(5ES14.4)')R_EXT, EXP(LOG_DIST), EBMV, CHI_SQ, 1.0D+04*CHI_SQ/NUM_BNDS
	  IF(CHI_SQ .LT.  CHI_SQ_SVE)THEN
	    CHI_SQ_SVE=CHI_SQ
	    GAL_RED_LAW_SAVE=GAL_RED_LAW
	    EBMV_SVE=EBMV
	    DIST_SVE=EXP(LOG_DIST)
	    R_SVE=R_EXT
	  END IF
	END DO
!
	DO I=1,NUM_BNDS
	  T1=WEIGHT(I)*(LOG(OBS(I)/FIT(I))+2*LOG(DIST_SVE)+GAL_RED_LAW_SAVE(I)*EBMV_SVE)**2
	  WRITE(6,'(2F14.2,3X,F3.0,ES12.3)')LAM_ST(I),LAM_END(I),WEIGHT(I),T1/CHI_SQ_SVE
	END DO
!
	WRITE(6,'(A)')
	WRITE(6,'(A,F10.3)')'        The optimal E(B-V) is:',EBMV_SVE
	WRITE(6,'(A,F10.3)')'       The optimal R value is:',R_SVE
	WRITE(6,'(A,F10.3)')'The optimal distance (kpc) is:',DIST_SVE
	WRITE(6,'(A)')
!
	DEALLOCATE (LAM_ST,LAM_END,NU_ST,NU_END,OBS,FIT,WEIGHT,GAL_RED_LAW)
!
	RETURN
	END
