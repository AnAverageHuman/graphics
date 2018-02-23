      MODULE EDGEMATRIX
          USE LINE
          USE NODES

          IMPLICIT NONE
          PRIVATE
          PUBLIC :: EDGMAT

          TYPE, EXTENDS(NODE) :: EDGMAT
              PRIVATE
              CLASS(NODE), POINTER :: FIRST => NULL(), LAST => NULL()
          CONTAINS
              PROCEDURE, NON_OVERRIDABLE :: ADDPOINT
              PROCEDURE, NON_OVERRIDABLE :: ADDEDGE
              PROCEDURE, NON_OVERRIDABLE :: DRAW
          END TYPE EDGMAT
      CONTAINS
          SUBROUTINE ADDPOINT(THIS, DATA)
              CLASS(EDGMAT), INTENT(INOUT) :: THIS
              INTEGER,       INTENT(IN)    :: DATA(:)

              IF (ASSOCIATED(THIS%FIRST)) THEN ! not null; push on front
                  THIS%FIRST => NODE(DATA, THIS%FIRST, NULL())
              ELSE
                  THIS%FIRST => NODE(DATA, NULL(), NULL())
                  THIS%LAST => THIS%FIRST
              END IF
          END SUBROUTINE ADDPOINT

          SUBROUTINE ADDEDGE(THIS, D1, D2)
              CLASS(EDGMAT), INTENT(INOUT) :: THIS
              INTEGER,       INTENT(IN)    :: D1(:), D2(:)

              CALL THIS%ADDPOINT(D1)
              CALL THIS%ADDPOINT(D2)
          END SUBROUTINE ADDEDGE

          SUBROUTINE DRAW(THIS, DISPLAY, COLOR)
              CLASS(EDGMAT), INTENT(IN)    :: THIS
              INTEGER,       INTENT(INOUT) :: DISPLAY(:, :, :, :)
              INTEGER,       INTENT(IN)    :: COLOR(3)
              CLASS(NODE), POINTER  :: CURR
              INTEGER, DIMENSION(3) :: P1, P2

              CURR => THIS%FIRST
              DO WHILE (ASSOCIATED(CURR%GETNEXT()))
                  ! TODO: make this block look prettier
                  SELECT TYPE (X => CURR%GETVAL())
                      TYPE IS (INTEGER); P1 = X
                  END SELECT
                  SELECT TYPE (X => CURR%NEXT%GETVAL())
                      TYPE IS (INTEGER); P2 = X
                  END SELECT
                  CALL DRAWLINE(DISPLAY, P1, P2, COLOR)
                  CURR => CURR%GETNEXT()
              END DO
          END SUBROUTINE DRAW
      END MODULE EDGEMATRIX

