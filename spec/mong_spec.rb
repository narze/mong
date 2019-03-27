RSpec.describe Mong do
  it "has a version number" do
    expect(Mong::VERSION).not_to be nil
  end

  shared_examples 'default' do |input, result|
    context "when time is #{input}" do
      let(:time) { input }

      it "returns #{result}" do
        is_expected.to eq result
      end
    end
  end

  shared_examples 'error' do |input, result|
    context "when time is #{input}" do
      let(:time) { input }

      it "raise Mong::ParseError" do
        expect { subject }.to raise_error(Mong::ParseError)
      end
    end
  end

  describe "#parse_minute" do
    subject { Mong.parse_minute(time) }

    it_behaves_like 'default', "00", "ศูนย์นาที"
    it_behaves_like 'default', "0", "ศูนย์นาที"
    it_behaves_like 'default', "01", "หนึ่งนาที"
    it_behaves_like 'default', "15", "สิบห้านาที"
    it_behaves_like 'error', "-1"
    it_behaves_like 'error', "60"
  end

  describe "#parse_hour" do
    subject { Mong.parse_hour(time) }

    let(:time) { "00" }

    it_behaves_like 'default', "00", "เที่ยงคืน"
    it_behaves_like 'default', "0", "เที่ยงคืน"
    it_behaves_like 'default', "01", "ตีหนึ่ง"
    it_behaves_like 'default', "15", "บ่ายสามโมง"
    it_behaves_like 'error', "-1"
    it_behaves_like 'error', "24"
  end

  describe '#parse_hour_and_minute' do
    subject { Mong.parse_hour_and_minute(time) }

    it_behaves_like 'default', "03:25", "ตีสามยี่สิบห้านาที"
    it_behaves_like 'default', "01:00", "ตีหนึ่งศูนย์นาที"
    it_behaves_like 'error', "24:00"
    it_behaves_like 'error', "01:60"
  end

  describe '#parse' do
    subject { Mong.parse(time) }

    it_behaves_like 'default', Time.new(2002, 10, 31, 2, 2, 2), "ตีสองสองนาที"
  end
end
