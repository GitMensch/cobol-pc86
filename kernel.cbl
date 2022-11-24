000100******************************************************************
000200*
000300* Main kernel code
000400*
000500******************************************************************
000600 IDENTIFICATION DIVISION.
000700 PROGRAM-ID. KERNEL.
000800 ENVIRONMENT DIVISION.
000900 CONFIGURATION SECTION.
001000 SPECIAL-NAMES.
001100     CRT STATUS IS WS-EXCEPTION-STATUS.
001200 DATA DIVISION.
001300 WORKING-STORAGE SECTION.
001400 01  WS-END                                          PIC A(1).
001500 01  WS-EXCEPTION-STATUS                             PIC X(4).
001600 01  WS-RESIDUE                                      PIC 9(8).
001700 01  WS-DIVRES                                       PIC 9(8).
001800 01  WS-MULBY                                        PIC 9(8).
001900 01  WS-MULRES                                       PIC 9(8).
002000 01  WS-AND1                                         PIC 9(8).
002100 01  WS-ANDBY                                        PIC 9(8).
002200 01  WS-ANDRES                                       PIC 9(8).
       01  WS-OR1                                          PIC 9(8).
       01  WS-ORBY                                         PIC 9(8).
       01  WS-ORRES                                        PIC 9(8).
002300 01  WS-LOOP                                         PIC 9(8).
002400 01  WS-TMP                                          PIC 9(8).
       01  WS-TMP2                                         PIC 9(8).
002500 01  WS-DEBUG                                        PIC A.
002600 01  WS-PTR                                          USAGE IS
002700     POINTER.
002800 01  I                                               PIC S9(8)
002900     COMP.
003000 01  J                                               PIC S9(8)
003100     COMP.
003200 01  K                                               PIC S9(8)
003300     COMP.
003400 01  WS-HEXCHMAP                                     PIC X(16)
003500     VALUE "0123456789ABCDEF".
003600 01  WS-CHAR                                         PIC X.
003700 01  WS-INSTR                                        PIC X(8).
003800 01  WS-OUTSTR                                       PIC X(16).
003900 01  WS-REPLY                                        PIC X.
       01  WS-TIMEOUT                                      PIC 9(4).
004000 01  IO-PORT                                         USAGE IS
004100     BINARY-SHORT UNSIGNED.
004200 01  IO-DATA                                         USAGE IS
004300     BINARY-LONG UNSIGNED.
004400******************************************************************
004500 01  SHELL-DATA.
004700******************************************************************
004600     02 SHELL-OPNAME                                 PIC A(20).
004800******************************************************************
004900 01  DEMO-DATA.
005000******************************************************************
005100     02 DEMO-REPLY                                   PIC X
005200     VALUE SPACE.
005300******************************************************************
005400 01  UART-DATA.
005500******************************************************************
005600     02 UART-PORT                                    PIC 9(4).
005700******************************************************************
005800 01  SB16-DATA.
005900******************************************************************
006000     02 SB16-BASE                                    PIC 9(4).
006100     02 SB16-DSP-VER                                 PIC 9(8).
006200******************************************************************
006300 01  PCIE-DATA.
006400******************************************************************
006500     02 PCI-BUS                                      PIC 9(8).
006600     02 PCI-SLOT                                     PIC 9(8).
006700     02 PCI-FUNC                                     PIC 9(8).
006800     02 PCI-OFFSET                                   PIC 9(8).
006900     02 PCI-ADDRESS                                  PIC 9(16).
007000     02 PCI-DATA                                     PIC 9(8).
007100******************************************************************
007200 01  FLOPPY-DATA.
007300******************************************************************
007400     02 FLOPPY-DRIVE1                                PIC 9(2).
007500     02 FLOPPY-DRIVE2                                PIC 9(2).
007600******************************************************************
007700 01  PS2-DATA.
007800******************************************************************
007900     02 PS2-NUM-DEVICES                              PIC 9(1).
008000     02 PS2-CONFIG                                   PIC 9(8).
008100     02 PS2-DEVSEL                                   PIC 9(1).
008200******************************************************************
008300 01  ATAPI-DATA.
008400******************************************************************
008500     02 ATAPI-BUS                                    PIC 9(4).
           02 ATAPI-DRIVE                                  PIC 9(4).
008600     02 ATAPI-SIZE                                   PIC 9(4).
008700     02 ATAPI-STATUS                                 PIC 9(8).
           02 ATAPI-LBA                                    PIC 9(8).
008800     02 ATAPI-CMD-SIZE                               PIC 9(8).
008900     02 ATAPI-CMD                                    PIC X(32).
009000     02 ATAPI-BUF                                    PIC X(2048).
           02 ATAPI-FIRST-BUS                              PIC 9(4)
           VALUE H'1F0'.
           02 ATAPI-SECOND-BUS                             PIC 9(4)
           VALUE H'170'.
           02 ATAPI-DRIVE-MASTER                           PIC 9(4)
           VALUE H'A0'.
