<?php
if (!isset($_SESSION)) {
    session_start();
}

include_once("../koneksi.php");

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $id = $_POST['id'];

    if (isset($_POST['aktifkan'])) {
        // Dapatkan id_dokter berdasarkan id jadwal
        $query_get_jadwal = "SELECT id_dokter FROM jadwal_periksa WHERE id = '$id'";
        $result_get_jadwal = $mysqli->query($query_get_jadwal);

        if ($result_get_jadwal && $result_get_jadwal->num_rows > 0) {
            $jadwal = $result_get_jadwal->fetch_assoc();
            $id_dokter = $jadwal['id_dokter'];

            // Nonaktifkan semua jadwal milik dokter ini
            $query_update = "UPDATE jadwal_periksa SET status = 'nonaktif' WHERE id_dokter = '$id_dokter'";
            $mysqli->query($query_update);

            // Aktifkan jadwal ini
            $query_aktifkan = "UPDATE jadwal_periksa SET status = 'aktif' WHERE id = '$id'";
            if ($mysqli->query($query_aktifkan)) {
                echo '<script>alert("Jadwal berhasil diaktifkan.");</script>';
            } else {
                echo '<script>alert("Error: ' . $mysqli->error . '");</script>';
            }
        }
    } elseif (isset($_POST['nonaktifkan'])) {
        // Nonaktifkan jadwal
        $query_nonaktifkan = "UPDATE jadwal_periksa SET status = 'nonaktif' WHERE id = '$id'";
        if ($mysqli->query($query_nonaktifkan)) {
            echo '<script>alert("Jadwal berhasil dinonaktifkan.");</script>';
        } else {
            echo '<script>alert("Error: ' . $mysqli->error . '");</script>';
        }
    }
}

// Redirect kembali ke halaman jadwal_periksa
header("Location: atur_jadwal.php");
exit();
?>
