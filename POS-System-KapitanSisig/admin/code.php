<?php

include('../config/function.php');

ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);


// Save Admin Functionality
if (isset($_POST['saveAdmin'])) {
    $firstname = validate($_POST['firstname']);
    $lastname = validate($_POST['lastname']);
    $username = validate($_POST['username']);
    $password = validate($_POST['password']);

    $position = isset($_POST['position']) && $_POST['position'] == 1 ? 1 : 0;

    if ($firstname != '' && $lastname != '' && $username != '' && $password != '') {
        $usernameCheck = mysqli_query($conn, "SELECT * FROM admins WHERE username='$username'");
        if ($usernameCheck && mysqli_num_rows($usernameCheck) > 0) {
            $_SESSION['message'] = 'Username already used by another user.';
            header('Location: admins-create.php');
            exit();
        }

        $bcrypt_password = password_hash($password, PASSWORD_BCRYPT);

        $data = [
            'firstname' => $firstname,
            'lastname' => $lastname,
            'username' => $username,
            'password' => $bcrypt_password,
            'position' => $position
        ];

        $result = insert('admins', $data);
        if ($result) {
            $_SESSION['message'] = 'Admin created.';
            header('Location: admins.php');
            exit();
        } else {
            $_SESSION['message'] = 'Something went wrong.';
            header('Location: admins-create.php');
            exit();
        }
    } else {
        $_SESSION['message'] = 'Please fill required fields.';
        header('Location: admins-create.php');
        exit();
    }
}


// Update Admin Functionality
if (isset($_POST['updateAdmin'])) {
    $adminId = validate($_POST['adminId']);

    $adminData = getByID('admins', $adminId);

    if ($adminData['status'] != 200) {
        $_SESSION['message'] = 'Admin not found.';
        header('Location: admins-edit.php?id=' . $adminId);
        exit();
    }

    $firstname = validate($_POST['firstname']);
    $lastname = validate($_POST['lastname']);
    $username = validate($_POST['username']);
    $password = validate($_POST['password']);

    $position = isset($_POST['position']) && $_POST['position'] == 1 ? 1 : 0;

    $hashedPassword = $password != '' ? password_hash($password, PASSWORD_BCRYPT) : $adminData['data']['password'];

    if ($firstname != '' && $lastname != '' && $username != '') {
        $data = [
            'firstname' => $firstname,
            'lastname' => $lastname,
            'username' => $username,
            'password' => $hashedPassword,
            'position' => $position
        ];

        $result = update('admins', $adminId, $data);
        if ($result) {
            $_SESSION['message'] = 'Admin updated.';
            header('Location: admins.php');
            exit();
        } else {
            $_SESSION['message'] = 'Something went wrong.';
            header('Location: admins.php');
            exit();
        }
    } else {
        $_SESSION['message'] = 'Please fill required fields.';
        header('Location: admins-edit.php?id=' . $adminId);
        exit();
    }
}


// Save Supplier
if (isset($_POST['saveSupplier'])) {
    $firstname = validate($_POST['firstname']);
    $lastname = validate($_POST['lastname']);
    $phonenumber = validate($_POST['phonenumber']);
    $address = validate($_POST['address']);

    if ($firstname != '' && $lastname != '' && $phonenumber != '' && $address != '') {
        $data = [
            'firstname' => $firstname,
            'lastname' => $lastname,
            'phonenumber' => $phonenumber,
            'address' => $address
        ];

        $result = insert('suppliers', $data);
        if ($result) {
            $_SESSION['message'] = 'Supplier added successfully.';
            header('Location: suppliers.php');
            exit();
        } else {
            $_SESSION['message'] = 'Something went wrong.';
            header('Location: suppliers-create.php');
            exit();
        }
    } else {
        $_SESSION['message'] = 'Please fill required fields.';
        header('Location: suppliers-create.php');
        exit();
    }
}