009100******************************************************************
009200 01  FILE-DATA.
009300******************************************************************
009400     02 FILE-NAME                                    PIC X(24).
009500     02 FILE-EXT                                     PIC X(3).
009600     02 FILE-CYL                                     PIC 9(4).
009700     02 FILE-SECT                                    PIC 9(4).
009800     02 FILE-RECORD                                  PIC 9(4).
009900     02 FILE-CREAT-TIME.
010000         05 FILE-CREAT-TIME-HOUR                     PIC 9(2).
010100         05 FILE-CREAT-TIME-SECOND                   PIC 9(2).
010200         05 FILE-CREAT-TIME-MINUTE                   PIC 9(2).
010300         05 FILE-CREAT-TIME-DAY                      PIC 9(2).
010400         05 FILE-CREAT-TIME-MONTH                    PIC 9(2).
010500         05 FILE-CREAT-TIME-YEAR                     PIC 9(4).
010600     02 FILE-RECLEN                                  PIC 9(4).
010700     02 FILE-NUMRECS                                 PIC 9(4).
010800******************************************************************
010900 01  MEM-DATA.
011000******************************************************************
011100     02 MEM-FREE-BYTES                               PIC 9(4).
011200 SCREEN SECTION.
011300 01  STATUS-SCREEN.
011400     02 VALUE "KINNOWOS (C) 2022" BLANK SCREEN LINE 1 COL 1.
011500* The best ASCII art you'll see ever :3
011600     02 VALUE "K    K                                           "
011700     LINE 5 COL 10.
011800     02 VALUE "K   K                                            "
011900     LINE 6 COL 10.
012000     02 VALUE "K  K   I NN   N NN   N  OOOO  W    W  OOO   SSSSS"
012100     LINE 7 COL 10.
012200     02 VALUE "KKK      N N  N N N  N O    O W    W O   O S     "
012300     LINE 8 COL 10.
012400     02 VALUE "K  K   I N  N N N  N N O    O W WW W O   O  SSSS "
012500     LINE 9 COL 10.
012600     02 VALUE "K   K  I N   NN N   NN O    O WW  WW O   O      S"
012700     LINE 10 COL 10.
012800     02 VALUE "K    K I N    N N    N  OOOO  W    W  OOO  SSSSS "
012900     LINE 11 COL 10.
013000     02 VALUE "[I]ntroduction" LINE 13 COL 10.
013100     02 VALUE "Kernal [S]hell" LINE 14 COL 10.
013200     02 VALUE "****" LINE 15 COL 10.
013300     02 VALUE "E[X]it" LINE 16 COL 10.
013400     02 VALUE "Option?" LINE 17 COL 10.
013500     02 VALUE "Hello :)" LINE 25 COL 1 BLANK LINE
013600     BACKGROUND-COLOR 4.
013700     02 KD-OPTINPUT LINE 17 COL 20 PIC X
013800     USING WS-REPLY.
013900 01  INTRO-SCREEN-1.
014000     02 VALUE "KINNOWOS (C) 2022" BLANK SCREEN LINE 1 COL 1.
014100     02 VALUE "Why COBOL?" LINE 5 COL 10.
014200     02 VALUE "Why NOT COBOL? It's a great language!"
014300     LINE 7 COL 10.
014400     02 VALUE "* It's sophisticated" LINE 8 COL 10.
014500     02 VALUE "* It's verbose" LINE 9 COL 10.
014600     02 VALUE "* Dynamically typed" LINE 10 COL 10.
014700     02 VALUE "* It looks cool with syntax highlight" LINE 11
014800     COL 10.
014900 01  INTRO-SCREEN-2.
015000     02 VALUE "KINNOWOS (C) 2022" BLANK SCREEN LINE 1 COL 1.
015100     02 VALUE "B-b-but COBOL is outdated!" LINE 5 COL 10.
015200     02 VALUE "Lies, COBOL just had a revision ongoing this year!"
015300     LINE 7 COL 10.
015400     02 VALUE "* The COBOL 2014 standard" LINE 8 COL 10.
015500     02 VALUE "* GNU/COBOL is being actively developed in 2022"
015600     LINE 9 COL 10.
015700     02 VALUE "  and said compiler is one of the best I've used"
015800     LINE 10 COL 10.
015900     02 VALUE "* C is from 1970, yet people still use it"
016000     LINE 11 COL 10.
016100     02 VALUE "* and C++ is from the 80's! Being old doesn't "
016200     LINE 12 COL 10.
016300     02 VALUE " mean that it is inherently bad!" LINE 13 COL 10.
016400 01  INTRO-SCREEN-3.
016500     02 VALUE "KINNOWOS (C) 2022" BLANK SCREEN LINE 1 COL 1.
016600     02 VALUE "Goals and vision" LINE 5 COL 10.
016700     02 VALUE "* Monolthic kernel" LINE 7 COL 10.
016800     02 VALUE "* All system utilities written on COBOL"
016900     LINE 8 COL 10.
017000     02 VALUE "* Remove as much C code from the kernel"
017100     LINE 9 COL 10.
017200 01  INTRO-SCREEN-4.
017300     02 VALUE "KINNOWOS (C) 2022" BLANK SCREEN LINE 1 COL 1.
017400     02 VALUE "The end" LINE 5 COL 10.
017500     02 VALUE "That was a quick slideshow wasn't it?"
017600     LINE 7 COL 10.
017700     02 VALUE "I would've added more slides but I think"
017800     LINE 8 COL 10.
017900     02 VALUE "it's better that the OS speaks by itself"
018000     LINE 9 COL 10.
018100     02 VALUE "so why not try out the kernel shell?"
018200     LINE 10 COL 10.
018300 01  INTRO-SCREEN-INPUT.
018400     02 VALUE "(press B for going back or P/N for slide control)"
018500     LINE 20 COL 10.
018600     02 KD-OPTINPUT LINE 20 COL 70 PIC X
018700     USING WS-REPLY.
018800 01  SHELL-PROMPT.
018900     02 VALUE "KINNOWOS (C) 2022" BLANK SCREEN LINE 1 COL 1.
019000     02 VALUE "(Use TAB to switch between fields)" LINE 2 COL 1.
019100     02 VALUE "Operation:" LINE 3 COL 1.
019200     02 SH-OPNAME LINE 3 COL 15 PIC A(20)
019300     USING SHELL-OPNAME.
019400     02 VALUE "IO-PORT:" LINE 4 COL 1.
019500     02 SH-T1 LINE 4 COL 15 PIC 9(8)
019600     USING IO-PORT.
019700     02 VALUE "IO-DATA:" LINE 5 COL 1.
019800     02 SH-T2 LINE 5 COL 15 PIC 9(8)
019900     USING IO-DATA.
020000     02 VALUE "WS-TMP:" LINE 6 COL 1.
020100     02 SH-T3 LINE 6 COL 15 PIC 9(8)
020200     USING WS-TMP.
020300     02 VALUE "UART-PORT:" LINE 7 COL 1.
020400     02 SH-T2 LINE 7 COL 15 PIC 9(4)
020500     USING UART-PORT.
020600     02 VALUE "OUT8 = Perform an IO operation" LINE 20 COL 1.
020700     02 VALUE "OUT16, OUT32, IN8, IN16, IN32" LINE 21 COL 1.
020800 PROCEDURE DIVISION.
020900******************************************************************
021000*
021100* Kernel main procedure
021200*
021300******************************************************************
021400 KERNEL.
      * Configure as you wish
021500     MOVE 'Y' TO WS-DEBUG.
021600     MOVE H'3F8' TO UART-PORT.
           MOVE ATAPI-FIRST-BUS TO ATAPI-BUS.
           MOVE ATAPI-DRIVE-MASTER TO ATAPI-DRIVE.
      * Perform sanity checks
           IF WS-DEBUG = 'Y'
               MOVE H'7F' TO WS-AND1
               MOVE H'0F' TO WS-ANDBY
               PERFORM BITWISE-AND
               IF WS-ANDRES NOT = H'0F'
                   DISPLAY "Bitwise and 7F & 0F gave incorrect result "
                   WS-ANDRES END-DISPLAY
                   PERFORM DEBUG-HANG
               END-IF
           END-IF.
      * Initialize main drivers
           PERFORM ATAPI-READ.
           PERFORM DEBUG-HANG.
