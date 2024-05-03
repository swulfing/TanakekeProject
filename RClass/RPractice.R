# # R STUDIO
# 


# 4 PANEL -----------------------------------------------------------------

# ### KIRI ATAS - SUMBER PANEL
# - Menulis dan menyimpan skrip - skrip kode sehingga analisis bisa dilakukan kembali
# 
# ### KIRI BAWAH - KONSOLE
# - Menunjukkan hasil atau keluaran kode. Bisa menjalankan kode di sini kalau kamu mau memeriksa kodenya atau berinteraksi dengan data.
# 
# ### KANAN ATAS
# - Environment/lingkungan: punya variabel - variabel yang kamu buat.
# 
# ### KANAN BAWAH
# - Tab tab: Files - Files bisa dieksplorasi
# Plots/ grafik: Visualisasi
# Packages: Di sini kamu bisa menemukan paket kode yang dibuat oleh orang lain
# -Banyak fungsi: genetika, menganalisis matriks, membuat peta, menyelesaikan persamaan, dll
# Help: mengakses library
# CONTOH - bisa mengetik ?NAMAPAKET di panel sumber atau panel konsole dan bisa membaca tentang paket, input input, contoh, dan kegunaan paketnya
# 
# # BAGAIMANA MEMBUAT DOKUMEN DAN MULAI ANALISIS
# - File => New file => R script
# - Cara cara kode diaktifkan
# Blok, "Code", "Run"
# "Run" Tombol di kanan atas
# CTRL + ENTER


# DASAR OPERASI -----------------------------------------------------------

#Perhitungan dasar dapat diselesaikan
2 + 3

#Pembagian
94729 / 7

# Pembagian utuh- desimal tidak dipakai
94729 %/% 7

# Aritmatika modular - keluaran adaleh sisanya
94729 %% 7

# BISA membuat komentar - kata - kata tidak dijalankan - dengan tanda tagar/hashtag
# SELALU DIBERI LABEL PADA KODE. MEMBERI CATATAN - TAKE NOTES

#FUNGSI CETAK

print("Hello, world")
#soal matematika tentang perkalian
4*12

#soal matematika tentang penjumlahan
199+56

# VARIABEL ----------------------------------------------------------------

# METODE SIMPAN DATA - memberi nama pada data atau objek
# 
# - HARUS mulai dengan huruf
# - huruf/angka/titik/garis bawah bisa dipakai
# - Harus cek huruf besar atau huruf kecil
# - Tidak bisa pakai nama variabel: TRUE, FALSE, NULL, if. Sudah dipakai di fungsi R 

# # Nama variabel yang tidak berjalan
# 1nama <- "Sophie"
# .1nama <- "Sophie"
# _1nama <- "Sophie"
# nama 1 <- "Sophie"

#Huruf besar atau huruf kecil
nama1 <- "Sophie"
NAMA_1<- "meja"

# Bisa membuat variabel dari nomor dan membuat kalkulasi
x <- 4
y <- 17

x*y

# Membuat variabel dari hasil kalkulasi
z <- x * y
z


#Bersatu Rangkaian
Negara <- "Amerika"
Umur <- 27

paste("Halo, nama saya", nama1, "Saya dari", Negara, "Umur saya", Umur, "tahun") # Harus pakai koma di antara kata dan variabel



# JENIS DATA --------------------------------------------------------------
# 
# - Nomor
# - Angka utuh
# - Bolean/logical
# - Karakter/huruf
# - Rangkaian/string
# - Factor - Kita bisa melewati dulu. Seperti Rangkaian tapi pakai hirarki


# Angka - tidak pakai tanda kutip
k <- "17"
x * k

# Cek jenis data dengan "class"
class(k)

# Mengubah jenis data
k <- as.numeric(k)


class(k)
x * k #Berjalan

# BOLEAN: TRUE OR FALSE (Betul atau Salah). Di worksheet
x < k
x == k #harus pakai dua tkamu sama dengan


# Karakter dan rangkaian

#Menghitung
nchar(nama1)

# Cek kalau ada kata di dalam rangkaian
grepl("Soph", nama1)
grepl("Anne", nama1)



# DAFTAR ------------------------------------------------------------------

# Koleksi objek diatur
# Berberapa objek bisa disimipan di satu variabel

buah <- c("apel", "pisang", "sangka", "salak", "mangga")
Daftar_1 <- c(4, 546, 234, 85, 1, 8, 3543, 654, 14, 46, 8934)


OneToTen <- 1:10 # Membuat daftar kalipatan dengan tanda titik dua
evenNumbers <- seq(0, 20, 2) #kalau tidak mau setiap angka, bisa membuat urutan dengan "seq"
#Even number = angka genap
#Odd NUMBER = angka ganjil
tenOnes <- rep(1, 10) #Membuat dafter dengan angka yang sama berkali-kali

# Dafter Isi
min(Daftar_1) #Minimum
max(Daftar_1) #Maksimum
sort(Daftar_1) #Mengatur
length(Daftar_1) #Jumlah 
range(Daftar_1) #Minimum dan Maksimum

#Memanggil sebagian data dari daftar
buah[1]
buah[1:3]
buah[c(1,3, 5)]
buah[-2]

#Mengubah bagian daftar
buah[1] <- "jeruk"
buah

#operator boolean - cek daftar
"apel" %in% buah

#Menambah input baru pada daftar
buah_2 <- append(buah, "apel", after = 2)
buah_2


# MATRIKS, DATA FRAMES, DAN DAFTAR BERSARANG ------------------------------

