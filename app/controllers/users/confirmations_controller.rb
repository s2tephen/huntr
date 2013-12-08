class Users::ConfirmationsController < Devise::ConfirmationsController
  protected

  # blacklist a user
  def blacklist
    self.resource = resource_class.confirm_by_token(params[:confirmation_token])
    resource.destroy
    bl_file = File.join(Rails.root, 'db', 'blacklist.yml')
    bl_hash = YAML.load(File.open(bl_file))
    bl_hash[params[:email]] = Time.now

    # save to yaml
    File.open(bl_file, "w") do |f|
      f.write(yaml(bl_hash))
    end
  end
end
