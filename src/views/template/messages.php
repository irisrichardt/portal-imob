<?php

$errors = [];

if ($exception) {
  $message = [
    "type" => "error",
    "message" => $exception->getMessage()
  ];

  if ($exception instanceof ValidationException) {
    $errors = $exception->getErrors();
  }
}

$alertType = "";

if ($message["type"] == "error") {
  $alertType = "danger";
} else {
  $alertType = "success";
}
?>

<?php if ($message): ?>
  <div role="alert" class="mb-4 mt-2 alert alert-<?= $alertType ?>">
    <?= $message["message"] ?>
  </div>
<?php endif ?>
