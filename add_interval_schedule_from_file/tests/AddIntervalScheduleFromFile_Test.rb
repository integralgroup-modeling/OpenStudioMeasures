require 'openstudio'
require 'openstudio/ruleset/ShowRunnerOutput'
require 'minitest/autorun'
require_relative '../measure.rb'
require 'fileutils'

class AddIntervalScheduleFromFile_Test < MiniTest::Unit::TestCase

  def test_number_of_arguments_and_argument_names
    #this test ensures that the current test is matched to the measure inputs
    
    # create an instance of the measure
    measure = AddIntervalScheduleFromFile.new

    # make an empty model
    model = OpenStudio::Model::Model.new

    # get arguments and test that they are what we are expecting
    arguments = measure.arguments(model)
    assert_equal(3, arguments.size)
    assert_equal("schedule_name", arguments[0].name)
    assert_equal("file_path", arguments[1].name)
    assert_equal("unit_choice", arguments[2].name)
  end

  def test_good_hourly_values
     
    # create an instance of the measure
    measure = AddIntervalScheduleFromFile.new

    # create an instance of a runner
    runner = OpenStudio::Ruleset::OSRunner.new

    # make an empty model
    model = OpenStudio::Model::Model.new

    # set argument values to good values and run the measure on model
    arguments = measure.arguments(model)    
    argument_map = OpenStudio::Ruleset::OSArgumentMap.new
    
    schedule_name = arguments[0].clone
    assert(schedule_name.setValue("Hourly Values"))    
    argument_map["schedule_name"] = schedule_name    
    
    file_path = arguments[1].clone
    assert(file_path.setValue("#{File.dirname(__FILE__)}/hourly_values.csv"))
    argument_map["file_path"] = file_path
    
    unit_choice = arguments[2].clone
    assert(unit_choice.setValue("W"))
    argument_map["unit_choice"] = unit_choice

    # run the measure
    measure.run(model, runner, argument_map)
    result = runner.result
    
    # show the output
    show_output(result)
    
    # assertions to check that it ran correctly
    assert(result.value.valueName == "Success")
    assert(result.warnings.size == 0)
    assert(result.info.size == 0)

    #model.save("#{File.dirname(__FILE__)}/out.osm",true)     
  end

  def test_good_leap_year_hourly_values
     
    # create an instance of the measure
    measure = AddIntervalScheduleFromFile.new

    # create an instance of a runner
    runner = OpenStudio::Ruleset::OSRunner.new

    # make an empty model
    model = OpenStudio::Model::Model.new

    # set argument values to good values and run the measure on model
    arguments = measure.arguments(model)    
    argument_map = OpenStudio::Ruleset::OSArgumentMap.new
    
    schedule_name = arguments[0].clone
    assert(schedule_name.setValue("Leap Year Hourly Values"))    
    argument_map["schedule_name"] = schedule_name    
    
    file_path = arguments[1].clone
    assert(file_path.setValue("#{File.dirname(__FILE__)}/leap_year_hourly_values.csv"))
    argument_map["file_path"] = file_path
    
    unit_choice = arguments[2].clone
    assert(unit_choice.setValue("W"))
    argument_map["unit_choice"] = unit_choice

    # run the measure
    measure.run(model, runner, argument_map)
    result = runner.result
    
    # show the output
    show_output(result)
    
    # assertions to check that it ran correctly
    assert(result.value.valueName == "Success")
    assert(result.warnings.size == 0)
    assert(result.info.size == 0)

    #model.save("#{File.dirname(__FILE__)}/out.osm",true)    
  end

  def test_good_15min_values
     
    # create an instance of the measure
    measure = AddIntervalScheduleFromFile.new

    # create an instance of a runner
    runner = OpenStudio::Ruleset::OSRunner.new

    # make an empty model
    model = OpenStudio::Model::Model.new

    # set argument values to good values and run the measure on model
    arguments = measure.arguments(model)    
    argument_map = OpenStudio::Ruleset::OSArgumentMap.new
    
    schedule_name = arguments[0].clone
    assert(schedule_name.setValue("15min Values"))
    argument_map["schedule_name"] = schedule_name    
    
    file_path = arguments[1].clone
    assert(file_path.setValue("#{File.dirname(__FILE__)}/15min_values.csv"))
    argument_map["file_path"] = file_path
    
    unit_choice = arguments[2].clone
    assert(unit_choice.setValue("unitless"))
    argument_map["unit_choice"] = unit_choice

    # run the measure
    measure.run(model, runner, argument_map)
    result = runner.result
    
    # show the output
    show_output(result)
    
    # assertions to check that it ran correctly
    assert(result.value.valueName == "Success")
    assert(result.warnings.size == 0)
    assert(result.info.size == 0)

    #model.save("#{File.dirname(__FILE__)}/out.osm",true)    
  end
  
  def test_bad_hourly_values
     
    # create an instance of the measure
    measure = AddIntervalScheduleFromFile.new

    # create an instance of a runner
    runner = OpenStudio::Ruleset::OSRunner.new

    # make an empty model
    model = OpenStudio::Model::Model.new

    # set argument values to good values and run the measure on model
    arguments = measure.arguments(model)    
    argument_map = OpenStudio::Ruleset::OSArgumentMap.new
    
    schedule_name = arguments[0].clone
    assert(schedule_name.setValue("Bad Hourly Values"))
    argument_map["schedule_name"] = schedule_name    
    
    file_path = arguments[1].clone
    assert(file_path.setValue("#{File.dirname(__FILE__)}/bad_hourly_values.csv"))
    argument_map["file_path"] = file_path
    
    unit_choice = arguments[2].clone
    assert(unit_choice.setValue("W"))
    argument_map["unit_choice"] = unit_choice

    # run the measure
    measure.run(model, runner, argument_map)
    result = runner.result
    
    # show the output
    show_output(result)
    
    # assertions to check that it ran correctly
    assert(result.value.valueName == "Fail")
    #assert(result.warnings.size == 0)
    #assert(result.info.size == 0)
  end

  def test_bad_path
     
    # create an instance of the measure
    measure = AddIntervalScheduleFromFile.new

    # create an instance of a runner
    runner = OpenStudio::Ruleset::OSRunner.new

    # make an empty model
    model = OpenStudio::Model::Model.new

    # set argument values to good values and run the measure on model
    arguments = measure.arguments(model)    
    argument_map = OpenStudio::Ruleset::OSArgumentMap.new
    
    schedule_name = arguments[0].clone
    assert(schedule_name.setValue("Hourly Values"))
    argument_map["schedule_name"] = schedule_name    
    
    file_path = arguments[1].clone
    assert(file_path.setValue("#{File.dirname(__FILE__)}/does_not_exist.csv"))
    argument_map["file_path"] = file_path
    
    unit_choice = arguments[2].clone
    assert(unit_choice.setValue("W"))
    argument_map["unit_choice"] = unit_choice

    # run the measure
    measure.run(model, runner, argument_map)
    result = runner.result
    
    # show the output
    show_output(result)
    
    # assertions to check that it ran correctly
    assert(result.value.valueName == "Fail")
    #assert(result.warnings.size == 0)
    #assert(result.info.size == 0)
  end
  
end
