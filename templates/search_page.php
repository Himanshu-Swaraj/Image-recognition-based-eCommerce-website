<?php

include 'components/connect.php';

session_start();

if(isset($_SESSION['user_id'])){
   $user_id = $_SESSION['user_id'];
}else{
   $user_id = '';
};

?>
<?php
if(isset($_SESSION['message'])){
   $message = $_SESSION['message'];
   unset($_SESSION['message']);
}else{
   $message = '';
};
?>

<!DOCTYPE html>
<html lang="en">
<head>
   <meta charset="UTF-8">
   <meta http-equiv="X-UA-Compatible" content="IE=edge">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <title>search page</title>
   
   <!-- font awesome cdn link  -->
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">

   <!-- custom css file link  -->
   <link rel="stylesheet" href="css/style.css">

</head>
<body>
   
<?php include 'components/user_header.php'; ?>


<section class="search-form">
   <form action="" method="post">
      <input id="toSearch" type="text" name="search_box" placeholder="search here..." maxlength="100" class="box" required>
      <button type="submit" id="searchSubmit" class="fas fa-search" name="search_btn"></button>
   </form>
</section>
<section class="search-form">
   <form id="upload-form">
      
      <input type="file" name="file" id="file">
      <button type="button" onclick="previewImage()">View</button>
      <button type="submit" class="fas fa-search" name="search_btn"></button>

   </form>
  
   <?php if(!empty($message)): ?>
      <div id="message"><?= $message ?></div>
   <?php endif; ?>

</section>

<script type="text/javascript">
         //"http://127.0.0.1:5000/predict_image"
         document.querySelector("#upload-form").addEventListener("submit",async (event)=>{
            event.preventDefault();
            const fileInput=document.querySelector("#file")
            console.log("the is log")
            const data = new FormData();
            data.append("file",fileInput.files[0]);
            let res=await fetch("http://127.0.0.1:5000/predict_image",{
               body:data,
               method:"post"
            });
            console.log("run till now")
            let search=await res.json();
            document.querySelector("#toSearch").value=search.name;
            document.querySelector("#searchSubmit").click();
         });
         
       
  function previewImage() {
  var file = document.getElementById("file").files[0];
  var reader = new FileReader();
  
  reader.onloadend = function () {
    var preview = window.open("", "Image Preview", "width=500,height=500");
    preview.document.write("<img src='" + reader.result + "' style='max-width: 100%; max-height: 100%; object-fit: contain;'>");
    
  }
  
  if (file) {
    reader.readAsDataURL(file);
  } else {
                preview.src = "";
                preview.style.display = "none";
            }
}

 </script>



<section class="products" style="padding-top: 0; min-height:100vh;">

   <div class="box-container">

   <?php
     if(isset($_POST['search_box']) OR isset($_POST['search_btn'])){
     $search_box = $_POST['search_box'];
     $select_products = $conn->prepare("SELECT * FROM `products` WHERE name LIKE '%{$search_box}%'"); 
     $select_products->execute();
     if($select_products->rowCount() > 0){
      while($fetch_product = $select_products->fetch(PDO::FETCH_ASSOC)){
   ?>
   <form action="" method="post" class="box">
      <input type="hidden" name="pid" value="<?= $fetch_product['id']; ?>">
      <input type="hidden" name="name" value="<?= $fetch_product['name']; ?>">
      <input type="hidden" name="price" value="<?= $fetch_product['price']; ?>">
      <input type="hidden" name="image" value="<?= $fetch_product['image_01']; ?>">
      
      <a href="quick_view.php?pid=<?= $fetch_product['id']; ?>" class="fas fa-eye"></a>
      <img src="uploaded_img/<?= $fetch_product['image_01']; ?>" alt="">
      <div class="name"><?= $fetch_product['name']; ?></div>
      <div class="flex">
         <div class="price"><span>Rs. </span><?= $fetch_product['price']; ?><span>/-</span></div>
         <input type="number" name="qty" class="qty" min="1" max="99" onkeypress="if(this.value.length == 2) return false;" value="1">
      </div>
      <input type="submit" value="add to cart" class="btn" name="add_to_cart">
   </form>
   <?php
         }
      }else{
         echo '<p class="empty">no products found!</p>';
      }
   }
   ?>

   </div>

</section>


<?php include 'components/footer.php'; ?>

<script src="js/script.js"></script>

</body>
</html>