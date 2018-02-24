      MODULE EDGEMATRIX
          USE LINE
          USE MATRIXUTIL

          IMPLICIT NONE
          PRIVATE
          PUBLIC :: EDGMAT

          TYPE :: EDGMAT
              PRIVATE
              REAL, DIMENSION(:, :), ALLOCATABLE :: EM
              INTEGER :: SIZE
          CONTAINS
              PROCEDURE, PASS, NON_OVERRIDABLE :: INIT
              PROCEDURE, PASS, NON_OVERRIDABLE :: REALLOCEM
              PROCEDURE, PASS, NON_OVERRIDABLE :: GETCOLS
              PROCEDURE, PASS, NON_OVERRIDABLE :: GETROWS
              PROCEDURE, PASS, NON_OVERRIDABLE :: ADDPOINT
              PROCEDURE, PASS, NON_OVERRIDABLE :: ADDEDGE
              PROCEDURE, PASS, NON_OVERRIDABLE :: DRAW
              PROCEDURE, PASS, NON_OVERRIDABLE :: DUMP
          END TYPE EDGMAT
      CONTAINS
          SUBROUTINE INIT(THIS)
              CLASS(EDGMAT) :: THIS

              ALLOCATE(THIS%EM(3, 1))
              THIS%SIZE = 0
          END SUBROUTINE INIT

          PURE SUBROUTINE REALLOCEM(THIS)    ! double allocated size
              CLASS(EDGMAT), INTENT(INOUT) :: THIS
              REAL, DIMENSION(:, :), ALLOCATABLE :: TMP

              ALLOCATE(TMP(3, THIS%GETROWS() * 2))
              TMP(1:3, 1:THIS%SIZE) = THIS%EM
              CALL MOVE_ALLOC(TMP, THIS%EM)
          END SUBROUTINE REALLOCEM  ! implicit deallocation here

          PURE FUNCTION GETCOLS(THIS) RESULT(C) ! QA: currently unused
              CLASS(EDGMAT), INTENT(IN) :: THIS
              INTEGER :: C

              C = MERGE(UBOUND(THIS%EM, 1), 0, ALLOCATED(THIS%EM))
          END FUNCTION GETCOLS

          PURE FUNCTION GETROWS(THIS) RESULT(R)
              CLASS(EDGMAT), INTENT(IN) :: THIS
              INTEGER :: R

              R = MERGE(UBOUND(THIS%EM, 2), 0, ALLOCATED(THIS%EM))
          END FUNCTION GETROWS

          SUBROUTINE ADDPOINT(THIS, DATA)
              CLASS(EDGMAT), INTENT(INOUT) :: THIS
              REAL,          INTENT(IN)    :: DATA(3)

              IF (THIS%SIZE .GE. THIS%GETROWS()) THEN
                  CALL THIS%REALLOCEM()
              END IF

              THIS%SIZE = THIS%SIZE + 1
              THIS%EM(:, THIS%SIZE) = DATA
          END SUBROUTINE ADDPOINT

          SUBROUTINE ADDEDGE(THIS, D1, D2)
              CLASS(EDGMAT), INTENT(INOUT) :: THIS
              REAL,          INTENT(IN)    :: D1(3), D2(3)

              CALL THIS%ADDPOINT(D1)
              CALL THIS%ADDPOINT(D2)
          END SUBROUTINE ADDEDGE

          SUBROUTINE DRAW(THIS, DISPLAY, COLOR)
              CLASS(EDGMAT), INTENT(IN)    :: THIS
              INTEGER,       INTENT(INOUT) :: DISPLAY(:, :, :, :)
              INTEGER,       INTENT(IN)    :: COLOR(3)
              INTEGER :: I

              DO I = 1, THIS%SIZE - 1
                  CALL DRAWLINE(DISPLAY, INT(THIS%EM(:, I)),
     +                          INT(THIS%EM(:, I + 1)), COLOR)
              END DO
          END SUBROUTINE DRAW

          SUBROUTINE DUMP(THIS)
              CLASS(EDGMAT), INTENT(IN)    :: THIS

              CALL MATRIX_PRINT(THIS%EM)
          END SUBROUTINE DUMP
      END MODULE EDGEMATRIX

