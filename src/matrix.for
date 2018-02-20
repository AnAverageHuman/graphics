      MODULE MATRIX
          IMPLICIT NONE
          PRIVATE
          PUBLIC :: MATRIX_PRINT, MATRIX_IDENT, MATRIX_MULT
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

          PURE SUBROUTINE MATRIX_MULT(A, B, C)
              !   A   n x m   SIZE(A, 2), SIZE(A, 1)
              !   B   m x p   SIZE(B, 2), SIZE(A, 2)
              !   C   n x p   SIZE(B, 2), SIZE(A, 1)

              INTEGER, INTENT(IN), DIMENSION(:, :) :: A, B
              INTEGER, INTENT(OUT) :: C(SIZE(A,1), SIZE(B,2))
              INTEGER :: I, J

              C(:, :) = 0
              DO I = 1, SIZE(B, 2)
                  DO J = 1, SIZE(A, 2)
C                     DO K = 1, SIZE(A, 1)
                      C(:, I) = C(:, I) + A(:, J) * B(J, I)
C                     END DO
                  END DO
              END DO
          END SUBROUTINE MATRIX_MULT   ! possibly faster than MATMUL()
      END MODULE MATRIX

