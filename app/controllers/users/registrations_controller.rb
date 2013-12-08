class Users::RegistrationsController < Devise::RegistrationsController
  protected

  before_filter :check_user_status, only: :create

  def check_user_status
    bl_file = File.join(Rails.root, 'db', 'blacklist.yml')
    bl_hash = YAML.load(File.open(bl_file))
    if bl_hash.has_key?(params[:email])
      if ((Time.now - Time.parse(bl_hash[params[:email]])) / 3600 > 24) # more than 24 hours elapsed
        bl_hash.delete(params[:email])
        # save to yaml
        File.open(bl_file, "w") do |f|
          f.write(yaml(bl_hash))
        end
      else
        redirect_to new_user_session_path and return # prevent registration
      end
    end
  end
end
