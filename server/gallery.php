<?php
header('Content-Type: application/json');
include 'db.php';
include 'auth.php';
/*
// Verificar el token de autenticación
$headers = getallheaders();
if (!isset($headers['Authorization']) || !verifyToken($headers['Authorization'])) {
    echo json_encode(["error" => "Unauthorized"]);
    exit();
}
*/
// Crear una nueva imagen
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $input = json_decode(file_get_contents('php://input'), true);

    $lodge_id = $input['lodge_id'] ?? '';
    $url = $input['url'] ?? '';
    $footer = $input['footer'] ?? '';

    if ($lodge_id === '' || $url === '') {
        echo json_encode(["error" => "Lodge ID and URL are required"]);
        exit();
    }

    $stmt = $pdo->prepare("INSERT INTO Gallery (lodge_id, url, footer) VALUES (?, ?, ?)");
    $stmt->execute([$lodge_id, $url, $footer]);
    echo json_encode(["message" => "Image created successfully"]);
}

// Obtener todas las imágenes
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    $lodge_id = $_GET['lodge_id'] ?? null;
    $query = "SELECT * FROM Gallery";
    if ($lodge_id) {
        $query .= " WHERE lodge_id = ?";
        $stmt = $pdo->prepare($query);
        $stmt->execute([$lodge_id]);
    } else {
        $stmt = $pdo->query($query);
    }
    $images = $stmt->fetchAll(PDO::FETCH_ASSOC);
    echo json_encode($images);
}

// Actualizar una imagen
if ($_SERVER['REQUEST_METHOD'] === 'PUT') {
    parse_str(file_get_contents("php://input"), $_PUT);
    $id = $_PUT['id'] ?? null;
    $lodge_id = $_PUT['lodge_id'] ?? null;
    $url = $_PUT['url'] ?? null;
    $footer = $_PUT['footer'] ?? null;

    if (!$id || !$lodge_id || !$url) {
        echo json_encode(["error" => "ID, Lodge ID, and URL are required"]);
        exit();
    }

    $stmt = $pdo->prepare("UPDATE Gallery SET lodge_id = ?, url = ?, footer = ? WHERE id = ?");
    $stmt->execute([$lodge_id, $url, $footer, $id]);
    echo json_encode(["message" => "Image updated successfully"]);
}

// Eliminar una imagen
if ($_SERVER['REQUEST_METHOD'] === 'DELETE') {
    parse_str(file_get_contents("php://input"), $_DELETE);
    $id = $_DELETE['id'] ?? null;

    if (!$id) {
        echo json_encode(["error" => "ID is required"]);
        exit();
    }

    $stmt = $pdo->prepare("DELETE FROM Gallery WHERE id = ?");
    $stmt->execute([$id]);
    echo json_encode(["message" => "Image deleted successfully"]);
}
?>
