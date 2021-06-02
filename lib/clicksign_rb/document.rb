# frozen_string_literal: true


module ClicksignRb
  module Document
    class << self
      def create_through_upload(
        file:,
        path:,
        deadline_at: nil,
        auto_close: true,
        locale: 'pt-BR',
        sequence_enabled: false,
        remind_interval: nil
      )
        Dispatcher.new.post(
          '/documents',
          {
            document: {
              path:             path,
              content_base64:   "data:application/pdf;base64,#{base_64_encoded_file(file)}",
              deadline_at:      deadline_at,
              auto_close:       auto_close,
              locale:           locale,
              sequence_enabled: sequence_enabled,
              remind_interval:  remind_interval
            }
          }
        )
      end


      private
        def base_64_encoded_file(file)
          Base64.encode64(File.open(file).read)
        end
    end
  end
end
