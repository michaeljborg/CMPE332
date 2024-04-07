<?php
include 'connectdb.php';

// Queries to fetch average rents
$queries = [
    'Houses' => "SELECT AVG(rentCost) AS avgRent FROM house",
    'Apartments' => "SELECT AVG(rentCost) AS avgRent FROM apartment",
    'Rooms' => "SELECT AVG(rentCost) AS avgRent FROM room"
];

$averages = [];

// Execute each query and store the results
foreach ($queries as $type => $query) {
    $stmt = $pdo->query($query);
    $result = $stmt->fetch(PDO::FETCH_ASSOC);
    $averages[$type] = $result ? round($result['avgRent'], 2) : 0;
}
?>


<!DOCTYPE html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Average Rent</title>
    <link rel="stylesheet" href="styles/style.css">
    <link rel="stylesheet" href="styles/average-rent-style.css">
</head>
<body>
    <div class="header">
        <h1>Average Rent</h1>
    </div>
    <table>
        <thead>
            <tr>
                <th>Houses</th>
                <th>Apartments</th>
                <th>Rooms</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <?php foreach ($averages as $avgRent): ?>
                    <td>$<?= htmlspecialchars($avgRent) ?></td>
                <?php endforeach; ?>
            </tr>
        </tbody>
    </table>
    <a href="rental.html" class="return-home">Return to Homepage</a>
</body>
</html>
