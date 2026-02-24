# PAB_Pertemuan-4_part-5

# Mini E-Commerce Shopping Cart (Flutter + Provider)

## Deskripsi Project

Project ini merupakan implementasi sederhana aplikasi Mini E-Commerce Shopping Cart menggunakan framework Flutter dengan state management Provider. Aplikasi ini dibuat untuk memahami konsep manajemen state global menggunakan ChangeNotifier, serta implementasi interaksi dasar keranjang belanja pada aplikasi mobile.

Pada versi ini, project juga menambahkan materi lanjutan Part 6 (Advanced Provider Topics): MultiProvider, perbedaan Consumer vs context.watch vs context.read, serta optimasi performa menggunakan Selector.

Pengguna dapat melihat daftar produk, menambahkan produk ke keranjang, mencari dan memfilter produk, mengatur jumlah item, menghapus item, serta melihat total harga sebelum melakukan checkout melalui halaman checkout terpisah.

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
* Checkout page (order summary + form)
* Search products by name
* Filter products by category
* MultiProvider untuk multiple state objects
* Optimasi badge cart dengan Selector

Checklist Penilaian:

WAJIB (70 points):
* [x] Add to cart from product list
<p align="center">
  <img src="https://github.com/user-attachments/assets/83513cdc-351b-430c-9a8c-05ce3690ed64" width="600"/>
</p>

* [x] Show cart items dengan quantity
<p align="center">
  <img src="https://github.com/user-attachments/assets/6d1d64d4-308e-415d-a32b-aa9df5ca2147" width="600"/>
</p>

* [x] Update quantity (+/-)
<p align="center">
  <img src="https://github.com/user-attachments/assets/fc1c1bf7-b47f-41c3-b43a-b47a7080a439" width="600"/>
</p>

* [x] Remove items from cart
<p align="center">
  <img src="https://github.com/user-attachments/assets/98e37f0e-5883-4038-b6b9-fad2d9d84a1c" width="600"/>
</p>

* [x] Display total price correctly
<p align="center">
  <img src="https://github.com/user-attachments/assets/030d041b-aaba-4974-9fe7-b369a8f001e5" width="600"/>
</p>

BONUS (+30 points):
* [x] Search/Filter (+10) - Search products by name
<p align="center">
  <img src="https://github.com/user-attachments/assets/9bc438e2-a4e5-4832-964b-75cd34c549e0" width="600"/>
</p>

* [x] Categories (+10) - Filter products by category
<p align="center">
  <img src="https://github.com/user-attachments/assets/a578dc50-993b-4363-b5c6-09a6772184a5" width="600"/>
</p>

* [x] Checkout Page (+10) - Order summary + form
<p align="center">
  <img src="https://github.com/user-attachments/assets/77080b70-e4f3-4cf7-8add-408a57bc34af" width="600"/>
</p>

---

## Struktur Folder

```
lib/
│
├── models/
│   ├── product.dart
│   ├── cart_item.dart
│   ├── cart_model.dart
│   ├── user_model.dart
│   └── theme_model.dart
│
├── pages/
│   ├── product_list_page.dart
│   ├── cart_page.dart
│   └── checkout_page.dart
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

Menggunakan MultiProvider pada root aplikasi sehingga seluruh halaman dapat mengakses state tanpa prop drilling:

* CartModel untuk state keranjang
* UserModel untuk data user checkout
* ThemeModel untuk pengaturan tema

Perbandingan penggunaan provider pada project:

* Consumer: untuk rebuild widget tertentu agar lebih efisien
* context.watch: untuk membaca state di build method
* context.read: untuk trigger aksi pada callback
* Selector: untuk rebuild hanya pada field yang dibutuhkan (contoh: itemCount badge)

Troubleshooting lanjutan:

* Bad state: No ChangeNotifierProvider found
  * Penyebab: context digunakan di atas provider
  * Solusi: pastikan provider membungkus app / gunakan Builder
* Too many rebuilds / app lambat
  * Penyebab: terlalu banyak context.watch pada area besar
  * Solusi: gunakan Consumer/Selector untuk widget spesifik
* Selector tidak update
  * Penyebab: selector mengembalikan referensi object yang sama
  * Solusi: kembalikan primitive value atau implementasi equality dengan benar

---

## Cara Menjalankan Project

1. Clone repository atau salin source code
2. Jalankan perintah berikut pada terminal

```bash
flutter pub get
```

3. Jalankan aplikasi

```bash
flutter run
```

Pastikan Flutter SDK sudah terinstall dan device/emulator aktif.

---

## Cara Penggunaan Aplikasi

1. Buka aplikasi
2. Gunakan search bar atau category chips untuk filter produk (opsional)
3. Pilih produk dari halaman utama
4. Tekan tombol Add untuk memasukkan ke cart
5. Tekan ikon cart untuk membuka halaman keranjang
6. Gunakan tombol tambah/kurang untuk mengubah jumlah
7. Hapus item jika diperlukan
8. Tekan Checkout untuk membuka halaman checkout
9. Isi form customer dan konfirmasi order

---

## Pengujian Fungsional

Pengujian manual dilakukan dengan skenario berikut:

* Menambahkan produk beberapa kali
* Menambahkan produk berbeda
* Mengubah jumlah item
* Menghapus item
* Mengosongkan cart
* Memastikan total harga terhitung benar saat quantity berubah
* Mencari produk berdasarkan nama
* Filter produk berdasarkan kategori
* Navigasi product list -> cart -> checkout
* Submit checkout form valid

Seluruh fungsi berjalan sesuai harapan dan state tetap konsisten antar halaman.

---

## Kesimpulan

Project ini menunjukkan bahwa penggunaan Provider mempermudah pengelolaan state global pada aplikasi Flutter. Implementasi ChangeNotifier memungkinkan UI diperbarui secara otomatis tanpa perlu mengirim data antar widget secara manual.

Penambahan MultiProvider, penggunaan Consumer/context.watch/context.read yang tepat, serta Selector untuk rebuild terfokus membantu meningkatkan skalabilitas dan performa aplikasi.

Struktur pemisahan model dan halaman membantu meningkatkan keterbacaan kode serta memudahkan pengembangan lanjutan seperti integrasi database atau API.

---
