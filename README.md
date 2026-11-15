# Repositori Proyek PjBL Praktik Basis Data & RKPL

Selamat datang di repositori resmi tugas praktikum mata kuliah **Praktik Basis Data** yang diintegrasikan dengan proyek mata kuliah **Rekayasa Kebutuhan Perangkat Lunak (RKPL)**.

---

## 👥 Tim Penyusun (Kelompok 5 - RKPL)
**Program Studi D4 Teknologi Rekayasa Perangkat Lunak — Politeknik Negeri Madiun**

| No. | Nama Mahasiswa | NIM | Peran / Fokus |
| :---: | :--- | :---: | :--- |
| 1 | **Anisa Latifatul Rohma** | 264311035 | Requirement & Database Analyst |
| 2 | **Muhammad Amirul Hafidz** | 264311048 | Database Administrator & Query Engineer |
| 3 | **Sakhiya Azam Khoirunni'am** | 264311058 | System & Technical Documentator |

- **Kelas:** 1B - D4 Teknologi Rekayasa Perangkat Lunak (TRPL)
- **Nama Proyek:** Sistem Informasi Manajemen Pemeliharaan Aset Kampus (**SIMPAK / SIM-PAK**)
- **Basis Data Utama:** `db_simpak` / `sim_pak_db` (MySQL 8.4 / MariaDB)

---

## 📁 Struktur Direktori Repositori

Repositori ini telah ditata secara modular ke dalam direktori terpisah untuk masing-masing modul tugas praktikum:

```text
PjBL/
├── modul_09/                     # Modul 09: Redundansi Data dan Denormalisasi
│   ├── modul9_denormalisasi_aset.sql
│   ├── 9.4 LEMBAR KERJA (POST-TEST).docx
│   ├── TUGAS UNJUK KERJA (PRAKTIKUM & PRESENTASI) Modul 9.docx
│   ├── 264311048_Muhammad Amirul Hafidz_modul 9 Redundasi dan Denormalisasi.docx
│   ├── screenshot_*.png
│   └── README.md
│
├── modul_10/                     # Modul 10: DBMS dan Aplikasi Basis Data
│   ├── modul10_script.sql
│   ├── 10.4 LEMBAR KERJA (PASCA UJI).docx
│   ├── 264311048_Muhammad Amirul Hafidz_Modul 10.docx
│   └── README.md
│
├── modul_11/                     # Modul 11: Perkembangan DBMS & Lingkup Penerapan
│   ├── db_simpak tambahan.sql
│   ├── modul11_json_katalog.sql
│   ├── modul11_json_simpak.sql
│   ├── perbandingan_dbms.md
│   ├── Modul 11.docx
│   └── README.md
│
└── README.md                     # Berkas dokumentasi utama repositori
```

---

## 📌 Ringkasan Modul Praktikum

### 1. [Modul 09: Redundansi Data dan Denormalisasi](./modul_09/)
Membahas teknik evaluasi redundansi terencana untuk meningkatkan efisiensi pembacaan data agregasi biaya pemeliharaan aset kampus tanpa mengorbankan integritas data.

### 2. [Modul 10: DBMS dan Aplikasi Basis Data](./modul_10/)
Membahas perancangan skema relasional, penegakan integritas referensial kunci asing (*Foreign Key Constraints*), serta pengujian transaksi operasional pada sistem aplikasi basis data.

### 3. [Modul 11: Perkembangan DBMS dan Lingkup Penerapan](./modul_11/)
Membahas studi komparatif DBMS (MySQL 8.4, PostgreSQL, MongoDB), analisis basis data berorientasi objek (OODBMS), implementasi tipe data semi-terstruktur native JSON pada tabel aset SIMPAK, dan evaluasi lingkup penerapan sistem.
