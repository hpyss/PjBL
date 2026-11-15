# Perbandingan DBMS (Modul 11)

DBMS praktikum: MariaDB 10.4.32 (mariadb.org binary distribution), storage engine default InnoDB.

| Aspek | MySQL/MariaDB (utama) | PostgreSQL (calon migrasi) | MongoDB (pembanding) |
| --- | --- | --- | --- |
| Model data | Relasional | Relasional, objek-relasional | Dokumen (BSON/JSON) |
| Bahasa query | SQL | SQL | MongoDB Query Language |
| Transaksi ACID | Ya, pada engine InnoDB | Ya, penuh | Ya, pada multi-document transaction |
| Dukungan JSON | Tipe JSON (MySQL native, MariaDB alias teks) | JSON dan JSONB dengan indeks | Dasar penyimpanan dokumen |
| Skema | Tetap | Tetap, bisa dilonggarkan dengan JSONB | Fleksibel |
| Skalabilitas | Replikasi, vertikal | Replikasi, vertikal, partisi | Sharding horizontal |
| Keamanan | GRANT/REVOKE, SSL | GRANT/REVOKE, row-level security | Role-based access control |
| Kelebihan | Ringan, mudah, banyak dipakai di web | Fitur SQL lengkap, ekstensibel | Atribut bervariasi, mudah di-scale |
| Keterbatasan | Fitur lanjutan lebih sedikit | Konfigurasi lebih rumit | JOIN dan integritas relasional lemah |
| Lingkup pengguna | Aplikasi web, sistem informasi | Sistem keuangan, analitik, GIS | Katalog, konten, aplikasi real-time |

## Matriks pemilihan DBMS untuk SIM-PAK

Skor 1 sampai 5 (5 = paling sesuai).

| Kriteria | MySQL/MariaDB | PostgreSQL | MongoDB |
| --- | --- | --- | --- |
| Jenis data | 5 | 5 | 3 |
| Konsistensi | 5 | 5 | 4 |
| Skalabilitas | 3 | 4 | 5 |
| Keamanan | 4 | 5 | 4 |
| Performa | 4 | 4 | 4 |
| Integrasi | 5 | 4 | 4 |
| Pemeliharaan | 4 | 4 | 3 |
| Biaya | 5 | 5 | 4 |
| **Total** | **35** | **36** | **31** |

Kesimpulan: MySQL/MariaDB dipilih untuk SIM-PAK karena sudah dipakai sepanjang praktikum, terpasang di XAMPP, dan semua kebutuhan sistem terpenuhi tanpa migrasi. PostgreSQL menjadi opsi migrasi bila sistem kelak butuh fitur lanjutan.
