<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>Instalar o CIV Revendas</title>
    <link rel="stylesheet" href="<?php echo base_url('assets/dist/css/style.min.css')?>" media="screen" title="no title" charset="utf-8">
    <link rel="stylesheet" href="<?php echo base_url('assets/dist/css/panel_style.min.css')?>" media="screen" title="no title" charset="utf-8">
  </head>
  <body class="setup-body" ng-app="setupApp">
    <div class="container-fluid">
      <div class="row">
        <div class="col-md-2 col-md-offset-5 box-setup">
          <div ng-view=""></div>
        </div>
      </div>
    </div>
  </body>
  <script src="<?php echo base_url('assets/dist/js/components.min.js');?>"></script>
  <script src="<?php echo base_url('assets/dist/js/angular_components.min.js');?>"></script>
  <?php if(isset($js_inject)):
          foreach ($js_inject as $js): ?>
  <script src="<?php echo base_url($js);?>"></script>
<?php     endforeach;
        endif; ?>
</html>
