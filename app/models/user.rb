class User < ApplicationRecord
    def send_thanks_letter
        client = CodenbergClient.new(Rails.application.secrets.codenberg_api_key, Rails.application.secrets.codenberg_secret)
        client.create_order(Rails.application.secrets.codenberg_template_id,
                            postal_code,
                            prefecture,
                            city,
                            address,
                            name,
                            tel,
                            [{id: Rails.application.secrets.codenberg_custom_field_id, value: name}]
                            )
    end
end
