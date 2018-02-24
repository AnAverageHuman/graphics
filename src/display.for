      MODULE DISPLAY
          USE CONFIG

          IMPLICIT NONE
          PRIVATE
          PUBLIC :: DISPLAY_PRINT, PLOT, FILL
      CONTAINS
          SUBROUTINE DISPLAY_PRINT(DISPLAY)
              INTEGER, INTENT(IN) :: DISPLAY(:, :, :, :)

              WRITE(*, "(A)") MAGICNUMBER  ! suppress beginning space
              WRITE(*, *) DIMR, DIMC, MAXCOLOR, DISPLAY
          END SUBROUTINE DISPLAY_PRINT

          PURE SUBROUTINE PLOT(DISPLAY, X, Y, Z, COLOR)
              INTEGER, INTENT(INOUT), DIMENSION(:, :, :, :) :: DISPLAY
              INTEGER, INTENT(IN) :: X, Y, Z, COLOR(3)

              DISPLAY(:, Z, Y, X) = COLOR
          END SUBROUTINE PLOT

          RECURSIVE SUBROUTINE FILL(DISPLAY, X, Y, Z, COLOR, BOUND)
              INTEGER, INTENT(INOUT), DIMENSION(:, :, :, :) :: DISPLAY
              INTEGER, INTENT(IN) :: X, Y, Z, COLOR(3), BOUND(3)
              INTEGER :: P(3), I
              INTEGER, PARAMETER :: DIRECTIONS(3, 4) =
     +          RESHAPE((/ 0,1,0,  0,0,1,  0,-1,0,  0,0,-1 /), (/3, 4/))

              CALL PLOT(DISPLAY, X, Y, Z, COLOR)
              DO I = 1, SIZE(DIRECTIONS, 2)
                  P = (/ Z, Y, X /) + DIRECTIONS(:, I)
                  IF (P(1) > 0 .AND. P(1) <= SIZE(DISPLAY, 2) .AND.
     +                P(2) > 0 .AND. P(2) <= SIZE(DISPLAY, 3) .AND.
     +                P(3) > 0 .AND. P(3) <= SIZE(DISPLAY, 4) .AND.
     +                ANY(DISPLAY(:, P(1), P(2), P(3)) .NE. BOUND) .AND.
     +                ANY(DISPLAY(:, P(1), P(2), P(3)) .NE. COLOR)) THEN
                      CALL FILL(DISPLAY, P(3), P(2), P(1), COLOR, BOUND)
                  END IF
              END DO
          END SUBROUTINE FILL
      END MODULE DISPLAY

