-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Nov 13, 2026 at 06:55 AM
-- Server version: 8.4.3
-- PHP Version: 8.3.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_simpak`
--

-- --------------------------------------------------------

--
-- Table structure for table `aset`
--

CREATE TABLE `aset` (
  `id_aset` int NOT NULL,
  `nama_aset` varchar(100) NOT NULL,
  `id_kategori` int DEFAULT NULL,
  `id_ruangan` int DEFAULT NULL,
  `lokasi` varchar(100) NOT NULL,
  `total_akumulasi_biaya` decimal(15,2) DEFAULT '0.00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `aset`
--

INSERT INTO `aset` (`id_aset`, `nama_aset`, `id_kategori`, `id_ruangan`, `lokasi`, `total_akumulasi_biaya`) VALUES
(1, 'AC Split 2 PK Lab Komputer 1', NULL, NULL, 'Gedung TI Lt. 2', 1700000.00),
(2, 'Proyektor Epson EB-X400 R. Teori A', NULL, NULL, 'Gedung Utama Lt. 1', 850000.00),
(3, 'PC Workstation Multimedia', NULL, NULL, 'Lab Desain Lt. 3', 750000.00);

-- --------------------------------------------------------

--
-- Table structure for table `detail_biaya_perbaikan`
--

CREATE TABLE `detail_biaya_perbaikan` (
  `id_detail` int NOT NULL,
  `id_perbaikan` int NOT NULL,
  `id_vendor` int DEFAULT NULL,
  `deskripsi_tindakan` varchar(255) NOT NULL,
  `biaya` decimal(15,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `detail_biaya_perbaikan`
--

INSERT INTO `detail_biaya_perbaikan` (`id_detail`, `id_perbaikan`, `id_vendor`, `deskripsi_tindakan`, `biaya`) VALUES
(1, 101, NULL, 'Isi Ulang Freon R32', 350000.00),
(2, 101, NULL, 'Cuci Evaporator & Penggantian Pipa', 150000.00),
(3, 102, NULL, 'Ganti Kompresor Baru', 1200000.00),
(4, 103, NULL, 'Ganti Lampu Proyektor Original', 850000.00),
(5, 104, NULL, 'Ganti Power Supply 650W Bronze', 750000.00);

-- --------------------------------------------------------

--
-- Table structure for table `gedung`
--

CREATE TABLE `gedung` (
  `id_gedung` int NOT NULL,
  `kode_gedung` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama_gedung` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `jumlah_lantai` int NOT NULL DEFAULT '1',
  `keterangan` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `kategori_aset`
--