021700     PERFORM UART-INIT.
021800     PERFORM PS2-INIT.
021900     PERFORM PS2-INIT-KEYBOARD.
022000* Display main menu
022100 KDEMO-MAIN-MENU.
022300     MOVE SPACE TO WS-REPLY.
022400     PERFORM UNTIL WS-REPLY = 'X'
022500          ACCEPT STATUS-SCREEN END-ACCEPT
022600          EVALUATE WS-REPLY
022700              WHEN 'I'
022800                 PERFORM KDEMO-INTRO-0
022900              WHEN 'S'
023000                 PERFORM KDEMO-SHELL
023100              WHEN 'X'
023200                 PERFORM KDEMO-EXIT
023300          END-EVALUATE
023400     END-PERFORM.
023500     STOP RUN.
023600 KDEMO-INTRO-0.
023700     GO TO KDEMO-INTRO-1.
023800 KDEMO-INTRO-1.
023900     DISPLAY INTRO-SCREEN-1 END-DISPLAY.
024000     MOVE SPACE TO WS-REPLY.
024100     PERFORM UNTIL WS-REPLY = 'B'
024200         ACCEPT INTRO-SCREEN-INPUT END-ACCEPT
024300         EVALUATE WS-REPLY
024400             WHEN 'N'
024500                 PERFORM KDEMO-INTRO-2
024600             WHEN 'P'
024700                 PERFORM KDEMO-INTRO-0
024800         END-EVALUATE
024900     END-PERFORM.
025000     MOVE SPACE TO WS-REPLY.
025100     GO TO KDEMO-MAIN-MENU.
025200 KDEMO-INTRO-2.
025300     DISPLAY INTRO-SCREEN-2 END-DISPLAY.
025400     MOVE SPACE TO WS-REPLY.
025500     PERFORM UNTIL WS-REPLY = 'B'
025600         ACCEPT INTRO-SCREEN-INPUT END-ACCEPT
025700         EVALUATE WS-REPLY
025800             WHEN 'N'
025900                 PERFORM KDEMO-INTRO-3
026000             WHEN 'P'
026100                 PERFORM KDEMO-INTRO-1
026200         END-EVALUATE
026300     END-PERFORM.
026400     MOVE SPACE TO WS-REPLY.
026500     GO TO KDEMO-MAIN-MENU.
026600 KDEMO-INTRO-3.
026700     DISPLAY INTRO-SCREEN-3 END-DISPLAY.
026800     MOVE SPACE TO WS-REPLY.
026900     PERFORM UNTIL WS-REPLY = 'B'
027000         ACCEPT INTRO-SCREEN-INPUT END-ACCEPT
027100         EVALUATE WS-REPLY
027200             WHEN 'N'
027300                 PERFORM KDEMO-INTRO-4
027400             WHEN 'P'
027500                 PERFORM KDEMO-INTRO-2
027600         END-EVALUATE
027700     END-PERFORM.
027800     MOVE SPACE TO WS-REPLY.
027900     GO TO KDEMO-MAIN-MENU.
028000 KDEMO-INTRO-4.
028100     DISPLAY INTRO-SCREEN-4 END-DISPLAY.
028200     MOVE SPACE TO WS-REPLY.
028300     PERFORM UNTIL WS-REPLY = 'B'
028400         ACCEPT INTRO-SCREEN-INPUT END-ACCEPT
028500         EVALUATE WS-REPLY
028600             WHEN 'N'
028700                 GO TO KDEMO-MAIN-MENU
028800             WHEN 'P'
028900                 PERFORM KDEMO-INTRO-3
029000         END-EVALUATE
029100     END-PERFORM.
029200     MOVE SPACE TO WS-REPLY.
029300     GO TO KDEMO-MAIN-MENU.
029400 KDEMO-SHELL.
029500     MOVE SPACE TO WS-REPLY.
029600     PERFORM UNTIL WS-REPLY = 'X'
029700         ACCEPT SHELL-PROMPT END-ACCEPT
029800         EVALUATE SHELL-OPNAME
029900             WHEN "OUT8"
030000                 PERFORM IO-OUT-8
030100             WHEN "OUT16"
030200                 PERFORM IO-OUT-16
030300             WHEN "OUT32"
030400                 PERFORM IO-OUT-32
030500             WHEN "IN8"
030600                 PERFORM IO-OUT-8
030700             WHEN "IN16"
030800                 PERFORM IO-OUT-16
030900             WHEN "IN32"
031000                 PERFORM IO-OUT-32
031100             WHEN "EXIT"
031200                 MOVE 'X' TO WS-REPLY
031300         END-EVALUATE
031400         MOVE SPACES TO SHELL-OPNAME
031500     END-PERFORM.
031600     MOVE SPACE TO WS-REPLY.
031700     GO TO KDEMO-MAIN-MENU.
031800 KDEMO-EXIT.
031900* Hacky VM shutdown, for VMware, qemu and bochs
032000     MOVE H'2000' TO IO-DATA.
032100     MOVE H'B004' TO IO-PORT.
032200     PERFORM IO-OUT-16.
032300     MOVE H'2000' TO IO-DATA.
032400     MOVE H'0604' TO IO-PORT.
032500     PERFORM IO-OUT-16.
032600     MOVE H'3400' TO IO-DATA.
032700     MOVE H'4004' TO IO-PORT.
032800     PERFORM IO-OUT-16.
032900     STOP RUN.
033000* Default error handler
033100 KDEMO-ERROR.
033200     ACCEPT WS-EXCEPTION-STATUS FROM EXCEPTION STATUS END-ACCEPT.
033300     DISPLAY "." BLANK LINE AT LINE 25 COL 1
033400     WITH BACKGROUND-COLOR 4 END-DISPLAY.
033500     DISPLAY WS-EXCEPTION-STATUS AT LINE 25 COL 1
033600     WITH BACKGROUND-COLOR 4 END-DISPLAY.
033700     IF WS-EXCEPTION-STATUS NOT EQUAL "1000" THEN
033800         DISPLAY "Press any key to continue" AT LINE 25 COL 30
033900         WITH BACKGROUND-COLOR 4 END-DISPLAY
034000         ACCEPT WS-REPLY END-ACCEPT
034100         STOP RUN
034200     END-IF.
034300******************************************************************
034400*
034500* File management services driver
034600*
034700******************************************************************
034800 FILE-CREATE.
034900     MULTIPLY FILE-RECLEN BY FILE-NUMRECS GIVING WS-MULRES
035000     END-MULTIPLY.
035100     ALLOCATE WS-MULRES CHARACTERS INITIALIZED RETURNING WS-PTR.
035200******************************************************************
035300*
035400* ATAPI Driver
035500*
035600******************************************************************
035700 ATAPI-SECTION SECTION.
035800 ATAPI-INIT.
035900* Reads a part of the disk onto ATAPI-BUFFER, set ATAPI-SIZE
036000* previously ;)
036100 ATAPI-READ.
           PERFORM ATAPI-DRIVESEL.
      * Clear the command buffer first
           MOVE ZEROES TO ATAPI-CMD.
           MOVE 12 TO ATAPI-CMD-SIZE.
           MOVE H'A8' TO ATAPI-CMD(1:1).
           MOVE 1 TO ATAPI-CMD(10:1).
      * Low byte
           MOVE ATAPI-LBA TO ATAPI-CMD(6:1).
      * Second byte, shift by 8 bits
           MOVE ATAPI-LBA TO WS-TMP.
           DIVIDE WS-TMP BY H'100' GIVING WS-TMP END-DIVIDE.
           MOVE WS-TMP TO ATAPI-CMD(5:1).
      * Third byte, shift by 16 bits
           MOVE ATAPI-LBA TO WS-TMP.
           DIVIDE WS-TMP BY H'10000' GIVING WS-TMP END-DIVIDE.
           MOVE WS-TMP TO ATAPI-CMD(4:1).
      * Last byte, shift by 24 bits
           MOVE ATAPI-LBA TO WS-TMP.
           DIVIDE WS-TMP BY H'1000000' GIVING WS-TMP END-DIVIDE.
           MOVE WS-TMP TO ATAPI-CMD(3:1).
           PERFORM ATAPI-SEND-COMMAND.
      * Obtain the size of the read (high byte first)
           COMPUTE IO-PORT = ATAPI-BUS + 5 END-COMPUTE.
           PERFORM IO-IN-8.
           COMPUTE WS-TMP = IO-DATA * H'100' END-COMPUTE.
           COMPUTE IO-PORT = ATAPI-BUS + 4 END-COMPUTE.
           PERFORM IO-IN-8.
           COMPUTE WS-TMP = WS-TMP + IO-DATA END-COMPUTE.
           DISPLAY "Read size is " WS-TMP END-DISPLAY.
