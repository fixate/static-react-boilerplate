gulp       = require "gulp"
gutil      = require "gulp-util"
assign     = require "lodash/object/assign"
babelify   = require "babelify"
browserify = require "browserify"
es         = require "event-stream"
eslint     = require "gulp-eslint"
rename     = require "gulp-rename"
source     = require "vinyl-source-stream"
buffer     = require "vinyl-buffer"
watchify   = require 'watchify'
sourcemaps = require 'gulp-sourcemaps'

conf       = require("../gulpconfig")


#*------------------------------------*\
#     $COMPILE JS
#*------------------------------------*/
customOpts =
  entries: "#{conf.path.dev.js}/index.jsx"
  debug: true

opts = assign({}, watchify.args, customOpts)
b = watchify(browserify(opts))

b.transform(babelify, presets: ['es2015', 'react', 'stage-0'], plugins: ['transform-class-properties'])

bundle = ->
  b.bundle()
    .on('error', gutil.log.bind(gutil, 'Browserify Error'))
    .pipe(source('bundle.js'))
    .pipe(buffer())
    .pipe(sourcemaps.init(loadMaps: true))
    .pipe(sourcemaps.write('./'))
    .pipe gulp.dest("#{conf.path.dest}/assets/js")
    .pipe global.browserSync.reload({stream: true})

# so you can run `gulp js` to build the file
b.on 'update', bundle
# on any dep update, runs the bundler
b.on 'log', gutil.log

gulp.task "scripts", bundle







#*------------------------------------*\
#     $LINT
#*------------------------------------*/
gulp.task 'scripts:lint',  () ->
  files = [
    "#{path.dev.js}/**/!(*.bundle).{js,jsx}"
  ]

  gulp.src(files)
    .pipe(eslint())
    .pipe(eslint.format())
