RSpec.describe "uniq column cop test" do
  let(:uniq_column_csv) {
    row1 = CSV::Row.new(["header1", "header2"], ["row1_1", "row1_2"])
    row2 = CSV::Row.new(["header1", "header2"], ["row2_1", "row2_2"])
    CSV::Table.new([row1, row2])
  }
  let(:not_uniq_column_csv) {
    row1 = CSV::Row.new(["header1", "header2"], ["row1_1", "row1_2"])
    row2 = CSV::Row.new(["header1", "header2"], ["row1_1", "row2_2"])
    CSV::Table.new([row1, row2])
  }

  let(:enable_config) { CsvCop::Config.new.read }
  let(:disable_config) {
    disable_config = enable_config
    disable_config[:AllCops][:DeplicatedElementInOneColumn][:Enable]=false
    disable_config
  }
  
  describe "with enabled config" do
    describe "deplicate row in column" do
      it "ensure by cop" do
        cop = CsvCop::Cop::Lint::DeplicatedElementInOneColumn.new(not_uniq_column_csv,enable_config)
        expect(cop.run).not_to be false 
      end
    end

    describe "not deplicate row in column" do 
      it "not ensure by cop" do
        cop = CsvCop::Cop::Lint::DeplicatedElementInOneColumn.new(uniq_column_csv,enable_config)
        expect(cop.run).to be false
      end
    end
  end

  describe "with disable config" do
    describe "deplicate row in column" do
      it "ensure by cop" do
        cop = CsvCop::Cop::Lint::DeplicatedElementInOneColumn.new(not_uniq_column_csv,disable_config)
        expect(cop.run).to be false 
      end
    end

    describe "not deplicate row in column" do 
      it "not ensure by cop" do
        cop = CsvCop::Cop::Lint::DeplicatedElementInOneColumn.new(uniq_column_csv,disable_config)
        expect(cop.run).to be false
      end
    end
  end
end
