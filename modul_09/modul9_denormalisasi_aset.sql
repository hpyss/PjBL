-- ============================================================================
-- MODUL 9: REDUNDANSI DAN DENORMALISASI
-- KELOMPOK / PROYEK : SISTEM INFORMASI MANAJEMEN PERBAIKAN ASET KAMPUS
-- ============================================================================

-- ----------------------------------------------------------------------------
-- 0. PERSIAPAN DDL AWAL (3 Tabel Relasi) & DUMMY DATA
-- ----------------------------------------------------------------------------

DROP TABLE IF EXISTS detail_biaya_perbaikan;
DROP TABLE IF EXISTS laporan_perbaikan;
DROP TABLE IF EXISTS aset;

-- Tabel 1: Master Aset Kampus
CREATE TABLE aset (
    id_aset INT PRIMARY KEY,
    nama_aset VARCHAR(100) NOT NULL,
    lokasi VARCHAR(100) NOT NULL
);

-- Tabel 2: Tiket/Laporan Pengajuan Perbaikan
CREATE TABLE laporan_perbaikan (
    id_perbaikan INT PRIMARY KEY,
    id_aset INT NOT NULL,
    tanggal_lapor DATE NOT NULL,
    status_perbaikan VARCHAR(30) DEFAULT 'Diproses',
    FOREIGN KEY (id_aset) REFERENCES aset(id_aset) ON DELETE CASCADE
);

-- Tabel 3: Rincian Biaya & Tindakan Perbaikan
CREATE TABLE detail_biaya_perbaikan (
    id_detail INT PRIMARY KEY,
    id_perbaikan INT NOT NULL,
    deskripsi_tindakan VARCHAR(255) NOT NULL,
    biaya DECIMAL(15,2) NOT NULL,
    FOREIGN KEY (id_perbaikan) REFERENCES laporan_perbaikan(id_perbaikan) ON DELETE CASCADE
);

-- Memasukkan Data Fiktif/Dummy untuk Simulasi
INSERT INTO aset (id_aset, nama_aset, lokasi) VALUES
(1, 'AC Split 2 PK Lab Komputer 1', 'Gedung TI Lt. 2'),
(2, 'Proyektor Epson EB-X400 R. Teori A', 'Gedung Utama Lt. 1'),
(3, 'PC Workstation Multimedia', 'Lab Desain Lt. 3');

INSERT INTO laporan_perbaikan (id_perbaikan, id_aset, tanggal_lapor, status_perbaikan) VALUES
(101, 1, '2026-08-10', 'Selesai'),
(102, 1, '2026-10-15', 'Selesai'),
(103, 2, '2026-09-05', 'Selesai'),
(104, 3, '2026-10-20', 'Selesai');

INSERT INTO detail_biaya_perbaikan (id_detail, id_perbaikan, deskripsi_tindakan, biaya) VALUES
(1, 101, 'Isi Ulang Freon R32', 350000.00),
(2, 101, 'Cuci Evaporator & Penggantian Pipa', 150000.00),
(3, 102, 'Ganti Kompresor Baru', 1200000.00),
(4, 103, 'Ganti Lampu Proyektor Original', 850000.00),
(5, 104, 'Ganti Power Supply 650W Bronze', 750000.00);


-- ----------------------------------------------------------------------------
-- 1. TAHAP 1: EKSPLORASI JOIN (Kondisi Normalisasi Penuh)
-- Menghitung total biaya perbaikan per aset secara on-the-fly dengan 2 kali JOIN + SUM
-- ----------------------------------------------------------------------------
SELECT 
    a.id_aset,
    a.nama_aset,
    a.lokasi,
    COALESCE(SUM(db.biaya), 0) AS total_akumulasi_biaya
FROM aset a
JOIN laporan_perbaikan lp ON a.id_aset = lp.id_aset
JOIN detail_biaya_perbaikan db ON lp.id_perbaikan = db.id_perbaikan
GROUP BY a.id_aset, a.nama_aset, a.lokasi;


-- ----------------------------------------------------------------------------
-- 2. TAHAP 2: PENERAPAN DENORMALISASI
-- Menambahkan atribut turunan (redundansi sengaja) pada tabel master aset
-- ----------------------------------------------------------------------------

-- A. Menambahkan kolom baru 'total_biaya_perbaikan' pada tabel master 'aset'
ALTER TABLE aset 
ADD COLUMN total_biaya_perbaikan DECIMAL(15,2) DEFAULT 0;

-- B. Sinkronisasi/Update data awal kolom turunan dari hasil kalkulasi yang sudah ada
UPDATE aset a
SET total_biaya_perbaikan = (
    SELECT COALESCE(SUM(db.biaya), 0)
    FROM laporan_perbaikan lp
    JOIN detail_biaya_perbaikan db ON lp.id_perbaikan = db.id_perbaikan
    WHERE lp.id_aset = a.id_aset
);


-- ----------------------------------------------------------------------------
-- 3. TAHAP 3: PEMBUKTIAN (Menghindari Fungsi & JOIN dalam Query Baca)
-- Query baca yang cepat dan ringkas, sangat cocok untuk fitur Dashboard Aset Sarpras
-- ----------------------------------------------------------------------------
SELECT 
    id_aset,
    nama_aset,
    lokasi,
    total_biaya_perbaikan
FROM aset;
