      PROGRAM MAIN
          USE CONFIG
          USE DISPLAY
          USE LINE

          IMPLICIT NONE
          INTEGER :: LINES(2, 2, 10), I

          lines(:, 1, 1) = (/425,250/)
          lines(:, 2, 1) = (/175,400/)
          lines(:, 1, 2) = (/425,250/)
          lines(:, 2, 2) = (/175,100/)
          lines(:, 1, 3) = (/125,400/)
          lines(:, 2, 3) = (/175,400/)
          lines(:, 2, 4) = (/125,100/)
          lines(:, 1, 4) = (/175,100/)
          lines(:, 1, 5) = (/125,400/)
          lines(:, 2, 5) = (/ 75,350/)
          lines(:, 1, 6) = (/125,100/)
          lines(:, 2, 6) = (/ 75,150/)
          lines(:, 1, 7) = (/ 75,300/)
          lines(:, 2, 7) = (/ 75,350/)
          lines(:, 1, 8) = (/ 75,150/)
          lines(:, 2, 8) = (/ 75,200/)
          lines(:, 1, 9) = (/ 75,300/)
          lines(:, 2, 9) = (/150,250/)
          lines(:, 1,10) = (/ 75,200/)
          lines(:, 2,10) = (/150,250/)

          DO I=1,10
              CALL DRAWLINE(THEDISPLAY, LINES(:, 1, I),
     +         LINES(:, 2, I), (/255, 255, 255/))
          END DO

          CALL DISPLAY_PRINT(THEDISPLAY)
      END PROGRAM MAIN

