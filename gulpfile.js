var gulp = require('gulp');
var coffee = require('gulp-coffee');
var gutil = require('gulp-util');
var mocha = require('gulp-mocha');

gulp.task('test', function() {
  gulp.src(['build/test/*.js'], {
    read: false
  })
    .pipe(mocha({
      reporter: 'spec',
      globals: {
        should: require('should')
      }
    })).on('error', function handleError(err) {
      console.log(err.toString());
      this.emit('end');
    });
});



gulp.task('coffee', function() {
  gulp.src(['./**/*.coffee', '!./node_modules/**'])
    .pipe(coffee()
      .on('error', gutil.log))
    .pipe(gulp.dest('./build'));
});

gulp.task('watch', function() {
  gulp.watch('./**/*.coffee', ['coffee', 'test']);
});

gulp.task('default', ['watch']);
