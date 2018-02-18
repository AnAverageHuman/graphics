      MODULE LINE
          USE DISPLAY

          IMPLICIT NONE
          PRIVATE
          PUBLIC :: DRAWLINE

          INTEGER :: DX, DY, X, Y
      CONTAINS
          RECURSIVE SUBROUTINE DRAWLINE(DISPLAY, P1, P2, COLOR)
              INTEGER, INTENT(INOUT), DIMENSION(:, :, :, :) :: DISPLAY
              INTEGER, INTENT(IN), DIMENSION(2) :: P1, P2
              INTEGER, INTENT(IN), DIMENSION(3) :: COLOR

              DX = P2(1) - P1(1)
              DY = P2(2) - P1(2)
              X = P1(1)
              Y = P1(2)

              IF (ABS(DY) < ABS(DX)) THEN
                  IF (P1(1) > P2(1)) THEN
                      CALL DRAWLINE(DISPLAY, P2, P1, COLOR)
                  ELSE
                      CALL DRAWLINELOW(DISPLAY, P2(1), COLOR)
                  ENDIF
              ELSE
                  IF (P1(2) > P2(2)) THEN
                      CALL DRAWLINE(DISPLAY, P2, P1, COLOR)
                  ELSE
                      CALL DRAWLINEHIGH(DISPLAY, P2(2), COLOR)
                  ENDIF
              ENDIF
          END SUBROUTINE DRAWLINE

          SUBROUTINE DRAWLINELOW(DISPLAY, MX, COLOR)
              INTEGER, INTENT(INOUT), DIMENSION(:, :, :, :) :: DISPLAY
              INTEGER, INTENT(IN)               :: MX
              INTEGER, INTENT(IN), DIMENSION(3) :: COLOR
              INTEGER                           :: D, I, YI

              YI = 1
              IF (DY < 0) THEN
                  YI = -1
                  DY = -DY
              ENDIF

              D = 2 * DY - DX
              DO I = X, MX
                  CALL PLOT(DISPLAY, I, Y, 1, COLOR)
                  D = D + 2 * DY
                  IF (D > 0) THEN
                      Y = Y + YI
                      D = D - 2 * DX
                  END IF
              END DO
          END SUBROUTINE DRAWLINELOW

          SUBROUTINE DRAWLINEHIGH(DISPLAY, MY, COLOR)
              INTEGER, INTENT(INOUT), DIMENSION(:, :, :, :) :: DISPLAY
              INTEGER, INTENT(IN)               :: MY
              INTEGER, INTENT(IN), DIMENSION(3) :: COLOR
              INTEGER                           :: D, I, XI

              XI = 1
              IF (DX < 0) THEN
                  XI = -1
                  DX = -DX
              ENDIF

              D = 2 * DX - DY
              DO I = Y, MY
                  CALL PLOT(DISPLAY, X, I, 1, COLOR)
                  D = D + 2 * DX
                  IF (D > 0) THEN
                      X = X + XI
                      D = D - 2 * DY
                  END IF
              END DO
          END SUBROUTINE DRAWLINEHIGH
      END MODULE LINE

