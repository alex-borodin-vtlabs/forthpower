RSpec.describe User, type: :model do
  it { should have_many(:chat_rooms).dependent(:destroy) }
  it { should have_many(:messages).dependent(:destroy) }
  it { should have_many(:attachments).dependent(:destroy) }
  it { should validate_presence_of(:email)}

  it "should have name" do
    user = FactoryGirl.create(:user, email: "example@example.exa")
    expect(user.name).to eq("example")
  end
end
