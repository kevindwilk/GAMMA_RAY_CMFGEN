	MODULE FILT_PASS_BAND
	IMPLICIT NONE
C
	INTEGER, PARAMETER :: NF=6
	CHARACTER*4 FILT_NAME(NF)
	REAL*8 FILT_ST_LAM(NF)
	REAL*8 FILT_DEL_LAM(NF)
	REAL*8 FILT_ZP(NF)
	REAL*8 NORM_PASS(25,NF)
	INTEGER NUM_FILT_DP(NF)
C
	DATA FILT_NAME/'UX','BX','B','V','R','I'/
	DATA FILT_ST_LAM/3000.0D0,3600.0D0,3600.0D0,4700.0D0,5500.0D0,7000.0D0/
	DATA FILT_DEL_LAM/50.0D0,100.0D0,100.0D0,100.0D0,100.0D0,100.0D0/
!
! Johnson system: A0V star with m=0.0
!
! UBVRI = 4.22E-09, 6.40E-09, 3.75E-09, 1.75E-09, 8.4E-10 
!
	
        DATA FILT_ZP/8.079,9.035,9.034,8.915,8.755,8.505/
!        DATA FILT_ZP/20.937,20.485,20.485,21.065,21.892,22.689/
!        DATA FILT_ZP/0.790,-0.104,-0.102,0.008,0.193,0.443/
C
	DATA NUM_FILT_DP/25,21,21,25,25,23/
C
	DATA NORM_PASS(1:25,1)
	1    /0.000,0.016,0.068,0.167,0.287,0.423,0.560,0.673,0.772,0.842,
	1     0.905,0.943,0.981,0.993,1.000,0.989,0.916,0.804,0.625,0.423,
	1     0.238,0.114,0.051,0.019,0.000/
C
	DATA NORM_PASS(1:21,2)
	1    /0.000,0.026,0.120,0.523,0.875,0.956,1.000,0.998,0.972,0.901,
	1     0.793,0.694,0.587,0.460,0.362,0.263,0.169,0.107,0.049,0.010,
	1     0.000/
C
	DATA NORM_PASS(1:21,3)
	1    /0.000,0.030,0.134,0.567,0.920,0.978,1.000,0.978,0.935,0.853,
	1     0.740,0.640,0.536,0.424,0.325,0.235,0.150,0.095,0.043,0.009,
	1     0.000/
C
	DATA NORM_PASS(1:24,4)
	1   /0.000,0.030,0.163,0.458,0.780,0.967,1.000,0.973,0.898,0.792,
	1    0.684,0.574,0.461,0.359,0.270,0.197,0.135,0.081,0.045,0.025,
	1    0.017,0.013,0.009,0.000/
C
	DATA NORM_PASS(1:24,5)
	1   /0.00,0.23,0.74,0.91,0.98,1.00,0.98,0.96,0.93,0.90,
	1    0.86,0.81,0.78,0.72,0.67,0.61,0.56,0.51,0.46,0.40,
	1    0.35,0.14,0.03,0.00/
C
	DATA NORM_PASS(1:23,6)
	1   /0.000,0.024,0.232,0.555,0.785,0.910,0.965,0.985,0.990,0.995,
	1    1.000,1.000,0.990,0.980,0.950,0.910,0.860,0.750,0.560,0.330,
	1    0.150,0.030,0.000/
C
	END MODULE FILT_PASS_BAND
