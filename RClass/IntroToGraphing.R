#Datasets yang sudah ada di R. Bisa dipakai kapanpun untuk latihan

View(mtcars)
View(pressure)
View(BOD)
View(faithful)

# Base R atau ggplot2
# Download package ggplot2
# Package perlu dimanggil di setiap file R
library(ggplot2) #Perlu didownload di tab packages di layar kanan bawah
require(ggplot2)

#SCATTERPLOT
plot(x = mtcars$wt, y = mtcars$mpg)

# GGPLOT2 - semua syntax barhasil grafik yang sama
# menentukan vektor x dan y
qplot(x = mtcars$wt, y = mtcars$mpg)
# menentukan dataframe, vektor x dan y 
qplot(x = wt, y = mpg, data = mtcars)
# sintaksis ggplot2 - lebih dipakai
ggplot(data = mtcars, aes(x = wt, y = mpg)) + # menentukan data, x dan y dinentukan di dalam aes
  geom_point() # menentukan genis grafik



#GRAFIK GARIS
plot(x = pressure$temperature, y = pressure$pressure, type = "l")
# tambah titik
points(x = pressure$temperature, y = pressure$pressure)
# tambah garis merah
lines(x = pressure$temperature, y = pressure$pressure/2, col = "red")
# tambah titik
points(x = pressure$temperature, y = pressure$pressure/2, col = "red")

# di ggplot2
ggplot(pressure, aes(x = temperature, y = pressure)) +
  geom_line() +
  geom_point()



#BARBLOT
#Base R
barplot(height = BOD$demand, names.arg = BOD$Time)

#GGplot
p <-ggplot(data = BOD, aes(x=Time,  y=demand)) +
  geom_bar(stat="identity")
p
# Barplot horisontal
p + coord_flip()



#HISTOGRAM
hist(mtcars$mpg)
hist(mtcars$mpg, breaks = 10) #Binning - Binning adalah cara untuk mengelompokkan suatu data ke dalam jumlah yang lebih kecil pada “bins”. Sering dipakai di statistik

# ggplot
ggplot(mtcars, aes(x=mpg)) +
  geom_histogram(binwidth = 10)
#binwidth dari ggplot dan breaks dari baseR beda. Breaks adalah nomor CATEGORIES di dalam data. Binwidth adalah RANGE OF EACH BIN



# BOXPLOT
boxplot(mpg ~ cyl, data = mtcars)

# ggplot
ggplot(mtcars, aes(x=as.factor(cyl), y=mpg)) + #Apa terjadi kalau kita menghapus as.factor?
  geom_boxplot()



# Latihan
# Pakai dataset yang bernama airquality. Buatlah scatterplot yang membandingkan Temp dan Ozone. Apakah terdapat hubungan?
# Buat histogram variabel Temp pakai 25 bins. Apakah distribusinya normal?
# Buatlah frekuensi observasi setiap bulan. Apakah bulan bulannya terwakilkan dengan baik
# Bandingkan histogram dan boxplot variabel Ozone
# Buat boxplot distribusi Ozone di setiap bulan. Apakah distribusinya berbeda setiap bulan
# Buat line chart pakai dataset longely yang mengambarkan jumlah pengangguran setiap tahun

