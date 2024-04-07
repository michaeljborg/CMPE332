<?php
include 'connectdb.php';

if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['groupID'])) {
    
    // Add input data to variables not directly into SQL statement
    $groupID = $_POST['groupID'];
    $accessibility = isset($_POST['accessibility']) ? 1 : 0;
    $laundry = isset($_POST['laundry']) ? 1 : 0;
    $parking = isset($_POST['parking']) ? 1 : 0;
    $numOfBathroom = filter_input(INPUT_POST, 'numOfBathroom', FILTER_SANITIZE_NUMBER_INT);
    $numOfBedrooms = filter_input(INPUT_POST, 'numOfBedrooms', FILTER_SANITIZE_NUMBER_INT);
    $maxRent = filter_input(INPUT_POST, 'maxRent', FILTER_SANITIZE_NUMBER_INT);

    //SQL statement
    $sql = "UPDATE preferences SET 
                accessibility = :accessibility,
                laundry = :laundry,
                parking = :parking,
                numOfBathroom = :numOfBathroom,
                numOfBedrooms = :numOfBedrooms,
                maxRent = :maxRent 
            WHERE groupID = :groupID";

    $stmt = $pdo->prepare($sql);

    // Bind data
    $stmt->bindParam(':accessibility', $accessibility, PDO::PARAM_INT);
    $stmt->bindParam(':laundry', $laundry, PDO::PARAM_INT);
    $stmt->bindParam(':parking', $parking, PDO::PARAM_INT);
    $stmt->bindParam(':numOfBathroom', $numOfBathroom, PDO::PARAM_INT);
    $stmt->bindParam(':numOfBedrooms', $numOfBedrooms, PDO::PARAM_INT);
    $stmt->bindParam(':maxRent', $maxRent, PDO::PARAM_INT);
    $stmt->bindParam(':groupID', $groupID, PDO::PARAM_INT);

    // Execute
    $stmt->execute();

    // Redirect back to the rental-groups.php
    header("Location: rental-groups.php?groupID=" . $groupID . "&update=success");
    exit();
} else {
    echo "Form submission error.";
}