// Update Supplier
if (isset($_POST['updateSupplier'])) {
    $supplierId = validate($_POST['supplierId']);

    $supplierData = getById('suppliers', $supplierId);

    if ($supplierData['status'] != 200) {
        $_SESSION['message'] = 'Invalid Supplier ID.';
        header('Location: suppliers.php');
        exit();
    }

    $firstname = validate($_POST['firstname']);
    $lastname = validate($_POST['lastname']);
    $phonenumber = validate($_POST['phonenumber']);
    $address = validate($_POST['address']);

    if ($firstname != '' && $lastname != '' && $phonenumber != '' && $address != '') {
        $data = [
            'firstname' => $firstname,
            'lastname' => $lastname,
            'phonenumber' => $phonenumber,
            'address' => $address
        ];

        $result = update('suppliers', $supplierId, $data);
        if ($result) {
            $_SESSION['message'] = 'Supplier updated successfully.';
            header('Location: suppliers.php');
            exit();
        } else {
            $_SESSION['message'] = 'Something went wrong.';
            header('Location: suppliers.php');
            exit();
        }
    } else {
        $_SESSION['message'] = 'Please fill required fields.';
        header('Location: suppliers-edit.php?id=' . $supplierId);
        exit();
    }
}

// Save Ingredient
if (isset($_POST['saveIngredient'])) {
    $name = trim($_POST['name']);
    $unit_id = trim($_POST['unit_id']);
    $category = trim($_POST['category']);
    $price = trim($_POST['price']);
    $quantity = trim($_POST['quantity']); // Get quantity from the form

    // Prepare the SQL query with placeholders
    $query = "INSERT INTO ingredients (name, unit_id, category, price, quantity) 
              VALUES (?, ?, ?, ?, ?)";

    // Initialize the prepared statement
    if ($stmt = mysqli_prepare($conn, $query)) {
        // Bind parameters to the placeholders
        mysqli_stmt_bind_param($stmt, "sisdi", $name, $unit_id, $category, $price, $quantity);

        // Execute the statement
        if (mysqli_stmt_execute($stmt)) {
            $_SESSION['message'] = "Ingredient added successfully";
            header('Location: ingredients-view.php');
            exit(0);
        } else {
            $_SESSION['message'] = "Failed to add ingredient";
            header('Location: ingredients-add.php');
            exit(0);
        }

        // Close the prepared statement
        mysqli_stmt_close($stmt);
    } else {
        $_SESSION['message'] = "Database error: Unable to prepare statement";
        header('Location: ingredients-add.php');
        exit(0);
    }
}

// Update Ingredient
if (isset($_POST['updateIngredient'])) {
    $ingredientId = trim($_POST['ingredientId']);
    $name = trim($_POST['name']);
    $unit_id = trim($_POST['unit_id']);
    $category = trim($_POST['category']);
    
    // Prepare the SQL query with placeholders
    $query = "UPDATE ingredients SET name=?, unit_id=?, category=? WHERE id=?";

    // Initialize the prepared statement
    if ($stmt = mysqli_prepare($conn, $query)) {
        // Bind parameters to the placeholders (types: s = string, i = integer)
        mysqli_stmt_bind_param($stmt, "sssi", $name, $unit_id, $category, $ingredientId); // Correctly set types

        // Execute the statement
        if (mysqli_stmt_execute($stmt)) {
            $_SESSION['message'] = "Ingredient updated successfully";
            header('Location: ingredients-view.php');
            exit(0);
        } else {
            $_SESSION['message'] = "Failed to update ingredient";
            header('Location: ingredients-edit.php?id=' . $ingredientId);
            exit(0);
        }

        // Close the prepared statement
        mysqli_stmt_close($stmt);
    } else {
        $_SESSION['message'] = "Database error: Unable to prepare statement";
        header('Location: ingredients-edit.php?id=' . $ingredientId);
        exit(0);
    }
}

// Save Category
if (isset($_POST['saveCategory'])) {
    $name = validate($_POST['name']);
    // $description = validate($_POST['description']);
    $status = isset($_POST['status']) ? 1 : 0;

    if ($name != '' ) {
        $data = [
            'name' => $name,
            // 'description' => $description,
            'status' => $status
        ];
        $result = insert('categories', $data);
        if ($result) {
            $_SESSION['message'] = 'Category created successfully!';
            header('Location: categories.php');
            exit();
        } else {
            $_SESSION['message'] = 'Something went wrong.';
            header('Location: categories-create.php');
            exit();
        }
    } else {
        $_SESSION['message'] = 'Please fill required fields.';
        header('Location: categories-create.php');
        exit();
    }
}


