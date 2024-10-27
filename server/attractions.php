<?php
header('Content-Type: application/json');
include 'db.php'; // Asegúrate de tener la conexión PDO en 'db.php'

// Crear un nuevo atractivo
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $input = json_decode(file_get_contents('php://input'), true);

    $lodge_id = $input['lodge_id'] ?? null;
    $category = $input['category'] ?? '';
    $title = $input['title'] ?? '';
    $image_url = $input['image_url'] ?? '';

    if ($lodge_id === null || $category === '' || $title === '') {
        echo json_encode(["error" => "Lodge ID, Category, and Title are required"]);
        exit();
    }

    $stmt = $pdo->prepare("INSERT INTO Attractions (lodge_id, category, title, image_url) VALUES (?, ?, ?, ?)");
    $stmt->execute([$lodge_id, $category, $title, $image_url]);
    $lastInsertedId = $pdo->lastInsertId();

    echo json_encode(["id" => $lastInsertedId, "message" => "Attraction created successfully"]);
    exit();
}

// Obtener todos los atractivos o uno específico
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    if (isset($_GET['id'])) {
        // Obtener un atractivo específico por ID
        $id = intval($_GET['id']);
        $stmt = $pdo->prepare("SELECT * FROM Attractions WHERE id = ?");
        $stmt->execute([$id]);
        $attraction = $stmt->fetch(PDO::FETCH_ASSOC);

        if ($attraction) {
            echo json_encode($attraction);
        } else {
            echo json_encode(["error" => "Attraction not found"]);
        }
    } else {
        // Obtener todos los atractivos
        $stmt = $pdo->query("SELECT * FROM Attractions");
        $attractions = $stmt->fetchAll(PDO::FETCH_ASSOC);
        echo json_encode($attractions);
    }
    exit();
}

// Actualizar un atractivo
if ($_SERVER['REQUEST_METHOD'] === 'PUT') {
    $input = json_decode(file_get_contents('php://input'), true);

    $id = $input['id'] ?? null;
    $category = $input['category'] ?? '';
    $title = $input['title'] ?? '';
    $image_url = $input['image_url'] ?? '';

    if ($id === null || $category === '' || $title === '') {
        echo json_encode(["error" => "ID, Category, and Title are required"]);
        exit();
    }

    $stmt = $pdo->prepare("UPDATE Attractions SET category = ?, title = ?, image_url = ? WHERE id = ?");
    $stmt->execute([$category, $title, $image_url, $id]);

    echo json_encode(["message" => "Attraction updated successfully"]);
    exit();
}

// Eliminar un atractivo
if ($_SERVER['REQUEST_METHOD'] === 'DELETE') {
    $input = json_decode(file_get_contents('php://input'), true);
    $id = $input['id'] ?? null;

    if ($id === null) {
        echo json_encode(["error" => "ID is required"]);
        exit();
    }

    $stmt = $pdo->prepare("DELETE FROM Attractions WHERE id = ?");
    $stmt->execute([$id]);

    echo json_encode(["message" => "Attraction deleted successfully"]);
    exit();
}

// Cerrar la conexión
$pdo = null;
?>
