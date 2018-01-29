platform :ios, '9.0'

target 'VocaPro' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for VocaPro
    pod 'RealmSwift'
    pod 'SwipeCellKit'
    pod 'ChameleonFramework/Swift', :git => 'https://github.com/ViccAlexander/Chameleon.git'
    pod 'SVProgressHUD'

end

post_install do |installer|
installer.pods_project.targets.each do |target|
target.build_configurations.each do |config|
config.build_settings['CLANG_WARN_DOCUMENTATION_COMMENTS'] = 'NO'
config.build_settings['GCC_WARN_INHIBIT_ALL_WARNINGS'] = 'YES'
end
end
end

