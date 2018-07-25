require 'yaml'

desc 'Tasks related to the application'
namespace :prog_image do
  desc 'Setup the application'
  task :setup do
    module Setup
      class << self
        def execute
          create_application_yml_file(*request_aws_credentials)
          say 'Setup complete'
        end

        private

        def request_aws_credentials
          access_key_id = ask 'Please paste your AWS access_key_id: '
          access_key = ask 'Please paste your AWS access_key: '
          [access_key_id, access_key]
        end

        def create_application_yml_file(access_key_id, access_key)
          application_config_path = File.join('config', 'application.yml')
          application_config = build_application_config(access_key_id, access_key)
          File.write(application_config_path, application_config.to_yaml)
          say 'application.yml successfully created in config/ folder'
        end

        def build_application_config(access_key_id, access_key)
          sample_file_path = File.join('config', 'application.sample.yml')
          YAML.load_file(sample_file_path).tap do |config|
            config['AWS_ACCESS_KEY_ID'] = access_key_id
            config['AWS_ACCESS_KEY'] = access_key
          end
        end

        def ask(message)
          say message
          STDIN.gets.strip
        end

        def say(message)
          STDOUT.puts message
        end
      end
    end

    Setup.execute
  end
end