// Update Category
if (isset($_POST['updateCategory'])) {
    $categoryId = validate($_POST['categoryId']);

    $categoryData = getById('categories', $categoryId);

    if ($categoryData['status'] != 200) {
        $_SESSION['message'] = 'Category not found.';
        header('Location: categories-edit.php?id=' . $categoryId);
        exit();
    }

    $name = validate($_POST['name']);
    // $description = validate($_POST['description']);
    $status = isset($_POST['status']) ? 1 : 0;

    if ($name != '') {
        $data = [
            'name' => $name,
            // 'description' => $description,
            'status' => $status
        ];
        $result = update('categories', $categoryId, $data);
        if ($result) {
            $_SESSION['message'] = 'Category updated successfully!';
            header('Location: categories.php');
            exit();
        } else {
            $_SESSION['message'] = 'Something went wrong.';
            header('Location: categories.php');
            exit();
        }
    } else {
        $_SESSION['message'] = 'Please fill required fields.';
        header('Location: categories-edit.php');
        exit();
    }
}


// Save Product
if (isset($_POST['saveProduct'])) {
    $category_id = validate($_POST['category_id']);
    $productname = validate($_POST['productname']);
    $description = validate($_POST['description']);
    $quantity = validate($_POST['quantity']);  // Corrected quantity validation
    $price = validate($_POST['price']);

    if ($_FILES['image']['size'] > 0) {
        $path = "../pics/uploads/products";
        $image_ext = pathinfo($_FILES['image']['name'], PATHINFO_EXTENSION);

        $filename = time() . '.' . $image_ext;

        move_uploaded_file($_FILES['image']['tmp_name'], $path . "/" . $filename);
        $finalImage = "pics/uploads/products/" . $filename;
    } else {
        $finalImage = '';
    }

    $data = [
        'category_id' => $category_id,
        'productname' => $productname,
        'description' => $description,
        'quantity' => $quantity,  // Added quantity to the data array
        'price' => $price,
        'image' => $finalImage
    ];

    $result = insert('products', $data);
    if ($result) {
        redirect('products.php', 'Menu product created successfully!');
    } else {
        redirect('products-create.php', 'Something went wrong.');
    }
}


// Update Product
if (isset($_POST['updateProduct'])) {
    $product_id = validate($_POST['product_id']);

    $productData = getById('products', $product_id);
    if ($productData['status'] != 200) {
        $_SESSION['message'] = 'Product not found.';
        header('Location: products-edit.php?id=' . $product_id);
        exit();
    }

    $category_id = validate($_POST['category_id']);
    $productname = validate($_POST['productname']);
    $description = validate($_POST['description']);
    $quantity = validate($_POST['quantity']);  // Corrected quantity validation for update
    $price = validate($_POST['price']);

    if ($_FILES['image']['size'] > 0) {
        $path = "../pics/uploads/products";
        $image_ext = strtolower(pathinfo($_FILES['image']['name'], PATHINFO_EXTENSION));
        $allowed_ext = ['jpg', 'jpeg', 'png', 'gif'];

        if (!in_array($image_ext, $allowed_ext)) {
            $_SESSION['message'] = 'Invalid image type.';
            header('Location: products-edit.php?id=' . $product_id);
            exit();
        }

        $filename = time() . '.' . $image_ext;
        $destination = $path . "/" . $filename;

        if (move_uploaded_file($_FILES['image']['tmp_name'], $destination)) {
            $finalImage = "pics/uploads/products/" . $filename;

            $deleteImage = "../" . $productData['data']['image'];
            if (file_exists($deleteImage)) {
                unlink($deleteImage);
            }
        } else {
            $finalImage = $productData['data']['image'];
            $_SESSION['message'] = 'Failed to move the uploaded file.';
            header('Location: products-edit.php?id=' . $product_id);
            exit();
        }
    } else {
        $finalImage = $productData['data']['image'];
    }

    $data = [
        'category_id' => $category_id,
        'productname' => $productname,
        'description' => $description,
        'quantity' => $quantity,  // Added quantity to the update array
        'price' => $price,
        'image' => $finalImage
    ];

    $result = update('products', $product_id, $data);

    if ($result) {
        $_SESSION['message'] = 'Menu product updated successfully!';
        header('Location: products.php');
        exit();
    } else {
        $_SESSION['message'] = 'Something went wrong.';
        header('Location: products-edit.php?id=' . $product_id);
        exit();
    }
}


