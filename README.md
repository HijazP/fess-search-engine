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

[Sekilas Tentang](#sekilas-tentang) | [Instalasi](#instalasi) | [Konfigurasi](#konfigurasi) | [Cara Pemakaian](#cara-pemakaian) | [Pembahasan](#pembahasan) | [Referensi](#referensi)
:---:|:---:|:---:|:---:|:---:|:---:
    
# Sekilas Tentang
[`^kembali ke atas^`](#)
![alt text](https://github.com/HijazP/i-hate-to-budget/blob/main/Image/Loginpage.png)

[IHateToBudget](https://github.com/bminusl/ihatetobudget) adalah sebuah web apps yang bertujuan untuk membantu dalam memahami dan mengontrol pengeluaran/budget. Pada web apps ini, kita dapat mengkategori kan jenis dan total pengeluaran yg ada pada suatu bulan sehingga kita dapat melihat berapa pengeluaran kita untuk setiap bulannya. Kita juga bisa melihat dan memfilter pengeluaran bulan mana yang mau dilihat. Dengan web apps ini, diharapkan dapat membantu dalam memanajemen keuangan.

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


## Otomatisasi (opsional)

Skrip shell untuk otomatisasi instalasi, konfigurasi, dan maintenance.


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

- Pendapat anda tentang aplikasi web ini
    - kelebihan
    - kekurangan
- Bandingkan dengan aplikasi web lain yang sejenis


## Referensi

Cantumkan tiap sumber informasi yang anda pakai.