036200     DISPLAY "TODO: Read" END-DISPLAY.
       ATAPI-DRIVESEL.
           IF WS-DEBUG = 'Y'
               IF ATAPI-DRIVE NOT = ATAPI-DRIVE-MASTER
                   DISPLAY "Invalid ATA drive " ATAPI-DRIVE END-DISPLAY
                   PERFORM DEBUG-HANG
               END-IF
               IF ATAPI-BUS NOT = ATAPI-FIRST-BUS AND
               ATAPI-BUS NOT = ATAPI-SECOND-BUS
                   DISPLAY "Invalid ATA bus " ATAPI-BUS END-DISPLAY
                   PERFORM DEBUG-HANG
               END-IF
           END-IF.
           COMPUTE IO-PORT = ATAPI-BUS + 7 END-COMPUTE.
           PERFORM IO-IN-8.
           IF IO-DATA = H'FF'
               DISPLAY "Warning: Drive on bus " ATAPI-BUS " not present"
               END-DISPLAY
           END-IF.
           COMPUTE IO-PORT = ATAPI-BUS + 6 END-COMPUTE.
           MOVE ATAPI-DRIVE TO IO-DATA.
           PERFORM IO-OUT-8.
      * 4ns wait
           COMPUTE IO-PORT = ATAPI-BUS + H'206' END-COMPUTE.
           PERFORM IO-IN-8.
           PERFORM IO-IN-8.
           PERFORM IO-IN-8.
           PERFORM IO-IN-8.
036300 ATAPI-SEND-COMMAND.
036400* Perform operation via PIO
036500     COMPUTE IO-PORT = ATAPI-BUS + 1 END-COMPUTE.
036600     MOVE 0 TO IO-DATA.
036700     PERFORM IO-OUT-8.
036800* Tell the controller the size of our read, first send the low
036900* part of the integer
037000     MOVE ATAPI-SIZE TO WS-AND1.
037100     MOVE H'FF' TO WS-ANDBY.
037200     PERFORM BITWISE-AND.
037300     MOVE WS-ANDRES TO IO-DATA.
037400     COMPUTE IO-PORT = ATAPI-BUS + 4 END-COMPUTE.
037500     PERFORM IO-OUT-8.
037600* Now send the high part
037700     DIVIDE ATAPI-SIZE BY 256 GIVING WS-DIVRES END-DIVIDE.
037800     MOVE WS-DIVRES TO IO-DATA.
037900     COMPUTE IO-PORT = ATAPI-BUS + 5 END-COMPUTE.
038000     PERFORM IO-OUT-8.
038100* Tell it's an ATA PACKET command
038200     COMPUTE IO-PORT = ATAPI-BUS + 7 END-COMPUTE.
038300     MOVE H'A0' TO IO-DATA.
038400     PERFORM IO-OUT-8.
038500     PERFORM ATAPI-WAIT-1.
038600     PERFORM ATAPI-WAIT-2.
038700* Check bit 1 is not set
038800     MOVE ATAPI-STATUS TO WS-AND1.
038900     MOVE H'01' TO WS-ANDBY.
039000     PERFORM BITWISE-AND.
039100     IF WS-ANDRES NOT = 0
039200         DISPLAY "ATAPI bit 1 not clear" END-DISPLAY
039300     END-IF.
039400* Send the command to the ATAPI controller, notice how it's being
039500* outputted in chunks of 16-bits
039600     MOVE ATAPI-CMD-SIZE TO WS-LOOP.
039700     MOVE ATAPI-BUS TO IO-PORT.
039800     PERFORM UNTIL WS-LOOP = 0
039900         MOVE ATAPI-CMD(WS-LOOP:1) TO IO-DATA
040000         PERFORM IO-OUT-16
040100         SUBTRACT 1 FROM WS-LOOP END-SUBTRACT
040200     END-PERFORM.
040300 ATAPI-WAIT-1.
           MOVE 5 TO WS-TIMEOUT.
040400     MOVE 0 TO ATAPI-STATUS.
040500     COMPUTE IO-PORT = ATAPI-BUS + 7 END-COMPUTE.
040600     PERFORM UNTIL ATAPI-STATUS NOT = 0 OR WS-TIMEOUT = 0
040700         PERFORM IO-IN-8
040800         MOVE IO-DATA TO WS-AND1
040900         MOVE H'80' TO WS-ANDBY
041000         PERFORM BITWISE-AND
041100         MOVE WS-ANDRES TO ATAPI-STATUS
               SUBTRACT 1 FROM WS-TIMEOUT END-SUBTRACT
041200     END-PERFORM.
041300 ATAPI-WAIT-2.
           MOVE 5 TO WS-TIMEOUT.
041400     MOVE 0 TO ATAPI-STATUS.
041500     COMPUTE IO-PORT = ATAPI-BUS + 7 END-COMPUTE.
041600     PERFORM UNTIL ATAPI-STATUS = 0 OR WS-TIMEOUT = 0
041700         PERFORM IO-IN-8
041800* Bit 3 has to be clear
041900         MOVE IO-DATA TO WS-AND1
042000         MOVE H'08' TO WS-ANDBY
042100         PERFORM BITWISE-AND
042200         MOVE WS-ANDRES TO ATAPI-STATUS
042300* Bit 0 also has to be clear
042400         MOVE IO-DATA TO WS-AND1
042500         MOVE H'01' TO WS-ANDBY
042600         PERFORM BITWISE-AND
042700         ADD WS-ANDRES TO ATAPI-STATUS END-ADD
               SUBTRACT 1 FROM WS-TIMEOUT END-SUBTRACT
