      MODULE UTILITIES
          USE CONFIG

          IMPLICIT NONE
          PRIVATE
          PUBLIC :: STDERR, TOSTR, DEG2RAD

          REAL, PARAMETER :: PI     = 4._DP * ATAN(1._DP)
          REAL, PARAMETER :: DEG180 = 180._DP
          REAL, PARAMETER :: D_TO_R = PI / DEG180
      CONTAINS
          SUBROUTINE STDERR(MESSAGE)
              USE ISO_FORTRAN_ENV, ONLY : ERROR_UNIT
              CHARACTER(LEN=*) :: MESSAGE

              WRITE(ERROR_UNIT, '(A)') MESSAGE
          END SUBROUTINE STDERR

          PURE FUNCTION TOSTR(K) RESULT(STR)
              INTEGER, INTENT(IN) :: K
              CHARACTER(LEN=20) :: STR

              WRITE(STR, *) K
              STR = ADJUSTL(STR)
          END FUNCTION TOSTR

          PURE FUNCTION DEG2RAD(D) RESULT(R)
              REAL(DP), INTENT(IN) :: D
              REAL(DP) :: R

              R = D * D_TO_R
          END FUNCTION DEG2RAD
      END MODULE UTILITIES

