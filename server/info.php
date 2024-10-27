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
}*/

// Crear una nueva información
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $input = json_decode(file_get_contents('php://input'), true);
    $name = $input['name'] ?? '';
    $lodge_id = $input['lodge_id'] ?? '';

    if ($name === '') {
        echo json_encode(["error" => "Information is required"]);
        exit();
    }

    $stmt = $pdo->prepare("INSERT INTO Information (name,lodge_id) VALUES (?,?)");
    $stmt->execute([$name,$lodge_id]);
    
    echo json_encode(["message" => "Information created successfully"]);
}

// Obtener todas las Information
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    $stmt = $pdo->query("SELECT * FROM Information");
    $informations = $stmt->fetchAll(PDO::FETCH_ASSOC);
    echo json_encode($informations);
}

// Actualizar una información
if ($_SERVER['REQUEST_METHOD'] === 'PUT') {
    parse_str(file_get_contents("php://input"), $_PUT);
    $id = $_PUT['id'] ?? null;
    $information = $_PUT['information'] ?? null;

    if (!$id || !$information) {
        echo json_encode(["error" => "ID and Information are required"]);
        exit();
    }

    $stmt = $pdo->prepare("UPDATE Information SET information = ? WHERE id = ?");
    $stmt->execute([$information, $id]);
    echo json_encode(["message" => "Information updated successfully"]);
}

// Eliminar una información
if ($_SERVER['REQUEST_METHOD'] === 'DELETE') {
    parse_str(file_get_contents("php://input"), $_DELETE);
    $id = $_DELETE['id'] ?? null;

    if (!$id) {
        echo json_encode(["error" => "ID is required"]);
        exit();
    }

    $stmt = $pdo->prepare("DELETE FROM Information WHERE id = ?");
    $stmt->execute([$id]);
    echo json_encode(["message" => "Information deleted successfully"]);
}
?>