# Di atas satu dimensi pakai baris dan kolom

# MATRIX - seperti daftar. 2 dimensi. Perintah mirip

# Membuat matriks

matriksAngka <- matrix(c(1,2,3,4,5,6), nrow = 2, ncol = 3)

# Cetak matriks
matriksAngka 

# Bisa dibuat dengan rangkaian
matriksBuah <- matrix(c("apel", "pisang", "semangka", "mangga","anggur", "nanas", "salak", "alpukat", "jeruk"), nrow = 3, ncol = 3)

matriksBuah

# Daftar Isi
matriksBuah[1, 2]
matriksBuah[2,]
matriksBuah[,2]

# > 1 Kolom
matriksBuah[c(1,2),]
matriksBuah[,c(1,2)]


# Menambah Kolom
matriksBuahBaru_1 <- cbind(matriksBuah, c("stroberi", "bluberi", "durian"))

# Cetak matriks baru
matriksBuahBaru_1

#Menambah Baris
matriksBuahBaru_2 <- rbind(matriksBuah, c("stroberi", "bluberi", "durian"))

# Cetak matriks baru
matriksBuahBaru_2

# Menghapus baris dan kolom
matriksBuah <- matriksBuah[-c(1), -c(1)]

matriksBuah

# Cek matriks
"apel" %in% matriksBuah
"grape" %in% matriksBuah

# Cek dimensi dan ukuran
dim(matriksBuah)
length(matriksBuah)


# DATAFRAME ---------------------------------------------------------------

# Kolom punya nama yang bisa dimanggil

# Membuat dataframe
Data_Frame <- data.frame (
  Murid = c("Rina", "Virginia", "Ben"),
  Nilai = c(100, 150, 120),
  Waktu = c(60, 30, 45)
)


# Cetak Data frame
View(Data_Frame)

summary(Data_Frame)

#Menanggil kolom
View(Data_Frame[1])

Data_Frame[["Murid"]]

Data_Frame$Murid


# Menambah baris
baris_baru_DF <- rbind(Data_Frame, c("John", 110, 110))

# Cetak data frame baru
View(baris_baru_DF)

# Menambah kolom
kolom_baru_DF <- cbind(Data_Frame, Place = c(2, 1, 3))

# Cetak data frame
View(kolom_baru_DF)

# Hapus baris dan kolom yang pertama
Data_Frame_Remove <- Data_Frame[-c(1), -c(1)]

# Cetak dataframe
View(Data_Frame_Remove)

# Dimensi
dim(Data_Frame)
ncol(Data_Frame)
nrow(Data_Frame)
length(Data_Frame) #sama ncol


# IF STATEMENTS -----------------------------------------------------------

# Akan menjalankan kode hanya kalau kalimat tetap benar

#if statement
a <- 33
b <- 200

if (b > a) { #Kalimat boolean. Kalau benar, R akan menjalankan kode di dalam kurung keriting
  print("b lebih besar daripada a")
}

# else if statement - dijalankan kalau kalimat diatas salah

a <- 33
b <- 33

if (b > a) {
  print("b lebih besar daripada a")
} else if (a == b) {
  print ("a sama dengan b")
}

# Else statement - dijalankan kalau semua kalimat tersebut salah

a <- 200
b <- 33

if (b > a) {
  print("b lebih besar daripada a")
} else if (a == b) {
  print ("a sama dengan b")
} else {
  print("a lebih besar daripada b")
}

## Nested If Statement

a <- 200
b <- 33

if (a < 1000){
  if(b < 1000) {
    print("a dan b kurang dari 1000")
  } 
}

## Qualified If Statement

# 2 statement

a <- 200
b <- 33

if (a < 100 & b < 100) {
  print("a dan b kurang dari 100")
} 

if (a < 100 | b < 100) {
  print("a atau b kurang dari 100")
} 



# While Loops -------------------------------------------------------------

# Akan menjalankan kode berkali-kali hanya kalau kalimat tetap benar

i <- 1 # memberi angka pada i
while (i <= 6) { # Boolean, cek kalimat (benar/salah)
  print(i) # Menjalan kode
  i <- i + 1 # Merubah i. Kode berulang
}

# For Loops ---------------------------------------------------------------

for (x in 1:10) {
  print(paste("Nomornya ", x))
}


loopBuah <- list("apel", "pisang", "alpukat")

for (x in loopBuah) {
  print(paste("Buahnya ", x))
}


# FUNGSI ------------------------------------------------------------------

#Kode yang tidak dijalankan kecuali kamu menanggil kodenya

fungsi_aku <- function() { # membuat fungsi dengan nama "fungsi_aku". Tidak dijalankan
  print("Hello World!")
}

# menanggil fungsi
fungsi_aku()

# Fungsi dengan input

fungsi_nama <- function(name){
  print(paste("Hello, my name is", name))
}

fungsi_nama()
fungsi_nama("Sophie") #Bisa merubah input fungsi

# Berbagai input
intro_function <- function(nama, asal){
  print(paste("Halo, nama saya", nama, "Saya berasal dari", asal))
}

intro_function("Sophie", "Washington")


# Fungsi yang pakai "return" - return lebih dipakai karena bisa menyimpan keluaran pada variabel
fungsi_perkalian <- function(x) {
  return (5 * x)
}

print(fungsi_perkalian(3))
print(fungsi_perkalian(5))
print(fungsi_perkalian(9))

nilaiFinal <- fungsi_perkalian(9) * 100
nilaiFinal


