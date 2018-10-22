	SUBROUTINE WR_SPEC_SUM(NUM_FRAC,MASS_FRAC,ND)
	USE MOD_DISP
	IMPLICIT NONE
!
	INTEGER ND
	LOGICAL NUM_FRAC
	LOGICAL MASS_FRAC
!
	REAL*8 T1
	REAL*8 ATOMIC_MASS_UNIT
	REAL*8 VALUE(NSPEC)
	INTEGER ISPEC_STORE(NSPEC)
	INTEGER IWORK(NSPEC)
	INTEGER INDX(NSPEC)
!
	EXTERNAL ATOMIC_MASS_UNIT
	INTEGER, PARAMETER :: NSTR=10
	CHARACTER(LEN=120) STRING(NSTR)
	CHARACTER(LEN=120) HEADER
!
	LOGICAL, PARAMETER :: L_FALSE=.FALSE.
	INTEGER I,J,K
	INTEGER DPTH_INDX
	INTEGER ISPEC
!
	STRING=' '
	HEADER=' '
	DPTH_INDX=1
	DO K=1,3
	  IF(K .EQ. 2)DPTH_INDX=(ND+1)/2
	  IF(K .EQ. 3)DPTH_INDX=ND
!
	  J=LEN_TRIM(HEADER)+1
	  IF(K .GT. 1)J=J+13
	  WRITE(HEADER(J:),'(7X,A,I3,A,F8.1)')'V(',DPTH_INDX,')=',V(DPTH_INDX)
	  VALUE=0.0D0
	  DO ISPEC=1,NSPEC
	    IF(POPDUM(DPTH_INDX,ISPEC) .GT. 0.0D0)THEN
	      IF(NUM_FRAC)THEN
	        VALUE(ISPEC)=POPDUM(DPTH_INDX,ISPEC)/POP_ATOM(DPTH_INDX)+1.0D-100
	      ELSE IF(MASS_FRAC)THEN
	        T1=AT_MASS(ISPEC)*ATOMIC_MASS_UNIT()
	        VALUE(ISPEC)=T1*POPDUM(DPTH_INDX,ISPEC)/MASS_DENSITY(DPTH_INDX)+1.0D-100
	      ELSE
	        VALUE(ISPEC)=POPDUM(DPTH_INDX,ISPEC)+1.0D-100
	      END IF
	    END IF
	    ISPEC_STORE(ISPEC)=ISPEC
	  END DO
	  CALL INDEXX(NSPEC,VALUE,INDX,L_FALSE)
	  CALL SORTINT(NSPEC,ISPEC_STORE,INDX,IWORK)
!
	  DO I=1,NSTR
	    IF(ISPEC_STORE(I) .EQ. 0)EXIT
	    J=LEN_TRIM(STRING(I))+1
	    IF(J .NE. 1)J=J+5
	    ISPEC=ISPEC_STORE(I)
	    T1=VALUE(ISPEC)
	    IF(NUM_FRAC .OR. MASS_FRAC)THEN
	      WRITE(STRING(I)(J:),'(A6,2X,F9.6,3X,ES9.2,5X)')TRIM(SPECIES(ISPEC)),T1,LOG10(T1)
	    ELSE
	      WRITE(STRING(I)(J:),'(A6,2X,ES9.3,3X,ES9.2,5X)')TRIM(SPECIES(ISPEC)),T1,LOG10(T1)
	    END IF
	    END DO
	END DO
!
        WRITE(6,'(A)')' '
	IF(NUM_FRAC)THEN
	  WRITE(6,'(A)')' Number fraction (NF) and Log(NF) at inner boundary'
	ELSE IF(MASS_FRAC)THEN
	  WRITE(6,'(A)')' Mass fraction (MF) and Log(MF) at inner boundary'
	ELSE
	  WRITE(6,'(A)')' Number denistury (ND) and Log(ND) at inner boundary'
	END IF
	WRITE(6,'(A)')' '
!
	WRITE(6,'(A)')HEADER
	DO I=1,NSTR
	  IF(STRING(I) .NE. ' ')THEN
	    WRITE(6,'(A)')STRING(I)
	  END IF
	END DO
!
	RETURN
	END
