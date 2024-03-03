.386
.model flat, stdcall
option casemap:none

include \masm32\include\windows.inc
include \masm32\include\kernel32.inc
include \masm32\include\masm32.inc
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\masm32.lib

.data
;prompts/choice
toMenuPrompt db 10,10,"Go back to menu?(Y/N): ", 0
MenuPrompt db 10,"Choose an action: ", 0
tester db 10,"Hello", 0 ;tester for debugging

;Main Menu Variables
menuHead db "-Menu-", 0
choice1 db 10,"[1]1st Year" , 0
choice2 db 10,"[2]2nd Year" , 0
choice3 db 10,"[3]3rd Year" , 0
choice4 db 10,"[4]4th Year" , 0
EndMenu db 10,"[6]Exit" , 0
showAll db 10,"[5]Show All" , 0

;Sub Menu Variables
submenuHead db "-Sub Menu-", 0
subchoice1 db 10,"[1] 1st Semester",0
subchoice2 db 10,"[2] 2nd Semester",0
subchoice3 db 10,"[3] Summer",0
subchoice4 db 10,"[4] To Main menu", 0 

;toYear
y1choice db 10,"[1] To 1st Year Menu",0
y2choice db 10,"[1] To 2nd Year Menu",0
y3choice db 10,"[1] To 3rd Year Menu",0
y4choice db 10,"[1] To 4th Year Menu",0
tomainmenuchoice db 10,"[2] Main Menu",0

;Header Variables
collegeHead db "-----COLLEGE OF ARTS AND SCIENCES-----", 0
majorHead db 10,"-----BACHELOR OF SCIENCE IN PSYCHOLOGY-----", 0 
summerHead db 10,10,"-----SUMMER-----", 0
year1Head db 10,"-----FIRST YEAR-----", 0
year2Head db 10,"-----SECOND YEAR-----", 0
year3Head db 10,"-----THIRD YEAR-----", 0
year4Head db 10,"-----FOURTH YEAR-----", 0
semester1Head db 10,"| First Semester					| Unit Distribution |          |", 0
semester2Head db 10,"| Second Semester					| Unit Distribution |          |", 0
subject1Head db 10,"| Subj. Code |		Subject Title			| Lec | Lab | Total |  PreReq  |",0
subject2Head db 10,"| Subj. Code |		Subject Title			| Lec | Lab | Total |  PreReq  |",0



;year1 subjects Variables
ge4 db 10,"|    GE 4    | Mathematics in the Modern World		|  3  |  0  |   3   |   None   |",0
ge1 db 10,"|    GE 1    | Understanding the self 			|  3  |  0  |   3   |   None   |",0
ge2 db 10,"|    GE 2    | Purposive Commo w/ Interactive Learning 	|  6  |  0  |   6   |   None   |",0
psy111 db 10,"|   PSY 111  | Introduction to Psychology 		|  3  |  0  |   3   |   None   |",0
bio204 db 10,"|  BIO 204/L | Biological Science			|  3  |  2  |   5   |   None   |",0
psy112 db 10,"|  PSY 112/L | Psychological Statistics			|  3  |  2  |   5   |   None   | ",0
pahf1 db 10,"|   PAHF 1   | Movement Competency Training 		|  2  |  0  |   2   |   None   |",0
;------------------------------------------------------------------------------------------------------
blank db 10,"|            |						|     |     |       |          |",0
uge1 db 10,"|    UGE 1   | Reading Comprehension 			|  2  |  0  |   2   |   None   |",0
ge3 db 10,"|    GE 3    | The Contemporary World 			|  2  |  0  |   2   |   None   |",0
psy124 db 10,"|   PSY 124  | Developmental Psychology 		|  2  |  0  |   2   |   None   |",0
bio202 db 10,"|  BIO202/L  | Genetics, Evolution, and Diversity 	|  2  |  0  |   2   |   None   |",0
ge15 db 10,"|   GE 15    | Environmental Science 			|  2  |  0  |   2   |   None   |",0
pahf2 db 10,"|   PAHF 2   | Exercise-based Fitness Activities	|  2  |  0  |   2   |   None   |",0
;--------------------------------------------------------------------------------------------------------
ge8 db 10,"|    GE 8    | Readings in Philippine History		|  3  |  0  |   3   |   None   |",0
psy125 db 10,"|   PSY 125  | Theories of Personality			|  3  |  0  |   3   |  PSY 111 |",0
psy212 db 10,"|   PSY 212  | Group Dynamics				|  3  |  0  |   3   |  PSY 123 |",0

