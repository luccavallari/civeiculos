<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Setup_model extends CI_Model {
	
	public function databaseCheck($data){
		
		$checking = [
			'status' 	=> FALSE,
			'message' 	=> NULL
		];

		$this->saveDatabaseConfig($data);

		try{
		    if (@$this->load->database()){
		        $query = $this->db->query("SELECT COUNT(*) AS total FROM information_schema.tables WHERE table_schema = '".$data['db_name']."' LIMIT 1;");
				if($query->result()[0]->total){
					throw new Exception("A base de dados não esta vazia.",1);
				}
				else{
					$checking = [
						'status' 	=> TRUE,
						'message' 	=> NULL
					];
				}	
		    }
		    else{
				throw new Exception("Não foi possivel se conectar à base de dados",1);
			}
		}
		catch (Exception $e){
			$this->saveDatabaseConfig();
			$checking = [
				'header'	=> 406,
				'status' 	=> FALSE,
				'message' 	=> $e->getMessage()
			];
		}

		return $checking;
	}

	
	public function createTables($file = NULL){

		
		$sql_files = $this->sqlFileManager(NULL,TRUE);
		$ret = [
			'status' => FALSE,
			'message' => NULL,
		];

		try{
			
			foreach ($sql_files as $file) {
				$sql = $this->sqlFileManager($file);
				@$this->load->database();
				foreach ($sql as $s ) {
					$query = $this->db->query($s);
					if(!$query){
						throw new Exception("Erro ao criar a tabela. $s", 1);
					}
				}
			}

			$ret = [
				'header'=>200,
				'status'=>TRUE,
				'message'=>NULL,
			];
				
				
		}
		catch(Exception $e){
			$ret =  [
				'header' => 406,
				'status' => FALSE,
				'message' => $e->getMessage()
			];
		}
		return $ret;

	}


	public function createUser($data){

		$ret = [
			'status' => FALSE,
			'message' => NULL,
		];

		/*

			INSERT INTO permissoes (
				permissoes.perm_id_usuario, permissoes.perm_categorias, permissoes.perm_combustiveis,
				permissoes.perm_imagens, permissoes.perm_marcas, permissoes.perm_modelos, permissoes.perm_opcionais,
				permissoes.perm_tipo_venda, permissoes.perm_usuarios, permissoes.perm_veiculos, permissoes.perm_permissoes
			) VALUES (
				NEW.usu_id,
				COLUMN_CREATE('editar',FALSE,'adicionar',FALSE,'visualizar',TRUE,'deletar',FALSE),
				COLUMN_CREATE('editar',FALSE,'adicionar',FALSE,'visualizar',TRUE,'deletar',FALSE),
				COLUMN_CREATE('editar',FALSE,'adicionar',FALSE,'visualizar',TRUE,'deletar',FALSE),
				COLUMN_CREATE('editar',FALSE,'adicionar',FALSE,'visualizar',TRUE,'deletar',FALSE),
				COLUMN_CREATE('editar',FALSE,'adicionar',FALSE,'visualizar',TRUE,'deletar',FALSE),
				COLUMN_CREATE('editar',FALSE,'adicionar',FALSE,'visualizar',TRUE,'deletar',FALSE),
				COLUMN_CREATE('editar',FALSE,'adicionar',FALSE,'visualizar',TRUE,'deletar',FALSE),
				COLUMN_CREATE('editar',FALSE,'adicionar',FALSE,'visualizar',TRUE,'deletar',FALSE),
				COLUMN_CREATE('editar',FALSE,'adicionar',FALSE,'visualizar',TRUE,'deletar',FALSE),
			                  	COLUMN_CREATE('editar',FALSE,'visualizar',TRUE)
			)

			UPDATE permissoes SET
				
				
				
				
				
				
				
			 

		*/

		//$sql = "INSERT INTO usuarios(usu_nome,usu_email,usu_senha,usu_status)VALUES('".$data['nome']."','".$data['email']."','".md5($data['senha'])."','1');";
		
		$this->load->database();
		
		try{
			$query = $this->db->insert('usuarios',['usu_nome'=>$data['nome'],'usu_email'=>$data['email'],'usu_senha'=>md5($data['senha']),'usu_status'=>1]);
			
			if(!$query){
				throw new Exception("Ocorreu um erro ao inserir um novo administrador do sistema.", 1);
			}else{

				$upd =  "UPDATE permissoes SET ";
				$upd .= "permissoes.perm_categorias = COLUMN_CREATE('editar',TRUE,'adicionar',TRUE,'visualizar',TRUE,'deletar',TRUE),";
				$upd .= "permissoes.perm_combustiveis = COLUMN_CREATE('editar',TRUE,'adicionar',TRUE,'visualizar',TRUE,'deletar',TRUE),";
				$upd .= "permissoes.perm_imagens = COLUMN_CREATE('editar',TRUE,'adicionar',TRUE,'visualizar',TRUE,'deletar',TRUE),";
				$upd .= "permissoes.perm_marcas = COLUMN_CREATE('editar',TRUE,'adicionar',TRUE,'visualizar',TRUE,'deletar',TRUE),";
				$upd .= "permissoes.perm_modelos = COLUMN_CREATE('editar',TRUE,'adicionar',TRUE,'visualizar',TRUE,'deletar',TRUE),";
				$upd .= "permissoes.perm_opcionais = COLUMN_CREATE('editar',TRUE,'adicionar',TRUE,'visualizar',TRUE,'deletar',TRUE),";
				$upd .= "permissoes.perm_tipo_venda = COLUMN_CREATE('editar',TRUE,'adicionar',TRUE,'visualizar',TRUE,'deletar',TRUE),";
				$upd .= "permissoes.perm_usuarios = COLUMN_CREATE('editar',FALSE,'adicionar',FALSE,'visualizar',TRUE,'deletar',FALSE),";
				$upd .= "permissoes.perm_veiculos = COLUMN_CREATE('editar',FALSE,'adicionar',FALSE,'visualizar',TRUE,'deletar',FALSE),";
				$upd .= "permissoes.perm_permissoes = COLUMN_CREATE('editar',TRUE,'adicionar',TRUE,'visualizar',TRUE,'deletar',TRUE) ";
				$upd .= "WHERE permissoes.perm_id_usuario=".$this->db->insert_id();

				$update_permissoes = $this->db->query($upd);
				if(!$update_permissoes){
					throw new Exception("Ocorreu um erro a definir as permissões de administrador do sistema", 1);
				}
			}
			$ret = [
				'header'=>200,
				'status'=>TRUE,
				'message'=>NULL,
			];
		}catch(Exception $e){
			$ret =  [
				'header' => 406,
				'status' => FALSE,
				'message' => $e->getMessage()
			];
		}

		return $ret;
	}

	private function sqlFileManager($file = NULL, $files_directory = FALSE){
		$this->load->helper('file');

		if($files_directory){
			return get_filenames('./sql_structure/');
		}
		elseif($file){
			$sql = read_file('./sql_structure/'.$file);
			$sql = explode(';',$sql);
			array_pop($sql);
			return $sql;	
		}
		
	}


	private function saveDatabaseConfig($data = NULL){

		$hostname = (isset($data['db_server'])) ? $data['db_server'] : NULL;
		$username = (isset($data['db_user'])) ? $data['db_user'] : NULL;
		$password = (isset($data['db_password'])) ? $data['db_password'] : NULL;
		$database = (isset($data['db_name'])) ? $data['db_name'] : NULL;

		$this->load->helper('file');
		
		$default_database =  '<?php defined(\'BASEPATH\') OR exit(\'No direct script access allowed\');'."\n";
		$default_database .= '$active_group = \'default\';'."\n";
		$default_database .= '$query_builder = TRUE;'."\n"; 
		$default_database .= '$query_builder = TRUE;'."\n"; 
		$default_database .= '$db[\'default\'] = array('."\n\t"; 
		$default_database .= '\'dsn\'	=> \'\','."\n\t"; 
		$default_database .= '\'hostname\' => \''.$hostname.'\','."\n\t";
		$default_database .= '\'username\' => \''.$username.'\','."\n\t";
		$default_database .= '\'password\' => \''.$password.'\','."\n\t";
		$default_database .= '\'database\' => \''.$database.'\','."\n\t";
		$default_database .= '\'dbdriver\' => \'mysqli\','."\n\t";
		$default_database .= '\'dbprefix\' => \'\','."\n\t";
		$default_database .= '\'pconnect\' => FALSE,'."\n\t";
		$default_database .= '\'db_debug\' => FALSE,'."\n\t";
		$default_database .= '\'cache_on\' => FALSE,'."\n\t";
		$default_database .= '\'cachedir\' => \'\','."\n\t";
		$default_database .= '\'char_set\' => \'utf8\','."\n\t";
		$default_database .= '\'dbcollat\' => \'utf8_general_ci\','."\n\t";
		$default_database .= '\'swap_pre\' => \'\','."\n\t";
		$default_database .= '\'encrypt\' => FALSE,'."\n\t";
		$default_database .= '\'compress\' => FALSE,'."\n\t";
		$default_database .= '\'stricton\' => FALSE,'."\n\t";
		$default_database .= '\'failover\' => array(),'."\n\t";
		$default_database .= '\'save_queries\' => TRUE'."\n";
		$default_database .= ');';

		write_file('./application/config/database.php', $default_database, 'wb');

	}
	



}

/* End of file setup_model.php */
/* Location: ./application/modules/admin/models/setup_model.php */