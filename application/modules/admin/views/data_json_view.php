<?php
  if(isset($json['header']))
    http_response_code($json['header']);
  header('Content-Type: application/json');
  echo json_encode($json);
?>
