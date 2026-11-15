-- Modul 11: Demonstrasi fitur JSON pada proyek SIM-PAK
-- Database: sim_pak_db (tabel aset: kode_aset, id_kategori, id_ruangan, nama_aset, kondisi)

USE sim_pak_db;

-- Tambah kolom JSON untuk spesifikasi aset
ALTER TABLE aset ADD COLUMN spesifikasi JSON NULL;

-- Isi spesifikasi (data contoh, atribut berbeda tiap jenis aset)
UPDATE aset SET spesifikasi = '{"prosesor": "Intel Core i7", "ram": "16GB", "storage": "512GB SSD"}' WHERE kode_aset = 'PC-LAB01-01';
UPDATE aset SET spesifikasi = '{"prosesor": "Intel Core i7", "ram": "16GB", "storage": "512GB SSD"}' WHERE kode_aset = 'PC-LAB01-02';
UPDATE aset SET spesifikasi = '{"bahan": "Kayu", "panjang": "120 cm", "lebar": "60 cm"}' WHERE kode_aset = 'MJ-R101-01';
UPDATE aset SET spesifikasi = '{"merk": "Epson", "lumens": 3500, "resolusi": "1080p"}' WHERE kode_aset = 'PRJ-R101-01';

SELECT * FROM aset;

-- Baca atribut (NULL bila aset tidak punya atribut itu)
SELECT nama_aset, JSON_EXTRACT(spesifikasi, '$.ram') AS ram FROM aset;

-- Cari aset dengan RAM 16GB
SELECT kode_aset, nama_aset FROM aset
WHERE JSON_UNQUOTE(JSON_EXTRACT(spesifikasi, '$.ram')) = '16GB';

-- Tambah atribut baru pada proyektor
UPDATE aset SET spesifikasi = JSON_SET(spesifikasi, '$.tahun_beli', 2023) WHERE kode_aset = 'PRJ-R101-01';
SELECT nama_aset, JSON_EXTRACT(spesifikasi, '$.tahun_beli') AS tahun_beli
FROM aset WHERE kode_aset = 'PRJ-R101-01';

-- Gabungan data relasional dan JSON
SELECT a.kode_aset, a.nama_aset, k.nama_kategori, a.kondisi, a.spesifikasi
FROM aset a
JOIN kategori_aset k ON a.id_kategori = k.id_kategori;

-- Untuk membatalkan perubahan struktur setelah demo:
-- ALTER TABLE aset DROP COLUMN spesifikasi;
