class RacePage < SitePrism::Page
  set_url '/'

  element :roll_field,          '#test-roll'
  element :processing_field,    '#test-processing'
  element :message_field,       '#message'

  element :normal_speed_button, '#roll-normal-speed'
  element :super_speed_button,  '#roll-super-speed'
  element :new_race_button,     '#new-race'

  element :race_controls,       '#race-controls'
  element :race_over,           '#race-over'

  def roll roll, speed:
    roll_field.set roll

    case speed
    when :NORMAL
      normal_speed_button.click
    when :SUPER
      super_speed_button.click
    end

    wait_until_processed
  end

  def new_race
    new_race_button.click

    wait_until_processed
  end

  def position id
    find("#test-racer-#{id}-position").text.to_i
  end

  def damage id
    find("#test-racer-#{id}-damage").text.to_i
  end

  def message
    message_field.text
  end

  def over?
    has_no_race_controls? and has_race_over?
  end

  private

    def wait_until_processed
      wait_until_processing_field_invisible
    end
end
