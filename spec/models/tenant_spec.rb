require 'rails_helper'

RSpec.describe Tenant, :type => :model do
  describe '::current' do
    let(:tenant) { build_stubbed(:tenant) }
    before { expect(Apartment::Tenant).to receive(:current).and_return('mine') }

    specify do
      expect(Tenant).to receive(:find_by).with(database: 'mine').and_return(tenant)
      expect(Tenant.current).to eq(tenant)
    end
  end

  describe 'validations' do
    subject(:tenant) { described_class.new }

    it { is_expected.to validate_presence_of(:name) }

    it { is_expected.to validate_presence_of(:domain) }
    it { is_expected.to allow_value("valid-domain-1234567890").for(:domain) }
    it { is_expected.to_not allow_value("invalid_domain", "INVALID-DOMAIN").for(:domain) }

    it { is_expected.to validate_presence_of(:database) }
    it { is_expected.to allow_value("valid_database_1234567890").for(:database) }
    it { is_expected.to_not allow_value("invalid-database", "INVALID_DATABASE").for(:database) }

    context "unique" do
      subject { create(:tenant) }

      it { is_expected.to validate_uniqueness_of(:name) }
      it { is_expected.to validate_uniqueness_of(:domain) }
      it { is_expected.to validate_uniqueness_of(:database) }
    end
  end

  describe '#enable!' do
    subject(:tenant) { create(:tenant, enabled: false) }

    specify do
      expect {
        tenant.enable!
      }.to change { tenant.enabled? }.from(false).to(true)
    end
  end

  describe '#disable!' do
    subject(:tenant) { create(:tenant, enabled: true) }

    specify do
      expect {
        tenant.disable!
      }.to change { tenant.enabled? }.from(true).to(false)
    end
  end

  describe '#switch!' do
    let(:tenant) { build_stubbed(:tenant, database: 'mydb') }

    specify do
      expect(Apartment::Tenant).to receive(:switch).with('mydb')
      tenant.switch!
    end
  end
end