// Save Unit of Measurement Category
if (isset($_POST['saveUnitCategory'])) {
    $category_unit_name = $_POST['category_unit_name'];

    if (!empty($category_unit_name)) {
        // Insert into database
        $stmt = $conn->prepare("INSERT INTO unit_categories (category_unit_name) VALUES (?)");
        $stmt->bind_param("s", $category_unit_name);
        $stmt->execute();
        $stmt->close();

        // Redirect with success message
        $_SESSION['message'] = "Unit category created successfully!";
        $_SESSION['msg_type'] = "success";
        header('Location: units.php');
        exit;
    } else {
        // Redirect with error message
        $_SESSION['message'] = "Please fill all required fields!";
        $_SESSION['msg_type'] = "danger";
        header('Location: units-category.php');
        exit;
    }
}

// Save UoMs
if (isset($_POST['save_uom'])) {
    $category_id = $_POST['category_id'];

    // Process existing UoMs
    if (!empty($_POST['uom_id'])) {
        foreach ($_POST['uom_id'] as $index => $uom_id) {
            $new_type = $_POST['uom_type'][$index];
            $new_ratio = $_POST['ratio'][$index];
            $new_active = isset($_POST['active'][$index]) ? 1 : 0;
            $new_rounding_precision = $_POST['rounding_precision'][$index];

            $stmt = $conn->prepare("UPDATE units_of_measure SET type=?, ratio=?, active=?, rounding_precision=? WHERE id=?");
            $stmt->bind_param("sdsdi", $new_type, $new_ratio, $new_active, $new_rounding_precision, $uom_id);
            $stmt->execute();
            $stmt->close();
        }
    }

    // Process new UoMs
    if (!empty($_POST['new_uom_name'])) {
        $new_uom_name = $_POST['new_uom_name'];
        $new_uom_type = $_POST['new_uom_type'];
        $new_ratio = $_POST['new_ratio'];
        $new_active = isset($_POST['new_active']) ? 1 : 0;
        $new_rounding_precision = $_POST['new_rounding_precision'];

        $stmt = $conn->prepare("INSERT INTO units_of_measure (category_id, uom_name, type, ratio, active, rounding_precision) VALUES (?, ?, ?, ?, ?, ?)");
        $stmt->bind_param("issdii", $category_id, $new_uom_name, $new_uom_type, $new_ratio, $new_active, $new_rounding_precision);
        $stmt->execute();
        $stmt->close();
    }

    $_SESSION['message'] = "Units of Measure updated successfully!";
    header("Location: units-view-category.php?id=$category_id");
    exit;
}

// Delete UoM
if (isset($_GET['delete_uom'])) {
    $uom_id = $_GET['delete_uom'];
    $stmt = $conn->prepare("DELETE FROM units_of_measure WHERE id = ?");
    $stmt->bind_param("i", $uom_id);
    $stmt->execute();
    $stmt->close();

    $_SESSION['message'] = "Unit of Measure deleted successfully!";
    header("Location: " . $_SERVER['HTTP_REFERER']);
    exit;
}


// Handle update category
if (isset($_POST['updateUnitCategory'])) {
    // Handle the update of the unit category
    $category_id = $_POST['category_id'];
    $category_unit_name = $_POST['category_unit_name'];

    $sql = "UPDATE unit_categories SET category_unit_name = ? WHERE id = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("si", $category_unit_name, $category_id);

    if ($stmt->execute()) {
        // Success message
        $_SESSION['message'] = "Unit category updated successfully.";
    } else {
        // Error message
        $_SESSION['message'] = "Error updating unit category.";
    }
    $stmt->close();
    header("Location: units.php");
    exit();
}

