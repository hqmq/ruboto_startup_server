desc "generate dummy data"
task :gen_data => :environment do
  raise 'Only Allowed in Development Mode' unless Rails.env.development?
  packages_and_versions = [
    ['org.ruboto.benchmarks','0.1.0'],
    ['org.ruboto.startup_timer','0.9.8']
  ]
  tests = [
    'Startup',
    'Fibonacci, n=25',
    'Fibonacci, n=20',
    'Startup with image',
    'Script load',
    'RubotoCore Install',
    'require json'
  ]
  manufacturers_and_models = {
    'HTC' => ['HTC HD2'],
    'samsung' => ['GT-N7000','GT-I9100','GT-I9300'],
    'asus' => ['Nexus 7']
  }
  android_versions = [
    '4.0.3','4.0.1','4.1.1','4.1.2','4.2','2.2','2.3.6'
  ]
  ruboto_platform_versions = [
    '0.4.7','0.4.9'
  ]
  ruboto_app_versions = [
    '0.6.1','0.7.1'
  ]
  compile_modes = ['OFF','OFFIR']
  ruby_versions = ['1_8','1_9']
  dates = [
    "2012-12-01 12:45:00",
    "2012-12-06 15:23:54",
    "2012-11-15 18:32:02"
  ].map{ |str| Time.zone.parse(str) }

  Measurement.destroy_all

  100.times do
    pv = packages_and_versions.shuffle.first
    package = pv.first
    version = pv.last
    test = tests.shuffle.first
    manufacturer = manufacturers_and_models.keys.shuffle.first
    model = manufacturers_and_models[manufacturer].shuffle.first
    android_version = android_versions.shuffle.first
    ruboto_platform_version = ruboto_platform_versions.shuffle.first
    ruboto_app_version = ruboto_app_versions.shuffle.first
    compile_mode = compile_modes.shuffle.first
    ruby_version = ruby_versions.shuffle.first

    m = Measurement.new({
      :duration => 1000 + rand(10_000),
      :package => package,
      :package_version => version,
      :manufacturer => manufacturer,
      :model => model,
      :android_version => android_version,
      :ruboto_platform_version => ruboto_platform_version,
      :ruboto_app_version => ruboto_app_version,
      :test => test,
      :compile_mode => compile_mode,
      :ruby_version => ruby_version
    })
    m.created_at = dates.shuffle.first
    m.save!
  end
end
