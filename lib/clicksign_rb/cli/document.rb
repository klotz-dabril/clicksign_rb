module ClicksignRb
  module CLI
    class Document < SubCommandBase
      desc 'create_through_upload', "creates a document through file upload"
      method_option :path,  type: :string, required: true
      method_option :file,  type: :string, required: true
      method_option :token, type: :string, required: true

      method_options test:             :boolean,
                     deadline_at:      :string,
                     auto_close:       :boolean,
                     locale:           :string,
                     sequence_enabled: :boolean,
                     remind_interval:  :boolean

      def create_through_upload
        ClicksignRb.configure do |config|
          config.host = options.test? ? 'https://sandbox.clicksign.com/api' : 'https://app.clicksign.com/api'
          config.token = options.token
        end

        params = options
          .reject { |k,v| ['test', 'token'].include? k }
          .inject({}) do |acc,(k,v)|
            acc[k.to_sym] = v
            acc
          end

        puts ClicksignRb::Document.create_through_upload(**params)
      rescue StandardError => error
        Config.logger.fatal error.message

        exit 1
      end
    end
  end
end
