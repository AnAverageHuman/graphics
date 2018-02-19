      MODULE MATRIX
          IMPLICIT NONE
          PRIVATE
          PUBLIC :: MATRIX_PRINT
      CONTAINS
          SUBROUTINE MATRIX_PRINT(MATRIX)
              INTEGER, INTENT(IN) :: MATRIX(:, :)
              INTEGER :: ROW, COL
              DO ROW=1, SIZE(MATRIX, 2)
                  WRITE (*,*) (MATRIX(COL, ROW), COL=1, SIZE(MATRIX, 1))
              ENDDO
          END SUBROUTINE MATRIX_PRINT
      END MODULE MATRIX

