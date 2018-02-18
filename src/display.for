      MODULE DISPLAY
          USE CONFIG

          IMPLICIT NONE
          PRIVATE
          PUBLIC :: DISPLAY_PRINT, PLOT
      CONTAINS
          SUBROUTINE DISPLAY_PRINT(DISPLAY)
              INTEGER, INTENT(IN) :: DISPLAY(:, :, :, :)

              WRITE(*, "(A)") MAGICNUMBER  ! suppress beginning space
              WRITE(*, *) DIMR, DIMC, MAXCOLOR, DISPLAY
          END SUBROUTINE DISPLAY_PRINT

          PURE SUBROUTINE PLOT(DISPLAY, X, Y, Z, COLOR)
              INTEGER, INTENT(INOUT), DIMENSION(:, :, :, :) :: DISPLAY
              INTEGER, INTENT(IN) :: X, Y, Z
              INTEGER, INTENT(IN), DIMENSION(3) :: COLOR

              DISPLAY(:, Z, Y, X) = COLOR
          END SUBROUTINE PLOT
      END MODULE DISPLAY

