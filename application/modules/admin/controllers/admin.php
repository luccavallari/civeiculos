<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Admin extends MY_Controller{
	public function index(){
		
	}

	public function deleteSetup(){
		
		echo file_exists(APPPATH."modules\\admin\\controllers\\setup.php");
		echo file_exists(APPPATH."modules\\admin\models\\setup_model.php");
		echo file_exists(APPPATH."modules\\admin\\views\\setup");
		echo file_exists(FCPATH."assets\\dist\\js\\setupapp.angular.min.js");
		echo file_exists(FCPATH."assets\\dist\\html\\setup");
		redirect('admin');

	}
}