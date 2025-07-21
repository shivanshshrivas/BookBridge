class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  has_one_attached :profile_picture

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  before_validation :assign_university_from_email, on: :create

  def assign_university_from_email
    return unless email.present?

    domain = email.split('@').last
    university_data = JSON.parse(File.read(Rails.root.join('config', 'universities.json')))

    match = university_data.find do |uni|
      uni['domains'].any? { |d| d.downcase == domain.downcase }
    end

    self.university = match['name'] if match
  end
end

