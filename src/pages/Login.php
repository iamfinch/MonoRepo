<!DOCTYPE html>
<head>
    
</head>
<body>
    <?php 
        require("classes/Database.class.php");
        $db = new Database();
    ?>
    <form action="/actions/login.php">
        <label for="username">Username: </label>
        <input type="text" name="username" id="username">
        <label for="current_password">: </label>
        <input type="password" name="current_password" id="current_password">
    </form>
</body>