class RacePage < SitePrism::Page
  set_url '/'

  element :roll_field,          '#test-roll'
  element :processing_field,    '#test-processing'
  element :normal_speed_button, '#roll-normal-speed'
  element :super_speed_button,  '#roll-super-speed'

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

  def position id
    wait_until_processed

    find("#test-racer-#{id}-position").text.to_i
  end

  def damage id
    wait_until_processed

    find("#test-racer-#{id}-damage").text.to_i
  end

  private

    def wait_until_processed
      wait_until_processing_field_visible text: false
    end
end
