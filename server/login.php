<?php
header('Content-Type: application/json');
include 'auth.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $username = $_POST['username'] ?? '';
    $password = $_POST['password'] ?? '';

    $token = login($username, $password);
    if ($token) {
        echo json_encode(["token" => $token]);
    } else {
        echo json_encode(["error" => "Invalid credentials"]);
    }
}
?>
