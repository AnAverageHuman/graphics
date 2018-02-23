      MODULE NODES
          IMPLICIT NONE
          PRIVATE
          PUBLIC :: NODE, RMNODE

          TYPE :: NODE
              CLASS(*), DIMENSION(:), POINTER :: DATA => NULL()
              TYPE(NODE),             POINTER :: NEXT => NULL()
              TYPE(NODE),             POINTER :: PREV => NULL()
          CONTAINS
              PROCEDURE :: GETNEXT
              PROCEDURE :: SETNEXT
              PROCEDURE :: GETPREV
              PROCEDURE :: SETPREV
              PROCEDURE :: GETVAL
              FINAL     :: RMNODE
          END TYPE NODE

          INTERFACE NODE
              MODULE PROCEDURE :: CONSTRUCT
          END INTERFACE
      CONTAINS
          FUNCTION GETNEXT(THIS) RESULT(NEXT)
              CLASS(NODE), INTENT(IN) :: THIS
              CLASS(NODE), POINTER    :: NEXT

              NEXT => THIS%NEXT
          END FUNCTION GETNEXT

          SUBROUTINE SETNEXT(THIS, NEXT)
              CLASS(NODE), INTENT(INOUT)       :: THIS
              CLASS(NODE), POINTER, INTENT(IN) :: NEXT

              THIS%NEXT => NEXT
          END SUBROUTINE SETNEXT

          FUNCTION GETPREV(THIS) RESULT(PREV)
              CLASS(NODE), INTENT(IN) :: THIS
              CLASS(NODE), POINTER    :: PREV

              PREV => THIS%PREV
          END FUNCTION GETPREV

          SUBROUTINE SETPREV(THIS, PREV)
              CLASS(NODE), INTENT(INOUT)       :: THIS
              CLASS(NODE), POINTER, INTENT(IN) :: PREV

              THIS%PREV => PREV
          END SUBROUTINE SETPREV

          FUNCTION GETVAL(THIS) RESULT(VAL)
              CLASS(NODE), INTENT(IN) :: THIS
              CLASS(*), DIMENSION(:), POINTER :: VAL

              VAL => THIS%DATA
          END FUNCTION GETVAL

          FUNCTION CONSTRUCT(VAL, NEXT, PREV) RESULT(THIS)
              CLASS(*), DIMENSION(:), INTENT(IN) :: VAL
              CLASS(NODE), POINTER,   INTENT(IN) :: NEXT, PREV
              CLASS(NODE), POINTER               :: THIS

              ALLOCATE(THIS)
              ALLOCATE(THIS%DATA, SOURCE=VAL)

              CALL THIS%SETNEXT(NEXT)
              CALL THIS%SETPREV(PREV)
              IF (ASSOCIATED(THIS%NEXT)) THEN
                  CALL NEXT%SETPREV(THIS)
              ENDIF
              IF (ASSOCIATED(THIS%PREV)) THEN
                  CALL PREV%SETNEXT(THIS)
              ENDIF
          END FUNCTION CONSTRUCT

          SUBROUTINE RMNODE(THIS)
              TYPE(NODE) :: THIS

              DEALLOCATE(THIS%DATA)
              IF (ASSOCIATED(THIS%NEXT)) THEN
                  CALL THIS%NEXT%SETPREV(THIS%GETPREV())
              END IF
              IF (ASSOCIATED(THIS%PREV)) THEN
                  CALL THIS%PREV%SETNEXT(THIS%GETNEXT())
              END IF
          END SUBROUTINE RMNODE
      END MODULE NODES

