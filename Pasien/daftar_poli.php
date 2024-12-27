<?php
if (!isset($_SESSION)) {
    session_start();
}
if (!isset($_SESSION['nama_pasien'])) {
    header("Location: index.php?page=loginPasien");
    exit;
}

// Menyimpan poli yang dipilih
$poli_terpilih = isset($_GET['poli']) ? $_GET['poli'] : '';
?>

<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Daftar Poli Poliklinik</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .mycare-sidebar {
            height: 100vh;
            position: fixed;
            top: 0;
            left: 0;
            width: 250px;
            padding-top: 15px;
            background-color: #0171f9;
            color: #fff;
            transition: all 0.3s;
            z-index: 1;
            overflow-x: hidden;
            box-shadow: 0px 2px 10px rgba(0, 0, 0, 0.1);
        }

        .mycare-sidebar a {
            padding: 15px;
            text-decoration: none;
            font-size: 1.2rem;
            color: #fff;
            display: block;
            transition: padding 0.3s;
        }

        .mycare-sidebar a:hover {
            padding-left: 20px;
            background-color: #0c8ff7;
        }

        .mycare-sidebar .navbar-brand {
            font-size: 1.8rem;
            color: #fff;
            font-weight: bold;
            margin-bottom: 20px;
        }

        .mycare-dropdown-content {
            display: none;
            background-color: #3a5795;
            min-width: 160px;
            box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
            z-index: 1;
            position: absolute;
        }

        .mycare-dropdown-content a {
            padding: 12px 16px;
            display: block;
            color: #fff;
            text-decoration: none;
        }

        .mycare-dropdown-content a:hover {
            background-color: #3a5795;
        }

        .mycare-dropdown:hover .mycare-dropdown-content {
            display: block;
        }

        .mycare-content {
            margin-left: 250px;
            padding: 20px;
            transition: margin-left 0.3s;
        }

        @media (max-width: 768px) {
            .mycare-sidebar {
                left: -250px;
            }

            .mycare-content {
                margin-left: 0;
            }
        }
    </style>
</head>

<body>
    <!-- Sidebar/Navbar -->
    <div class="mycare-sidebar">
        <a class="navbar-brand" href="../index.php">My Care</a>
        <a href="index.php"><i class="fas fa-home"></i> Home</a>
        <?php if (isset($_SESSION['nama_pasien'])) { ?>
            <a href="daftar_poli.php"><i class="fas fa-user-md"></i> Mendaftar ke Poli</a>
            <a href="Logout.php"><i class="fas fa-sign-out-alt"></i> Logout (<?php echo $_SESSION['nama_pasien'] ?>)</a>
        <?php } else { ?>
            <a href="index.php?page=loginPasien"><i class="fas fa-sign-in-alt"></i> Login</a>
            <a href="index.php?page=registerPasien"><i class="fas fa-user-plus"></i> Registrasi Pasien</a>
        <?php } ?>
    </div>

    <!-- Content -->
    <div class="mycare-content">
        <div class="container mt-5">
            <h2>Daftar Poli Poliklinik</h2>

            <!-- Dropdown untuk memilih Poli -->
            <form method="GET" action="daftar_poli.php">
                <div class="mb-3">
                    <label for="poli" class="form-label">Pilih Poli:</label>
                    <select class="form-select" id="poli" name="poli" onchange="this.form.submit()">
                        <option value="">-- Pilih Poli --</option>
                        <?php
                        $mysqli = new mysqli("localhost", "root", "", "poli");

                        if ($mysqli->connect_error) {
                            die("Koneksi database gagal: " . $mysqli->connect_error);
                        }

                        // Mengambil daftar poli dari database
                        $query_poli = "SELECT * FROM poli";
                        $result_poli = $mysqli->query($query_poli);

                        while ($poli = $result_poli->fetch_assoc()) {
                            $selected = ($poli_terpilih == $poli['nama_poli']) ? "selected" : "";
                            echo "<option value='" . $poli['nama_poli'] . "' $selected>" . htmlspecialchars($poli['nama_poli']) . "</option>";
                        }
                        ?>
                    </select>
                </div>
            </form>

            <!-- Tabel Jadwal Dokter -->
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th scope="col">No.</th>
                        <th scope="col">Nama Dokter</th>
                        <th scope="col">Hari</th>
                        <th scope="col">Jam Mulai</th>
                        <th scope="col">Jam Selesai</th>
                        <th scope="col">Daftar</th>
                    </tr>
                </thead>
                <tbody>
                    <?php
                    // Jika poli dipilih, tampilkan jadwal dokter sesuai poli
                    if ($poli_terpilih) {
                        $query = "SELECT jp.*, d.nama_dokter
                                  FROM jadwal_periksa jp
                                  INNER JOIN dokter d ON jp.id_dokter = d.id
                                  INNER JOIN poli p ON d.id_poli = p.id
                                  WHERE p.nama_poli = ? AND jp.status = 'Aktif'";

                        $stmt = $mysqli->prepare($query);
                        $stmt->bind_param("s", $poli_terpilih);
                        $stmt->execute();
                        $result = $stmt->get_result();

                        if ($result->num_rows > 0) {
                            $count = 1;
                            while ($row = $result->fetch_assoc()) {
                                echo "<tr>";
                                echo "<td>" . $count . "</td>";
                                echo "<td>" . htmlspecialchars($row['nama_dokter']) . "</td>";
                                echo "<td>" . htmlspecialchars($row['hari']) . "</td>";
                                echo "<td>" . htmlspecialchars($row['jam_mulai']) . "</td>";
                                echo "<td>" . htmlspecialchars($row['jam_selesai']) . "</td>";

                                // Tombol Daftar
                                echo "<td><a href='proses_form_keluhan.php?id_jadwal=" . $row['id'] . "&id_pasien=" . (isset($_SESSION['id_pasien']) ? $_SESSION['id_pasien'] : '') . "' class='btn btn-primary'>Daftar</a></td>";
                                echo "</tr>";
                                $count++;
                            }
                        } else {
                            echo "<tr><td colspan='6'>Tidak ada jadwal untuk poli ini.</td></tr>";
                        }
                        $stmt->close();
                    } else {
                        echo "<tr><td colspan='6'>Silakan pilih poli terlebih dahulu.</td></tr>";
                    }

                    $mysqli->close();
                    ?>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>
