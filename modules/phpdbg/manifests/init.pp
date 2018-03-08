# A Chassis extension to install and configure Phpdbg on your Chassis server
class phpdbg (
	$config,
	$path = '/vagrant/extensions/phpdbg',
) {
	if ( ! empty( $config[disabled_extensions] ) and 'chassis/phpdbg' in $config[disabled_extensions] ) {
		$package = absent
	} else {
		$package = latest
	}

	if versioncmp( $config[php], '5.4') <= 0 {
		$php_package = 'php5'
	} else {
		$php_package = "php${config[php]}"
	}

	package { "${php_package}-phpdbg":
		ensure  => $package,
		require => [ Package["${php_package}-cli"], Package["${php_package}-fpm"] ],
		notify  => Service["${php_package}-fpm"]
	}
}
