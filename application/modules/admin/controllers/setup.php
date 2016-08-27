<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Setup extends MY_Controller{

  public function __construct(){
    parent::__construct();
    $this->load->model('Setup_model','mSetup');
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
      $input_post = $this->utilities->jsonPost(NULL,FALSE,'admin/setup');
      if($input_post)
        $data['json'] = $this->mSetup->databaseCheck($input_post);
      else
        $data['json'] = [
          'header'=>400,
          'status'=>FALSE,
          'message'=>'Requesição inválida.'
        ];
      $this->load->view('data_json_view', $data);
  }

  
  
  public function createTablesDataBase(){

    if($this->utilities->checkRequest('POST','admin/setup')){
      $data['json'] = $this->mSetup->createTables();
    }else{
      $data['json'] = [
        'header'=>400,
        'status'=>FALSE,
        'message'=>'Requesição inválida.'
      ];
    }
    $this->load->view('data_json_view', $data);
  }

  /**
   * createUser
   */
  public function createUser(){
    if($this->utilities->checkRequest('POST','admin/setup')){
      $data['json'] = $this->mSetup->createUser($this->utilities->jsonPost());
    }else{
      $data['json'] = [
        'header'=>400,
        'status'=>FALSE,
        'message'=>'Requesição inválida.'
      ];
    }
    $this->load->view('data_json_view', $data);
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
