require "test-unit"
require "webmock"

module FixtureReader
  private def read_fixture(file_name)
    test_dir = Pathname(__dir__).expand_path
    fixtures_dir = test_dir + "fixtures"
    full_path = fixtures_dir + file_name
    File.read(full_path.to_s)
  end
end

module WithWebMock
  include WebMock::API

  def self.included(cls)
    cls.class_eval do
      setup
      def setup_with_webmock
        WebMock.enable!
      end

      teardown
      def teardown_with_webmock
        WebMock.reset!
        WebMock.disable!
      end
    end
  end
end
