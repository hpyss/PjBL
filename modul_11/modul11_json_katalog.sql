-- Modul 11: Implementasi fitur JSON pada MariaDB 10.4.32 (XAMPP)
-- Studi kasus: Katalog Produk dan Layanan Digital
-- Database: praktikum_modul11

CREATE DATABASE IF NOT EXISTS praktikum_modul11;
USE praktikum_modul11;

-- 1. Tabel
CREATE TABLE kategori (
    id_kategori INT AUTO_INCREMENT PRIMARY KEY,
    nama_kategori VARCHAR(100) NOT NULL UNIQUE
) ENGINE=InnoDB;

CREATE TABLE produk (
    id_produk INT AUTO_INCREMENT PRIMARY KEY,
    id_kategori INT NOT NULL,
    nama_produk VARCHAR(150) NOT NULL,
    harga DECIMAL(12,2) NOT NULL,
    spesifikasi JSON NOT NULL,
    CONSTRAINT fk_produk_kategori
        FOREIGN KEY (id_kategori)
        REFERENCES kategori(id_kategori)
) ENGINE=InnoDB;

-- 2. Penyimpanan data
INSERT INTO kategori (nama_kategori)
VALUES ('Laptop'), ('Smartphone'), ('Layanan Digital');

INSERT INTO produk (id_kategori, nama_produk, harga, spesifikasi) VALUES
(1, 'Laptop Pro', 8500000,
 '{"ram": "16GB", "storage": "512GB SSD", "prosesor": "Intel Core i7", "ukuran_layar": "14 inch"}'),
(2, 'Smartphone X', 4500000,
 '{"ram": "8GB", "storage": "256GB", "kamera": "50MP", "baterai": "5000mAh"}'),
(3, 'Paket Premium', 150000,
 '{"durasi": "30 hari", "jumlah_pengguna": 5, "fitur": ["Cloud Storage", "Backup", "Multi Device"]}');

SELECT * FROM kategori;
SELECT * FROM produk;

-- 3. Pembacaan atribut JSON
SELECT nama_produk, JSON_EXTRACT(spesifikasi, '$.ram') AS ram FROM produk;
SELECT nama_produk, JSON_EXTRACT(spesifikasi, '$.storage') AS kapasitas_storage FROM produk;
SELECT nama_produk, JSON_EXTRACT(spesifikasi, '$.baterai') AS kapasitas_baterai FROM produk;

-- 4. Pencarian berdasarkan atribut JSON
SELECT nama_produk, harga FROM produk
WHERE JSON_UNQUOTE(JSON_EXTRACT(spesifikasi, '$.ram')) = '16GB';

SELECT nama_produk, harga FROM produk
WHERE JSON_UNQUOTE(JSON_EXTRACT(spesifikasi, '$.storage')) = '256GB';

SELECT nama_produk FROM produk
WHERE JSON_CONTAINS(spesifikasi, '"Backup"', '$.fitur');

-- 5. Ubah atribut
UPDATE produk SET spesifikasi = JSON_SET(spesifikasi, '$.ram', '32GB')
WHERE nama_produk = 'Laptop Pro';

SELECT nama_produk, JSON_EXTRACT(spesifikasi, '$.ram') AS ram
FROM produk WHERE nama_produk = 'Laptop Pro';

-- 6. Tambah atribut
UPDATE produk SET spesifikasi = JSON_SET(spesifikasi, '$.warna', 'Silver')
WHERE nama_produk = 'Laptop Pro';

SELECT nama_produk, JSON_EXTRACT(spesifikasi, '$.warna') AS warna
FROM produk WHERE nama_produk = 'Laptop Pro';

-- 7. Hapus atribut
UPDATE produk SET spesifikasi = JSON_REMOVE(spesifikasi, '$.warna')
WHERE nama_produk = 'Laptop Pro';

SELECT nama_produk, JSON_EXTRACT(spesifikasi, '$.warna') AS warna
FROM produk WHERE nama_produk = 'Laptop Pro';

-- 8. Fungsi JSON lainnya
SELECT JSON_OBJECT('nama', 'Budi', 'umur', 21, 'status', 'Mahasiswa') AS data_mahasiswa;
SELECT JSON_ARRAY('MySQL', 'MariaDB', 'PostgreSQL') AS daftar_dbms;
SELECT nama_produk, JSON_LENGTH(spesifikasi) AS jumlah_atribut FROM produk;
