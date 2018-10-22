C
C Function to compute the bound-free gaunt factors for
C a hydrogenic ion of charge Z. The method uses approximate
C formulae which have been fitted to the results of Karasz
C and Latter by Mihalas (Ap. J. ,149,1967, p171) .
C For n> 10 the bound free coefficients are set to unity.
C The frequency should be given in units of 1.0E+15 Hz and the
C temperature in units of 1.0E+04 K .
C
	FUNCTION GBF(RNU,N,ZHE)
	IMPLICIT NONE
C
C Altered 24-May-1996 : IMPLICIT NONE installed.
C                       A now declared REAL*8
C
	INTEGER N
	REAL*8 GBF,RNU,ZHE
C
	REAL*8 A(0:6,10),T1
	DATA A
	1/  1.2302628D0,-2.9094219D-03,7.3993579D-06,-8.7356966D-09
	1, -5.5759888D0,12.803223D0,0.0D0
	1,  1.1595421D0,-2.0735860D-03,2.7033384D-06,0.0D0
	1, -1.2709045D0,2.1325684D0,-2.0244141D0
	1,  1.1450949D0,-1.9366592D-03,2.3572356D-06,0.0D0
	1, -0.55936432D0,0.52471924D0,-0.23387146D0
	1,  1.1306695D0,-1.3482273D-03,-4.6949424D-06,2.3548636D-08
	1, -0.31190730D0,0.1968356D0,-5.4418565D-02
	1,  1.1190904D0,-1.0401085D-03,-6.9943488D-06,2.8496742D-08
	1, -0.16051018D0,5.5545091D-02,-8.9182854D-03
	1,  1.1168376D0,-8.9466573D-04,-8.8393113D-06,3.4696768D-08
	1, -0.13075417D0,4.1921183D-02,-5.5303574D-03
	1,  1.1128623D0,-7.4883260D-04,-1.0244504D-05,3.8595771D-08
	1, -9.5441161D-02,2.3350812D-02,-2.2752881D-03
	1,  1.1093137D0,-6.2619148D-04,-1.1342068D-05,4.1477731D-08
	1, -7.1010560D-02,1.3298411D-02,-9.7200274D-04
	1,  1.1078717D0,-5.4837392D-04,-1.2157943D-05,4.3796716D-08
	1, -5.6056560D-02,8.5139736D-03,-4.9576163D-04
	1,  1.1052734D0,-4.4341570D-04,-1.3235905D-05,4.7003140D-08
	1, -4.7326370D-02,6.1516856D-03,-2.9467046D-04/
C
	T1=RNU/ZHE/ZHE/0.2998D0		!To convert from microns to hz
	IF(N .GT. 10 .OR. T1 .GT. 110.0D0)THEN
	  GBF=1.0D0
	ELSE
	  GBF=A(0,N)+(A(1,N)+(A(2,N)+A(3,N)*T1)*T1)*T1
	1  +(A(4,N)+(A(5,N)+A(6,N)/T1)/T1)/T1
	END IF
C
C
	RETURN
	END