;total Units
y1s1total db 10,9,9,9,9,9,"|  Total Units  |  23 |  4  |   27  |",0
y1s2total db 10,9,9,9,9,9,"|  Total Units  |  23 |  2  |   25  |",0
y1sumtotal db 10,9,9,9,9,9,"|  Total Units  |  9  |  0  |   9   |",0
;--------------------------------------------------------------------------------------------------------



;year2 subjects Variables
ge5 db 10,"|    GE 5    | Science, Technology, and Society		|  3  |  0  |   3   |   None   |",0
uge2 db 10,"|   UGE 2    | Technical Writing in the Discipline	|  3  |  0  |   3   |   None   |",0
psy213 db 10,"|  PSY 213/L | Experimental Psychology			|  3  |  2  |   5   | PSY 112/L|",0
ge6 db 10,"|    GE 6    | Rizal's Life and Works			|  3  |  0  |   3   |   None   |",0
psy222 db 10,"|  PSY 213/L | Abnormal Psychology			|  6  |  0  |   6   |  PSY 123 |",0
chem201 db 10,"| CHEM 201/L | General Inorganic Chemistry 1		|  3  |  2  |   5   | BIO 202/L|",0
pahf3 db 10,"|   PAHF 3   | Dance and Sports 1			|  2  |  0  |   2   |  PAHF 2  |",0
;------------------------------------------------------------------------------------------------------
ge7 db 10,"|    GE 7    | Art Appreciation				|  3  |  0  |   3   |   None   |",0
cn112 db 10,"|  CN 112/L  | Biochemistry				|  3  |  2  |   5   |CHEM 201/L|",0
psy221 db 10,"|  PSY 221/L | Field Methods in Psychology		|  3  |  2  |   5   |PSY 213/L |",0
psy225 db 10,"|  PSY 225   | Industrial/Organizational Psychology	|  6  |  0  |   6   | PSY 212  |",0
psy224 db 10,"|  PSY 224   | Social Psychology			|  3  |  0  |   3   |PSY 213/L |",0
pahf4 db 10,"|   PAHF 4   | Dance and Sports 2			|  2  |  0  |   2   |  PAHF 3  |",0
;------------------------------------------------------------------------------------------------------
psy122 db 10,"| PSY 122  | Culture and Psychology			|  3  |  0  |   3   | PSY 111  |",0
psy324 db 10,"| PSY 324  | Educational Psychology			|  3  |  0  |   3   | PSY 224  |",0
psy211 db 10,"| PSY 211  | Physiological/Biological Psychology	|  3  |  0  |   3   | PSY 125  |",0

;total Units
y2s1total db 10,9,9,9,9,9,"|  Total Units  |  23 |  4  |   27  |",0
y2s2total db 10,9,9,9,9,9,"|  Total Units  |  20 |  4  |   24  |",0
y2sumtotal db 10,9,9,9,9,9,"|  Total Units  |  9  |  0  |   9   |",0
;------------------------------------------------------------------------------------------------------


