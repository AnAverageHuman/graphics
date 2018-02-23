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
      END MODULE EDGEMATRIX

