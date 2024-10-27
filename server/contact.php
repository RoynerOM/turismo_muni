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
// Crear un nuevo contacto
if ($_SERVER['REQUEST_METHOD'] === 'POST') {

    $input = json_decode(file_get_contents('php://input'), true);
    $lodge_id = $input['lodge_id'] ?? '';
    $phone = $input['phone'] ?? '';
    $page = $input['page'] ?? '';
    $email = $input['email'] ?? '';
    $place = $input['place'] ?? '';

    if ($phone === '') {
        echo json_encode(["error" => "Phone is required"]);
        exit();
    }

    $stmt = $pdo->prepare("INSERT INTO Contact (phone, page, email, place,lodge_id) VALUES (?, ?, ?, ?,?)");
    $stmt->execute([$phone, $page, $email, $place, $lodge_id]);
    echo json_encode(["message" => "Contact created successfully"]);
}

// Obtener todos los contactos
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    $stmt = $pdo->query("SELECT * FROM Contact");
    $contactos = $stmt->fetchAll(PDO::FETCH_ASSOC);
    echo json_encode($contactos);
}

// Actualizar un contacto
if ($_SERVER['REQUEST_METHOD'] === 'PUT') {
    parse_str(file_get_contents("php://input"), $_PUT);
    $id = $_PUT['id'] ?? null;
    $phone = $_PUT['phone'] ?? null;
    $page = $_PUT['page'] ?? null;
    $email = $_PUT['email'] ?? null;
    $place = $_PUT['place'] ?? null;

    if (!$id || !$phone) {
        echo json_encode(["error" => "ID and Phone are required"]);
        exit();
    }

    $stmt = $pdo->prepare("UPDATE Contact SET phone = ?, page = ?, email = ?, place = ? WHERE id = ?");
    $stmt->execute([$phone, $page, $email, $place, $id]);
    echo json_encode(["message" => "Contact updated successfully"]);
}

// Eliminar un contacto
if ($_SERVER['REQUEST_METHOD'] === 'DELETE') {
    parse_str(file_get_contents("php://input"), $_DELETE);
    $id = $_DELETE['id'] ?? null;

    if (!$id) {
        echo json_encode(["error" => "ID is required"]);
        exit();
    }

    $stmt = $pdo->prepare("DELETE FROM Contact WHERE id = ?");
    $stmt->execute([$id]);
    echo json_encode(["message" => "Contact deleted successfully"]);
}
?>