// Delete UoM category
if (isset($_GET['delete'])) {
    // Handle the deletion of the unit category
    $category_id = $_GET['delete'];

    // Optionally, check for UoMs in this category and delete them if necessary
    $deleteUoMsSql = "DELETE FROM units_of_measure WHERE category_id = ?";
    $stmt = $conn->prepare($deleteUoMsSql);
    $stmt->bind_param("i", $category_id);
    $stmt->execute();
    $stmt->close();

    // Now delete the category
    $sql = "DELETE FROM unit_categories WHERE id = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("i", $category_id);

    if ($stmt->execute()) {
        // Success message
        $_SESSION['message'] = "Unit category deleted successfully.";
    } else {
        // Error message
        $_SESSION['message'] = "Error deleting unit category.";
    }
    $stmt->close();
    header("Location: units.php");
    exit();
}

// Save Customer
if (isset($_POST['saveCustomer'])) {
    $name = validate($_POST['name']);
    

    if ($name != '') {
        $data = [
            'name' => $name,
            
        ];
        $result = insert('customers', $data);
        if ($result) {
            $_SESSION['message'] = 'Customer created successfully!';
            header('Location: customers.php');
            exit();
        } else {
            $_SESSION['message'] = 'Something went wrong.';
            header('Location: customer-create.php');
            exit();
        }
    } else {
        $_SESSION['message'] = 'Please fill required fields.';
        header('Location: customer-create.php');
        exit();
    }
}


// Update Customer
if (isset($_POST['updateCustomer'])) {
    $customerId = validate($_POST['customerId']);

    $customerData = getById('customers', $customerId);

    if ($customerData['status'] != 200) {
        $_SESSION['message'] = 'Customer not found.';
        header('Location: customer-edit.php?id=' . $customerId);
        exit();
    }

    $name = validate($_POST['name']);

    if ($name != '') {
        $data = [
            'name' => $name
            
        ];
        $result = update('customers', $customerId, $data);
        if ($result) {
            $_SESSION['message'] = 'Customer updated successfully!';
            header('Location: customers.php');
            exit();
        } else {
            $_SESSION['message'] = 'Something went wrong.';
            header('Location: customers.php');
            exit();
        }
    } else {
        $_SESSION['message'] = 'Please fill required fields.';
        header('Location: customer-edit.php');
        exit();
    }
}

// Save Recipe
if (isset($_POST['saveRecipe'])) {
    // Retrieve form data
    $product_id = $_POST['product_id']; 
    $ingredient_ids = $_POST['ingredient_id']; 
    $units = $_POST['unit_id']; 
    $ingredient_quantities = $_POST['quantity']; 

    // Validate inputs
    if (empty($product_id) || empty($ingredient_ids) || empty($units) || empty($ingredient_quantities)) {
        $_SESSION['message'] = "All fields are required.";
        header("Location: recipes-add.php");
        exit();
    }

    // Check if a recipe already exists for the selected product
    $check_recipe_query = "SELECT * FROM recipes WHERE product_id = ?";
    $check_stmt = mysqli_prepare($conn, $check_recipe_query);
    mysqli_stmt_bind_param($check_stmt, 'i', $product_id);
    mysqli_stmt_execute($check_stmt);
    $check_result = mysqli_stmt_get_result($check_stmt);

    if (mysqli_num_rows($check_result) > 0) {
        // A recipe already exists for this product
        $_SESSION['message'] = "A recipe for this product already exists.";
        header("Location: recipes-add.php");
        exit();
    }

    // Begin transaction
    mysqli_begin_transaction($conn);
    try {
        // Insert into recipes table
        $recipe_query = "INSERT INTO recipes (product_id) VALUES (?)";
        $stmt = mysqli_prepare($conn, $recipe_query);
        mysqli_stmt_bind_param($stmt, 'i', $product_id); 
        mysqli_stmt_execute($stmt);
        
        // Get the last inserted recipe ID
        $recipe_id = mysqli_insert_id($conn);

        // Prepare to insert into recipe_ingredients table
        $ingredient_query = "INSERT INTO recipe_ingredients (recipe_id, ingredient_id, unit_id, quantity) VALUES (?, ?, ?, ?)";
        $ingredient_stmt = mysqli_prepare($conn, $ingredient_query);

        // Loop through each ingredient and insert into recipe_ingredients table
        for ($i = 0; $i < count($ingredient_ids); $i++) {
            $ingredient_id = $ingredient_ids[$i];
            $unit_id = $units[$i];
            $quantity = $ingredient_quantities[$i];

            mysqli_stmt_bind_param($ingredient_stmt, 'iiid', $recipe_id, $ingredient_id, $unit_id, $quantity);
            mysqli_stmt_execute($ingredient_stmt);
        }

        // Commit the transaction
        mysqli_commit($conn);

        // Set success message and redirect
        $_SESSION['message'] = "Recipe saved successfully!";
        header("Location: recipe-view.php?id=$product_id"); // Redirect to recipe-view instead of products
        exit();
    } catch (Exception $e) {
        // Rollback transaction in case of error
        mysqli_rollback($conn);
        $_SESSION['message'] = "Error saving recipe: " . mysqli_error($conn);
        header("Location: recipes-add.php");
        exit();
    }
}

