-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 27 Des 2024 pada 15.33
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `poli`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `daftar_poli`
--

CREATE TABLE `daftar_poli` (
  `id` int(11) NOT NULL,
  `id_pasien` int(11) DEFAULT NULL,
  `id_jadwal` int(11) NOT NULL,
  `keluhan` text NOT NULL,
  `no_antrian` int(11) NOT NULL,
  `status_periksa` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `daftar_poli`
--

INSERT INTO `daftar_poli` (`id`, `id_pasien`, `id_jadwal`, `keluhan`, `no_antrian`, `status_periksa`) VALUES
(33, 35, 5, 'test\r\n', 6, ''),
(36, 37, 5, 'sakit gigi pak', 2, ''),
(37, 36, 68, 'mual', 1, ''),
(38, 36, 65, 'sakit', 1, ''),
(39, 43, 65, 'Sakit kepala, meriang, mual dan badan terasa capek.', 2, ''),
(40, 36, 69, 'nyeri sendi', 1, ''),
(41, 36, 68, 'nyeri sendi dok', 2, ''),
(42, 36, 69, 'nyeri sendi dok', 2, ''),
(43, 36, 69, 'nyeri sendi', 3, ''),
(44, 48, 69, 'sakit gigi', 4, ''),
(45, 48, 69, 'nyeri sendi', 5, ''),
(46, 50, 69, 'kjbsdjfsjf', 6, ''),
(47, 50, 62, 'coba', 1, ''),
(48, 50, 62, 'coba lagi', 2, ''),
(49, 50, 62, 'dada sesak', 3, ''),
(50, 50, 72, 'gusi sakit dok', 1, '');

-- --------------------------------------------------------

--
-- Struktur dari tabel `detail_periksa`
--

CREATE TABLE `detail_periksa` (
  `id` int(11) NOT NULL,
  `id_periksa` int(11) NOT NULL,
  `id_obat` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `detail_periksa`
--

INSERT INTO `detail_periksa` (`id`, `id_periksa`, `id_obat`) VALUES
(16, 14, 10),
(17, 14, 21),
(18, 15, 10),
(19, 15, 15),
(20, 15, 16),
(21, 16, 3),
(22, 18, 10),
(23, 19, 2),
(24, 19, 3),
(25, 20, 14),
(26, 20, 15),
(27, 20, 17),
(28, 21, 13),
(29, 21, 15);

-- --------------------------------------------------------

--
-- Struktur dari tabel `dokter`
--

CREATE TABLE `dokter` (
  `id` int(11) NOT NULL,
  `nama_dokter` varchar(255) NOT NULL,
  `alamat` varchar(255) NOT NULL,
  `no_hp` varchar(50) NOT NULL,
  `id_poli` int(11) NOT NULL,
  `nip` varchar(50) NOT NULL,
  `sandi_dokter` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `dokter`
--

INSERT INTO `dokter` (`id`, `nama_dokter`, `alamat`, `no_hp`, `id_poli`, `nip`, `sandi_dokter`) VALUES
(12, 'dokter1', 'dokter1', '1111111111111', 6, '1', '$2y$10$49nBrKsf0x8kg9WS8mwiK.Y.Lv9oNBHnIiJYErlhYv62OCjjeBqFS'),
(21, 'dr. Muhammad Shohibul Afiq Sp. PD', 'Pati', '082133896005', 16, '0834234823', '$2y$10$BhQcX8NDsfovfxkSozsXKuknckhNN064absErp/IqqsP2oYxI8Bhe'),
(23, 'Dr. Shohibul Najib', 'Ungaran', '082133899898', 14, '33188', '$2y$10$7lO5s7HD1PhaqxOJ93FEFepEhYK/XhcA2TtVBxI7HYDMTGoIgaHqe'),
(24, 'Dr. Tirta', 'Tegal', '08912392124', 6, '0123', '$2y$10$m7zkK0z3H.H5kiNMw.Huo.biScTFTrpeNpncbSt/6Y9X3LPt1/jCa');

-- --------------------------------------------------------

--
-- Struktur dari tabel `jadwal_periksa`
--

CREATE TABLE `jadwal_periksa` (
  `id` int(11) NOT NULL,
  `id_dokter` int(11) NOT NULL,
  `hari` enum('Senin','Selasa','Rabu','Kamis','Jumat','Sabtu') NOT NULL,
  `jam_mulai` time NOT NULL,
  `jam_selesai` time NOT NULL,
  `status` enum('aktif','nonaktif') DEFAULT 'nonaktif'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `jadwal_periksa`
--

INSERT INTO `jadwal_periksa` (`id`, `id_dokter`, `hari`, `jam_mulai`, `jam_selesai`, `status`) VALUES
(5, 12, 'Senin', '07:00:00', '17:47:00', 'nonaktif'),
(62, 21, 'Senin', '09:00:00', '15:00:00', 'aktif'),
(65, 21, 'Rabu', '07:00:00', '10:00:00', 'nonaktif'),
(67, 21, 'Kamis', '12:30:00', '17:00:00', 'nonaktif'),
(68, 21, 'Jumat', '13:00:00', '18:00:00', 'nonaktif'),
(69, 23, 'Senin', '12:00:00', '17:00:00', 'nonaktif'),
(70, 23, 'Selasa', '07:30:00', '11:30:00', 'nonaktif'),
(72, 24, 'Jumat', '12:00:00', '16:00:00', 'aktif'),
(73, 24, 'Selasa', '08:00:00', '12:00:00', 'nonaktif');

-- --------------------------------------------------------

--
-- Struktur dari tabel `obat`
--

CREATE TABLE `obat` (
  `id` int(11) NOT NULL,
  `nama_obat` varchar(100) NOT NULL,
  `kemasan` varchar(50) NOT NULL,
  `harga` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `obat`
--

INSERT INTO `obat` (`id`, `nama_obat`, `kemasan`, `harga`) VALUES
(1, 'Bodrex', 'Tablet', 6000),
(2, 'OBH', 'Syrup', 12000),
(3, 'Vitamin', 'Tablet', 12000),
(10, 'Paracetamol', 'Tablet 500 mg', 5000),
(11, 'Amoxicillin', 'Kapsul 500 mg', 15000),
(12, 'Cefadroxil', 'Sirup 125 mg/5 ml', 25000),
(13, 'Ibuprofen', 'Tablet 200 mg', 10000),
(14, 'Cetirizine', 'Tablet 10 mg', 8000),
(15, 'Omeprazole', 'Kapsul 20 mg', 20000),
(16, 'Metformin', 'Tablet 500 mg', 12000),
(17, 'Amlodipine', 'Tablet 5 mg', 15000),
(18, 'Captopril', 'Tablet 25 mg', 5000),
(19, 'Ranitidine', 'Tablet 150 mg', 7000),
(20, 'Salbutamol', 'Sirup 2 mg/5 ml', 18000),
(21, 'Dexamethasone', 'Tablet 0.5 mg', 3000),
(22, 'Chlorpheniramine', 'Tablet 4 mg', 2500),
(23, 'Hydrocortisone', 'Salep 2.5%', 20000),
(24, 'Ketoconazole', 'Shampoo 2%', 30000);

-- --------------------------------------------------------

--
-- Struktur dari tabel `pasien`
--

CREATE TABLE `pasien` (
  `id` int(11) NOT NULL,
  `nama_pasien` varchar(255) NOT NULL,
  `alamat` varchar(255) NOT NULL,
  `no_ktp` varchar(255) NOT NULL,
  `no_hp` varchar(50) NOT NULL,
  `no_rm` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `pasien`
--

INSERT INTO `pasien` (`id`, `nama_pasien`, `alamat`, `no_ktp`, `no_hp`, `no_rm`) VALUES
(35, 'Test', 'Test', '00', '00', '20240133'),
(36, 'pram', 'slawi', '0982304892432', '089324984323', '20241236'),
(37, 'pram', 'slawi', '098238499234234', '09238498233', '20241237'),
(38, 'sapik', 'pati', '892349298923423', '0812234972', '20241238'),
(39, 'santi', 'semarang', '98237897439792', '0833823422', '20241239'),
(40, 'dika', 'batang', '09234890802423', '02349824233', '20241240'),
(42, 'joko', 'pati', '12345', '0829384988', '202412130001'),
(43, 'Sinta', 'Semarang', '9822739424992348', '08523424245', '20241243'),
(44, 'adit', 'semarang', '3318', '08981231234', '20241244'),
(45, 'rendra', 'pati', '112233', '982349234', '20241245'),
(46, 'check', 'asda', '3312', '081', '20241246'),
(47, 'test', 'semarang', '122', '038499234', '20241247'),
(48, 'test1', 'semarang', '0011', '082348732', '20241248'),
(49, 'testi', 'semarang', '0122333', '08239489', '20241249'),
(50, 'coba', 'sambirejo', '000111', '082133389', '20241250');

-- --------------------------------------------------------

--
-- Struktur dari tabel `periksa`
--

CREATE TABLE `periksa` (
  `id` int(11) NOT NULL,
  `id_daftar_poli` int(11) NOT NULL,
  `tgl_periksa` datetime NOT NULL,
  `catatan` text NOT NULL,
  `biaya_periksa` int(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `periksa`
--

INSERT INTO `periksa` (`id`, `id_daftar_poli`, `tgl_periksa`, `catatan`, `biaya_periksa`) VALUES
(14, 37, '2024-12-12 00:00:00', 'tolong perbaiki pola tidur, dan pola makannya', 158000),
(15, 45, '2024-12-27 00:00:00', 'kurangi makanan yang mengandung minyak goreng berlebih', 187000),
(16, 45, '2024-12-27 00:00:00', 'kurangi makanan yang mengandung minyak goreng berlebih, sering olahraga pada pagi hari.', 162000),
(17, 45, '2024-12-27 00:00:00', 'kurangi makanan yang mengandung minyak goreng berlebih, sering lakukan olahraga.', 150000),
(18, 40, '2024-12-27 00:00:00', 'kjhasdhad', 155000),
(19, 49, '2024-12-27 00:00:00', 'jangan merokok teruuuussss', 174000),
(20, 46, '2024-12-27 00:00:00', 'check', 193000),
(21, 46, '2024-12-27 00:00:00', 'check', 180000);

-- --------------------------------------------------------

--
-- Struktur dari tabel `poli`
--

CREATE TABLE `poli` (
  `id` int(11) NOT NULL,
  `nama_poli` varchar(25) NOT NULL,
  `keterangan` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `poli`
--

INSERT INTO `poli` (`id`, `nama_poli`, `keterangan`) VALUES
(6, 'poli THT', 'Telinga Hidung Dan Tenggorokan'),
(13, 'Poli Umum', 'Pelayanan kesehatan umum untuk pasien.'),
(14, 'Poli Gigi', 'Pelayanan kesehatan gigi dan mulut.'),
(15, 'Poli Anak', 'Pelayanan kesehatan khusus untuk anak-anak.'),
(16, 'Poli Penyakit Dalam', 'Pelayanan untuk penyakit dalam seperti diabetes dan hipertensi.'),
(17, 'Poli Kesehatan Ibu', 'Pelayanan kesehatan untuk ibu hamil dan menyusui.');

-- --------------------------------------------------------

--
-- Struktur dari tabel `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `username` varchar(50) NOT NULL,
  `sandi_adm` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `user`
--

INSERT INTO `user` (`id`, `nama`, `username`, `sandi_adm`) VALUES
(2, '', 'admin', '$2y$10$4OtDb/8H9JuEvxPcLqnWt.g.uUSpupJGJkU7WUGoiTQbKinxtUkmS'),
(6, '', 'apiq', '$2y$10$fE3j80L9trKcxYRO6HnJEOraKjt2Z0xuuvc.bYtLpG32kMMAKdKyu'),
(7, '', 'admin3', '$2y$10$Ft43AF7Nx3uh2DtOdlQMRuBYzI6JXTWt9Exo9YzyYNeyokuwr4Cai');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `daftar_poli`
--
ALTER TABLE `daftar_poli`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_jadwal` (`id_jadwal`),
  ADD KEY `daftar_poli_ibfk_1` (`id_pasien`);

--
-- Indeks untuk tabel `detail_periksa`
--
ALTER TABLE `detail_periksa`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_detail_periksa_obat` (`id_obat`),
  ADD KEY `id_periksa` (`id_periksa`);

--
-- Indeks untuk tabel `dokter`
--
ALTER TABLE `dokter`
  ADD PRIMARY KEY (`id`),
  ADD KEY `dokter_ibfk_1` (`id_poli`);

--
-- Indeks untuk tabel `jadwal_periksa`
--
ALTER TABLE `jadwal_periksa`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_dokter` (`id_dokter`);

--
-- Indeks untuk tabel `obat`
--
ALTER TABLE `obat`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `pasien`
--
ALTER TABLE `pasien`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `periksa`
--
ALTER TABLE `periksa`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_daftar_poli` (`id_daftar_poli`);

--
-- Indeks untuk tabel `poli`
--
ALTER TABLE `poli`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `daftar_poli`
--
ALTER TABLE `daftar_poli`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT untuk tabel `detail_periksa`
--
ALTER TABLE `detail_periksa`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT untuk tabel `dokter`
--
ALTER TABLE `dokter`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT untuk tabel `jadwal_periksa`
--
ALTER TABLE `jadwal_periksa`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=74;

--
-- AUTO_INCREMENT untuk tabel `obat`
--
ALTER TABLE `obat`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT untuk tabel `pasien`
--
ALTER TABLE `pasien`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT untuk tabel `periksa`
--
ALTER TABLE `periksa`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT untuk tabel `poli`
--
ALTER TABLE `poli`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT untuk tabel `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `daftar_poli`
--
ALTER TABLE `daftar_poli`
  ADD CONSTRAINT `daftar_poli_ibfk_1` FOREIGN KEY (`id_pasien`) REFERENCES `pasien` (`id`),
  ADD CONSTRAINT `daftar_poli_ibfk_2` FOREIGN KEY (`id_jadwal`) REFERENCES `jadwal_periksa` (`id`);

--
-- Ketidakleluasaan untuk tabel `detail_periksa`
--
ALTER TABLE `detail_periksa`
  ADD CONSTRAINT `detail_periksa_ibfk_1` FOREIGN KEY (`id_periksa`) REFERENCES `periksa` (`id`),
  ADD CONSTRAINT `fk_detail_periksa_obat` FOREIGN KEY (`id_obat`) REFERENCES `obat` (`id`);

--
-- Ketidakleluasaan untuk tabel `dokter`
--
ALTER TABLE `dokter`
  ADD CONSTRAINT `dokter_ibfk_1` FOREIGN KEY (`id_poli`) REFERENCES `poli` (`id`);

--
-- Ketidakleluasaan untuk tabel `jadwal_periksa`
--
ALTER TABLE `jadwal_periksa`
  ADD CONSTRAINT `jadwal_periksa_ibfk_1` FOREIGN KEY (`id_dokter`) REFERENCES `dokter` (`id`);

--
-- Ketidakleluasaan untuk tabel `periksa`
--
ALTER TABLE `periksa`
  ADD CONSTRAINT `periksa_ibfk_1` FOREIGN KEY (`id_daftar_poli`) REFERENCES `daftar_poli` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
