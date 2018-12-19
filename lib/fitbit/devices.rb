module Fitbit
  class Client
    # The Get Device endpoint returns a list of the Fitbit devices connected to a user's
    # account.
    # @param [String] user_id: The encoded ID of the user. Use "-" (dash) for current logged-in user.
    # @return [Object] response data from Fitbit API
    def devices(user_id: '-')
      return get("#{API_URI}/user/#{user_id}/devices.json")
    end

    # The Get Alarms endpoint returns a list of the set alarms connected to a user's account.
    # @param [String] user_id: The encoded ID of the user. Use "-" (dash) for current logged-in user.
    # @param [String] tracker_id: The ID of the tracker for which data is returned. The tracker-id value is found via the Get Devices endpoint.
    # @return [Object] response data from Fitbit API
    def alarms(user_id: '-', tracker_id:)
      return get("#{API_URI}/user/#{user_id}/devices/tracker/#{tracker_id}/alarms.json")
    end

    # The Add Alarm endpoint adds the alarm settings to a given ID for a given device.
    # @param [String] user_id: The encoded ID of the user. Use "-" (dash) for current logged-in user.
    # @param [String] tracker_id: The ID of the tracker for which data is returned. The tracker-id value is found via the Get Devices endpoint.
    # @param [String] time: Time of day that the alarm vibrates with a UTC timezone offset, e.g. 07:15-08:00
    # @param [Boolean] enabled: true or false. If false, alarm does not vibrate until enabled is set to true.
    # @param [Boolean] recurring: true or false. If false, the alarm is a single event.
    # @param [String] week_days: Comma separated list of days of the week on which the alarm vibrates, e.g. MONDAY,TUESDAY
    # @return [Object] response data from Fitbit API
    def add_alarm(user_id: '-', tracker_id:, time:, enabled: true, recurring: true, week_days:)
      opts = {time: time, enabled: enabled, recurring: recurring, weekDays: week_days}
      return post("#{API_URI}/user/#{user_id}/devices/tracker/#{tracker_id}/alarms.json", opts)
    end

    # The Update Alarm endpoint updates the alarm entry with a given ID for a given device.
    # It also gets a response in the format requested.
    # @param [String] user_id: The encoded ID of the user. Use "-" (dash) for current logged-in user.
    # @param [String] tracker_id: The ID of the tracker whose alarms is managed. The tracker_id value is found via the Get Devices endpoint.
    # @param [String] alarm_id: The ID of the alarm to be updated. The alarm_id value is found in the response of the Get Alarms endpoint.
    # @param [String] time: Time of day that the alarm vibrates with a UTC timezone offset, e.g. 07:15-08:00
    # @param [Boolean] enabled: true or false. If false, alarm does not vibrate until enabled is set to true.
    # @param [Boolean] recurring: true or false. If false, the alarm is a single event.
    # @param [String] week_days: Comma separated list of days of the week on which the alarm vibrates, e.g. MONDAY,TUESDAY
    # @param [String] snooze_length: Minutes between alarms; integer value.
    # @param [String] snooze_count: Maximum snooze count; integer value.
    # @param [String] label: Label for the alarm; string value.
    # @param [String] vibe: Vibe pattern; only one value for now - DEFAULT.
    # @return [Object] response data from Fitbit API
    def update_alarm(user_id: '-', tracker_id:, alarm_id:, time: nil, enabled: nil, recurring: nil, week_days: nil, snooze_length: nil, snooze_count: nil, label: nil, vibe: nil)
      registered_alarms = alarms(user_id: user_id, tracker_id: tracker_id)
      updating_alarm = nil

      registered_alarms['trackerAlarms'].each do |registered_alarm|
        if registered_alarm['alarmId'] == alarm_id.to_i
          updating_alarm = registered_alarm
        end
      end
      if updating_alarm.nil?
        return nil
      end

      opts = Hash.new
      opts['time'] = time.nil? ? updating_alarm['time'] : time
      opts['enabled'] = enabled.nil? ? updating_alarm['enabled'] : enabled
      opts['recurring'] = recurring.nil? ? updating_alarm['recurring'] : recurring
      opts['weekDays'] = week_days.nil? ? updating_alarm['weekDays'].join(',') : week_days
      opts['snoozeLength'] = snooze_length.nil? ? updating_alarm['snoozeLength'] : snooze_length
      opts['snoozeCount'] = snooze_count.nil? ? updating_alarm['snoozeCount'] : snooze_count
      opts['label'] = label unless label.nil?
      opts['vibe'] = vibe unless vibe.nil?

      return post("#{API_URI}/user/#{user_id}/devices/tracker/#{tracker_id}/alarms/#{alarm_id}.json", opts)
    end

    # The Delete Alarm API deletes the user's device alarm entry with the given ID for a given
    # device.
    # @param [String] user_id: The encoded ID of the user. Use "-" (dash) for current logged-in user.
    # @param [String] tracker_id: The ID of the tracker whose alarms is managed. The tracker_id value is found via the Get Devices endpoint.
    # @param [String] alarm_id: The ID of the alarm that is updated. The alarm_id value is found via the Get Alarms endpoint.
    # @return [Object] response data from Fitbit API
    def delete_alarm(user_id: '-', tracker_id:, alarm_id:)
      return delete("#{API_URI}/user/#{user_id}/devices/tracker/#{tracker_id}/alarms/#{alarm_id}.json")
    end
  end
end
