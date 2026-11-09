-- =========================================================================
-- KUMPULAN SCRIPT SQL PRAKTIKUM BASIS DATA MODUL 10: DBMS DAN APLIKASI BASIS DATA
-- Nama  : Anisa Latifatul Rohma / Muhammad Amirul Hafidz / Sakhiya Azam Khoirunni’am 
-- NIM   : 264311035 / 264311048 / 264311058
-- Kelas : 1B - Teknologi Rekayasa Perangkat Lunak
-- =========================================================================

-- 1. PRE-TEST: CONTOH SCRIPT CREATE TABLE PELANGGAN & PESANAN
CREATE TABLE pelanggan (
    id_pelanggan INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nama_pelanggan VARCHAR(100) NOT NULL,
    email VARCHAR(120) NOT NULL UNIQUE
);

CREATE TABLE pesanan (
    id_pesanan INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_pelanggan INT UNSIGNED NOT NULL,
    CONSTRAINT fk_pesanan_pelanggan
    FOREIGN KEY (id_pelanggan)
    REFERENCES pelanggan(id_pelanggan)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
);

-- 2. PRE-TEST & POST-TEST: PENGUJIAN EXPLAIN PADA TABEL PESANAN
-- Sebelum indeks
EXPLAIN SELECT * FROM pesanan WHERE tanggal >= '2026-10-01';

-- Membuat indeks tanggal pada pesanan
CREATE INDEX idx_pesanan_tanggal ON pesanan(tanggal);

-- Setelah membuat indeks
EXPLAIN SELECT * FROM pesanan WHERE tanggal >= '2026-10-01';


-- =========================================================================
-- 3. POST-TEST: SKEMA BASIS DATA SIMPAK (Sistem Informasi Manajemen Pemeliharaan Aset Kampus)
-- =========================================================================

-- Membuat database
CREATE DATABASE IF NOT EXISTS db_simpak;
USE db_simpak;

