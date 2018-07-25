module ProgImage
  module Api
    class V10::Images < Grape::API
      helpers do
        def image_upload_form
          @image_upload_form ||= ::ProgImage::ImageUploadForm.new \
            params[:image_file].slice(*permitted_image_file_params)
        end

        def fetched_image
          @fetched_image ||= file_fetcher.fetch
        end

        def formatted_fetched_image
          { key: file_fetcher.key, public_url: fetched_image.public_url }
        end

        def file_fetcher
          @file_fetcher ||= ProgImage::FileFetcher.new(params[:key])
        end

        def formatted_image_key(response)
          { key: response }
        end

        def formatted_image(response)
          { key: params[:key], public_url: response.public_url }
        end

        def permitted_image_file_params
          ::ProgImage::ImageUploadForm.permitted_params
        end
      end

      namespace :images do
        desc 'Upload an image'
        params do
          requires :image_file, type: File, desc: 'The multipart file to upload'
        end
        post '/' do
          if image_upload_form.persist
            present image_upload_form, with: ProgImage::Entities::ImageKey
          else
            say_unprocessable_entity_for image_upload_form
          end
        end

        desc 'View an image'
        params do
          requires :key, type: String, desc: 'The key returned when performing POST request for an image'
        end
        get :view do
          if fetched_image.exists?
            present fetched_image, with: ProgImage::Entities::Image
          else
            say_not_found
          end
        end
      end
    end
  end
end
