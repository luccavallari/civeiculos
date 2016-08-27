<?php
defined('BASEPATH') OR exit('No direct script access allowed');

/**
 *
 */
class Utilities
{
  var $CI;

  function __construct()
  {
    $this->CI = & get_instance();
  }

  public function jsonPost($index = NULL,$xss_clean = FALSE){
    
    $value = json_decode(file_get_contents('php://input'),true);
    if(!empty($index))
      if(isset($value[$index]))
        return ($xss_clean === TRUE) ? $this->security->xss_clean($value[$index]) : $value[$index];
      else
        return NULL;
    else
      return ($xss_clean === TRUE) ? $this->security->xss_clean($value) : $value;
    
    
  }

  public function checkRequest($method = 'POST', $referer = NULL){
    $header = getallheaders();
    if($referer){
      if(!isset($header['Referer']) || $header['Referer'] !==  base_url($referer))
        return FALSE;
    }
    if($this->CI->input->method(TRUE) == $method){
      return TRUE;
    }
    else{
      return FALSE;
    }


  }


}
