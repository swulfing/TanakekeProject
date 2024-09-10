# 1. Running R code
#   Blok, "Code", "Run"
#   "Run" Tombol di kanan atas
#   CTRL + ENTER

# 2. R is case sensitive
#  head(mtcars)
#  Head(mtcars)

# 3. Making Comments


# MAKING VARIABLES ----------------------------------------------------------------

# VARIABLES ARE CASE-SENSITIVE! Show how this makes two different variables
nama1 <- "Sophie"
NAMA1<- "Rina"

NAMA1 <- "BEN" # THIS WILL REWRITE OVER THE VARIABLE AND SAVE NEW INFORMATION

# YOU CAN ASSIGN A NUMBER TO A VARIABLE 
x <- 4
y <- 17

x*y

# YOU CAN CREATE A VAIRABLE FROM OTHER VARIABLES
z <- x * y
z


# COMBINE WORDS THAT ARE VARIABLES
Negara <- "Amerika"
Umur <- 27

# THE FUNCTION PASTE ALLOWS YOU TO PRINT WORDS AND COMBINE STRING VARIABLES. MUST USE COMMAS IN BETWEEN WORDS AND VARIABLES

paste("Hello world. My name is", nama1, "I am from", Negara, "I am", Umur, "years old")


###################### back to slides

# DATA TYPES -----------------------------------------------------------

## NUMERIC - DO NOT USE QUOTATION MARKS FOR NUMERIC DATA

2 + 3

# DIVISION
94729 / 7

# MULTIPLICATION
13532 * 7

# INTEGER DIVISION
94729 %/% 7

# MODULAR ARITHMETIC - show on whiteboard what this is
94729 %% 7

# YOU CAN ALSO USE PARENTHESES IN THE SAME WAY THEY ARE USED IN MATHEMATICS

7 * 2 + 3

7 * (2 + 3)


## ACTIVITY 
# GO INTO GROUPS AND TAKE TURNS ONE PERSON SAYING AN EQUATION AND EVERYONE TYPING OUT TO CALCULATE THE ANSWER (CHALLENGE: TRY TO USE INTEGER DIVISION, MODULAR ARITHMETIC, AND VARIABLES IN YOUR CALCULATIONS)





















###################### back to slides

# STRINGS

# ALWAYS USE QUOTATION MARKS. CANNOT PERFORM CALCULATIONS ON STRINGS
k <- "17"
14 * k

# GREPL FUNCTION CHECKS IF THERE IS A CERTAIN STRING WITHIN ANOTHER STRING
grepl("Soph", nama1)
grepl("Anne", nama1)




## ACTIVITY: CREATE INDIVIDUALIZED INTRODUCTIONS: FILL IN THE VARIABLES BELOW TO WRITE YOUR OWN INDIVIDUAL INTRODUCTION

# erase the inputs below

NAME <- "Sophie"
AGE <- 27
SIBLINGS <- 6
NAME_MOTHER <- "Gretchen"
NAME_FATHER <- "Tony"


paste("My name is", NAME, "I am", AGE, "years old. I have", SIBLINGS, "brothers and sisters. My mom's name is", NAME_MOTHER, "My father's name is", NAME_FATHER)

###################### back to slides

# ACTIVITY: GET INTO GROUPS AND CREATE A MAD LIBS GAME LIKE THE EXAMPLE IN CLASS. WE WILL THEN PLAY MAD LIBS WITH THE GROUP. PAY ATTENTION TO COMMAS, PARENTHESES, AND QUOTATION MAKRS

# delete the example below

ADJECTIVE1 <- 
ADJECTIVE2 <- 
ADJECTIVE3 <- 

NOUN1 <- 
NOUN2 <- 
NOUN3 <- 
PLURALNOUN1 <- 
PLURALNOUN2 <- 
PLURALNOUN3 <- 
PLURALNOUN4 <- 

GAME <- 
PLACE <- 
NUMBER <- 
PLANT <- 
BODYPART <- 

INGVERB1 <- 
INGVERB2 <- 
INGVERB3 <- 
INGVERB4 <- 



