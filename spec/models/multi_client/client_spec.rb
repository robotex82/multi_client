require 'rails_helper'

module MultiClient
  RSpec.describe Client, type: :model do
    it { should validate_presence_of :identifier }
    it { FactoryGirl.create(:multi_client_client); should validate_uniqueness_of :identifier }

    it { should validate_presence_of :subdomain }
    it { FactoryGirl.create(:multi_client_client); should validate_uniqueness_of :subdomain }

    describe 'self.current_id' do
      subject { Client }

      it { should respond_to :current_id }
    end

    describe 'self.current_id=' do
      subject { Client }

      it { should respond_to :current_id= }
    end

    describe 'self.find_by_subdomain!' do
      subject { Client }

      it { should respond_to :find_by_subdomain! }
    end
  end
end
