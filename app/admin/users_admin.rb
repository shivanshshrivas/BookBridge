Trestle.resource(:users) do
  menu do
    item :users, icon: "fa fa-star"
  end

  # Customize the table columns shown on the index view.
  #
  table do
    column :name
    column :email
    column :university
    column :is_admin
    column :created_at, align: :center
    actions
  end

  # Customize the form fields shown on the new/edit views.
  #
  form do |user|
    text_field :name
    text_field :email
    text_field :university
    check_box :is_admin, label: "isAdmin"
    file_field :profile_picture, label: "Profile Picture"
    text_area :profile_bio, label: "Bio"
  end

  # By default, all parameters passed to the update and create actions will be
  # permitted. If you do not have full trust in your users, you should explicitly
  # define the list of permitted parameters.
  #
  # For further information, see the Rails documentation on Strong Parameters:
  #   http://guides.rubyonrails.org/action_controller_overview.html#strong-parameters
  #
  # params do |params|
  #   params.require(:user).permit(:name, ...)
  # end
end
