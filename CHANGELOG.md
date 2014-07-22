# master 

# Version 0.3.9

* removed a stray file from gemspec [Alessandro Tagliapietra]
* updated bundle [John Cupitt]
* revised spec tests [John Cupitt]
* fix a segv in im.label_regions [John Cupitt]
* add a Valgrind suppressions file [John Cupitt]
* fix .monotonic? [John Cupitt]
* fix .data on coded images [John Cupitt]
* add .size, see issue #58 [John Cupitt]
* add rdoc-data dep, maybe it will help ruby-gems docs [John Cupitt]

# Version 0.3.8

* add VIPS::thread_shutdown(), must be called on foreign thread exit [John Cupitt]

# Version 0.3.7

* update build dependencies [John Cupitt]
* README updated [John Cupitt]

# Version 0.3.6

* add png and jpg load from memory buffer [John Cupitt]
* README updated to include buffer read/write example [John Cupitt]
* better vips version testing [John Cupitt]
* spec tests for new buffer read/write code [John Cupitt]
* fix rdoc build to include C sources [John Cupitt]
* better compat with older libvips [John Cupitt]

# Version 0.3.5

* rb_raise() in mask.c no longer passes a string pointer as the fmt arg, stopping gcc bailing out on some platforms [John Cupitt]
* Image.magick() now calls im_magick2vips() directly rather than relying on libvips file type sniffing [John Cupitt]

# Version 0.3.4

* Update specs for lcms changes, thanks Stanislaw [John Cupitt]
* VIPS::Reader supports .exif() / .exif?() methods for better back compat, thanks Jeremy [John Cupitt]
* VIPS::Reader fallbacks load the image if its not been loaded [John Cupitt]
* VIPS::Reader no longer allows VIPS::Header methods [John Cupitt]

# Version 0.3.3

* Typo in workaround in 0.3.2 [John Cupitt]

# Version 0.3.2

### Fixed

* Workaround helps ruby-vips compile (and run) against 7.26.3 [John Cupitt and 
James Harrison]

# Version 0.3.1

### Fixed

* PNG writer no longer changes the filename argument [John Cupitt]
* Workaround helps ruby-vips compile against 7.26.3 [John Cupitt]
* Image read now runs GC and retries on fail [John Cupitt]
* Image write GCs every 100 images [John Cupitt]

# Version 0.3.0

Release date: 2012-07-20

### Added

* More rspec tests [John Cupitt]
* Updated to libvips-7.30 [John Cupitt]

### Changed

* Reworked Reader class offers better performance and compatibility [John
  Cupitt]
* Don't use :sequential option for older libvipses [John Cupitt]
* Rename "tone_analyze" as "tone_analyse" for consistency with the rest of
  vips [John  CUpitt]

### Fixed

* Now passes rspec test suite cleanly in valgrind [John Cupitt]
* Fixed check of sequential mode support [Stanislaw Pankevich]

# Version 0.2.0

Release date: 2012-06-29

### Added

* Add tile_cache [John Cupitt]
* Add :sequential option to tiff, jpeg and png readers [John Cupitt]
* Add raise if suitable pkg_config for libvips is not found, thanks to Pierre
  Chapuis [Stanislaw Pankevich]
* Add backward compatibility of 0.1.x ruby-vips with libvips versions less than 7.28 [John Cupitt]
* Add Travis. ruby-vips now is being tested on travis-ci.org. [Stanislaw Pankevich]

### Changed

* Disable the vips8 operation cache to save some memory [John Cupitt]
* Update example shrinker [John Cupitt]

### Fixed

* #8: Memory allocation-free issues [Grigoriy Chudnov]

# Version 0.1.1

Release date: 2012-06-22

### Changed

* Upgrade spec/* code to latest RSpec  [Stanislaw Pankevich]

### Added

* Added CHANGELOG.md file (thanks to jnicklas/capybara - using the layout of their History.txt) [Stanislaw Pankevich]
* Added Gemfile with the only 'rspec' dependency. [Stanislaw Pankevich]
* Added Jeweler Rakefile contents to release ruby-vips as a gem. [Stanislaw Pankevich]

# Before (initial unreleased version 0.1.0)

Long-long history here undocumented...
