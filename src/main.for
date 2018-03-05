      PROGRAM MAIN
          USE CONFIG
          USE DISPLAY
          USE EDGEMATRIX
          USE LINE
          USE MATRIXUTIL

          IMPLICIT NONE
          INTEGER :: I, COLOR(3), THEDISPLAY(3, DIMD, DIMC, DIMR)
          REAL(DP) :: SMAT(4)
          REAL(DP), ALLOCATABLE :: M(:, :)
          TYPE(EDGMAT) :: EDGES

          CALL EDGES%INIT()
          CALL EDGES%ADDEDGE([425._DP, 250._DP, 1._DP],
     +                       [175._DP, 400._DP, 1._DP])
          CALL EDGES%ADDEDGE([125._DP, 400._DP, 1._DP],
     +                       [ 75._DP, 350._DP, 1._DP])
          CALL EDGES%ADDEDGE([ 75._DP, 300._DP, 1._DP],
     +                       [150._DP, 250._DP, 1._DP])
          CALL EDGES%ADDEDGE([ 75._DP, 200._DP, 1._DP],
     +                       [ 75._DP, 150._DP, 1._DP])
          CALL EDGES%ADDEDGE([125._DP, 100._DP, 1._DP],
     +                       [175._DP, 100._DP, 1._DP])
          CALL EDGES%ADDPOINT([425._DP, 250._DP, 1._DP])

          COLOR = [255, 0, 0]
          SMAT = [0.95, 0.95, 1.0, 0.0]
          ALLOCATE(M(EDGES%GETCOLS(), 3))

          DO I = 1, 70
              CALL EDGES%DRAW(THEDISPLAY, COLOR)
              CALL MATRIX_SCALE(M, SMAT)
              CALL EDGES%TRANSFORM(M)
              COLOR(1) = COLOR(1) * 0.95
          END DO

          CALL DISPLAY_PRINT(THEDISPLAY)
      END PROGRAM MAIN

