# write a nested if statement that checks if a number x is positive, negative, or 0
# Write an if statement that checks if a number is divisible by 2, 3, or both
# Use a while loop to investigate the number of terms required before the product 1⋅2⋅3⋅4⋅…reaches above 10 million. print the number of terms required
# 



x <- 11

if (x > 0) {
  print("x positif")
} else if (x < 0) {
  print ("x negatif")
} else if (x == 0) {
  print ("x sama dengan nol")
}

if (x %% 2 == 0 ) {
  print("x habis dibagi 2")
} else if (x %% 3 == 0) {
  print ("x habis dibagi 3")
}


abs(-7)
a <- 250
b <- sample(1:500, 1 )
if (a == b) {
  print("you win 1,000,000")
} else if (abs(a - b) < 100){
  print("you get 500,000")
} else if (abs(a- b) < 200){
  print("you get 100,000")
} else {print("no money")}


a <- "batu"
b <- "gunting"
c <- "kertas"
Player1 <- a
Player2 <- b

if(Player1==a){
  if(Player2== c){
  print("Player2 menang")
} else if(Player2==b){
  print("Player1 menang")
} else("Match")
}else if(Player1==b){
  if(Player2== c){
    print("Player2 menang")
  } else if(Player2==a){
    print("Player1 menang")
  } else("Match")  
}else if(Player1==c){
  if(Player2== b){
    print("Player2 menang")
  } else if(Player2==a){
    print("Player1 menang")
  } else("Match") 
} 


