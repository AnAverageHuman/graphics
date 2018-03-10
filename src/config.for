      MODULE CONFIG
          IMPLICIT NONE
          CHARACTER(LEN = 2), PARAMETER :: MAGICNUMBER = "P3"
          INTEGER, PARAMETER :: DIMC=500, DIMR=500, DIMD=1, MAXCOLOR=255

C         define some constants
          INTEGER, PARAMETER :: DP=KIND(0.D0)   ! double precision
          INTEGER, PARAMETER :: FD=10           ! unit for script
      END MODULE CONFIG

