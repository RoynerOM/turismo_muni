<?php
header('Content-Type: application/json');
include 'db.php';
include 'auth.php';

// Verificar el token de autenticación
/*
$headers = getallheaders();
if (!isset($headers['Authorization']) || !verifyToken($headers['Authorization'])) {
    echo json_encode(["error" => "Unauthorized"]);
    exit();
}*/

// Crear un nuevo lodge
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $input = json_decode(file_get_contents('php://input'), true);
    
    $title = $input['title'] ?? '';
    $description = $input['description'] ?? '';
    $logo = $input['logo'] ?? '';

    if ($title === '' || $logo === '') {
        echo json_encode(["error" => "Title and Logo are required"]);
        exit();
    }

    $stmt = $pdo->prepare("INSERT INTO Lodges (title, description, logo) VALUES (?, ?, ?)");
    $stmt->execute([$title, $description, $logo]);
    
    $lastInsertedId = $pdo->lastInsertId();

    echo json_encode(["id" => $lastInsertedId]);
}

// Obtener todos los lodges
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    $stmt = $pdo->query("
    SELECT L.id AS lodge_id, L.title, L.description, L.logo, G.url AS image_url, G.footer, S.name AS service_name, I.name AS info_name, C.phone, C.page, C.email, C.place FROM Lodges L INNER JOIN Gallery G ON L.id = G.lodge_id INNER JOIN Services S ON L.id = S.lodge_id INNER JOIN Information I ON L.id = I.lodge_id INNER JOIN Contact C ON L.id = C.lodge_id ORDER BY L.id;
    ");
    $lodges = $stmt->fetchAll(PDO::FETCH_ASSOC);
    echo json_encode($lodges);
}

// Actualizar un lodge
if ($_SERVER['REQUEST_METHOD'] === 'PUT') {
    parse_str(file_get_contents("php://input"), $_PUT);
    $id = $_PUT['id'] ?? null;
    $title = $_PUT['title'] ?? null;
    $description = $_PUT['description'] ?? null;
    $logo = $_PUT['logo'] ?? null;

    if (!$id || !$title || !$logo) {
        echo json_encode(["error" => "ID, Title, and Logo are required"]);
        exit();
    }

    $stmt = $pdo->prepare("UPDATE Lodges SET title = ?, description = ?, logo = ? WHERE id = ?");
    $stmt->execute([$title, $description, $logo, $id]);
    echo json_encode(["message" => "Lodge updated successfully"]);
}

// Eliminar un lodge
if ($_SERVER['REQUEST_METHOD'] === 'PATCH') {
    parse_str(file_get_contents("php://input"), $_DELETE);
    $id = $_DELETE['id'] ?? null;

    if (!$id) {
        echo json_encode(["error" => "ID is required"]);
        exit();
    }

    $stmt = $pdo->prepare("DELETE FROM Lodges WHERE id = ?");
    $stmt->execute([$id]);
    echo json_encode(["message" => "Lodge deleted successfully"]);
}
