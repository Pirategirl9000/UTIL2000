       IDENTIFICATION DIVISION.                                         00010001
       PROGRAM-ID. UTIL1000.                                            00020001
      ***************************************************************** 00030001
      *  Programmer.: Violet French                                     00040001
      *  Date.......: 2.10.2026                                         00050001
      *  GitHub URL.: https://github.com/Pirategirl9000/UTIL2000/       00060001
      *  Description: This program uses predetermined values to         00070004
      *               calculate three customers' bills based on         00071004
      *               their KwH and the fee per KwH                     00071104
      ***************************************************************** 00080001
       DATA DIVISION.                                                   00090001
       WORKING-STORAGE SECTION.                                         00100001
                                                                        00110001
      ***************************************************************** 00120001
      * CONSTANTS                                                       00130001
      ***************************************************************** 00140001
       01  WS-RATE-TIER1            PIC V99      VALUE .12.             00150001
       01  WS-RATE-TIER2            PIC V99      VALUE .15.             00160001
       01  WS-RATE-TIER3            PIC V99      VALUE .18.             00170001
       01  WS-TIER1-LIMIT           PIC 9(4)     VALUE 500.             00180001
       01  WS-TIER2-LIMIT           PIC 9(4)     VALUE 500.             00190001
                                                                        00200001
      ***************************************************************** 00210001
      * 3 PREDEFINED CUSTOMERS (NO TABLES)                              00220001
      ***************************************************************** 00230001
       01  WS-CUST1.                                                    00240001
           05  WS-C1-NAME           PIC X(12)   VALUE 'CUST-ALPHA  '.   00250001
           05  WS-C1-KWH            PIC 9(5)    VALUE 350.              00260001
           05  WS-C1-FEE            PIC 9(3)V99 VALUE 14.95.            00270001
                                                                        00280001
       01  WS-CUST2.                                                    00281002
           05  WS-C2-NAME           PIC X(12)   VALUE 'CUST-BRAVO  '.   00282002
           05  WS-C2-KWH            PIC 9(5)    VALUE 925.              00283002
           05  WS-C2-FEE            PIC 9(3)V99 VALUE 14.95.            00284002
                                                                        00285002
       01  WS-CUST3.                                                    00286002
           05  WS-C3-NAME           PIC X(12)   VALUE 'CUST-CHARLIE'.   00287002
           05  WS-C3-KWH            PIC 9(5)    VALUE 1350.             00288002
           05  WS-C3-FEE            PIC 9(3)V99 VALUE 14.95.            00289002
      ***************************************************************** 00290001
      * CURRENT "INPUT" FIELDS (LOADED PER CUSTOMER)                    00300001
      ***************************************************************** 00310001
       01  WS-CUST-NAME             PIC X(12)   VALUE SPACES.           00320001
       01  WS-KWH-USED              PIC 9(5)    VALUE 0.                00330001
       01  WS-SERVICE-FEE           PIC 9(3)V99 VALUE 0.                00340001
                                                                        00350001
      ***************************************************************** 00360001
      * WORK AREAS                                                      00370001
      ***************************************************************** 00380001
       01  WS-TIER1-KWH             PIC 9(5)     VALUE 0.               00390001
       01  WS-TIER2-KWH             PIC 9(5)     VALUE 0.               00400001
       01  WS-TIER3-KWH             PIC 9(5)     VALUE 0.               00410001
                                                                        00420001
       01  WS-TIER1-CHARGE          PIC 9(5)V99  VALUE 0.               00430001
       01  WS-TIER2-CHARGE          PIC 9(5)V99  VALUE 0.               00440001
       01  WS-TIER3-CHARGE          PIC 9(5)V99  VALUE 0.               00450001
                                                                        00460001
       01  WS-SUBTOTAL              PIC 9(6)V99  VALUE 0.               00470001
       01  WS-TOTAL-BILL            PIC 9(6)V99  VALUE 0.               00480001
                                                                        00490001
      ***************************************************************** 00500001
      * EDITED FIELDS FOR DISPLAY                                       00510001
      ***************************************************************** 00520001
       01  WS-KWH-USED-ED           PIC Z,ZZZ,ZZZ,ZZ9.                  00530001
       01  WS-MONEY-ED              PIC $$,$$$,$$9.99.                  00540001
       01  WS-MONEY-ED2             PIC $$,$$$,$$9.99.                  00550001
                                                                        00560001
      ***************************************************************** 00570001
      * IT'S GO TIME!                                                   00580001
      ***************************************************************** 00590001
       PROCEDURE DIVISION.                                              00600001
                                                                        00610001
      ***************************************************************** 00620001
      * MAINLINE - DISPLAY HEADING, LOAD CUSTOMER, RUN BILL, STOP       00630001
      ***************************************************************** 00640001
       000-MAIN.                                                        00650001
           DISPLAY '********************************'.                  00660001
           DISPLAY '*** UTIL1000 - CUSTOMER BILL ***'.                  00670001
           DISPLAY '********************************'.                  00680001
           DISPLAY ' '.                                                 00690001
                                                                        00700001
           PERFORM 500-LOAD-CUST1.                                      00710005
           PERFORM 600-RUN-BILL.                                        00720001
                                                                        00730001
           STOP RUN.                                                    00740001
                                                                        00750001
      ***************************************************************** 00760001
      * MOVE name/kwh/fee from CUST into current fields.                00770001
      ***************************************************************** 00780001
       500-LOAD-CUST1.                                                  00790005
           MOVE WS-C1-NAME TO WS-CUST-NAME.                             00800001
           MOVE WS-C1-KWH  TO WS-KWH-USED.                              00810001
           MOVE WS-C1-FEE  TO WS-SERVICE-FEE.                           00820001
                                                                        00830001
       510-LOAD-CUST2.                                                  00831005
           MOVE WS-C2-NAME TO WS-CUST-NAME.                             00832005
           MOVE WS-C2-KWH  TO WS-KWH-USED.                              00833005
           MOVE WS-C2-FEE  TO WS-SERVICE-FEE.                           00834005
                                                                        00835005
       520-LOAD-CUST3.                                                  00836005
           MOVE WS-C3-NAME TO WS-CUST-NAME.                             00837005
           MOVE WS-C3-KWH  TO WS-KWH-USED.                              00838005
           MOVE WS-C3-FEE  TO WS-SERVICE-FEE.                           00839005
                                                                        00839105
      ***************************************************************** 00840001
      * BILL ROUTINE                                                    00850001
      ***************************************************************** 00860001
       600-RUN-BILL.                                                    00870001
           PERFORM 100-INITIALIZE.                                      00880001
           PERFORM 200-CALC-TIERS.                                      00890001
           PERFORM 300-CALC-CHARGES.                                    00900001
           PERFORM 400-DISPLAY-RESULTS.                                 00910001
           DISPLAY ' '.                                                 00920001
                                                                        00930001
      ***************************************************************** 00940001
      * Zero tier kWh, charges, subtotal, total                         00950001
      ***************************************************************** 00960001
       100-INITIALIZE.                                                  00970001
           MOVE 0 TO WS-TIER1-KWH                                       00980001
                    WS-TIER2-KWH                                        00990001
                    WS-TIER3-KWH                                        01000001
                    WS-TIER1-CHARGE                                     01010001
                    WS-TIER2-CHARGE                                     01020001
                    WS-TIER3-CHARGE                                     01030001
                    WS-SUBTOTAL                                         01040001
                    WS-TOTAL-BILL.                                      01050001
                                                                        01060001
      ***************************************************************** 01070001
      * Determine WS-TIER1-KWH, WS-TIER2-KWH, WS-TIER3-KWH              01080001
      * based on WS-KWH-USED                                            01090001
      *                                                                 01100001
      * These are the per-kWh rates:                                    01110001
      * - Tier 1: first 500 kWh at $0.12/kWh                            01120001
      * - Tier 2: next 500 kWh (kWh 501 1000) at $0.15/kWh              01131003
      * - Tier 3: any kWh above 1000 at $0.18/kWh                       01140001
      ***************************************************************** 01150001
       200-CALC-TIERS.                                                  01160001
           *> If amount used is less than 500 kWh, all goes in tier 1   01170001
           IF WS-KWH-USED <= WS-TIER1-LIMIT                             01180001
               MOVE WS-KWH-USED TO WS-TIER1-KWH                         01190001
               MOVE 0 TO WS-TIER2-KWH WS-TIER3-KWH                      01200001
           ELSE                                                         01210001
               MOVE WS-TIER1-LIMIT TO WS-TIER1-KWH                      01220001
                                                                        01230001
               *> If amount used is between 501 and 1000 kWh,           01240001
               *> tier 1 is full, remainder goes in tier 2              01250001
               IF WS-KWH-USED <= (WS-TIER1-LIMIT + WS-TIER2-LIMIT)      01260001
                   COMPUTE WS-TIER2-KWH =                               01270001
                       WS-KWH-USED - WS-TIER1-LIMIT                     01280001
                   MOVE 0 TO WS-TIER3-KWH                               01290001
                                                                        01300001
               *> If amount used is between 1001 and above,             01310001
               *> tier 1 and tier 2 are full, remainder goes in tier 3  01320001
               ELSE                                                     01330001
                   MOVE WS-TIER2-LIMIT TO WS-TIER2-KWH                  01340001
                   COMPUTE WS-TIER3-KWH =                               01350001
                       WS-KWH-USED - WS-TIER1-LIMIT - WS-TIER2-LIMIT    01360001
               END-IF                                                   01370001
           END-IF.                                                      01380001
                                                                        01390001
      ***************************************************************** 01400001
      * COMPUTE charges using ROUNDED and compute totals.               01410001
      ***************************************************************** 01420001
       300-CALC-CHARGES.                                                01430001
           COMPUTE WS-TIER1-CHARGE ROUNDED =                            01440001
               WS-TIER1-KWH * WS-RATE-TIER1.                            01450001
                                                                        01460001
           COMPUTE WS-SUBTOTAL = WS-TIER1-CHARGE.                       01470001
                                                                        01480001
           COMPUTE WS-TOTAL-BILL =                                      01490001
               WS-SUBTOTAL + WS-SERVICE-FEE.                            01500001
                                                                        01510001
      ***************************************************************** 01520001
      * Display report including customer name.                         01530001
      ***************************************************************** 01540001
       400-DISPLAY-RESULTS.                                             01550001
           MOVE WS-KWH-USED TO WS-KWH-USED-ED.                          01560001
                                                                        01570001
           DISPLAY '--------------------------------'.                  01580001
           DISPLAY 'CUSTOMER: ' WS-CUST-NAME.                           01590001
           DISPLAY '--------------------------------'.                  01600001
           DISPLAY 'KWH USED       : ' WS-KWH-USED-ED.                  01610001
                                                                        01620001
           MOVE WS-SERVICE-FEE TO WS-MONEY-ED.                          01630001
           DISPLAY 'SERVICE FEE    : ' WS-MONEY-ED.                     01640001
                                                                        01650001
           MOVE WS-TIER1-CHARGE TO WS-MONEY-ED.                         01660001
           DISPLAY 'TIER 1 CHARGE  : ' WS-MONEY-ED.                     01670001
                                                                        01680001
           MOVE WS-TIER2-CHARGE TO WS-MONEY-ED.                         01690001
           DISPLAY 'TIER 2 CHARGE  : ' WS-MONEY-ED.                     01700001
                                                                        01710001
           MOVE WS-TIER3-CHARGE TO WS-MONEY-ED.                         01720001
           DISPLAY 'TIER 3 CHARGE  : ' WS-MONEY-ED.                     01730001
                                                                        01740001
           MOVE WS-TOTAL-BILL TO WS-MONEY-ED2.                          01750001
           DISPLAY '--------------------------------'.                  01760001
           DISPLAY 'TOTAL BILL     : ' WS-MONEY-ED2.                    01770001
           DISPLAY '--------------------------------'.                  01780001
