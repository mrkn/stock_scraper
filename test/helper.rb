require "test-unit"

module FixtureReader
  private def read_fixture(file_name)
    test_dir = Pathname(__dir__).expand_path
    fixtures_dir = test_dir + "fixtures"
    full_path = fixtures_dir + file_name
    File.read(full_path.to_s)
  end
end