;year 3 subject Variables
ge11 db 10,"|    GE 11   | The Entrepreneurial Mind			|  3  |  0  |   3   |   None   |",0
psy214 db 10,"|   PSY 214  | Cognitive Psychology			|  3  |  0  |   3   | PSY 121  |",0
psy2142 db 10, "|            |						|     |     |       | ,PSY 123 |",0
ge9 db 10,"|    GE 9    | Ethics (Disciplinal)			|  3  |  0  |   3   |   None   |",0
psy311 db 10,"|   PSY 311  | Introduction to Counseling		|  3  |  0  |   3   | PSY 222  |",0
psy312 db 10,"|  PSY 312/L | Psychological Assessment			|  3  |  2  |   5   | PSY 222  |",0
psy313 db 10,"|   PSY 313  | Research in Psychology I			|  3  |  0  |   3   | PSY 221/L|",0
nstp1 db 10,"|    NSTP 1  | National Service Training Program 1	|  3  |  0  |   3   |   None   |",0
;------------------------------------------------------------------------------------------------------
ge20 db 9,"|    GE 20   | Reading Visual Arts			|  3  |  0  |   3   |   None   |",0
psy321 db 9,"|  PSY 321   | Research in Psychology II		|  6  |  0  |   6   |   None   |",0
psy322 db 9,"|  PSY 322   | Community Health Psychology		|  3  |  0  |   3   |   None   |",0
psy323 db 9,"|  PSY 323   | Introduction to Clinical Psychology	|  3  |  0  |   3   |   None   |",0
nstp2 db 9,"|   NSTP 2  | National Service Training Program 2	|  3  |  0  |   3   |   None   |",0

;total Units
y3s1total db 10,9,9,9,9,9,"|  Total Units  |  21 |  2  |   23  |",0
y3s2total db 9,9,9,9,9,9,9,9,"|  Total Units  |  18 |  0  |   18  |",0
;------------------------------------------------------------------------------------------------------


;year 4 subject Variables
caed500 db 10,"| CAED 500c  | Career and Personality Development	|  3  |  0  |   3   |4th Year  |",0
psy3261 db 10,"|            | 						|     |     |       | PSY 321, |",0
psy3262 db 10,"|            | 						|     |     |       | PSY 323, |",0
psy326 db 10,"|  PSY 326   | Practicum in Psychology			|  6  |  0  |   6   |PSY 312/L |",0
psy3264 db 10,"|            | 						|     |     |       | PSY 322, |",0
psy3265 db 10,"|            | 						|     |     |       | PSY 324  |",0
;------------------------------------------------------------------------------------------------------
psy500 db 9,"|  PSY 500   | Psychological Testing/Assessment		|  3  |  0  |   3   |          |",0
psy5011 db 9,"|            | 						|     |     |       |          |",0
psy501 db 9,"|  PSY 501   | Abnormal Psychology			|  3  |  0  |   3   | PSY 326  |",0
psy502 db 9,"| PSY 502a   | Developmental Psychology			|  3  |  0  |   3   |Graduating|",0
psy503 db 9,"|  PSY 503   | Industrial/Organizational Psychology	|  3  |  0  |   3   |          |",0


;total Units
y4s1total db 10,9,9,9,9,9,"|  Total Units  |  9  |  2  |   9   |",0
y4s2total db 9,9,9,9,9,9,9,9,"|  Total Units  |  12 |  0  |   12  |",0


.data? ; input Variables
menuchoice db 10 dup(?)
subchoice db 10 dup(?)
A1 db 10 dup(?)
A2 db 10 dup(?)
A3 db 10 dup(?)
A4 db 10 dup(?)
A5 db 10 dup(?)

.code

start:
;----------Main Menu-----------
invoke ClearScreen
invoke StdOut, addr menuHead
invoke StdOut, addr choice1
invoke StdOut, addr choice2
invoke StdOut, addr choice3
invoke StdOut, addr choice4
invoke StdOut, addr showAll
invoke StdOut, addr EndMenu
invoke StdOut, addr MenuPrompt
invoke StdIn, addr menuchoice, 10

