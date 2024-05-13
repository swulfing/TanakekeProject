# Make a list of your favorite movies or tv shows (in order most to least favorite)
# Print for me your top 3 favorite
# Check to see if the movie "Batman" is included
# Add your least favorite movie to the end

film <- c("the conjuring", "fast and furious", "mission impossible", "spiderman", "narnia", "pengabdi setan", "habibie dan ainun")
film[c(1, 2, 3)]
"batman" %in% film
film_7 <- append(film, "cars", after = 7)
film_7


# Write an empty dataframe
# Write dataframe that has lists of your classes, the number of students in each class, what day of the week that class is, and how many jam that class is
# Add a column on the left that numbers the classes starting from 1
# Extract each column of that dataframe
# Extract the first two rows of that dataframe
# Extract the 3rd and 5th rows with 1st and 3rd columns from a given data frame.
# Add a column saying what time each class is
# Add a row of a made up class you'd like to take
# Show me the list of classes in alphabetical order


Data_Kelas <- data.frame(
  kelas = c("mikrobiologi", "botani laut", "oseanografi", "ekologi laut", "akustik"),
  jumlahsiswa = c(43, 51, 35, 40, 55),
  hari = c("rabu", "selasa", "jumat", "kamis", "senin"),
  jam = c(2, 3, 2.5, 2, 4)
)

  View(Data_Kelas)
  kolom_baru_DF <- cbind(Nomor = c(1, 2, 3, 4, 5), Data_Kelas)
  View(kolom_baru_DF)  

  Data_Kelas$kelas  
  Data_Kelas$jumlahsiswa
  Data_Kelas$hari  
  Data_Kelas$jam  

  Data_Kelas[c(1,2),]
  Data_Kelas[c(1,3),  c(4,3)] 
  
  kolom_baru_DF <- cbind(Data_Kelas, waktu = c(15.55, 16.00, 10.00, 13.50, 09.20))
  View(kolom_baru_DF)
  
  kolom_baru_DF <- rbind(Data_Kelas, kelas = c("biologi laut", jumlahsiswa = c(45), hari = c("rabu"), jam = c("2")))
  View(kolom_baru_DF)
kolom_baru_DF[order(kolom_baru_DF$kelas),]
  