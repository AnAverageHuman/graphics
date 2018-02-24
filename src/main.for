      PROGRAM MAIN
          USE CONFIG
          USE DISPLAY
          USE EDGEMATRIX
          USE LINE
          USE MATRIXUTIL

          IMPLICIT NONE
          INTEGER :: I, COLOR(3), THEDISPLAY(3, DIMD, DIMC, DIMR)
          REAL :: SMAT(3)
          REAL, ALLOCATABLE :: M(:, :)
          TYPE(EDGMAT) :: EDGES

          CALL EDGES%INIT()
          CALL EDGES%ADDEDGE((/ 425., 250., 1. /), (/ 175., 400., 1. /))
          CALL EDGES%ADDEDGE((/ 125., 400., 1. /), (/  75., 350., 1. /))
          CALL EDGES%ADDEDGE((/  75., 300., 1. /), (/ 150., 250., 1. /))
          CALL EDGES%ADDEDGE((/  75., 200., 1. /), (/  75., 150., 1. /))
          CALL EDGES%ADDEDGE((/ 125., 100., 1. /), (/ 175., 100., 1. /))
          CALL EDGES%ADDPOINT((/ 425., 250., 1. /))

          COLOR = (/ 255, 0, 0 /)
          SMAT = (/ 0.95, 0.95, 1.0 /)
          ALLOCATE(M(EDGES%GETCOLS(), 3))

          DO I = 1, 70
              CALL EDGES%DRAW(THEDISPLAY, COLOR)
              CALL MATRIX_SCALE(M, SMAT)
              CALL EDGES%TRANSFORM(M)
              COLOR(1) = COLOR(1) * 0.95
          END DO

          CALL DISPLAY_PRINT(THEDISPLAY)
      END PROGRAM MAIN

