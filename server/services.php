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

// Crear un nuevo servicio
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $input = json_decode(file_get_contents('php://input'), true);
    $lodge_id = $_POST['lodge_id'] ?? '';
    $name = $_POST['name'] ?? '';

    if ($service === '') {
        echo json_encode(["error" => "Service is required"]);
        exit();
    }

    $stmt = $pdo->prepare("INSERT INTO Services (name,lodge_id) VALUES (?,?)");
    $stmt->execute([$name,$lodge_id]);
    echo json_encode(["message" => "Service created successfully"]);
}

// Obtener todos los servicios
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    $stmt = $pdo->query("SELECT * FROM Services");
    $services = $stmt->fetchAll(PDO::FETCH_ASSOC);
    echo json_encode($services);
}

// Actualizar un servicio
if ($_SERVER['REQUEST_METHOD'] === 'PUT') {
    parse_str(file_get_contents("php://input"), $_PUT);
    $id = $_PUT['id'] ?? null;
    $service = $_PUT['service'] ?? null;

    if (!$id || !$service) {
        echo json_encode(["error" => "ID and Service are required"]);
        exit();
    }

    $stmt = $pdo->prepare("UPDATE Services SET service = ? WHERE id = ?");
    $stmt->execute([$service, $id]);
    echo json_encode(["message" => "Service updated successfully"]);
}

// Eliminar un servicio
if ($_SERVER['REQUEST_METHOD'] === 'DELETE') {
    parse_str(file_get_contents("php://input"), $_DELETE);
    $id = $_DELETE['id'] ?? null;

    if (!$id) {
        echo json_encode(["error" => "ID is required"]);
        exit();
    }

    $stmt = $pdo->prepare("DELETE FROM Services WHERE id = ?");
    $stmt->execute([$id]);
    echo json_encode(["message" => "Service deleted successfully"]);
}
?>
