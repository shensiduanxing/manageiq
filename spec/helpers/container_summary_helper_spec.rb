describe ContainerSummaryHelper do
  let(:container_project)     { FactoryGirl.create(:container_project) }
  let(:rel_hash_with_link)    { [:label, :image, :value, :link, :title] }
  let(:rel_hash_without_link) { [:label, :image, :value] }

  before do
    self.class.send(:include, ApplicationHelper)

    @record = FactoryGirl.build(:container_group, :container_project => container_project)
  end

  context ".textual_container_project" do
    subject { textual_container_project }

    it 'show link when role allows' do
      stub_user(:features => :all)
      expect(subject.keys).to eq(rel_hash_with_link)
      expect(subject[:value]).to eq(container_project.name)
    end

    it 'hide link when role does not allow' do
      stub_user(:features => :none)
      expect(subject.keys).to eq(rel_hash_without_link)
      expect(subject[:value]).to eq(container_project.name)
    end
  end

  context ".textual_containers" do
    before  { 2.times { FactoryGirl.create(:container, :container_group => @record) } }
    subject { textual_containers }

    it 'show link when role allows' do
      stub_user(:features => :all)
      expect(subject.keys).to eq(rel_hash_with_link)
      expect(subject[:value]).to eq("2")
    end

    it 'hide link when role does not allow' do
      stub_user(:features => :none)
      expect(subject.keys).to eq(rel_hash_without_link)
      expect(subject[:value]).to eq("2")
    end
  end
end
