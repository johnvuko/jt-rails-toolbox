module Jt
	class ToolboxGenerator < Rails::Generators::Base
		source_root File.expand_path("../templates", __FILE__)

		def create_initializer_file
			copy_file "jt-toolbox.yml", "config/jt-toolbox.yml"
		end
	end
end