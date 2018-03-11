      PROGRAM MAIN
          USE CONFIG
          USE DISPLAY
          USE EDGEMATRIX
          USE LINE
          USE MATRIXUTIL
          USE UTILITIES

          IMPLICIT NONE
          INTEGER :: I, COLOR(3), THEDISPLAY(3, DIMD, DIMC, DIMR)

          CHARACTER(LEN=128) :: FILENAME ! hard-limit for now
          CHARACTER(LEN=128) :: LINE
          CHARACTER          :: RDIR
          LOGICAL  :: BOOL
          INTEGER  :: IOS
          REAL(DP) :: RDATA(10)
          REAL(DP) :: TMPTRANS(4, 4)

          REAL(DP) :: TRANSM(4, 4)
          TYPE(EDGMAT) :: EDGES

          CALL GET_COMMAND_ARGUMENT(1, FILENAME)
          INQUIRE(FILE=FILENAME, EXIST=BOOL)
          IF (.NOT. BOOL) THEN
              WRITE (0,*) 'Specified file "', TRIM(ADJUSTL(FILENAME)),
     +                    '" does not exist; bailing out.'
              STOP
          END IF

          CALL EDGES%INIT()
          COLOR = [255, 0, 0]
          IOS = 0

          OPEN(FD, FILE=FILENAME, ACTION="READ")
          DO
              READ (FD,*,IOSTAT=IOS) LINE
              IF (IOS .NE. 0) EXIT
              SELECT CASE (LINE)
                  CASE ("line")
                      READ (FD,*) RDATA(1:6)
                      CALL EDGES%ADDEDGE(RDATA(1:3), RDATA(4:6))
                  CASE ("ident")
                      CALL MATRIX_IDENT(TRANSM)
                  CASE ("scale")
                      READ (FD,*) RDATA(1:3)
                      CALL MATRIX_SCALE(TMPTRANS, RDATA(1:3))
                      TRANSM = MATRIX_MULT(TMPTRANS, TRANSM)
                  CASE ("move")
                      READ (FD,*) RDATA(1:3)
                      CALL MATRIX_TRANSLATE(TMPTRANS, RDATA(1:3))
                      TRANSM = MATRIX_MULT(TMPTRANS, TRANSM)
                  CASE ("rotate")
                      READ (FD,*) RDIR, RDATA(1)
                      RDATA(1) = DEG2RAD(RDATA(1))
                      SELECT CASE (RDIR)
                          CASE("x")
                              CALL MATRIX_ROTATE(TMPTRANS, RDATA(1), 1)
                          CASE("y")
                              CALL MATRIX_ROTATE(TMPTRANS, RDATA(1), 2)
                          CASE("z")
                              CALL MATRIX_ROTATE(TMPTRANS, RDATA(1), 3)
                      END SELECT
                      TRANSM = MATRIX_MULT(TMPTRANS, TRANSM)
                  CASE ("apply")
                      CALL EDGES%TRANSFORM(TRANSM)
                  CASE DEFAULT
                      WRITE (0,*) 'Warning: could not interpret "',
     +                  TRIM(ADJUSTL(LINE)), '" at postion', FTELL(FD)
              END SELECT
          END DO
          CLOSE(FD)

          CALL EDGES%DRAW(THEDISPLAY, COLOR)
          CALL DISPLAY_PRINT(THEDISPLAY)
      END PROGRAM MAIN

