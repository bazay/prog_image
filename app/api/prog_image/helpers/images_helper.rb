module ProgImage
  module Helpers
    module ImagesHelper
      def image_convert_form
        @image_convert_form ||= ::ProgImage::ImageConvertForm.new \
          params.slice(*permitted_convert_image_params)
      end

      def image_upload_form
        @image_upload_form ||= ::ProgImage::ImageUploadForm.new \
          params[:image_file].slice(*permitted_upload_image_params)
      end

      def permitted_convert_image_params
        ::ProgImage::ImageConvertForm.permitted_params
      end

      def permitted_upload_image_params
        ::ProgImage::ImageUploadForm.permitted_params
      end

      def perform_image_conversion!
        if image_convert_form.persist
          present image_convert_form, with: ProgImage::Entities::Image
        else
          say_unprocessable_entity_for image_convert_form
        end
      end

      def image_key_exists?
        file_fetcher.file_exists?
      end

      def presentable_object
        params[:extension] ? image_convert_form.persist : formatted_image_details
      end

      def formatted_image_details
        { key: file_fetcher.key, public_url: file_fetcher.fetch_file_url }
      end

      def file_fetcher
        @file_fetcher ||= ProgImage::FileFetcher.new(params[:key])
      end
    end
  end
end