// Update Recipe
if (isset($_POST['updateRecipe'])) {
    $recipeId = $_POST['recipe_id'];
    $productId = $_POST['product_id'];

    // Arrays from the form
    $recipeIngredientIds = $_POST['recipe_ingredient_id'];
    $ingredientIds = $_POST['ingredient_id'];
    $unitIds = $_POST['unit_id'];
    $quantities = $_POST['quantity'];

    // Begin transaction for updating
    mysqli_begin_transaction($conn);
    try {
        // Handle updating and inserting ingredients
        for ($i = 0; $i < count($ingredientIds); $i++) {
            $recipeIngredientId = $recipeIngredientIds[$i];
            $ingredientId = $ingredientIds[$i];
            $unitId = $unitIds[$i];
            $quantity = $quantities[$i];

            if (!empty($recipeIngredientId)) {
                // Update existing ingredient
                $updateQuery = "UPDATE recipe_ingredients SET ingredient_id = ?, unit_id = ?, quantity = ? WHERE id = ?";
                $stmt = mysqli_prepare($conn, $updateQuery);
                mysqli_stmt_bind_param($stmt, 'iiid', $ingredientId, $unitId, $quantity, $recipeIngredientId);
                mysqli_stmt_execute($stmt);
            } else {
                // Insert new ingredient entry
                $insertQuery = "INSERT INTO recipe_ingredients (recipe_id, ingredient_id, unit_id, quantity) VALUES (?, ?, ?, ?)";
                $stmt = mysqli_prepare($conn, $insertQuery);
                mysqli_stmt_bind_param($stmt, 'iiid', $recipeId, $ingredientId, $unitId, $quantity);
                mysqli_stmt_execute($stmt);
            }
        }

        // Handle removing ingredients
        if (isset($_POST['remove_recipe_ingredient_id'])) {
            $removeIngredientIds = $_POST['remove_recipe_ingredient_id'];
            foreach ($removeIngredientIds as $removeId) {
                $deleteQuery = "DELETE FROM recipe_ingredients WHERE id = ?";
                $stmt = mysqli_prepare($conn, $deleteQuery);
                mysqli_stmt_bind_param($stmt, 'i', $removeId);
                mysqli_stmt_execute($stmt);
            }
        }

        // Commit transaction
        mysqli_commit($conn);

        // Store success message in session
        $_SESSION['message'] = "Recipe updated successfully!";

        // Redirect to recipe-view.php with the product ID
        header("Location: recipe-view.php?id=$productId");
        exit();
    } catch (Exception $e) {
        // Rollback transaction in case of error
        mysqli_rollback($conn);
        $_SESSION['message'] = "Error updating recipe: " . mysqli_error($conn);
        header("Location: recipe-edit.php?id=$recipeId");
        exit();
    }
}

// Function to get UoM ratio by unit_id
function getUomRatio($conn, $unit_id) {
    $query = "SELECT ratio FROM units_of_measure WHERE id = ?";
    $stmt = $conn->prepare($query);
    $stmt->bind_param("i", $unit_id);
    $stmt->execute();
    $result = $stmt->get_result()->fetch_assoc();
    return $result ? $result['ratio'] : null; // Return the ratio or null
}

