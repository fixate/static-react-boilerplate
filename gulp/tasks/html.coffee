gulp        = require "gulp"
jade        = require "gulp-jade"
minifyHTML  = require "gulp-minify-html"
conf        = require('../gulpconfig')
handleError = require('../lib/handle-error')

gulp.task "html", () ->
  gulp.src(["#{conf.path.dev.base}/index.jade"])
    .pipe jade().on 'error', handleError
    .pipe minifyHTML({conditionals: true})
    .pipe gulp.dest(conf.path.dest)
