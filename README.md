# PAB_Pertemuan-4_part-5

# Mini E-Commerce Shopping Cart (Flutter + Provider)

## Deskripsi Project

Project ini merupakan implementasi sederhana aplikasi Mini E-Commerce Shopping Cart menggunakan framework Flutter dengan state management Provider. Aplikasi ini dibuat untuk memahami konsep manajemen state global menggunakan ChangeNotifier, serta implementasi interaksi dasar keranjang belanja pada aplikasi mobile.

Pengguna dapat melihat daftar produk, menambahkan produk ke keranjang, mengatur jumlah item, menghapus item, serta melihat total harga sebelum melakukan checkout.

---

## Fitur Aplikasi

* Model produk
* Model cart item
* Cart model dengan ChangeNotifier
* Halaman daftar produk
* Tombol tambah ke cart
* Badge jumlah item pada icon cart
* Halaman cart berisi semua item
* Penambahan dan pengurangan jumlah item
* Hapus item dari cart
* Perhitungan total harga otomatis
* Pesan ketika cart kosong
* Fungsi checkout sederhana

---

## Struktur Folder

```
lib/
│
├── models/
│   ├── product.dart
│   ├── cart_item.dart
│   └── cart_model.dart
│
├── pages/
│   ├── product_list_page.dart
│   └── cart_page.dart
│
└── main.dart
```

---

## Penjelasan Arsitektur

### Product Model

Digunakan untuk merepresentasikan data produk seperti id, nama, harga, gambar, dan kategori.

### CartItem Model

Menyimpan informasi produk yang dimasukkan ke keranjang beserta jumlahnya. Menyediakan properti kalkulasi total harga.

### CartModel

Merupakan pusat state aplikasi yang mengatur:

* Penyimpanan item cart
* Penambahan produk
* Penghapusan produk
* Perubahan kuantitas
* Perhitungan total harga
* Notifikasi UI menggunakan notifyListeners()

Menggunakan struktur Map untuk akses cepat berdasarkan product ID.

### Provider

ChangeNotifierProvider digunakan pada root aplikasi sehingga seluruh halaman dapat mengakses state cart tanpa prop drilling.

---

## Cara Menjalankan Project

1. Clone repository atau salin source code
2. Jalankan perintah berikut pada terminal

```
flutter pub get
```

3. Jalankan aplikasi

```
flutter run
```

Pastikan Flutter SDK sudah terinstall dan device/emulator aktif.

---

## Cara Penggunaan Aplikasi

1. Buka aplikasi
2. Pilih produk dari halaman utama
3. Tekan tombol Add untuk memasukkan ke cart
4. Tekan ikon cart untuk membuka halaman keranjang
5. Gunakan tombol tambah/kurang untuk mengubah jumlah
6. Hapus item jika diperlukan
7. Tekan Checkout untuk menyelesaikan simulasi pembelian

---

## Pengujian Fungsional

Pengujian manual dilakukan dengan skenario berikut:

* Menambahkan produk beberapa kali
* Menambahkan produk berbeda
* Mengubah jumlah item
* Menghapus item
* Mengosongkan cart
* Navigasi antar halaman

Seluruh fungsi berjalan sesuai harapan dan state tetap konsisten antar halaman.

---

## Kesimpulan

Project ini menunjukkan bahwa penggunaan Provider mempermudah pengelolaan state global pada aplikasi Flutter. Implementasi ChangeNotifier memungkinkan UI diperbarui secara otomatis tanpa perlu mengirim data antar widget secara manual.

Struktur pemisahan model dan halaman membantu meningkatkan keterbacaan kode serta memudahkan pengembangan lanjutan seperti integrasi database atau API.

---