paste("A vacation is when you take a trip to some", ADJECTIVE1, "place with your", ADJECTIVE2, "family. Usually you go to some place that is near a", NOUN1, "or on a", NOUN2, ". A good vacation is where you can ride", PLURALNOUN1, "or play", GAME, "or go hunting for", PLURALNOUN2, ". I like to spend my time", INGVERB1,"or", INGVERB2,". When parents go on a vacation, they spend their time eating", NUMBER, PLURALNOUN3,", and fathers play golf, and mothers sit around", INGVERB3, ". Last summer, my brother fell off a", NOUN3, "and got poison", PLANT, "all over his", BODYPART, ". My family is going to go to the", PLACE, "and I will practice", INGVERB4, ". Parents need" , ADJECTIVE3, "and because they have to work", NUMBER, "hours every day all year making enough", PLURALNOUN4, "to pay for the vacation.")



###################### back to slides


# BOOLEAN/LOGICAL OPERATORS

5 < 6

x <- 6

x <= 6

(16/4) == 4 # NEED TO HAVE THE TWO EQUALS SIGNS OR ELSE YOU WILL JUST CREATE A VARIABLE

# LOGICAL OPERATORS FOR STRINGS

"." %in% "is there a period in this sentence?"



###################### back to slides

# CHECKING AND CHANGING CLASSES
class(x)

as.character(x)

as.numeric(x)

# LISTS ------------------------------------------------------------------

# LISTS CAN BE MAD OV NUMBERS OR OF WORDS

buah <- c("apel", "pisang", "sangka", "salak", "mangga")
Daftar_1 <- c(4, 546, 234, 85, 1, 8, 3543, 654, 14, 46, 8934)

# MAKING SEQUENCES
OneToTen <- 1:10 
evenNumbers <- seq(0, 20, 2) 
tenOnes <- rep(1, 10) 

# INDEXING LISTS
min(Daftar_1) #MINIMUM
max(Daftar_1) #MAXIMUM
sort(Daftar_1) #ORGANIZE
length(Daftar_1) #TOTAL IN LIST 
range(Daftar_1) #MIN AND MAX

# CALLING A CERTAIN PART OF LISTS
buah[1]
buah[1:3]
buah[c(1,3, 5)]
buah[-2]

# CHANGING DATA IN A LIST
buah[1] <- "jeruk"
buah

# CAN ALSO USE BOOLEAN OPERATORS IN LISTS
"apel" %in% buah

# ADD DATA TO A LIST. Note how this is now a new list
buah_2 <- append(buah, "apel", after = 2)
buah_2


## ACTIVITIES
# 1. MAKE A LIST OF ALL THE ODD NUMBERS FROM 1-100




# 2. MAKE A LIST OF ALL THE NUMBERS DIVISIBLE BY 7 FROM 1-1000




# 3. RUN THE FOLLOWING CODE AND IN YOUR OWN WORDS WRITE WHAT EACH INDEXING COMMAND DOES:
  buah[1]
  buah[1:3]
  buah[c(1,3, 5)]
  buah[-2]
  
  
# MAKE A LIST OF YOUR TOP FIVE FAVORITE MOVES (FROM MOST TO LEAST FAVORITE)
  # PRINT YOUR TOP 3 FAVORITE
  # CHECK TO SEE IF THE MOVE "BATMAN" IS INCLUDED
  # ADD THE MOVIE "BATMAN" TO THE END OF THE LIST (BECAUSE IT'S A GREAT MOVIE)




  
###################### back to slides
  
# MATRICES AND DATA FRAMES ------------------------------


# MAKING A MATRIX

matriksAngka <- matrix(c(1,2,3,4,5,6), nrow = 2, ncol = 3)

# PRINTING A MATRIX
matriksAngka 

# MATRICES CAN ALSO BE MADE WITH STRINGS
matriksBuah <- matrix(c("apel", "pisang", "semangka", "mangga","anggur", "nanas", "salak", "alpukat", "jeruk"), nrow = 3, ncol = 3)

matriksBuah

# INDEXING MATRICES
matriksBuah[1, 2]
matriksBuah[2,]
matriksBuah[,2]

