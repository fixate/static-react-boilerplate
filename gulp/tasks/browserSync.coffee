gulp         = require "gulp"

gulp.task 'browser-sync', () ->
  global.browserSync.init {
    server:
      baseDir: './dist'
    injectchanges: true
    open: false
    # notify: false
    # tunnel: true
  }

gulp.task 'bs-reload', () ->
  global.browserSync.reload()
