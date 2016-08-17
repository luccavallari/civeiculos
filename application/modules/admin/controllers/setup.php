<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Setup extends MY_Controller{

  public function __construct(){
    parent::__construct();
    //Codeigniter : Write Less Do More
  }

  /**
   * index
   */
  function index(){
    $data['js_inject'] = [
      'assets/dist/js/setupapp.angular.min.js'
    ];
    $this->load->view('setup/index_view',$data);
  }

  /**
   * configureDataBase
   */
  public function configureDataBase(){

  }

  /**
   * configureMasterUser
   */
  public function configureMasterUser(){

  }

  /**
   * configureSystem
   */
  public function configureSystem(){

  }

  /**
   * finishConfiguration
   */
  public function finishConfiguration(){

  }

}
