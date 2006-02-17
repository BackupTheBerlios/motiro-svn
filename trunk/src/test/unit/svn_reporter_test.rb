$:.push File.expand_path(File.dirname(__FILE__) + '/..')
$:.push File.expand_path(File.dirname(__FILE__) + '/../../app')

require 'date'
require 'test/unit'
require 'stubs/svn_connection'
require 'reporters/svn_reporter'

class SubversionReporterTest < Test::Unit::TestCase

    def setup
        @svn_connection = StubSVNConnection.new
        @svn_connection.log_append_line '------------------------------------------------------------------------'
        @svn_connection.log_append_line 'r1 | thiagoarrais | 2006-02-14 15:45:13 -0400 (Ter, 14 Fev 2006) | 1 line'
        @svn_connection.log_append_line 'Criacao do trunk do projeto'
        @svn_connection.log_append_line '------------------------------------------------------------------------'

        @reporter = SubversionReporter.new(@svn_connection)
    end

    def test_one_revision
        hl = @reporter.latest_headline
        assert_equal 'thiagoarrais', hl.author
        assert_equal DateTime.new(2006, 02, 14, 15, 45, 13), hl.date
        assert_equal 'Criacao do trunk do projeto', hl.title
    end

end
