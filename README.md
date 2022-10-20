<p align="center">
  <a href="https://github.com/bminusl/ihatetobudget/">
    <img src="https://raw.githubusercontent.com/bminusl/ihatetobudget/master/static/logo.png" alt="IHateToBudget logo" height="130">
  </a>
</p>

<p align="center">
  <img src="https://github.com/HijazP/i-hate-to-budget/blob/main/Image/logo%20azure.png" alt="GitHub Pipenv locked Python version" height="20">
  <img src="https://github.com/HijazP/i-hate-to-budget/blob/main/Image/logo%20docker.png" alt="GitHub Pipenv locked Python version" height="20">
  <img src="https://github.com/HijazP/i-hate-to-budget/blob/main/Image/logo%20pyhton.png" alt="GitHub Pipenv locked Python version" height="20">
  <img src="https://github.com/HijazP/i-hate-to-budget/blob/main/Image/django%20logo.png" alt="GitHub Pipenv locked Python version" height="20">
  </p>

<p align="center">
  Aplikasi web sederhana untuk mengatur pengeluaran Anda.
  <br>
  Didesain untuk dihosting sendiri.
  <br>
  <em>Reference by <a href="https://github.com/bminusl/ihatetobudget">bminusl</a>.</em>
</p>

[Sekilas Tentang](#sekilas-tentang) | [Instalasi](#instalasi) | [Maintenance](#maintenance) | [Otomatisasi](#otomatisasi) | [Cara Pemakaian](#cara-pemakaian) | [Pembahasan](#pembahasan) | [Referensi](#referensi)
:---:|:---:|:---:|:---:|:---:|:---:|:---:
    
# Sekilas Tentang
![alt text](https://github.com/HijazP/i-hate-to-budget/blob/main/Image/Loginpage.png)

[IHateToBudget](https://github.com/bminusl/ihatetobudget) adalah sebuah web app yang bertujuan untuk membantu dalam memahami dan mengontrol pengeluaran/budget. Pada web app ini, kita dapat mengkategorikan jenis dan total pengeluaran yang ada pada suatu bulan sehingga kita dapat melihat berapa pengeluaran kita untuk setiap bulannya. Kita juga bisa melihat dan memfilter pengeluaran bulan mana yang mau dilihat. Dengan web app ini, diharapkan dapat membantu dalam memanajemen keuangan.

## Instalasi
[`^ kembali ke atas ^`](#)

### Kebutuhan Sistem :
- Sistem Operasi: Windows, Unix, dan lainnya
- Python: Python versi 3
- Django: Django versi 3.1.14 atau lebih tinggi
- RAM: 64Mb atau lebih tinggi

### Proses Instalasi :
#### Docker
Proses instalasi menggunakan Docker hanyalah salah satu cara, banyak cara lainnya yang bisa disesuaikan dengan preferensi masing-masing.

1. Pasang [Docker](https://www.docker.com/) dan [Docker Compose](https://docs.docker.com/compose/)

2. *Clone* repositori:
```
git clone https://github.com/bminusl/ihatetobudget.git
cd ihatetobudget
```

3. *Copy* beberapa file berikut di dalam foldernya:
- `docker-compose.yml.example` ke `docker-compose.yml`
- `docker-compose.env.example` ke `docker-compose.env`
- `Caddyfile.example` ke `Caddyfile`
```
cp docker-compose.yml.example docker-compose.yml
cp docker-compose.env.example docker-compose.env
cp Caddyfile.example Caddyfile
```

4. Edit `docker-compose.env` dan sesuaikan beberapa variabel berikut:
- `DJANGO_SECRET_KEY`: *Secret key* yang digunakan untuk Django.
Lihat [di sini](https://docs.djangoproject.com/en/3.1/ref/settings/#std:setting-SECRET_KEY) untuk informasi lebih lanjut.
- `CURRENCY_GROUP_SEPARATOR`: Satu karakter untuk memisahkan 3 digit angka (misal: 1.000)
- `CURRENCY_DECIMAL_SEPARATOR`: Satu karakter untuk memisahkan desimal (misal: 1.000,00)
- `CURRENCY_PREFIX`: String yang akan diletakkan di awal nomor (misal: Rp. 1.000,00)
- `CURRENCY_SUFFIX`: String yang akan diletakkan di akhir nomor (misal: Rp. 1.000,00,-)
Secara *default*, format uang yang disediakan menyesuaikan dengan Euro Prancis. Untuk mengubahnya menjadi rupiah, format yang dipakai sebagai berikut:

```
CURRENCY_GROUP_SEPARATOR=.
CURRENCY_DECIMAL_SEPARATOR=,
CURRENCY_PREFIX=Rp.
CURRENCY_SUFFIX=
```
Catatan: Jangan lupa hilangkan format komentar (#).

5. Jalankan `docker compose up -d`. Perintah ini akan *build* atau membangun *main image*, membuat dan menjalankan *container*.

6. Jalankan `cron` di dalam *container*nya:
```
docker compose exec ihatetobudget service cron start
```

7. Untuk bisa *login*, dibutuhkan (super) user. Jalankan perintah berikut untuk membuat akun:
```
docker compose run --rm ihatetobudget pipenv run python manage.py migrate
docker compose run --rm ihatetobudget pipenv run python manage.py createsuperuser
```

8. Sekarang Anda sudah bisa mengakses [IHateToBudgetInstance](127.0.0.1) di `http://127.0.0.1:80`. *Login* menggunakan *username* dan *password* yang sebelumnya sudah dibuat.

## Maintenance
[`^ kembali ke atas ^`](#)

#### Docker
1. Pergi ke *root* di repositori.

2. Jalankan `docker compose down -v`, akan mengehentikan semua *container* yang sedang berjalan.

3. Membuat cadangan *database* (opsional), jalankan `cp db.sqlite3 db.sqlite3.bak`.

4. *Update codebase* menggunakan perintah `git pull`.

5. *Rebuild image*:
```
docker compose build
```

6. Migrasi *database*:
```
docker compose run --rm ihatetobudget pipenv run python manage.py migrate
```
Aksi ini akan mensinkronisasikan *database state* dengan set terbaru.

7. Jalankan `docker compose up -d`, untuk menjalankan container.

8. Jalankan `cron` di dalam *container*nya:
```
docker compose exec ihatetobudget service cron start
```


## Otomatisasi
[`^ kembali ke atas ^`](#)

Cara lain untuk mempersingkat proses instalasi adalah menggunakan *shell script*. *Shell script* adalah kumpulan kode yang dapat dijalankan di Unix shell. Berikut adalah kumpulan *shell script* untuk instalasi, menjalankan, serta menghentikan server aplikasi.

#### Cara menjalankannya dengan perintah `./(nama).sh`
1. [setup.sh](https://github.com/HijazP/i-hate-to-budget/shell/setup.sh) berisi kode `git clone` dan `cp`.

2. [change.sh](https://github.com/HijazP/i-hate-to-budget/shell/change.sh) berisi kode untuk konfigurasi tampilan mata uang.

3. [user.sh](https://github.com/HijazP/i-hate-to-budget/shell/user.sh) berisi kode untuk konfigurasi *user*.

4. [start.sh](https://github.com/HijazP/i-hate-to-budget/shell/start.ch) berisi kode untuk menjalankan server.

5. [stop.sh](https://github.com/HijazP/i-hate-to-budget/shell/stop.sh) berisi kode untuk menghentikan server.

*Shell script* `user.sh`, `start.sh`, dan `stop.sh` dan dijalankan kapanpun setelah `setup.sh` dan `change.sh` dijalankan.


## Cara Pemakaian
[`^ kembali ke atas ^`](#)
- Tampilan Aplikasi Web
    - Tampilan Utama Aplikasi
        ![alt text](https://github.com/HijazP/i-hate-to-budget/blob/main/Image/homepage.png)
- Fungsi-fungsi utama
    - Menambah Kategori Pengeluaran Baru
        ![alt text](https://github.com/HijazP/i-hate-to-budget/blob/main/Image/NewCategoryPage.png)
    - Menambah Pengeluaran Baru
        ![alt text](https://github.com/HijazP/i-hate-to-budget/blob/main/Image/NewExpensePage.png)
    - Melihat Riwayat Pengeluaran
        ![alt text](https://github.com/HijazP/i-hate-to-budget/blob/main/Image/HistoryPage.png)
- Contoh Pemakaian
    - Pembuatan Kategori Pengeluaran Baru
        ![alt text](https://github.com/HijazP/i-hate-to-budget/blob/main/Image/CreateNewCategory.png)
    - Pembuatan Pengeluaran Baru
        ![alt text](https://github.com/HijazP/i-hate-to-budget/blob/main/Image/CreateNewExpense.png)

## Pembahasan
[`^ kembali ke atas ^`](#)

- Pendapat anda tentang aplikasi web ini
    - ### Kelebihan
      1. Dapat mengatur sendiri kategori pengeluaran
      ![image](https://user-images.githubusercontent.com/65883882/196928714-801e1f62-ce89-4863-92e0-9645c3cd447e.png)
      2. Dapat melihat history pengeluaran
      ![image](https://user-images.githubusercontent.com/65883882/196929056-3bd522a1-6c5d-4cc0-bf9a-fe95491399c1.png)
      3. Terdapat insight pengeluaran per bulannya
      ![image](https://user-images.githubusercontent.com/65883882/196929851-ac9666bf-a346-43f8-8fa5-9c339b3c7764.png)

    - ### Kekurangan
      1. Hanya mencatat jumlah pengeluaran, tidak mencatat saldo yang ada
      ![image](https://user-images.githubusercontent.com/65883882/196930621-c0826813-e429-4ff7-945e-88a5af0a5274.png)
      2. Tidak bisa lebih dari 1 akun dalam 1 server
      ![image](https://user-images.githubusercontent.com/65883882/196932444-0107dbcb-4eab-4e5c-af0c-7bc012767ef9.png)
      
- Bandingkan dengan aplikasi web lain yang sejenis
  ### Money Lover
  1. Terdapat pembagian untuk sumber uang
  ![image](https://user-images.githubusercontent.com/65883882/196955697-2b1ce911-b781-4be9-b2bc-e18977ed5d37.png)
  2. Kategori pengeluaran sudah tersedia, namun tidak dapat dikustomisasi
  ![image](https://user-images.githubusercontent.com/65883882/196955818-f19f4168-f6a5-4a50-bf8a-b3de68a05de0.png)
  
  ### SikapiUangmu - OJK
  1. Terdapat opsi untuk menghitung harta dan dikurangi dengan utang yang dimiliki
  ![image](https://user-images.githubusercontent.com/65883882/196956060-e12af8c7-20f1-4de7-b9d8-24b4ef3a1bbf.png)
  2. Terdapat kalkulator untuk menghitung kesehatan keuangan
  ![image](https://user-images.githubusercontent.com/65883882/196956147-34c8f6b2-b253-49ac-89e3-9a184abec20b.png)

## Referensi
- [Azure Cloud](https://azure.microsoft.com/id-id/)
- [Docker](https://www.docker.com/)
- [Money Lover](https://moneylover.me/)
- [SikapiUangmu - OJK](https://sikapiuangmu.ojk.go.id/FrontEnd/Kalkulator/Kalkulator%20Dompet)

[`^ kembali ke atas ^`](#)
