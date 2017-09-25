require 'rails_helper'

RSpec.describe NetworkDumper, type: :model do
  let(:network_dumper) { NetworkDumper.new }

  context 'temporary file creation and checking' do
    it 'returns a temporary file name' do
      expect(network_dumper.file_name).to eq Pathname('network_files/temporaryfile')
    end

    it 'returns true if temporary file is present' do
      allow(File).to receive(:exist?).with(network_dumper.file_name).and_return(true)
      expect(network_dumper.file?).to be true
    end

    it 'returns false if temporary file is not present' do
      allow(File).to receive(:exist?).with(network_dumper.file_name).and_return(false)
      expect(network_dumper.file?).to be false
    end

    it 'changes the temporary file name to a md5 and returns its name' do
      md5 = 'bf2f2bce9d947a3563e25a431d891ee9'
      test_file = Pathname('spec/files/tempnetworkfile')
      allow(network_dumper).to receive(:file?).and_return true
      allow(File).to receive(:rename).with(test_file, network_dumper.dir_name + md5).and_return 0
      allow(network_dumper).to receive(:file_name).and_return test_file
      expect(network_dumper.file_md5).to eq network_dumper.dir_name + md5
    end

    it "raises exception when trying to change the temporary file name while it's missing" do
      allow(network_dumper).to receive(:file?).and_return false
      expect { network_dumper.file_md5 }.to raise_error(RuntimeError, "Temporary file is missing. Can't change a name")
    end
  end
end
