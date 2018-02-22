      MODULE MATRIXUTIL
          IMPLICIT NONE
          PRIVATE
          PUBLIC :: MATRIX_PRINT, MATRIX_IDENT
      CONTAINS
          SUBROUTINE MATRIX_PRINT(MATRIX)
              INTEGER, INTENT(IN) :: MATRIX(:, :)
              INTEGER :: ROW, COL
              DO ROW=1, SIZE(MATRIX, 2)
                  WRITE (*,*) (MATRIX(COL, ROW), COL=1, SIZE(MATRIX, 1))
              ENDDO
          END SUBROUTINE MATRIX_PRINT

          PURE SUBROUTINE MATRIX_IDENT(M)
              INTEGER, INTENT(INOUT) :: M(:, :)
              INTEGER :: I

              M(:, :) = 0
              FORALL(I = 1:MIN(SIZE(M, 1), SIZE(M, 2))) M(I, I) = 1
          END SUBROUTINE MATRIX_IDENT
      END MODULE MATRIXUTIL