042800     END-PERFORM.
042900******************************************************************
043000*
043100* PS2 driver
043200*
043300******************************************************************
043400 PS2-SECTION SECTION.
043500 PS2-INIT.
043600* Disable both devices
043700     MOVE H'AD' TO IO-DATA.
043800     MOVE H'64' TO IO-PORT.
043900     PERFORM IO-OUT-8.
044000     MOVE H'A7' TO IO-DATA.
044100     MOVE H'64' TO IO-PORT.
044200     PERFORM IO-OUT-8.
044300* Flush buffers
044400     MOVE H'60' TO IO-PORT.
044500     PERFORM IO-IN-8.
044600* Read configuration and disable IRQs
044700     MOVE H'20' TO IO-DATA.
044800     MOVE H'64' TO IO-PORT.
044900     PERFORM IO-OUT-8.
045000     PERFORM PS2-WAIT-INPUT.
045100     MOVE H'60' TO IO-PORT.
045200     PERFORM IO-IN-8.
045300     MOVE IO-DATA TO PS2-CONFIG.
045400* Clear bits 0, 1 and 6
045500     MOVE PS2-CONFIG TO WS-AND1.
045600     MOVE 240 TO WS-ANDBY.
045700     PERFORM BITWISE-AND.
045800     MOVE WS-ANDRES TO PS2-CONFIG.
045900     MOVE 1 TO PS2-NUM-DEVICES.
046000* Check if it's dual
046100     MOVE PS2-CONFIG TO WS-AND1.
046200     MOVE H'20' TO WS-ANDBY.
046300     PERFORM BITWISE-AND.
046400     IF WS-ANDRES NOT = 0
046500         MOVE 2 TO PS2-NUM-DEVICES
046600     END-IF
046700* Write new configuration value
046800     MOVE H'60' TO IO-DATA.
046900     MOVE H'64' TO IO-PORT.
047000     PERFORM IO-OUT-8.
047100     MOVE H'60' TO IO-PORT.
047200     MOVE PS2-CONFIG TO IO-DATA.
047300     PERFORM IO-OUT-8.
047400* Test PS2 controller
047500     MOVE H'AA' TO IO-DATA.
047600     MOVE H'64' TO IO-PORT.
047700     PERFORM IO-OUT-8.
047800     PERFORM PS2-WAIT-INPUT.
047900     MOVE H'60' TO IO-PORT.
048000     PERFORM IO-IN-8.
048100     IF IO-DATA NOT = H'55'
048200         DISPLAY "Failed PS2 controller test " IO-DATA END-DISPLAY
048300*        GO TO PS2-INIT-END
048400     END-IF.
048500* Reset configure byte to old value
048600* NOTE: We're putting the same configure byte again as above :/
048700     MOVE H'60' TO IO-DATA.
048800     MOVE H'64' TO IO-PORT.
048900     PERFORM IO-OUT-8.
049000     MOVE H'60' TO IO-PORT.
049100     MOVE PS2-CONFIG TO IO-DATA.
049200     PERFORM IO-OUT-8.
049300     DISPLAY "Succeed PS2 controller test" END-DISPLAY.
049400     IF PS2-NUM-DEVICES = 2
049500* Enable back the second channel device temporarily to check
049600* for any errors
049700         MOVE H'64' TO IO-PORT
049800         MOVE H'A8' TO IO-DATA
049900         PERFORM IO-OUT-8
050000         MOVE H'64' TO IO-PORT
050100         MOVE H'20' TO IO-DATA
050200         PERFORM IO-OUT-8
050300         PERFORM PS2-WAIT-INPUT
050400* Read back configuration status byte
050500         MOVE H'60' TO IO-PORT
050600         PERFORM IO-IN-8
050700         MOVE IO-DATA TO PS2-CONFIG
050800* Bit 5 must be clear ^^
050900         MOVE PS2-CONFIG TO WS-AND1
051000         MOVE H'20' TO WS-ANDBY
051100         PERFORM BITWISE-AND
051200         IF WS-ANDRES NOT = 0
051300             MOVE 1 TO PS2-NUM-DEVICES
051400         END-IF
051500         IF PS2-NUM-DEVICES = 2
051600* Disable the second channel device
051700             MOVE H'64' TO IO-PORT
051800             MOVE H'A7' TO IO-DATA
051900             PERFORM IO-OUT-8
052000         END-IF
052100         DISPLAY PS2-NUM-DEVICES " PS2 devices" END-DISPLAY
052200     END-IF.
052300* TODO: Save which port is working and which is not since
052400* we can use either port in the case of a failure
052500     DISPLAY "Perform PS2 tests" END-DISPLAY.
052600     PERFORM PS2-WAIT-OUTPUT.
052700* Perform a test on the first controller
052800     MOVE H'AB' TO IO-DATA.
052900     MOVE H'64' TO IO-PORT.
053000     PERFORM IO-OUT-8.
053100     MOVE H'60' TO IO-PORT.
053200     PERFORM IO-IN-8.
053300     IF IO-DATA NOT = 0
053400         DISPLAY "First port test failed" END-DISPLAY
053500*        GO TO PS2-INIT-END
053600     END-IF.
053700     IF PS2-NUM-DEVICES = 2
053800         PERFORM PS2-WAIT-OUTPUT
053900* Perform a test on the second port
054000         MOVE H'64' TO IO-PORT
054100         MOVE H'A9' TO IO-DATA
054200         PERFORM IO-OUT-8
054300         MOVE H'60' TO IO-PORT
054400         PERFORM IO-IN-8
054500         IF IO-DATA NOT = 0
054600             MOVE 1 TO PS2-NUM-DEVICES
054700             DISPLAY "Second port test failed" END-DISPLAY
054800         END-IF
054900     END-IF.
055000* Enable the first PS2 port
055100     PERFORM PS2-WAIT-OUTPUT.
055200     MOVE H'64' TO IO-PORT.
055300     MOVE H'AE' TO IO-DATA.
055400     PERFORM IO-OUT-8.
055500     IF PS2-NUM-DEVICES = 2
055600* Enable second PS2 port
055700         PERFORM PS2-WAIT-OUTPUT
055800         MOVE H'64' TO IO-PORT
055900         MOVE H'A8' TO IO-DATA
056000         PERFORM IO-OUT-8
056100     END-IF.
056200 PS2-INIT-END.
056300     DISPLAY "Finished PS2 initialize" END-DISPLAY.
056400* Write to the first port
056500 PS2-WRITE-FIRST.
056600     MOVE IO-DATA TO WS-TMP.
056700     PERFORM PS2-WAIT-INPUT.
056800     MOVE H'60' TO IO-PORT.
056900     MOVE WS-TMP TO IO-DATA.
057000     PERFORM IO-OUT-8.
057100* Write to the second port
057200 PS2-WRITE-SECOND.
057300     MOVE IO-DATA TO WS-TMP.
057400     PERFORM PS2-WAIT-INPUT.
057500     MOVE H'64' TO IO-PORT.
057600     MOVE 212 TO IO-DATA.
057700     PERFORM IO-OUT-8.
057800     PERFORM PS2-WAIT-INPUT.
057900     MOVE H'60' TO IO-PORT.
058000     MOVE WS-TMP TO IO-DATA.
058100     PERFORM IO-OUT-8.
058200 PS2-WAIT-INPUT.
058300     MOVE H'64' TO IO-PORT.
058400     PERFORM IO-IN-8.
058500* TODO: Wait for input
058600 PS2-WAIT-OUTPUT.
058700     MOVE H'64' TO IO-PORT.
058800     PERFORM IO-IN-8.
058900* TODO: Wait for output
059000 PS2-POLL-READ.
059100     PERFORM PS2-WAIT-OUTPUT.
059200     MOVE H'60' TO IO-PORT.
059300     PERFORM IO-IN-8.
059400* Initialize the keyboard make sure to set PS2-DEVSEL properly
059500* before performing this paragraph
059600 PS2-INIT-KEYBOARD.
059700     MOVE H'FF' TO IO-DATA.
059800     IF PS2-DEVSEL = 0
059900         PERFORM PS2-WRITE-FIRST
060000     ELSE
060100         PERFORM PS2-WRITE-SECOND
060200     END-IF.
060300     PERFORM PS2-POLL-READ.
060400* Reset default parameters
060500     MOVE H'F6' TO IO-DATA.
060600     IF PS2-DEVSEL = 0
060700         PERFORM PS2-WRITE-FIRST
060800     ELSE
060900         PERFORM PS2-WRITE-SECOND
061000     END-IF.
061100     PERFORM PS2-POLL-READ.
061200* Set a 1000ms typematic delay
061300     MOVE H'F3' TO IO-DATA.
061400     IF PS2-DEVSEL = 0
061500         PERFORM PS2-WRITE-FIRST
061600     ELSE
061700         PERFORM PS2-WRITE-SECOND
061800     END-IF.
061900     MOVE H'7F' TO IO-DATA.
062000     IF PS2-DEVSEL = 0
062100         PERFORM PS2-WRITE-FIRST
062200     ELSE
062300         PERFORM PS2-WRITE-SECOND
062400     END-IF.
062500     PERFORM PS2-POLL-READ.
062600     IF IO-DATA = H'FE'
062700         DISPLAY "Set keyboard typematic rate" END-DISPLAY
062800     END-IF.
062900* Enable scanning
063000     MOVE H'F4' TO IO-DATA.
063100     IF PS2-DEVSEL = 0
063200         PERFORM PS2-WRITE-FIRST
063300     ELSE
063400         PERFORM PS2-WRITE-SECOND
063500     END-IF.
063600     PERFORM PS2-POLL-READ.
063700     IF IO-DATA = H'FE'
063800         DISPLAY "Enabled scanning" END-DISPLAY
063900     END-IF.
064000* Enable IRQs
064100     DISPLAY "Enabling keyboard IRQs" END-DISPLAY.
064200     MOVE H'64' TO IO-PORT.
064300     MOVE H'20' TO IO-DATA.
064400     PERFORM IO-OUT-8.
064500     PERFORM PS2-WAIT-INPUT.
064600     MOVE H'60' TO IO-PORT.
064700     PERFORM IO-IN-8.
064800     MOVE IO-DATA TO PS2-CONFIG.
064900* TODO: OR mask with bit 1
065000     MOVE H'64' TO IO-PORT.
065100     MOVE H'60' TO IO-DATA.
065200     PERFORM IO-OUT-8.
065300     PERFORM PS2-WAIT-OUTPUT.
065400     MOVE H'60' TO IO-PORT.
065500     MOVE PS2-CONFIG TO IO-DATA.
065600     PERFORM IO-OUT-8.
065700     PERFORM PS2-SET-SCANCODE.
065800     DISPLAY "Initialized PS2 keyboard" END-DISPLAY.
065900* TODO: Have a PIC subsystem and tell it to enable IRQ 1
066000 PS2-SET-SCANCODE.
066100     MOVE H'F0' TO IO-DATA.
066200     IF PS2-DEVSEL = 0
066300         PERFORM PS2-WRITE-FIRST
066400     ELSE
066500         PERFORM PS2-WRITE-SECOND
066600     END-IF.
066700     MOVE H'01' TO IO-DATA.
066800     IF PS2-DEVSEL = 0
066900         PERFORM PS2-WRITE-FIRST
067000     ELSE
067100         PERFORM PS2-WRITE-SECOND
067200     END-IF.
067300******************************************************************
067400*
067500* UART driver
067600*
067700******************************************************************
067800 UART-SECTION SECTION.
067900 UART-INIT.
068000* Disable interrupts
068100     COMPUTE IO-PORT = UART-PORT + 1 END-COMPUTE.
068200     MOVE H'00' TO IO-DATA.
068300     PERFORM IO-OUT-8.
068400* Enable DLAB
068500     COMPUTE IO-PORT = UART-PORT + 3 END-COMPUTE.
068600     MOVE H'80' TO IO-DATA.
068700     PERFORM IO-OUT-8.
068800* Set divisor to 3
068900     COMPUTE IO-PORT = UART-PORT + 0 END-COMPUTE.
069000     MOVE H'03' TO IO-DATA.
069100     PERFORM IO-OUT-8.
069200     COMPUTE IO-PORT = UART-PORT + 1 END-COMPUTE.
069300     MOVE H'00' TO IO-DATA.
069400     PERFORM IO-OUT-8.
069500* 8 bits and no parity with one stop bit
069600     COMPUTE IO-PORT = UART-PORT + 3 END-COMPUTE.
069700     MOVE H'03' TO IO-DATA.
069800     PERFORM IO-OUT-8.
069900* Enable FIFO, clear and with a 14-byte threshold
070000     COMPUTE IO-PORT = UART-PORT + 2 END-COMPUTE.
070100     MOVE H'C7' TO IO-DATA.
070200     PERFORM IO-OUT-8.
070300* Enable IRQs back, set RTS and DSR, the Data (???) Register
070400* and the RTS register (no shit)
070500     COMPUTE IO-PORT = UART-PORT + 4 END-COMPUTE.
070600     MOVE H'0B' TO IO-DATA.
070700     PERFORM IO-OUT-8.
070800* Set in loopback mode and test the serial chip in loopback
070900* a good serial port should return (loop) what we send over
071000     MOVE H'1E' TO IO-DATA.
071100     PERFORM IO-OUT-8.
071200     MOVE UART-PORT TO IO-PORT.
071300     PERFORM UART-TEST.
071400* Set on normal operation mode, that is a non-loopback mode with
071500* IRQs enabeld and OUT#1 and OUT#2 bits enabled :)
071600     COMPUTE IO-PORT = UART-PORT + 4 END-COMPUTE.
071700     MOVE H'0F' TO IO-DATA.
071800     PERFORM IO-OUT-8.
071900     DISPLAY "UART initialized" END-DISPLAY.
072000 UART-TEST.
072100* Test the serial chip (sending a dummy byte and checking if it
072200* returns the same byte)
072300     MOVE H'AE' TO IO-DATA.
072400     PERFORM IO-OUT-8.
072500     IF WS-DEBUG = 'Y' DISPLAY ">" IO-DATA END-DISPLAY END-IF.
072600     PERFORM IO-IN-8.
072700     IF WS-DEBUG = 'Y' DISPLAY ">" IO-DATA END-DISPLAY END-IF.
072800     IF IO-DATA NOT = H'AE'
072900         DISPLAY "UART test failure" END-DISPLAY
073000     END-IF.
073100******************************************************************
073200*
073300* Floppy disk driver
073400*
073500******************************************************************
073600 FLOPPY-SECTION SECTION.
073700 INIT-FLOPPY.
073800     MOVE H'70' TO IO-PORT.
073900     MOVE H'10' TO IO-DATA.
074000     PERFORM IO-OUT-8.
074100* Obtain the result of the query from the CMOS, remember the uwu
074200* actual floppy data is split between the 2 nibbles of the byte
074300     MOVE H'71' TO IO-PORT.
074400     PERFORM IO-IN-8.
074500     MOVE IO-DATA TO FLOPPY-DRIVE1.
074600     DIVIDE FLOPPY-DRIVE1 BY H'0F' GIVING WS-DIVRES END-DIVIDE.
074700     MOVE WS-DIVRES TO FLOPPY-DRIVE1.
074800     MOVE IO-DATA TO FLOPPY-DRIVE2.
074900     DIVIDE FLOPPY-DRIVE2 BY H'0F' GIVING WS-DIVRES
075000     REMAINDER WS-RESIDUE END-DIVIDE.
075100     DISPLAY "Floppy drives initialized " FLOPPY-DRIVE1
075200     FLOPPY-DRIVE2 END-DISPLAY.
075300******************************************************************
075400*
075500* Soundblaster driver
075600*
075700******************************************************************
075800 SB16-SECTION SECTION.
075900 INIT-SB16.
076000* Send the first DSP
076100     COMPUTE IO-PORT = SB16-BASE + H'0206' END-COMPUTE.
076200     MOVE H'0206' TO IO-PORT.
076300     MOVE H'01' TO IO-DATA.
076400     PERFORM IO-OUT-8.
076500* TODO: Wait for 3ms
076600* Do a final DSP reset
076700     MOVE H'00' TO IO-DATA.
076800     PERFORM IO-OUT-8.
076900     COMPUTE IO-PORT = SB16-BASE + H'020A' END-COMPUTE.
077000     PERFORM IO-IN-8.
077100     IF IO-DATA = H'AA'
077200         MOVE 'N' TO WS-END
077300         PERFORM UNTIL WS-END = 'Y'
077400             PERFORM IO-IN-8
077500* Check that the given bit is set
077600             DIVIDE IO-DATA BY H'80' GIVING WS-DIVRES
077700             REMAINDER WS-RESIDUE END-DIVIDE
077800             IF WS-RESIDUE = '0'
077900                 MOVE 'Y' TO WS-END
078000             END-IF
078100         END-PERFORM
078200         COMPUTE IO-PORT = SB16-BASE + H'020C' END-COMPUTE
078300         MOVE H'E1' TO IO-DATA
078400         PERFORM IO-OUT-8
078500* Obtain the DSP version (hi first, low second)
078600         COMPUTE IO-PORT = SB16-BASE + H'020A' END-COMPUTE
078700         PERFORM IO-IN-8
078800         MOVE IO-DATA TO SB16-DSP-VER
078900         MOVE H'10000' TO WS-MULBY
079000         MULTIPLY SB16-DSP-VER BY WS-MULBY GIVING SB16-DSP-VER
               END-MULTIPLY
