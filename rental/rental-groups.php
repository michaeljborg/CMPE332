<!DOCTYPE html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Rental Groups</title>
    <link rel="stylesheet" href="styles/style.css">
    <link rel="stylesheet" href="styles/rental-groups.css">
</head>
<body>
    <div class="header">
        <h1>Rental Groups</h1>
    </div>

    <form action="rental-groups.php" method="GET">
        <select name="groupID">
            <option value="">Select a Rental Group</option>
            
            <?php
            include 'connectdb.php';

            $sql = "SELECT groupID FROM rentalGroup ORDER BY groupID";
            $stmt = $pdo->query($sql);

            while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
                echo "<option value='" . htmlspecialchars($row['groupID']) . "'>" . htmlspecialchars($row['groupID']) . "</option>";
            }
            ?>
        </select>
        <input type="submit" value="View Details">
    </form>

    <?php
    if (isset($_GET['groupID']) && !empty($_GET['groupID'])) {
        $groupID = $_GET['groupID'];
        
        echo "<section class='results'>";
        // Display students in the selected group
        echo "<div class='student-list card'>";
        echo "<h2>Students in Group " . htmlspecialchars($groupID) . "</h2>";
        $sql = "SELECT fname, lname FROM student WHERE groupID = :groupID";
        $stmt = $pdo->prepare($sql);
        $stmt->execute(['groupID' => $groupID]);
        while ($student = $stmt->fetch(PDO::FETCH_ASSOC)) {
            echo "<p>" . htmlspecialchars($student['fname']) . " " . htmlspecialchars($student['lname']) . "</p>";
        }
        echo "</div>";

    
        // Display rental preferences of the selected group
        echo "<div class='preferences card'>";
        $sql = "SELECT accessibility, laundry, parking, numOfBathroom, numOfBedrooms, maxRent FROM preferences WHERE groupID = :groupID";
        $stmt = $pdo->prepare($sql);
        $stmt->execute(['groupID' => $groupID]);
        $preferences = $stmt->fetch(PDO::FETCH_ASSOC);

        // Check if the edit flag is set in the URL and display the edit form
        if (isset($_GET['edit']) && $_GET['edit'] == 'true') {
            echo "<form class='edit-preferences-form' action='update-preferences.php' method='POST'>";
            echo "<input type='hidden' name='groupID' value='" . htmlspecialchars($_GET['groupID']) . "'>";
            echo "<label>Accessibility: <input type='checkbox' name='accessibility' " . ($preferences['accessibility'] ? "checked" : "") . "></label>";
            echo "<label>Laundry: <input type='checkbox' name='laundry' " . ($preferences['laundry'] ? "checked" : "") . "></label>";
            echo "<label>Parking: <input type='checkbox' name='parking' " . ($preferences['parking'] ? "checked" : "") . "></label><br>";
            echo "<label>Number of Bathrooms: <input type='number' name='numOfBathroom' value='" . htmlspecialchars($preferences['numOfBathroom']) . "'></label><br>";
            echo "<label>Number of Bedrooms: <input type='number' name='numOfBedrooms' value='" . htmlspecialchars($preferences['numOfBedrooms']) . "'></label><br>";
            echo "<label>Max Rent: <input type='number' name='maxRent' value='" . htmlspecialchars($preferences['maxRent']) . "'></label><br>";
            echo "<p><input type='submit' value='Update Preferences' class='update-preferences-btn'></p>";
            echo "</form>";
        } else {
            // The part of the code that displays the group's current preferences
            if ($preferences) {
                echo "<h2>Rental Preferences</h2>";
                echo "<p>Accessibility: " . ($preferences['accessibility'] ? "Yes" : "No") . "</p>";
                echo "<p>Laundry: " . ($preferences['laundry'] ? "Yes" : "No") . "</p>";
                echo "<p>Parking: " . ($preferences['parking'] ? "Yes" : "No") . "</p>";
                echo "<p>Number of Bathrooms: " . htmlspecialchars($preferences['numOfBathroom']) . "</p>";
                echo "<p>Number of Bedrooms: " . htmlspecialchars($preferences['numOfBedrooms']) . "</p>";
                echo "<p>Max Rent: $" . htmlspecialchars($preferences['maxRent']) . "</p>";
                echo "<a href='rental-groups.php?groupID={$groupID}&edit=true' class='edit-button'>Edit</a>";
            }
        }
        echo "</div>";
        
        echo "</section>"; 
    }
?>

    <a href="rental.html" class="return-home">Return to Homepage</a>

</body>
</html>