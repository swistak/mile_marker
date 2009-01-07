# This simulates loading the mile_marker gem, but without relying on
# vendor/gems

mile_marker_path = File.join(File.dirname(__FILE__), *%w(.. .. .. ..))
mile_marker_lib_path = File.join(mile_marker_path, "lib")

$LOAD_PATH.unshift(mile_marker_lib_path)
load File.join(mile_marker_path, 'init.rb')

