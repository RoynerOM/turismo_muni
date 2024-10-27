<?php
session_start();

// Función para generar un token de autenticación
function generateToken($username) {
    return bin2hex(random_bytes(16)) . '.' . base64_encode($username);
}

// Función para verificar el token
function verifyToken($token) {
    $parts = explode('.', $token);
    if (count($parts) !== 2) return false;
    $username = base64_decode($parts[1]);
    return isset($_SESSION[$username]) && $_SESSION[$username]['token'] === $token;
}

// Ejemplo de login (puedes usar una base de datos para esto)
function login($username, $password) {
    // Aquí deberías validar las credenciales con la base de datos
    if ($username === 'admin' && $password === 'admin') {
        $token = generateToken($username);
        $_SESSION[$username] = ['token' => $token];
        return $token;
    }
    return false;
}

// Ejemplo de logout
function logout($username) {
    unset($_SESSION[$username]);
}
?>
