require "./spec_helper"

struct AcceptLanguageTest < ASPEC::TestCase
  @[DataProvider("type_data_provider")]
  def test_get_type(header : String?, expected : String?) : Nil
    ANG::AcceptLanguage.new(header).type.should eq expected
  end

  def type_data_provider : Tuple
    {
      {"en;q=0.7", "en"},
      {"en-GB;q=0.8", "en-gb"},
      {"da", "da"},
      {"en-gb;q=0.8", "en-gb"},
      {"es;q=0.7", "es"},
      {"fr ; q= 0.1", "fr"},
    }
  end

  @[DataProvider("value_data_provider")]
  def test_get_value(header : String?, expected : String?) : Nil
    ANG::AcceptLanguage.new(header).value.should eq expected
  end

  def value_data_provider : Tuple
    {
      {"en;q=0.7", "en;q=0.7"},
      {"en-GB;q=0.8", "en-GB;q=0.8"},
    }
  end
end