// Update Ingredient Inventory Function
function updateIngredientInventory($conn, $productId, $quantity) {
    // Fetch the recipe's ingredient details
    $recipeQuery = "SELECT ri.ingredient_id, ri.unit_id, ri.quantity as recipe_quantity, i.unit_id as ingredient_unit_id 
                    FROM recipe_ingredients ri 
                    JOIN ingredients i ON ri.ingredient_id = i.id 
                    WHERE ri.recipe_id = ?";
    
    $stmt = $conn->prepare($recipeQuery);
    $stmt->bind_param("i", $productId);
    $stmt->execute();
    $ingredients = $stmt->get_result();

    // Loop through each ingredient and adjust the inventory
    while ($ingredient = $ingredients->fetch_assoc()) {
        $ingredientId = $ingredient['ingredient_id'];
        $ingredientUomId = $ingredient['ingredient_unit_id'];
        $recipeUomId = $ingredient['unit_id'];
        $recipeQuantity = $ingredient['recipe_quantity'];

        // Get the ratios
        $ingredientRatio = getUomRatio($conn, $ingredientUomId);
        $recipeRatio = getUomRatio($conn, $recipeUomId);

        if ($ingredientRatio && $recipeRatio) {
            // Convert the recipe quantity to the ingredient's base unit
            $convertedQuantity = ($recipeQuantity * $recipeRatio) / $ingredientRatio;

            // Update the inventory
            $updateQuery = "UPDATE ingredients SET quantity = quantity - ? WHERE id = ?";
            $updateStmt = $conn->prepare($updateQuery);
            $updateStmt->bind_param("di", $convertedQuantity, $ingredientId);
            $updateStmt->execute();
        }
    }
}

// Check if the addItem button was clicked
if (isset($_POST['addItem'])) {
    $productId = $_POST['product_id'];
    $quantity = $_POST['quantity'];

    // Fetch product details
    $productQuery = "SELECT * FROM products WHERE id = ?";
    $stmt = $conn->prepare($productQuery);
    $stmt->bind_param("i", $productId);
    $stmt->execute();
    $product = $stmt->get_result()->fetch_assoc();

    if ($product) {
        $item = [
            'product_id' => $product['id'],
            'name' => $product['productname'],
            'price' => $product['price'],
            'quantity' => $quantity
        ];

        // Store the item in the session
        $_SESSION['productItems'][] = $item;

        // Update inventory based on ingredients
        updateIngredientInventory($conn, $productId, $quantity);

        $_SESSION['message'] = "Item added successfully!";
    } else {
        $_SESSION['error'] = "Product not found!";
    }

    header("Location: order-create.php");
    exit();
}

// Place the order
if (isset($_POST['placeOrder'])) {
    $customerName = $_POST['cname'];
    $paymentMode = $_POST['payment_mode'];
    $orderStatus = $_POST['order_status'];

    // Insert order into the database
    $orderQuery = "INSERT INTO orders (customer_name, payment_mode, order_status) VALUES (?, ?, ?)";
    $stmt = $conn->prepare($orderQuery);
    $stmt->bind_param("sss", $customerName, $paymentMode, $orderStatus);
    $stmt->execute();
    $orderId = $stmt->insert_id; // Get the last inserted order ID

    // Loop through items and add them to the order_items table
    foreach ($_SESSION['productItems'] as $item) {
        $orderItemQuery = "INSERT INTO order_items (order_id, product_id, quantity) VALUES (?, ?, ?)";
        $orderItemStmt = $conn->prepare($orderItemQuery);
        $orderItemStmt->bind_param("iii", $orderId, $item['product_id'], $item['quantity']);
        $orderItemStmt->execute();

        // Update ingredient inventory based on the recipe
        updateIngredientInventory($conn, $item['product_id'], $item['quantity']);
    }

    // Clear the session after placing the order
    unset($_SESSION['productItems']);

    $_SESSION['message'] = "Order placed successfully!";
    header("Location: orders.php");
    exit();
}

?>
