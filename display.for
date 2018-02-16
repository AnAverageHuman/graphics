      MODULE DISPLAY
          USE CONFIG

          IMPLICIT NONE
          PRIVATE
          PUBLIC :: DISPLAY_PRINT
      CONTAINS
          SUBROUTINE DISPLAY_PRINT(DISPLAY)
              INTEGER, INTENT(IN) :: DISPLAY(:, :, :, :)

              WRITE(*, "(A)") MAGICNUMBER  ! suppress beginning space
              WRITE(*, *) DIMR, DIMC, MAXCOLOR, DISPLAY
          END SUBROUTINE DISPLAY_PRINT
      END MODULE DISPLAY

