var gulp = require('gulp');
var concat      = require('gulp-concat');
var uglify      = require('gulp-uglify');
var strip       = require('gulp-strip-comments');
var cssmin      = require('gulp-cssmin');
var rename      = require('gulp-rename');
var imageop     = require('gulp-image-optimization');
var minifyHTML  = require('gulp-minify-html');
var jshint      = require('gulp-jshint');
var less        = require('gulp-less');


var dest_js     = 'assets/dist/js';
var dest_css    = 'assets/dist/css';
var dest_images = 'assets/dist/images';
var dest_html   = 'assets/dist/html';
var dest_fonts  = 'assets/dist/fonts';

var images_files = [
  'assets/src/images/*.png',
  'assets/src/images/*.jpg',
  'assets/src/images/*.gif',
  'assets/src/images/*.jpeg',
  'assets/src/images/*.svg',
  'assets/src/images/*.ico'
];

var html_files = [
  'assets/src/html/**/*.html'
];

var less_files = [
  'assets/src/less/*.less'
];

var style_files = [
  'bower_components/bootstrap/dist/css/*.min.css',
  'bower_components/font-awesome/css/font-awesome.min.css',
  'assets/src/css/*.css'
];

var fonts_files = [
  'bower_components/bootstrap/dist/fonts/*.*',
  'bower_components/font-awesome/fonts/*.*'
];

var angular_files = [
  'bower_components/angular/angular.min.js',
  'bower_components/angular-route/angular-route.min.js',
];
var js_files = [
  'bower_components/jquery/dist/jquery.min.js',
  'bower_components/bootstrap/dist/js/bootstrap.min.js',
  'bower_components/bootstrap3-dialog/dist/js/bootstrap-dialog.min.js',
  'assets/src/js/system.js'
];
var app_files = [
  'assets/src/js/*.angular.js'
];


gulp.task('jshint', function () {
  gulp.src(app_files)
    .pipe(jshint());
  gulp.src('assets/src/js/system.js')
    .pipe(jshint());
});

gulp.task('minify-html', function() {
  return gulp.src(html_files)
    .pipe(minifyHTML({ empty: true }))
    .pipe(gulp.dest(dest_html));
});

gulp.task('appBuild',function(){
  gulp.src(app_files)
    .pipe(uglify())
    .pipe(rename({suffix: '.min'}))
    .pipe(gulp.dest(dest_js))
});

gulp.task('jsBuild',function(){
  gulp.src(js_files)
    .pipe(concat('components.min.js'))
    .pipe(uglify())
    .pipe(gulp.dest(dest_js))
});

gulp.task('less',function(){
  gulp.src(less_files)
    .pipe(less())
    .pipe(cssmin())
    .pipe(rename({suffix: '.min'}))
    .pipe(gulp.dest(dest_css))
});

gulp.task('styleBuild',function(){
  gulp.src(style_files)
    .pipe(strip.text())
    .pipe(concat('style.css'))
    .pipe(cssmin())
    .pipe(rename({suffix: '.min'}))
    .pipe(gulp.dest(dest_css))
  gulp.src(fonts_files)
    .pipe(gulp.dest(dest_fonts))
});

gulp.task('imagesCompress', function() {
    gulp.src(images_files)
      .pipe(imageop({optimizationLevel: 2,}))
      .pipe(gulp.dest(dest_images));
});

gulp.task('angularBuild',function(){
  gulp.src(angular_files)
    .pipe(strip())
    .pipe(concat('angular_components.min.js'))
    .pipe(uglify())
    .pipe(gulp.dest(dest_js))
});

gulp.task('srcbuild',function(teste){
  console.log(teste);
})

gulp.task('watch', function() {
  gulp.watch(app_files, ['jshint']);
  gulp.watch(js_files, ['jshint']);
  gulp.watch(style_files, ['styleBuild']);
  gulp.watch(less_files, ['less']);
  gulp.watch(js_files, ['jsBuild']);
  gulp.watch(html_files,['minify-html']);
  gulp.watch(app_files, ['appBuild']);
  gulp.watch(images_files, ['imagesCompress']);
});

gulp.task('default',['angularBuild','styleBuild','jsBuild','minify-html','appBuild','imagesCompress'], function () {
  console.log('Default Task');
});