079100         PERFORM IO-IN-8
079200         ADD IO-DATA TO SB16-DSP-VER END-ADD
079300* TODO: Set IRQ to send data to
079400         COMPUTE IO-PORT = SB16-BASE + H'0204' END-COMPUTE
079500         MOVE H'80' TO IO-DATA
079600         PERFORM IO-OUT-8
079700* Serve IRQ 5
079800         COMPUTE IO-PORT = SB16-BASE + H'0205' END-COMPUTE
079900         MOVE H'02' TO IO-DATA
080000         PERFORM IO-OUT-8
080100     ELSE
080200         DISPLAY "Unable to initialize soundblaster" END-DISPLAY
080300     END-IF.
080400******************************************************************
080500*
080600* PCI Driver
080700*
080800******************************************************************
080900 PCI-SECTION SECTION.
081000 PCI-INIT.
081100     DISPLAY "PCI driver not implemented properly" END-DISPLAY.
081200* Computes the address of the PCI given an OFFSET
081300* an SLOT and a FUNC
081400 PCI-COMPUTE-ADDR.
081500     MOVE H'80000000' TO PCI-ADDRESS.
081600     MOVE PCI-OFFSET TO WS-AND1.
081700     MOVE H'FC' TO WS-ANDBY.
081800     PERFORM BITWISE-AND.
081900     ADD WS-ANDRES TO PCI-ADDRESS END-ADD.
082000* Shift func by 8
082100     MOVE H'100' TO WS-MULBY.
082200     MULTIPLY PCI-FUNC BY WS-MULBY GIVING WS-MULRES END-MULTIPLY.
082300     ADD WS-MULRES TO PCI-ADDRESS END-ADD.
082400* Shift slot by 11
082500     MOVE H'800' TO WS-MULBY.
082600     MULTIPLY PCI-SLOT BY WS-MULBY GIVING WS-MULRES END-MULTIPLY.
082700     ADD WS-MULRES TO PCI-ADDRESS END-ADD.
082800* Shift bus by 16
082900     MOVE H'10000' TO WS-MULBY.
083000     MULTIPLY PCI-BUS BY WS-MULBY GIVING WS-MULRES END-MULTIPLY.
083100     ADD WS-MULRES TO PCI-ADDRESS END-ADD.
083200* Reads a 32-bit value from the PCI subsystem root complex
083300* management thing
083400* Use PCI-ADDRESS, PCI-OFFSET, PCI-SLOT and PCI-FUNC accordingly
083500* and thou shall receive your data in PCI-DATA <3
083600 PCI-READ-32.
083700     PERFORM PCI-COMPUTE-ADDR.
083800     MOVE H'0CF8' TO IO-PORT.
083900     MOVE PCI-ADDRESS TO IO-DATA.
084000     PERFORM IO-OUT-32.
084100     MOVE H'0CFC' TO IO-PORT.
084200     PERFORM IO-IN-32.
084300     MOVE IO-DATA TO PCI-DATA.
084400* Use PCI-DATA for sending the value <3
084500 PCI-WRITE-32.
084600     PERFORM PCI-COMPUTE-ADDR.
084700     MOVE H'0CF8' TO IO-PORT.
084800     MOVE PCI-ADDRESS TO IO-DATA.
084900     PERFORM IO-OUT-32.
085000     MOVE H'0CFC' TO IO-PORT.
085100     MOVE PCI-DATA TO IO-DATA.
085200     PERFORM IO-OUT-32.
085300******************************************************************
085400*
085500* I/O procedures
085600*
085700******************************************************************
085800 IO-SECTION SECTION.
085900 IO-OUT-8.
086000     CALL STATIC "IO_OUT"
086100     USING BY VALUE UNSIGNED SIZE IS 2 IO-PORT
086200     BY VALUE UNSIGNED SIZE IS 4 IO-DATA
086300     BY CONTENT 'C'
086400     END-CALL.
086500     PERFORM DEBUG-PRINT-OUT.
086600 IO-OUT-16.
086700     CALL STATIC "IO_OUT"
086800     USING BY VALUE UNSIGNED SIZE IS 2 IO-PORT
086900     BY VALUE UNSIGNED SIZE IS 4 IO-DATA
087000     BY CONTENT 'H'
087100     END-CALL.
087200     PERFORM DEBUG-PRINT-OUT.
087300 IO-OUT-32.
087400     CALL STATIC "IO_OUT"
087500     USING BY VALUE UNSIGNED SIZE IS 2 IO-PORT
087600     BY VALUE UNSIGNED SIZE IS 4 IO-DATA
087700     BY CONTENT 'S'
087800     END-CALL.
087900     PERFORM DEBUG-PRINT-OUT.
088000 IO-IN-8.
088100     CALL STATIC "IO_IN"
088200     USING BY VALUE UNSIGNED SIZE IS 2 IO-PORT
088300     BY CONTENT 'C'
088400     BY REFERENCE IO-DATA
           END-CALL.
