<?php

include 'components/connect.php';

session_start();

if(isset($_SESSION['user_id'])){
   $user_id = $_SESSION['user_id'];
}else{
   $user_id = '';
};

if(isset($_POST['submit'])){

   $name = $_POST['name'];
   $name = filter_var($name, FILTER_SANITIZE_STRING);             
   $email = $_POST['email'];                                          
   $email = filter_var($email, FILTER_SANITIZE_STRING);
   $pass = $_POST['pass'];
   $pass = filter_var($pass, FILTER_SANITIZE_STRING);
   $cpass = $_POST['cpass'];
   $cpass = filter_var($cpass, FILTER_SANITIZE_STRING);

   $pass_sha1 = sha1($pass);
   $cpass_sha1 = sha1($cpass);

   $select_user = $conn->prepare("SELECT * FROM `users` WHERE email = ?");
   $select_user->execute([$email,]);
   $row = $select_user->fetch(PDO::FETCH_ASSOC);

   if($select_user->rowCount() > 0){
      $message[] = 'email already exists!';
   }else{
      if($pass_sha1 != $cpass_sha1){
         $message[] = 'confirm password not matched!';
      }else{
         $insert_user = $conn->prepare("INSERT INTO `users`(name, email, password) VALUES(?,?,?)");
         $insert_user->execute([$name, $email, $cpass_sha1]);
         $message[] = 'registered successfully, login now please!';
      }
   }
}

?>

<!DOCTYPE html>
<html lang="en">
<head>
   <meta charset="UTF-8">
   <meta http-equiv="X-UA-Compatible" content="IE=edge">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <title>register</title>
   
   <!-- font awesome cdn link  -->
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">

   <!-- custom css file link  -->
   <link rel="stylesheet" href="css/style.css">

</head>
<body>
   
<?php include 'components/user_header.php'; ?>

<section class="form-container">

   <form action="" method="post" onsubmit="return validatePassword()">
      <h3>register now</h3>
      <input type="text" name="name" required placeholder="enter your username" maxlength="20"  class="box">
      <input type="email" name="email" required placeholder="enter your email" maxlength="50"  class="box" oninput="this.value = this.value.replace(/\s/g, '')">
      <input type="password" name="pass" id="pass" required placeholder="enter your password" maxlength="20"  class="box" oninput="this.value = this.value.replace(/\s/g, '')">
      <div id="passMessage" style="color: red;"></div>
      <input type="password" name="cpass" id="cpass" required placeholder="confirm your password" maxlength="20"  class="box" oninput="this.value = this.value.replace(/\s/g, '')">
      <div id="cpassMessage" style="color: red;"></div>
      <input type="submit" value="register now" class="btn" name="submit">
      <p>already have an account?</p>
      <a href="user_login.php" class="option-btn">login now</a>
   </form>

</section>

<?php include 'components/footer.php'; ?>

<script>
function validatePassword() {
   const password = document.getElementById('pass').value;
   const confirmPassword = document.getElementById('cpass').value;
   let message = '';
   const passwordPattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$/;

   if (password.length < 8) {
      message = 'Password must be at least 8 characters long.';
   } else if (!/[a-z]/.test(password)) {
      message = 'Password must contain at least one lowercase letter.';
   } else if (!/[A-Z]/.test(password)) {
      message = 'Password must contain at least one uppercase letter.';
   } else if (!/\d/.test(password)) {
      message = 'Password must contain at least one digit.';
   } else if (!/[\W_]/.test(password)) {
      message = 'Password must contain at least one special character.';
   }

   document.getElementById('passMessage').innerText = message;

   if (message !== '') {
      return false;
   }

   if (password !== confirmPassword) {
      document.getElementById('cpassMessage').innerText = 'Confirm password does not match.';
      return false;
   } else {
      document.getElementById('cpassMessage').innerText = '';
   }

   return true;
}
</script>

</body>
</html>