# MORE THAN ONE COLUMN
matriksBuah[c(1,2),]
matriksBuah[,c(1,2)]


# ADDING A COLUMN
matriksBuahBaru_1 <- cbind(matriksBuah, c("stroberi", "bluberi", "durian"))

matriksBuahBaru_1

#ADDING A ROW
matriksBuahBaru_2 <- rbind(matriksBuah, c("stroberi", "bluberi", "durian"))

matriksBuahBaru_2

# ERASING A ROW AND A COLUMN
matriksBuah <- matriksBuah[-c(1), -c(1)]

matriksBuah

# CHECK YOUR MATRIX
"apel" %in% matriksBuah
"grape" %in% matriksBuah

# CHECKING SIZING
dim(matriksBuah)
length(matriksBuah)


# DATAFRAME ---------------------------------------------------------------

# SIMILAR TO A MATRIX BUT EACH COLUMN HAS A NAME THAT CAN BE CALLED

# MAKING A DATAFRAME
Data_Frame <- data.frame (
  Murid = c("Rina", "Virginia", "Ben"),
  Nilai = c(100, 150, 120),
  Waktu = c(60, 30, 45)
)


# PRINT YOUR DATAFRAME
View(Data_Frame)

summary(Data_Frame)

#CALLING A COLUMN
Data_Frame[1]

Data_Frame[["Murid"]]

Data_Frame$Murid


# ADDING A ROW
baris_baru_DF <- rbind(Data_Frame, c("John", 110, 110))

baris_baru_DF

# ADDING A COLUMN
kolom_baru_DF <- cbind(Data_Frame, Place = c(2, 1, 3))

kolom_baru_DF

# REMOVE FIRST COLUMN AND ROW
Data_Frame_Remove <- Data_Frame[-c(1), -c(1)]

Data_Frame_Remove

# DIMENSIONS
dim(Data_Frame)
ncol(Data_Frame)
nrow(Data_Frame)
length(Data_Frame) #SAME AS NCOL

## ACTIVITIES

# WRITE AN EMPTY DATAFRAME


# WRITE A DATAFRAME THAT HAS A LIST OF YOUR CLASSES, THE NUMBER OF STUDENTS IN EACH CLASS, WHICH DAY OF THE WEEK THE CLASS IS, AND HOW MANY CREDITS THE CLASS IS FOR
  # ADD A COLUMN ON THE LEFT THAT NUMBERS THE CLASSES STARTING FROM 1
  # EXTRACT EACH COLUMN OF THE DATAFRAME
  # EXTRACT THE FIRST TWO ROWS OF THAT DATAFRAME
  # EXTRACT THE 3RD AND 5TH ROW AND THE 1ST AND 3RD COLUMN OF THE DATAFRAME
  # ADD A COLUMN WITH THE TIME OF DAY EACH CLASS TAKES PLACE
  # ADD A ROW WITH A MADE UP CLASS YOU'D LIKE TO TAKE
  # ORGANZIE THE CLASSES IN ALPHABETICAL ORDER











###################### back to slides

# IF STATEMENTS -----------------------------------------------------------

# IF STATEMENTS WILL ONLY RUN UNDER CERTAIN CONDITIONS

a <- 33
b <- 200

if (b > a) {
  print("b is larger than a")
}

# ELSE IF STATEMENT. IF THE ABOVE STATEMENT IS FALSE, THEY WILL CHECK THE NEW CONDITION

a <- 33
b <- 33

if (b > a) {
  print("b is larger than a")
} else if (a == b) {
  print ("a is the same as b")
}

# ELSE STATEMENT - WILL RUN IF ALL ABOVE STATEMENTS ARE FALSE

a <- 200
b <- 33

if (b > a) {
  print("b is larger than a")
} else if (a == b) {
  print ("a is the same as b")
} else {
  print("a is larger than b")
}


## QUALIFIED IF STATEMENT

# 2 TWO STATEMENTS IN ONE LINE

a <- 200
b <- 33

if (a < 100 & b < 100) { # AND
  print("a and be are less than 100")
} 

if (a < 100 | b < 100) { # OR
  print("a or b are less than 100")
}