088500     PERFORM DEBUG-PRINT-IN.
088600 IO-IN-16.
088700     CALL STATIC "IO_IN"
088800     USING BY VALUE UNSIGNED SIZE IS 2 IO-PORT
088900     BY CONTENT 'S'
089000     BY REFERENCE IO-DATA
           END-CALL.
089100     PERFORM DEBUG-PRINT-IN.
089200 IO-IN-32.
089300     CALL STATIC "IO_IN"
089400     USING BY VALUE UNSIGNED SIZE IS 2 IO-PORT
089500     BY CONTENT 'H'
           BY REFERENCE IO-DATA
           END-CALL.
089700     PERFORM DEBUG-PRINT-IN.
089800 DEBUG-PRINT-OUT.
089900     IF WS-DEBUG = 'Y'
090300         DISPLAY "OUT: " IO-PORT " <- " IO-DATA "; " NO ADVANCING
               END-DISPLAY
090800     END-IF.
089800 DEBUG-PRINT-IN.
089900     IF WS-DEBUG = 'Y'
090300         DISPLAY "IN: " IO-PORT " -> " IO-DATA "; " NO ADVANCING
               END-DISPLAY
090800     END-IF.
090900******************************************************************
091000*
091100* Low-level bit manipulation
091200*
091300******************************************************************
091400 ARITH-SECTION SECTION.
091500* Perform a bitwise AND operation
091600* given WS-AND1 and WS-ANDBY perform (WS-AND1 & WS-ANDBY)
091700* to give WS-ANDRES
091800 BITWISE-AND.
091900     MOVE 0 TO WS-ANDRES.
092000     MOVE 1 TO I.
092100     PERFORM UNTIL WS-AND1 = 0 OR WS-ANDBY = 0
               DIVIDE WS-AND1 BY 2 GIVING WS-AND1 REMAINDER WS-TMP
               END-DIVIDE
               DIVIDE WS-ANDBY BY 2 GIVING WS-ANDBY REMAINDER WS-TMP2
               END-DIVIDE
               IF WS-TMP = 1 AND WS-TMP2 = 1
                   ADD I TO WS-ANDRES END-ADD
               END-IF
               MOVE 2 TO WS-MULBY
               MULTIPLY I BY WS-MULBY GIVING I END-MULTIPLY
