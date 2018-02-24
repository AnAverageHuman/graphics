      MODULE MATRIXUTIL
          IMPLICIT NONE
          PRIVATE
          PUBLIC :: MATRIX_PRINT, MATRIX_IDENT, MATRIX_SCALE,
     +              MATRIX_MULT
      CONTAINS
          SUBROUTINE MATRIX_PRINT(MATRIX)
              REAL, INTENT(IN) :: MATRIX(:, :)
              INTEGER :: ROW, COL
              DO ROW=1, SIZE(MATRIX, 2)
                  WRITE (*,*) (MATRIX(COL, ROW), COL=1, SIZE(MATRIX, 1))
              ENDDO
          END SUBROUTINE MATRIX_PRINT

          PURE SUBROUTINE MATRIX_IDENT(M)
              REAL, INTENT(INOUT) :: M(:, :)
              INTEGER :: I

              M(:, :) = 0
              FORALL(I = 1:MIN(SIZE(M, 1), SIZE(M, 2))) M(I, I) = 1
          END SUBROUTINE MATRIX_IDENT

          PURE SUBROUTINE MATRIX_SCALE(M, S)
              REAL, INTENT(INOUT) :: M(:, :)
              REAL, INTENT(IN)    :: S(3)
              INTEGER :: I

              CALL MATRIX_IDENT(M)
              FORALL (I = 1:MIN(SIZE(M, 1), SIZE(M, 2)))
                  M(I, I) = M(I, I) * S(I)
              END FORALL
          END SUBROUTINE MATRIX_SCALE

          PURE SUBROUTINE MATRIX_MULT(A, B, C)
              !   A   n x m   SIZE(A, 2), SIZE(A, 1)
              !   B   m x p   SIZE(B, 2), SIZE(A, 2)
              !   C   n x p   SIZE(B, 2), SIZE(A, 1)

              REAL, INTENT(IN), DIMENSION(:, :) :: A, B
              REAL, INTENT(OUT) :: C(SIZE(A,1), SIZE(B,2))
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
      END MODULE MATRIXUTIL