;------MenuOptions/Switch Case--------------
.if (menuchoice == "1") 
jmp first ;to 1st year
.elseif (menuchoice == '2')
jmp second ;to 2nd year
.elseif (menuchoice == '3')
jmp third ;to 3rd year
.elseif (menuchoice == '4')
jmp fourth ;to 4th year
.elseif (menuchoice == '5')
jmp everything ;show all 
.elseif (menuchoice == '6')
jmp exit

.endif

;##################################End of MenuOptions##############################


first:
invoke ClearScreen
;submenu
invoke StdOut, addr submenuHead
invoke StdOut, addr subchoice1
invoke StdOut, addr subchoice2
invoke StdOut, addr subchoice3
invoke StdOut, addr subchoice4
invoke StdOut, addr MenuPrompt
invoke StdIn, addr subchoice, 10

.if(subchoice == "1")
;1st Semester
;header
invoke ClearScreen
invoke StdOut, addr collegeHead
invoke StdOut, addr majorHead
invoke StdOut, addr year1Head

invoke StdOut, addr semester1Head
invoke StdOut, addr subject1Head

;print subjects
invoke StdOut, addr ge4
invoke StdOut, addr ge1
invoke StdOut, addr ge2
invoke StdOut, addr psy111
invoke StdOut, addr bio204
invoke StdOut, addr psy112
invoke StdOut, addr pahf1
invoke StdOut, addr y1s1total

jmp tomain1st

.elseif(subchoice == "2")
;2nd Semester
;header
invoke ClearScreen
invoke StdOut, addr collegeHead
invoke StdOut, addr majorHead
invoke StdOut, addr year1Head

invoke StdOut, addr semester2Head
invoke StdOut, addr subject2Head

;print subjects
invoke StdOut, addr blank
invoke StdOut, addr uge1
invoke StdOut, addr ge3
invoke StdOut, addr psy124
invoke StdOut, addr bio202
invoke StdOut, addr ge15
invoke StdOut, addr pahf2
invoke StdOut, addr y1s2total

jmp tomain1st

.elseif(subchoice == "3")
;Summer
invoke ClearScreen
invoke StdOut, addr summerHead
invoke StdOut, addr ge8
invoke StdOut, addr psy125
invoke StdOut, addr psy212
invoke StdOut, addr y1sumtotal

jmp tomain1st

.elseif(subchoice == "4")
jmp start
.endif

tomain1st:
;-----toMainMenu----------
invoke StdOut, addr y1choice
invoke StdOut, addr tomainmenuchoice
invoke StdOut, addr MenuPrompt
invoke StdIn, addr A1, 10
.if(A1 == "1")
jmp first
.elseif (A1 == "2")
jmp start
.endif
;#######################################Year 1 End########################################


second:
invoke ClearScreen
;submenu
invoke StdOut, addr submenuHead
invoke StdOut, addr subchoice1
invoke StdOut, addr subchoice2
invoke StdOut, addr subchoice3
invoke StdOut, addr subchoice4
invoke StdOut, addr MenuPrompt
invoke StdIn, addr subchoice, 10

.if(subchoice == "1")
;1st Semester
;header
invoke ClearScreen
invoke StdOut, addr collegeHead
invoke StdOut, addr majorHead
invoke StdOut, addr year2Head

invoke StdOut, addr semester1Head
invoke StdOut, addr subject1Head

;print subjects
invoke StdOut, addr ge5
invoke StdOut, addr uge2
invoke StdOut, addr psy213
invoke StdOut, addr ge6
invoke StdOut, addr psy222
invoke StdOut, addr chem201
invoke StdOut, addr pahf3
invoke StdOut, addr y2s1total

jmp tomain2nd

.elseif(subchoice == "2")
;2nd Semester
;header
invoke ClearScreen
invoke StdOut, addr collegeHead
invoke StdOut, addr majorHead
invoke StdOut, addr year2Head

invoke StdOut, addr semester2Head
invoke StdOut, addr subject2Head

