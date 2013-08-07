module Spreedly
  module TestCredentials

    def remote_test_environment_key
      remote_creds["environment_key"]
    end

    def remote_test_access_secret
      remote_creds["access_secret"]
    end

    private
    def remote_creds
      @@remote_creds ||= load_creds
    end

    def load_creds
      load_default_creds.merge(load_personal_creds)
    end

    def load_default_creds
      YAML.load(File.read(default_creds_file))
    end

    def load_personal_creds
      return {} unless File.exists?(personal_creds_file)

      personal_creds = YAML.load(File.read(personal_creds_file))
      return {} unless personal_creds
      raise("The file '#{personal_creds_file}' has an invalid format.\nIt should have the same format as '#{default_creds_file}'.") unless personal_creds.kind_of?(Hash)
      personal_creds
    end

    def default_creds_file
      File.join(File.dirname(__FILE__), 'credentials.yml')
    end

    def personal_creds_file
      File.join(File.dirname(__FILE__), 'personal_credentials.yml')
    end

  end
end
