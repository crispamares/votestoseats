# Be sure to restart your server when you modify this file.

Rails.application.config.serve_static_assets = true

#Rails.application.config.assets.enabled = false
#Rails.application.config.assets.initialize_on_precompile = false

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added. province/dhondt.js
Rails.application.config.assets.precompile += ['province/province.js', 'general/general.js', 'common/participation_bar.js',
	'common/tabulate_json.js', 'general.css', 'province.css', 'templates/province/dhont_table.js', 'templates/general/results_table.js']
