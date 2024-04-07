<!DOCTYPE html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Listings</title>
    <link rel="stylesheet" href="styles/style.css">
    <link rel="stylesheet" href="styles/listings.css">
</head>
<body>
    <div class="header">
        <h1>Listings</h1>
    </div>

    <!-- Fetch and Display -->
    <?php
    include 'connectdb.php'; 

    $sql = "SELECT p.propertyID, p.type, p.rent, p.address, GROUP_CONCAT(DISTINCT o.fname, ' ', o.lname ORDER BY o.fname SEPARATOR ', ') AS owners, m.fname AS managerFName, m.lname AS managerLName
            FROM (
                SELECT propertyID, 'House' AS type, rentCost AS rent, CONCAT(houseNumber, ' ', street, ', ', city, ', ', province, ', ', postalCode) AS address, managerID
                FROM house
                UNION ALL
                SELECT propertyID, 'Apartment', rentCost, CONCAT(apartmentNumber, ' ', street, ', ', city, ', ', province, ', ', postalCode), managerID
                FROM apartment
                UNION ALL
                SELECT propertyID, 'Room', rentCost, CONCAT(roomNumber, ' ', street, ', ', city, ', ', province, ', ', postalCode), managerID
                FROM room
            ) p
            LEFT JOIN ownsProperty op ON p.propertyID = op.propertyID
            LEFT JOIN owner o ON op.ID = o.ID
            LEFT JOIN manager m ON p.managerID = m.ID
            GROUP BY p.propertyID, p.type, p.rent, p.address, p.managerID
            ORDER BY p.propertyID";

    try {
        $stmt = $pdo->query($sql);
        
        echo "<table>";
        echo "<thead>";
        echo "<tr><th>Property ID</th><th>Type</th><th>Rent</th><th>Address</th><th>Owners</th><th>Manager Name</th></tr>";
        echo "</thead>";
        echo "<tbody>";
        
        while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
            echo "<tr>";
            echo "<td>" . htmlspecialchars($row['propertyID']) . "</td>";
            echo "<td>" . htmlspecialchars($row['type']) . "</td>";
            echo "<td>$" . htmlspecialchars($row['rent']) . "</td>";
            echo "<td>" . htmlspecialchars($row['address']) . "</td>";
            echo "<td>" . htmlspecialchars($row['owners']) . "</td>";
            echo "<td>" . htmlspecialchars($row['managerFName']) . " " . htmlspecialchars($row['managerLName']) . "</td>";
            echo "</tr>";
        }
        
        echo "</tbody>";
        echo "</table>";
    } catch (PDOException $e) {
        echo "Error: " . $e->getMessage();
    }
    ?>

    <a href="rental.html" class="return-home">Return to Homepage</a>
</body>
</html>