093700     END-PERFORM.
       BITWISE-OR.
           MOVE 0 TO WS-ORRES.
           MOVE 1 TO I.
           PERFORM UNTIL WS-OR1 = 0 OR WS-ORBY = 0
               DIVIDE WS-OR1 BY 2 GIVING WS-OR1 REMAINDER WS-TMP
               END-DIVIDE
               DIVIDE WS-ORBY BY 2 GIVING WS-ORBY REMAINDER WS-TMP2
               END-DIVIDE
               IF WS-TMP = 1 OR WS-TMP2 = 1
                   ADD I TO WS-ORRES END-ADD
               END-IF
               MOVE 2 TO WS-MULBY
               MULTIPLY I BY WS-MULBY GIVING I END-MULTIPLY
           END-PERFORM.
093800******************************************************************
093900*
094000* Miscellaneous utilities
094100*
094200******************************************************************
094300 UTIL-SECTION SECTION.
094400* Convert WS-CHAR to a printable character
094500 HCHAR-TO-PRINTABLE.
094600     DIVIDE WS-CHAR BY 16 GIVING WS-DIVRES REMAINDER WS-RESIDUE
094700     END-DIVIDE.
094800     ADD 1 TO WS-RESIDUE END-ADD.
094900     MOVE WS-HEXCHMAP(WS-RESIDUE:1) TO WS-CHAR.
095000 HEX-TO-PRINTABLE.
           MOVE SPACES TO WS-OUTSTR.
095100     PERFORM VARYING I FROM 1 BY 1 UNTIL I > LENGTH OF WS-INSTR
095200* Reminder: Every byte is equal to 2 characters as each character
095300* is representative of a nibble, and a byte is two nibbles
095400         COMPUTE J = (I * 2) - 1 END-COMPUTE
095500* Calculate low nibble first
095600         MOVE WS-INSTR(I:1) TO WS-CHAR
095700         PERFORM HCHAR-TO-PRINTABLE
095800         MOVE WS-CHAR TO WS-OUTSTR(J:1)
095900* Then calculate the high nibble
096000         MOVE WS-INSTR(I:1) TO WS-CHAR
096100         DIVIDE WS-CHAR BY 16 GIVING WS-DIVRES REMAINDER
096200         WS-RESIDUE END-DIVIDE
096300         MOVE WS-DIVRES TO WS-CHAR
096400         PERFORM HCHAR-TO-PRINTABLE
096500         ADD 1 TO J END-ADD
096600         MOVE WS-CHAR TO WS-OUTSTR(J:1)
096700     END-PERFORM.
      * Hang forever (for debug purpouses)
       DEBUG-HANG.
           IF WS-DEBUG = 'A'
               MOVE SPACE TO WS-REPLY
               PERFORM UNTIL WS-REPLY = 'X'
                   MOVE WS-REPLY TO WS-REPLY
               END-PERFORM
           END-IF.
096800* A dummy exit to catch paragraphs going out of bounds
096900 DUMMY-EXIT.
097000     DISPLAY "Using a dummy exit ^^" END-DISPLAY.
