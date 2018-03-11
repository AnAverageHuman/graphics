      MODULE MATRIXUTIL
          USE CONFIG

          IMPLICIT NONE
          PRIVATE
          PUBLIC :: MATRIX_PRINT, MATRIX_IDENT, MATRIX_TRANSLATE,
     +              MATRIX_SCALE, MATRIX_ROTATE, MATRIX_MULT
      CONTAINS
          SUBROUTINE MATRIX_PRINT(MATRIX)
              REAL(DP), INTENT(IN) :: MATRIX(:, :)
              INTEGER :: ROW, COL
              DO ROW=1, SIZE(MATRIX, 2)
                  WRITE (0,'(*(F10.3))')
     +              (MATRIX(COL, ROW), COL=1, SIZE(MATRIX, 1))
              ENDDO
          END SUBROUTINE MATRIX_PRINT

          PURE SUBROUTINE MATRIX_IDENT(M)
              REAL(DP), INTENT(INOUT) :: M(:, :)
              INTEGER :: I

              M(:, :) = 0
              FORALL(I = 1:MIN(SIZE(M, 1), SIZE(M, 2))) M(I, I) = 1
          END SUBROUTINE MATRIX_IDENT

          PURE SUBROUTINE MATRIX_TRANSLATE(M, S)
              REAL(DP), INTENT(INOUT) :: M(:, :)
              REAL(DP), INTENT(IN)    :: S(3)
              INTEGER :: I

              CALL MATRIX_IDENT(M)
              FORALL(I = 1:3) M(4, I) = S(I)
          END SUBROUTINE MATRIX_TRANSLATE

          PURE SUBROUTINE MATRIX_SCALE(M, S)
              REAL(DP), INTENT(INOUT) :: M(:, :)
              REAL(DP), INTENT(IN)    :: S(3)
              INTEGER :: I

              CALL MATRIX_IDENT(M)
              FORALL (I = 1:MIN(SIZE(M, 1), SIZE(M, 2), 3))
                  M(I, I) = M(I, I) * S(I)
              END FORALL
          END SUBROUTINE MATRIX_SCALE

          PURE SUBROUTINE MATRIX_ROTATE(M, S, D)
              REAL(DP), INTENT(INOUT) :: M(:, :)
              REAL(DP), INTENT(IN)    :: S
              INTEGER,  INTENT(IN)    :: D  ! 1: X, 2: Y, 3: Z
              INTEGER                 :: I
              REAL(DP)                :: X(4)
              INTEGER, PARAMETER :: RM(2, 4, 3) =
     +          RESHAPE([2,2, 2,3, 3,2, 3,3,
     +                   1,1, 3,1, 1,3, 3,3,
     +                   1,1, 1,2, 2,1, 2,2], [2, 4, 3])

              X = [COS(S), -SIN(S), SIN(S), COS(S)]
              CALL MATRIX_IDENT(M)
              FORALL (I = 1:4) M(RM(1, I, D), RM(2, I, D)) = X(I)
          END SUBROUTINE MATRIX_ROTATE

          PURE FUNCTION MATRIX_MULT(A, B) RESULT(C)
              !   A   n x m   SIZE(A, 2), SIZE(A, 1)
              !   B   m x p   SIZE(B, 2), SIZE(A, 2)
              !   C   n x p   SIZE(B, 1), SIZE(A, 2)

              REAL(DP), INTENT(IN), DIMENSION(:, :) :: A, B
              REAL(DP) :: C(SIZE(B,1), SIZE(A,2))
              INTEGER  :: I, J, K

              C(:, :) = 0
              DO I = 1, SIZE(A, 2)
                  DO J = 1, SIZE(B, 2)
C                     DO K = 1, SIZE(B, 1)
                      C(:, I) = C(:, I) + A(J, I) * B(:, J)
C                     END DO
                  END DO
              END DO
          END FUNCTION MATRIX_MULT   ! possibly faster than MATMUL()
      END MODULE MATRIXUTIL