-- A. Tabel Master / Induk: kategori_aset
CREATE TABLE kategori_aset (
    id_kategori INT AUTO_INCREMENT PRIMARY KEY,
    nama_kategori VARCHAR(100) NOT NULL,
    deskripsi TEXT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- B. Tabel Master / Induk: ruangan_lokasi
CREATE TABLE ruangan_lokasi (
    id_ruangan INT AUTO_INCREMENT PRIMARY KEY,
    kode_ruangan VARCHAR(50) NOT NULL,
    nama_ruangan VARCHAR(100) NOT NULL,
    lantai INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- C. Tabel Anak: aset (Menggunakan Foreign Key ke kategori_aset & ruangan_lokasi)
CREATE TABLE aset (
    kode_aset VARCHAR(50) PRIMARY KEY,
    id_kategori INT,
    id_ruangan INT,
    nama_aset VARCHAR(100) NOT NULL,
    kondisi ENUM('Baik', 'Rusak Ringan', 'Rusak Berat') DEFAULT 'Baik',
    CONSTRAINT fk_kategori FOREIGN KEY (id_kategori) REFERENCES kategori_aset(id_kategori) ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_ruangan FOREIGN KEY (id_ruangan) REFERENCES ruangan_lokasi(id_ruangan) ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- D. Tabel Transaksi: laporan_perbaikan
CREATE TABLE laporan_perbaikan (
    id_perbaikan INT NOT NULL,
    kode_aset VARCHAR(50) NOT NULL,
    tanggal_lapor DATE NOT NULL,
    status_perbaikan VARCHAR(30) DEFAULT 'Diproses',
    CONSTRAINT pk_laporan PRIMARY KEY (id_perbaikan),
    CONSTRAINT fk_laporan_aset FOREIGN KEY (kode_aset) 
    REFERENCES aset (kode_aset) 
    ON DELETE CASCADE 
    ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- E. Tabel Detail: detail_biaya_perbaikan
CREATE TABLE detail_biaya_perbaikan (
    id_detail INT NOT NULL,
    id_perbaikan INT NOT NULL,
    deskripsi_tindakan VARCHAR(255) NOT NULL,
    biaya DECIMAL(15,2) NOT NULL,
    CONSTRAINT pk_detail PRIMARY KEY (id_detail),
    CONSTRAINT fk_detail_laporan FOREIGN KEY (id_perbaikan) 
    REFERENCES laporan_perbaikan (id_perbaikan) 
    ON DELETE CASCADE 
    ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- =========================================================================
-- 4. OPERASI CRUD DAN PENGUJIAN INTEGRITAS
-- =========================================================================

-- A. CREATE (Menambahkan Data)
INSERT INTO kategori_aset (nama_kategori, deskripsi) VALUES ('Komputer', 'Perangkat PC dan Laptop Lab');
INSERT INTO ruangan_lokasi (kode_ruangan, nama_ruangan, lantai) VALUES ('LAB-01', 'Laboratorium RPL 1', 2);
INSERT INTO aset (kode_aset, id_kategori, id_ruangan, nama_aset, kondisi) 
VALUES ('PC-LAB01-01', 1, 1, 'PC Core i7 Unit 01', 'Baik');

INSERT INTO laporan_perbaikan (id_perbaikan, kode_aset, tanggal_lapor, status_perbaikan) 
VALUES (105, 'PC-LAB01-01', '2026-11-09', 'Diproses');

INSERT INTO detail_biaya_perbaikan (id_detail, id_perbaikan, deskripsi_tindakan, biaya) 
VALUES (6, 105, 'Penggantian Modul SFP 10G & Adaptor Power', 450000.00);

-- B. READ (Membaca Data dengan JOIN)
SELECT 
    a.kode_aset, 
    a.nama_aset, 
    k.nama_kategori, 
    r.nama_ruangan, 
    a.kondisi
FROM aset a
JOIN kategori_aset k ON a.id_kategori = k.id_kategori
JOIN ruangan_lokasi r ON a.id_ruangan = r.id_ruangan;

-- C. UPDATE (Memperbarui Data)
UPDATE aset
SET kondisi = 'Rusak Ringan'
WHERE kode_aset = 'PC-LAB01-01';

-- D. DELETE (Menghapus Data Uji)
DELETE FROM detail_biaya_perbaikan 
WHERE id_detail = 6;

-- E. UJI PELANGGARAN FOREIGN KEY (Akan menghasilkan Error #1452)
-- INSERT INTO aset (kode_aset, id_kategori, id_ruangan, nama_aset, kondisi) 
-- VALUES ('PC-X', 99, 1, 'Komputer Rusak', 'Baik');


-- =========================================================================
-- 5. PEMBUATAN INDEKS & ANALISIS EXPLAIN
-- =========================================================================

-- Membuat indeks pada tabel aset
CREATE INDEX idx_kategori ON aset(id_kategori);
CREATE INDEX idx_aset_lokasi ON aset(id_kategori, id_ruangan);
CREATE INDEX idx_tanggal_lapor ON laporan_perbaikan(tanggal_lapor);

-- Pengujian EXPLAIN sebelum/sesudah indeks
EXPLAIN SELECT a.kode_aset, a.nama_aset, k.nama_kategori 
FROM aset a 
JOIN kategori_aset k ON a.id_kategori = k.id_kategori 
WHERE a.id_kategori = 1;


-- =========================================================================
-- 6. DEMONSTRASI TRANSAKSI (COMMIT & ROLLBACK)
-- =========================================================================

-- Contoh Transaksi COMMIT (Berhasil & Disimpan Permanen)
START TRANSACTION;
UPDATE aset SET kondisi = 'Rusak Ringan' WHERE kode_aset = 'PC-LAB01-01';
COMMIT;

-- Contoh Transaksi ROLLBACK (Dibatalkan)
START TRANSACTION;
-- Misalkan terjadi kesalahan query / hapus tidak sengaja
DELETE FROM aset; 
-- Batalkan perubahan
ROLLBACK;
