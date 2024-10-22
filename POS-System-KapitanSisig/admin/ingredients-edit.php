<?php include('includes/header.php'); ?>

<div class="container-fluid px-4 pb-4">
    <div class="card mt-4 shadow-sm">
        <div class="card-header">
            <h4 class="mb-0">Edit Ingredient
                <a href="ingredients-view.php" class="btn btn-outline-danger float-end">Back</a>
            </h4>
        </div>
        <div class="card-body">
            <?php
            if (isset($_GET['id'])) {
                $ingredientData = getById('ingredients', $_GET['id']);
                if ($ingredientData['status'] == 200) {
                    $ingredient = $ingredientData['data'];
            ?>
            <form action="code.php" method="POST">
                <input type="hidden" name="ingredientId" value="<?= htmlspecialchars($ingredient['id']) ?>">

                <div class="mb-3">
                    <label for="name">Ingredient Name</label>
                    <input type="text" id="name" name="name" value="<?= htmlspecialchars($ingredient['name']) ?>" class="form-control" required>
                </div>

                <!-- Unit Selection -->
                <div class="mb-3">
                    <label for="unit_id">Select Unit:</label>
                    <select id="unit_id" name="unit_id" class="form-select" required>
                        <option value="">Select Unit</option>
                        <?php
                        // Fetch all active units from the database
                        $unitResult = getAll('units_of_measure'); // Adjust this function as needed
                        if ($unitResult && mysqli_num_rows($unitResult) > 0) {
                            while ($uItem = mysqli_fetch_assoc($unitResult)) {
                                echo '<option value="'.htmlspecialchars($uItem['id']).'">'.htmlspecialchars($uItem['uom_name']).'</option>';
                            }
                        } else {
                            echo '<option value="">No units found!</option>';
                        }
                        ?>
                    </select>
                </div>

                <!-- Category Selection -->
                <div class="mb-3">
                    <label for="category">Category:</label>
                    <select id="category" name="category" class="form-select" required>
                        <option value="Meat & Poultry" <?= $ingredient['category'] == 'Meat & Poultry' ? 'selected' : '' ?>>Meat & Poultry</option>
                        <option value="Vegetables" <?= $ingredient['category'] == 'Vegetables' ? 'selected' : '' ?>>Vegetables</option>
                        <option value="Condiments" <?= $ingredient['category'] == 'Condiments' ? 'selected' : '' ?>>Condiments</option>
                        <option value="Spices & Herbs" <?= $ingredient['category'] == 'Spices & Herbs' ? 'selected' : '' ?>>Spices & Herbs</option>
                        <option value="Others" <?= $ingredient['category'] == 'Others' ? 'selected' : '' ?>>Others</option>
                        <option value="Cutlery" <?= $ingredient['category'] == 'Cutlery' ? 'selected' : '' ?>>Cutlery</option>
                    </select>
                </div>

                <button type="submit" name="updateIngredient" class="btn btn-outline-primary">Update Ingredient</button>
            </form>
            <?php
                } else {
                    echo '<h4>No Ingredient Found.</h4>';
                }
            } else {
                echo '<h4>Invalid Request.</h4>';
            }
            ?>
        </div>
    </div>
</div>

<?php include('includes/footer.php'); ?>