CREATE TABLE `kategori_aset` (
  `id_kategori` int NOT NULL,
  `kode_kategori` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama_kategori` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Contoh: Elektronik & IT, Furnitur/Mebel, Fasilitas Ruang, Laboratorium',
  `deskripsi` text COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `laporan_perbaikan`
--

CREATE TABLE `laporan_perbaikan` (
  `id_perbaikan` int NOT NULL,
  `id_aset` int NOT NULL,
  `id_pelapor` int DEFAULT NULL,
  `tanggal_lapor` date NOT NULL,
  `status_perbaikan` varchar(30) DEFAULT 'Diproses'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `laporan_perbaikan`
--

INSERT INTO `laporan_perbaikan` (`id_perbaikan`, `id_aset`, `id_pelapor`, `tanggal_lapor`, `status_perbaikan`) VALUES
(101, 1, NULL, '2026-08-10', 'Selesai'),
(102, 1, NULL, '2026-10-15', 'Selesai'),
(103, 2, NULL, '2026-09-05', 'Selesai'),
(104, 3, NULL, '2026-10-20', 'Selesai');

-- --------------------------------------------------------

--
-- Table structure for table `pengguna`
--

CREATE TABLE `pengguna` (
  `id_pengguna` int NOT NULL,
  `nomor_induk` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'NIM Mahasiswa atau NIP/NIDN Dosen/Karyawan',
  `nama_lengkap` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `kata_sandi` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nomor_telepon` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_peran` int NOT NULL,
  `status_aktif` enum('Aktif','Nonaktif') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Aktif',
  `dibuat_pada` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `peran`
--

CREATE TABLE `peran` (
  `id_peran` int NOT NULL,
  `nama_peran` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Contoh: Admin Sarpras, Teknisi, Pelapor/Civitas, Pimpinan',
  `deskripsi` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ruangan`
--

CREATE TABLE `ruangan` (
  `id_ruangan` int NOT NULL,
  `id_gedung` int NOT NULL,
  `kode_ruangan` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama_ruangan` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Contoh: Lab Komputer 1, R. Kuliah 302, R. Dosen',
  `lantai` int NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `vendor`
--

CREATE TABLE `vendor` (
  `id_vendor` int NOT NULL,
  `nama_vendor` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `penanggung_jawab` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nomor_telepon` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `alamat` text COLLATE utf8mb4_unicode_ci,
  `jenis_layanan` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Contoh: Servis AC, Servis Komputer/Jaringan, Perbaikan Sipil'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `aset`
--
ALTER TABLE `aset`
  ADD PRIMARY KEY (`id_aset`),
  ADD KEY `fk_aset_kategori` (`id_kategori`),
  ADD KEY `fk_aset_ruangan` (`id_ruangan`);

--
-- Indexes for table `detail_biaya_perbaikan`
--
ALTER TABLE `detail_biaya_perbaikan`
  ADD PRIMARY KEY (`id_detail`),
  ADD KEY `id_perbaikan` (`id_perbaikan`),
  ADD KEY `fk_detail_vendor` (`id_vendor`);

--
-- Indexes for table `gedung`
--
ALTER TABLE `gedung`
  ADD PRIMARY KEY (`id_gedung`),
  ADD UNIQUE KEY `uq_kode_gedung` (`kode_gedung`);

--
-- Indexes for table `kategori_aset`
--
ALTER TABLE `kategori_aset`
  ADD PRIMARY KEY (`id_kategori`),
  ADD UNIQUE KEY `uq_kode_kategori` (`kode_kategori`);

--
-- Indexes for table `laporan_perbaikan`
--
ALTER TABLE `laporan_perbaikan`
  ADD PRIMARY KEY (`id_perbaikan`),
  ADD KEY `id_aset` (`id_aset`),
  ADD KEY `idx_tanggal_lapor` (`tanggal_lapor`),
  ADD KEY `fk_laporan_pengguna` (`id_pelapor`);

--
-- Indexes for table `pengguna`
--
ALTER TABLE `pengguna`
  ADD PRIMARY KEY (`id_pengguna`),
  ADD UNIQUE KEY `uq_nomor_induk` (`nomor_induk`),
  ADD UNIQUE KEY `uq_email` (`email`),
  ADD KEY `fk_pengguna_peran` (`id_peran`);

--
-- Indexes for table `peran`
--
ALTER TABLE `peran`
  ADD PRIMARY KEY (`id_peran`),
  ADD UNIQUE KEY `uq_nama_peran` (`nama_peran`);

--
-- Indexes for table `ruangan`
--
ALTER TABLE `ruangan`
  ADD PRIMARY KEY (`id_ruangan`),
  ADD UNIQUE KEY `uq_kode_ruangan` (`kode_ruangan`),
  ADD KEY `fk_ruangan_gedung` (`id_gedung`);

--
-- Indexes for table `vendor`
--
ALTER TABLE `vendor`
  ADD PRIMARY KEY (`id_vendor`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `gedung`
--
ALTER TABLE `gedung`
  MODIFY `id_gedung` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kategori_aset`
--
ALTER TABLE `kategori_aset`
  MODIFY `id_kategori` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pengguna`
--
ALTER TABLE `pengguna`
  MODIFY `id_pengguna` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `peran`
--
ALTER TABLE `peran`
  MODIFY `id_peran` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ruangan`
--
ALTER TABLE `ruangan`
  MODIFY `id_ruangan` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `vendor`
--
ALTER TABLE `vendor`
  MODIFY `id_vendor` int NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `aset`
--
ALTER TABLE `aset`
  ADD CONSTRAINT `fk_aset_kategori` FOREIGN KEY (`id_kategori`) REFERENCES `kategori_aset` (`id_kategori`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_aset_ruangan` FOREIGN KEY (`id_ruangan`) REFERENCES `ruangan` (`id_ruangan`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `detail_biaya_perbaikan`
--
ALTER TABLE `detail_biaya_perbaikan`
  ADD CONSTRAINT `detail_biaya_perbaikan_ibfk_1` FOREIGN KEY (`id_perbaikan`) REFERENCES `laporan_perbaikan` (`id_perbaikan`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_detail_laporan` FOREIGN KEY (`id_perbaikan`) REFERENCES `laporan_perbaikan` (`id_perbaikan`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_detail_vendor` FOREIGN KEY (`id_vendor`) REFERENCES `vendor` (`id_vendor`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `laporan_perbaikan`
--
ALTER TABLE `laporan_perbaikan`
  ADD CONSTRAINT `fk_laporan_pengguna` FOREIGN KEY (`id_pelapor`) REFERENCES `pengguna` (`id_pengguna`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `laporan_perbaikan_ibfk_1` FOREIGN KEY (`id_aset`) REFERENCES `aset` (`id_aset`) ON DELETE CASCADE;

--
-- Constraints for table `pengguna`
--
ALTER TABLE `pengguna`
  ADD CONSTRAINT `fk_pengguna_peran` FOREIGN KEY (`id_peran`) REFERENCES `peran` (`id_peran`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Constraints for table `ruangan`
--
ALTER TABLE `ruangan`
  ADD CONSTRAINT `fk_ruangan_gedung` FOREIGN KEY (`id_gedung`) REFERENCES `gedung` (`id_gedung`) ON DELETE RESTRICT ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
