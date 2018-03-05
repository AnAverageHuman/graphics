      MODULE MATRIXUTIL
          USE CONFIG

          IMPLICIT NONE
          PRIVATE
          PUBLIC :: MATRIX_PRINT, MATRIX_IDENT, MATRIX_TRANSLATE,
     +              MATRIX_SCALE, MATRIX_ROTX, MATRIX_ROTY, MATRIX_ROTZ,
     +              MATRIX_MULT
      CONTAINS
          SUBROUTINE MATRIX_PRINT(MATRIX)
              REAL(DP), INTENT(IN) :: MATRIX(:, :)
              INTEGER :: ROW, COL
              DO ROW=1, SIZE(MATRIX, 2)
                  WRITE (*,*) (MATRIX(COL, ROW), COL=1, SIZE(MATRIX, 1))
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
              FORALL (I = 1:MIN(SIZE(M, 1), SIZE(M, 2)))
                  M(I, I) = M(I, I) * S(I)
              END FORALL
          END SUBROUTINE MATRIX_SCALE

          PURE SUBROUTINE MATRIX_ROTX(M, S)
              REAL(DP), INTENT(INOUT) :: M(:, :)
              REAL(DP), INTENT(IN)    :: S

              CALL MATRIX_IDENT(M)
              M(2, 2) =  COS(S)
              M(2, 3) = -SIN(S)
              M(3, 2) =  SIN(S)
              M(3, 3) =  COS(S)
          END SUBROUTINE MATRIX_ROTX

          PURE SUBROUTINE MATRIX_ROTY(M, S)
              REAL(DP), INTENT(INOUT) :: M(:, :)
              REAL(DP), INTENT(IN)    :: S

              CALL MATRIX_IDENT(M)
              M(1, 1) =  COS(S)
              M(3, 1) = -SIN(S)
              M(1, 3) =  SIN(S)
              M(3, 3) =  COS(S)
          END SUBROUTINE MATRIX_ROTY

          PURE SUBROUTINE MATRIX_ROTZ(M, S)
              REAL(DP), INTENT(INOUT) :: M(:, :)
              REAL(DP), INTENT(IN)    :: S

              CALL MATRIX_IDENT(M)
              M(1, 1) =  COS(S)
              M(1, 2) = -SIN(S)
              M(2, 1) =  SIN(S)
              M(2, 2) =  COS(S)
          END SUBROUTINE MATRIX_ROTZ

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

