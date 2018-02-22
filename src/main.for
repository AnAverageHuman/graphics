      PROGRAM MAIN
          USE CONFIG
          USE DISPLAY
          USE EDGEMATRIX
          USE LINE
          USE MATRIXUTIL

          IMPLICIT NONE
          INTEGER, DIMENSION(3, DIMD, DIMC, DIMR) :: THEDISPLAY
          TYPE(EDGMAT) :: EDGES

          EDGES = EDGMAT()
          CALL EDGES%ADDEDGE((/ 425, 250, 1 /), (/ 175, 400, 1 /))
          CALL EDGES%ADDEDGE((/ 425, 250, 1 /), (/ 175, 100, 1 /))
          CALL EDGES%ADDEDGE((/ 125, 400, 1 /), (/ 175, 400, 1 /))
          CALL EDGES%ADDEDGE((/ 125, 100, 1 /), (/ 175, 100, 1 /))
          CALL EDGES%ADDEDGE((/ 125, 400, 1 /), (/  75, 350, 1 /))
          CALL EDGES%ADDEDGE((/ 125, 100, 1 /), (/  75, 150, 1 /))
          CALL EDGES%ADDEDGE((/  75, 300, 1 /), (/  75, 350, 1 /))
          CALL EDGES%ADDEDGE((/  75, 150, 1 /), (/  75, 200, 1 /))
          CALL EDGES%ADDEDGE((/  75, 300, 1 /), (/ 150, 250, 1 /))
          CALL EDGES%ADDEDGE((/  75, 200, 1 /), (/ 150, 250, 1 /))

          CALL EDGES%DRAW(THEDISPLAY, (/100, 200, 105/))

          CALL DISPLAY_PRINT(THEDISPLAY)
      END PROGRAM MAIN

