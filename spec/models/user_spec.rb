require 'spec_helper'

RSpec.describe User, type: :model do
  before(:all) do
    @subject = User.new(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Poland.')
  end

  # it 'title should be present' do
  #   subject.name = nil
  #   expect(@subject).to_not be_valid
  # end

  # it 'photo should be present' do 
  #   subject.photo = nil
  #   expect(@subject).to_not be_valid
  # end

end