# ACTIVITIES:
# IF STATEMENTS
  # WRITE AN IF STATEMENT THAT CHECKS IF A STUDENT HAS PASSING GRADES (75-100), NEEDS TO GET EXTRA CREDIT (50-75), OR IS FAILING (0-50)





  # WRITE AN IF STATEMENT THAT CHECKS IF A NUMBER IS DIVISIBLE BY 2, 3, OR BOTH










###################### back to slides

# WHILE LOOPS -------------------------------------------------------------

# CODE WILL RUN REPEATEDLY WHILE A STATEMENT IS TRUE
#go through this on the board

i <- 1 # ASSIGN A NUMBER TO I
while (i <= 6) { # CHECK TRUE/FALSE
  print(i) # RUN CODE
  i <- i + 1 # ADD TO I. CODE REPEATS
}


# FOR LOOPS  ---------------------------------------------------------------

# SIMILAR TO WHILE LOOPS BUT DIFFERENT SYNTAX. RUNS UNTIL THE END OF A GIVEN LIST

for (k in 1:10) {
  print(paste("Number =", k))
}


loopBuah <- list("apel", "pisang", "alpukat")

for (k in loopBuah) {
  print(paste("My favorite fruit is", k))
}






#ACTIVITIES:
# WHILE LOOP  
  # USE A WHILE LOOP TO CALCULATE THE NUMBER OF TERMS REQUIRED BEFORE THE PRODUCT 1 * 2 * 3 * 4 *... REACHES ABOVE 10 MILLION. PRINT THE NUMBER OF TERMS REQUIRED





# FOR LOOP
  # LOOP THROUGH THE DATAFRAME YOU MADE LAST TIME AND PRINT THE NAME OF EACH OF YOUR CLASSES ONE BY ONE




  # LOOP THROUGH 100 RANDOM FLIPS OF A COIN AND AT THE END OF THE LOOP, COUNT HOW MANY TIMES EACH WAS HEADS AND TAILS. USE THE CODE BELOW TO SIMULATE THE COIN FLIPS

#WHAT DOES EACH OF THESE LINES DO?
coin <- c('heads', 'tails')
sample(coin, size = 1) 




###################### back to slides

# FUNCTION ------------------------------------------------------------------

#CODE THAT IS NOT RUN UNLESS WE CALL IT

fungsi_saya <- function() { # MAKE A FUNCTION WITH THE NAME fungsi_saya. THIS CODE WILL NOT RUN UNLESS WE CALL IT
  print("Hello World!")
}

# CALLING A FUNCTION
fungsi_saya()

# FUNCTIONS WITH INPUT

fungsi_name <- function(name){
  paste("Hello, my name is", name)
}

fungsi_name()
fungsi_name("Sophie") #CHANGE THE INPUT OF THE FUNCTION

# MULTIPLE INPUTS
intro_function <- function(nama, asal){
  paste("Halo, nama saya", nama, "Saya berasal dari", asal)
}

intro_function("Sophie", "Washington")


# USING "RETURN" IN A FUNCTION ALLOWS YOU TO SAVE THE OUTPUT OUTSIDE OF THE FUNCTION
fungsi_perkalian <- function(x) {
  return (5 * x)
}

fungsi_perkalian(3)
fungsi_perkalian(5)
fungsi_perkalian(9)

nilaiFinal <- fungsi_perkalian(9) * 100
nilaiFinal

# ACTIVITIES
  # CREATE A FUNCTION THAT WILL RETURN THE SUM OF 2 INTEGERS

  # CREATE A FUNCTION THAT WILL RETURN T OR F IF A NUMBER IS DIVISIBLE BY 17


  # CREATE A FUNCTION THAT WILL TURN ALL NUMBERS INTO POSITIVE, WHOLE NUMBERS



  # CREATE A GUESS THE NUMBER GAME. THE FUNCTION WILL RANDOMLY GENERATE A NUMBER BETWEEN ONE AND 100. THEN, TWO PLAYERS WILL INPUT THEIR GUESSES. CLOSEST PLAYER WINS!
      # HINT: ADAPT THE COIN TOSS CODE TO RANDOMLY GENERATE A NUMBER























