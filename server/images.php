<?php
require 'db.php';  // Conexión a la base de datos

// Directorio donde se almacenan las imágenes
$upload_dir = $_SERVER['DOCUMENT_ROOT'] . '/imagenes/turismo/';


// Verificar el método HTTP
$method = $_SERVER['REQUEST_METHOD'];

switch ($method) {
    case 'POST':  // Subir una imagen
        if (isset($_FILES['image']) && $_FILES['image']['error'] == 0) {
            // Procesar la subida de la imagen
            $image_name = basename($_FILES['image']['name']);
            $image_temp = $_FILES['image']['tmp_name'];
            $image_type = strtolower(pathinfo($image_name, PATHINFO_EXTENSION));

            // Tipos permitidos
            $allowed_types = ['jpg', 'jpeg', 'png', 'gif'];

            if (in_array($image_type, $allowed_types)) {
                // Generar un nombre único para la imagen
                $image_new_name = uniqid('img_', true) . '.' . $image_type;
                $image_path = $upload_dir . $image_new_name;
                $image_url = 'https://muniupala.go.cr/imagenes/turismo/' . $image_new_name;

                // Mover la imagen al directorio de subida
                if (move_uploaded_file($image_temp, $image_path)) {
                    // Guardar los datos en la base de datos
                    $footer = isset($_POST['footer']) ? $_POST['footer'] : '';
                    
                    $sql = "INSERT INTO images (name, footer, url) VALUES (:name, :footer, :url)";
                    $stmt = $pdo->prepare($sql);
                    $stmt->bindParam(':name', $image_new_name);
                    $stmt->bindParam(':footer', $footer);
                    $stmt->bindParam(':url', $image_url);

                    if ($stmt->execute()) {
                        echo json_encode([
                            'status' => 'success',
                            'message' => 'Imagen subida correctamente.',
                            'url' => $image_url
                        ]);
                    } else {
                        echo json_encode([
                            'status' => 'error',
                            'message' => 'Error al guardar la imagen en la base de datos.'
                        ]);
                    }
                } else {
                    echo json_encode([
                        'status' => 'error',
                        'message' => 'Error al mover el archivo.'
                    ]);
                }
            } else {
                echo json_encode([
                    'status' => 'error',
                    'message' => 'Tipo de archivo no permitido. Solo se permiten JPG, JPEG, PNG, y GIF.'
                ]);
            }
        } else {
            echo json_encode([
                'status' => 'error',
                'message' => 'No se ha subido ninguna imagen o ha ocurrido un error.'
            ]);
        }
        break;

    case 'GET':  // Obtener todas las imágenes
        $sql = "SELECT * FROM images";
        $stmt = $pdo->prepare($sql);
        $stmt->execute();
        $images = $stmt->fetchAll(PDO::FETCH_ASSOC);

        if ($images) {
            echo json_encode([
                'status' => 'success',
                'data' => $images
            ]);
        } else {
            echo json_encode([
                'status' => 'error',
                'message' => 'No hay imágenes disponibles.'
            ]);
        }
        break;

    case 'DELETE':  // Eliminar una imagen por su ID
        if (isset($_GET['id'])) {
            // Validar y filtrar el ID
            $id = filter_var($_GET['id'], FILTER_VALIDATE_INT);
    
            if ($id === false) {
                echo json_encode([
                    'status' => 'error',
                    'message' => 'ID de imagen no válido.'
                ]);
                break;
            }
    
            // Obtener los detalles de la imagen a eliminar
            $sql = "SELECT * FROM images WHERE id = :id";
            $stmt = $pdo->prepare($sql);
            $stmt->bindParam(':id', $id, PDO::PARAM_INT);
            $stmt->execute();
            $image = $stmt->fetch(PDO::FETCH_ASSOC);
    
            if ($image) {
                // Ruta completa del archivo de imagen
                $image_path = $upload_dir . $image['name'];
    
                // Eliminar el archivo del servidor
                if (file_exists($image_path)) {
                    if (!unlink($image_path)) {
                        echo json_encode([
                            'status' => 'error',
                            'message' => 'Error al eliminar el archivo del servidor.'
                        ]);
                        break;
                    }
                }
    
                // Eliminar el registro de la base de datos
                $sql = "DELETE FROM images WHERE id = :id";
                $stmt = $pdo->prepare($sql);
                $stmt->bindParam(':id', $id, PDO::PARAM_INT);
    
                if ($stmt->execute()) {
                    echo json_encode([
                        'status' => 'success',
                        'message' => 'Imagen eliminada correctamente.'
                    ]);
                } else {
                    echo json_encode([
                        'status' => 'error',
                        'message' => 'Error al eliminar la imagen de la base de datos.'
                    ]);
                }
            } else {
                echo json_encode([
                    'status' => 'error',
                    'message' => 'Imagen no encontrada.'
                ]);
            }
        } else {
            echo json_encode([
                'status' => 'error',
                'message' => 'ID de imagen no proporcionado.'
            ]);
        }
        break;

    default:
        echo json_encode([
            'status' => 'error',
            'message' => 'Método no permitido.'
        ]);
        break;
}
?>