;print subjects
invoke StdOut, addr blank
invoke StdOut, addr ge7
invoke StdOut, addr cn112
invoke StdOut, addr psy221
invoke StdOut, addr psy225
invoke StdOut, addr psy224
invoke StdOut, addr pahf4
invoke StdOut, addr y2s2total

jmp tomain2nd

.elseif(subchoice == "3")
;Summer
invoke ClearScreen
invoke StdOut, addr summerHead
invoke StdOut, addr psy122
invoke StdOut, addr psy324
invoke StdOut, addr psy211
invoke StdOut, addr y2sumtotal

jmp tomain2nd

.elseif(subchoice == "4")
jmp start
.endif

tomain2nd:
;-----to Main Menu----------
invoke StdOut, addr toMenuPrompt
invoke StdOut, addr y2choice
invoke StdOut, addr tomainmenuchoice
invoke StdOut, addr MenuPrompt
invoke StdIn, addr A2, 10
.if(A2 == "1")
jmp second
.elseif (A2 == "2")
jmp start
.endif
;#######################################Year 2 End########################################






third:
invoke ClearScreen
;header
invoke StdOut, addr collegeHead
invoke StdOut, addr majorHead
invoke StdOut, addr year3Head

invoke StdOut, addr semester1Head
invoke StdOut, addr semester2Head
invoke StdOut, addr subject1Head
invoke StdOut, addr subject2Head

;print subjects
invoke StdOut, addr ge11
invoke StdOut, addr blank

invoke StdOut, addr psy214
invoke StdOut, addr blank
invoke StdOut, addr psy2142
invoke StdOut, addr blank

invoke StdOut, addr ge9
invoke StdOut, addr ge20

invoke StdOut, addr psy311
invoke StdOut, addr psy321

invoke StdOut, addr psy312
invoke StdOut, addr psy322

invoke StdOut, addr psy313
invoke StdOut, addr psy323

invoke StdOut, addr nstp1
invoke StdOut, addr nstp2

invoke StdOut, addr y3s1total
invoke StdOut, addr y3s2total



;-----to Main Menu----------
invoke StdOut, addr toMenuPrompt
invoke StdIn, addr A3, 10
.if(A3 == "Y")
jmp start
.elseif (A3 == "y")
jmp start
.elseif (A3 == "N")
jmp exit
.elseif (A3 == "n")
jmp exit
.endif
;#######################################Year 3 End########################################



fourth:
invoke ClearScreen
;header
invoke StdOut, addr collegeHead
invoke StdOut, addr majorHead
invoke StdOut, addr year4Head

invoke StdOut, addr semester1Head
invoke StdOut, addr semester2Head
invoke StdOut, addr subject1Head
invoke StdOut, addr subject2Head

;print subjects
invoke StdOut, addr caed500
invoke StdOut, addr psy500

invoke StdOut, addr psy3261
invoke StdOut, addr psy5011
invoke StdOut, addr psy3262
invoke StdOut, addr psy5011

invoke StdOut, addr psy326
invoke StdOut, addr psy501

invoke StdOut, addr psy3264
invoke StdOut, addr psy502

invoke StdOut, addr psy3265
invoke StdOut, addr psy503


invoke StdOut, addr y4s1total
invoke StdOut, addr y4s2total

;-----to Main Menu----------
invoke StdOut, addr toMenuPrompt
invoke StdIn, addr A4, 10
.if(A4 == "Y")
jmp start
.elseif (A4 == "y")
jmp start
.elseif (A4 == "N")
jmp exit
.elseif (A4 == "n")
jmp exit
.endif
;#######################################Year 4 End########################################











everything:
invoke ClearScreen
;-----to Main Menu----------
invoke StdOut, addr toMenuPrompt
invoke StdIn, addr A5, 10
.if(A5 == "Y")
jmp start
.elseif (A5 == "y")
jmp start
.elseif (A5 == "N")
jmp exit
.elseif (A5 == "n")
jmp exit
.endif




exit:
invoke ExitProcess, 0
end start
