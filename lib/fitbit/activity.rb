module Fitbit
  class Client
    # The Get Daily Activity Summary endpoint retrieves a summary and list of a user's
    # activities and activity log entries for a given day in the format requested using
    # units in the unit system which corresponds to the Accept-Language header provided.
    # @param [String] user_id: The encoded ID of the user. Use "-" (dash) for current logged-in user.
    # @param [String] date: The date in the format yyyy-MM-dd
    # @return [Hash] response data from Fitbit API
    def activity(user_id: '-', date: Date.today)
      return get("#{API_URI}/user/#{user_id}/activities/date/#{date}.json")
    end

    # The Get Activity Time Series endpoint returns time series data in the specified range
    # for a given resource in the format requested using units in the
    # {https://dev.fitbit.com/docs/basics/#units unit system} that corresponds to
    # the Accept-Language header provided.
    # @overload activity_time_series(user_id: '-', resource_path:, date:, period:)
    #   @param [String] user_id: The encoded ID of the user. Use "-" (dash) for current logged-in user.
    #   @param [String] resource_path: The resource path; see options in the "Resource Path Options" section below.
    #   @param [String] date: The end date of the period specified in the format yyyy-MM-dd or today.
    #   @param [String] period: The range for which data will be returned. Options are 1d, 7d, 30d, 1w, 1m, 3m, 6m, 1y, or max.
    # @overload activity_time_series(user_id: '-', resource_path:, base_date:, end_date:)
    #   @param [String] user_id: The encoded ID of the user. Use "-" (dash) for current logged-in user.
    #   @param [String] resource_path: The resource path; see options in the "Resource Path Options" section below.
    #   @param [String] base_date: The range start date, in the format yyyy-MM-dd or today.
    #   @param [String] end_date: The end date of the range.
    # @return [Hash] response data from Fitbit API
    def activity_time_series(user_id: '-', resource_path:, date: nil, period: nil, base_date: nil, end_date: nil)
      if date and period
        return get("#{API_URI}/user/#{user_id}/#{resource_path}/date/#{date}/#{period}.json")
      elsif base_date and end_date
        return get("#{API_URI}/user/#{user_id}/#{resource_path}/date/#{base_date}/#{end_date}.json")
      else
        raise StandardError
      end
    end

    # Access to the Intraday Time Series for personal use (accessing your own
    # data) is available through the
    # {https://dev.fitbit.com/docs/basics/#personal "Personal" App Type}.
    # Access to the Intraday Time Series for all other uses is currently granted on a
    # case-by-case basis. Applications must demonstrate necessity to create a great user
    # experience. Fitbit is very supportive of non-profit research and personal projects.
    # Commercial applications require thorough review and are subject to additional
    # requirements. Only select applications are granted access and Fitbit reserves the right
    # to limit this access. To request access, email api@fitbit.com. This endpoint returns the
    # Intraday Time Series for a given resource in the format requested. The endpoint mimics
    # the Get Activity Time Series endpoint. If your application has the appropriate access,
    # your calls to a time series endpoint for a specific day (by using start and end dates on
    # the same day or a period of 1d), the response will include extended intraday values with
    # a 1-minute detail level for that day. Unlike other time series calls that allow fetching
    # data of other users, intraday data is available only for and to the authorized user.
    # @overload activity_intraday_time_series(resource_path:, base_date:, end_date:, detail_level:)
    #   @param [String] user_id: The encoded ID of the user. Use "-" (dash) for current logged-in user.
    #   @param [String] resource_path: The resource path of the desired data.
    #   @param [String] base_date: The range start date, in the format yyyy-MM-dd or today.
    #   @param [String] end_date: The end date of the range.
    #   @param [String] detail_level: Number of data points to include. Either 1min or 15min.
    # @overload activity_intraday_time_series(resource_path:, base_date:, end_date:, start_time:, end_time:)
    #   @param [String] user_id: The encoded ID of the user. Use "-" (dash) for current logged-in user.
    #   @param [String] resource_path: The resource path of the desired data.
    #   @param [String] base_date: The range start date, in the format yyyy-MM-dd or today.
    #   @param [String] end_date: The end date of the range.
    #   @param [String] start_time: The start of the period, in the format HH:mm.
    #   @param [String] end_time: The end of the period, in the format HH:mm.
    #   @param [String] detail_level: Number of data points to include. Either 1min or 15min.
    # @overload activity_intraday_time_series(resource_path:, date:, detail_level:)
    #   @param [String] user_id: The encoded ID of the user. Use "-" (dash) for current logged-in user.
    #   @param [String] resource_path: The resource path of the desired data.
    #   @param [String] date: The date, in the format yyyy-MM-dd or today.
    #   @param [String] detail_level: Number of data points to include. Either 1min or 15min.
    # @overload activity_intraday_time_series(resource_path:, date:, start_time:, end_time:, detail_level:)
    #   @param [String] user_id: The encoded ID of the user. Use "-" (dash) for current logged-in user.
    #   @param [String] resource_path: The resource path of the desired data.
    #   @param [String] date: The date, in the format yyyy-MM-dd or today.
    #   @param [String] start_time: The start of the period, in the format HH:mm.
    #   @param [String] end_time: The end of the period, in the format HH:mm.
    #   @param [String] detail_level: Number of data points to include. Either 1min or 15min.
    # @return [Hash] response data from Fitbit API
    def activity_intraday_time_series(user_id: '-', resource_path:, date: nil, base_date: nil, end_date: nil, start_time: nil, end_time: nil, detail_level: nil)
      if base_date and end_date and detail_level and start_time and end_time
        return get("#{API_URI}/user/#{user_id}/#{resource_path}/date/#{base_date}/#{end_date}/#{detail_level}/time/#{start_time}/#{end_time}.json")
      elsif base_date and end_date and detail_level
        return get("#{API_URI}/user/#{user_id}/#{resource_path}/date/#{base_date}/#{end_date}/#{detail_level}.json")
      elsif date and detail_level and start_time and end_time
        return get("#{API_URI}/user/#{user_id}/#{resource_path}/date/#{date}/1d/#{detail_level}/time/#{start_time}/#{end_time}.json")
      elsif date and detail_level
        return get("#{API_URI}/user/#{user_id}/#{resource_path}/date/#{date}/1d/#{detail_level}.json")
      else
        raise StandardError
      end
    end

    # The Log Activity endpoint creates log entry for an activity or user's private custom
    # activity using units in the unit system which corresponds to the Accept-Language header
    # provided (or using optional custom distanceUnit) and get a response in the format
    # requested.
    # @param [String] user_id: The encoded ID of the user. Use "-" (dash) for current logged-in user.
    # @param [String] activity_id: Activity id; ID of the activity, directory activity, or intensity level activity. If you pass directory activity id, Fitbit calculates and substitutes it with the corresponding intensity level activity id based on the specified distance and/or duration.
    # @param [String] atctivity_name: Custom activity name. Either activityId or activityName must be provided.
    # @param [String] manual_calories: Calories burned, specified manually. Required with activityName parameter, otherwise optional.
    # @param [String] start_time: Activity start time. Hours and minutes in the format HH:mm:ss.
    # @param [String] duration_millis: Duration in milliseconds.
    # @param [String] date: Log entry date; in the format yyyy-MM-dd.
    # @param [String] distance: Distance; required for logging directory activity. In the format X.XX and in the selected distanceUnit or in the unit system that corresponds to the Accept-Language header provided.
    # @param [String] distance_unit: Distance measurement unit. Steps units are available only for "Walking" (activityId=90013) and "Running" (activityId=90009) directory activities and their intensity levels.
    # @return [Hash] response data from Fitbit API
    def log_activity(user_id: '-', activity_id: nil, activity_name: nil, manual_calories: nil, start_time:, duration_millis:, date:, distance: nil, distance_unit: nil)
      opts = {activityId: activity_id, activityName: activity_name, manualCalories: manual_calories, startTime: start_time, durationMillis: duration_millis, date: date, distance: distance, distanceUnit: distance_unit}
      post("#{API_URI}/user/#{user_id}/activities.json", opts)
    end

    # The Delete Activity Log endpoint deletes a user's activity log entry with the given ID.
    # A successful request will return a 204 status code with an empty response body.
    # @param [String] user_id: The encoded ID of the user. Use "-" (dash) for current logged-in user.
    # @param [String] log_id: The id of the activity log entry.
    # @return [Hash] response data from Fitbit API
    def delete_activity_log(user_id: '-', log_id:)
      delete("#{API_URI}/user/#{user_id}/activities/#{log_id}.json")
    end

    # The Get Activity Logs List endpoint retrieves a list of a user's activity log entries
    # before or after a given day with offset and limit using units in the unit system which
    # corresponds to the Accept-Language header provided.
    # @note This is a beta feature. During this period, Fitbit may need to make backwards
    #   incompatible changes with less than 30 days notice.
    # @param [String] user_id: The encoded ID of the user. Use "-" (dash) for current logged-in user.
    # @param [String] beforeDate: The date in the format yyyy-MM-ddTHH:mm:ss. Only yyyy-MM-dd is required. Either beforeDate or afterDate must be specified. Set sort to desc when using beforeDate.
    # @param [String] afterDate: The date in the format yyyy-MM-ddTHH:mm:ss. Only yyyy-MM-dd is required. Either beforeDate or afterDate must be specified. Set sort to asc when using afterDate.
    # @param [String] sort: The sort order of entries by date. Required. Use asc (ascending) when using afterDate. Use desc (descending) when using beforeDate.
    # @param [Integer] limit: The max of the number of entries returned (maximum: 20). Required.
    # @param [Integer] offset: This should always be set to 0. Required for now. IMPORTANT: To paginate, request the next and previous links in the pagination response object. Do not manually specify the offset parameter, as it will be removed in the future and your app will break.
    # @return [Hash] response data from Fitbit API
    def activity_logs_list(user_id: '-', before_date: nil, after_date: nil, sort: 'asc', limit: 20, offset: 0)
      opts = {beforeDate: before_date, afterDate: after_date, sort: sort, limit: limit, offset: offset}
      if before_date
        return get("#{API_URI}/user/#{user_id}/activities/list.json?beforeDate=#{before_date}&sort=#{sort}&limit=#{limit}&offset=#{offset}")
      elsif after_date
        return get("#{API_URI}/user/#{user_id}/activities/list.json?afterDate=#{after_date}&sort=#{sort}&limit=#{limit}&offset=#{offset}")
      else
        return get("#{API_URI}/user/#{user_id}/activities/list.json?beforeDate=#{Date.today}&sort=#{sort}&limit=#{limit}&offset=#{offset}")
      end
    end

    # The Get Activity TCX endpoint retrieves the details of a user's location and heart rate
    # data during a logged exercise activity. The Training Center XML (TCX) is a data exchange
    # format that contains GPS, heart rate, and lap data, when it is available for the
    # activity. The TCX MIME type is application/vnd.garmin.tcx+xml. TCX requires GPS data and
    # heart data points, which are tied to GPS data points. If you only want heart rate, see
    # {https://dev.fitbit.com/docs/heart-rate/ the heart rate intraday time series}.
    # @note This is a beta feature. During this period, Fitbit may need to make backwards
    #   incompatible changes with less than 30 days notice.
    # @param [String] user_id: The encoded ID of the user. Use "-" (dash) for current logged-in user.
    # @param [String] log_id: The activity's log ID.
    # @return [Hash] response data from Fitbit API
    def activity_tcx(user_id: '-', log_id:)
      return get("#{API_URI}/user/#{user_id}/activities/#{log_id}.tcx")
    end

    # Get a tree of all valid Fitbit public activities from the activities catalog as well as
    # private custom activities the user created in the format requested. If the activity has
    # levels, also get a list of activity level details. Typically, an applications retrieve
    # the complete list of activities once at startup to cache and show in the UI later.
    # @return [Hash] response data from Fitbit API
    def activity_types
      return get("#{API_URI}/activities.json")
    end

    # Returns the details of a specific activity in the Fitbit activities database in the
    # format requested. If activity has levels, also returns a list of activity level details.
    # @param [String] activity_id: The activity ID.
    # @return [Hash] response data from Fitbit API
    def activity_type(activity_id:)
      return get("#{API_URI}/activities/#{activity_id}.json")
    end

    # The Get Frequent Activities endpoint retrieves a list of a user's frequent activities in
    # the format requested using units in the unit system which corresponds to the
    # Accept-Language header provided. A frequent activity record contains the distance and
    # duration values recorded the last time the activity was logged. The record retrieved can
    # be used to log the activity via the Log Activity endpoint with the same or adjusted
    # values for distance and duration.
    # @param [String] user_id: The encoded ID of the user. Use "-" (dash) for current logged-in user.
    # @return [Hash] response data from Fitbit API
    def frequent_activities(user_id: '-')
      return get("#{API_URI}/user/#{user_id}/activities/frequent.json")
    end

    # The Get Recent Activity Types endpoint retrieves a list of a user's recent activities
    # types logged with some details of the last activity log of that type using units in the
    # unit system which corresponds to the Accept-Language header provided. The record
    # retrieved can be used to log the activity via the Log Activity endpoint with the same or
    # adjusted values for distance and duration.
    # @param [String] user_id: The encoded ID of the user. Use "-" (dash) for current logged-in user.
    # @return [Hash] response data from Fitbit API
    def recent_activities(user_id: '-')
      return get("#{API_URI}/user/#{user_id}/activities/recent.json")
    end

    # The Get Favorite Activities endpoint returns a list of a user's favorite activities.
    # @param [String] user_id: The encoded ID of the user. Use "-" (dash) for current logged-in user.
    # @return [Hash] response data from Fitbit API
    def favorite_activities(user_id: '-')
      return get("#{API_URI}/user/#{user_id}/activities/favorite.json")
    end

    # The Add Favorite Activity endpoint adds the activity with the given ID to user's list of
    # favorite activities.
    # @param [String] user_id: The encoded ID of the user. Use "-" (dash) for current logged-in user.
    # @param [String] activity_id: The ID of the activity to add to user's favorites.
    # @return [Hash] response data from Fitbit API
    def add_favorite_activity(user_id: '-', activity_id:)
      return post("#{API_URI}/user/#{user_id}/activities/favorite/#{activity_id}.json")
    end

    # The Delete Favorite Activity removes the activity with the given ID from a user's list of
    # favorite activities.
    # @param [String] user_id: The encoded ID of the user. Use "-" (dash) for current logged-in user.
    # @param [String] activity_id: The ID of the activity to be removed.
    # @return [Hash] response data from Fitbit API
    def delete_favorite_activity(user_id: '-', activity_id:)
      return delete("#{API_URI}/user/#{user_id}/activities/favorite/#{activity_id}.json")
    end

    # The Get Activity Goals retrieves a user's current daily or weekly activity goals using
    # measurement units as defined in the unit system, which corresponds to the Accept-Language
    # header provided.
    # @param [String] user_id: The encoded ID of the user. Use "-" (dash) for current logged-in user.
    # @param [String] period: daily or weekly
    # @return [Hash] response data from Fitbit API
    def activity_goals(user_id: '-', period:)
      return get("#{API_URI}/user/#{user_id}/activities/goals/#{period}.json")
    end

    # The Update Activity Goals endpoint creates or updates a user's daily activity goals and
    # returns a response using units in the unit system which corresponds to the
    # Accept-Language header provided.
    # @param [String] user_id: The encoded ID of the user. Use "-" (dash) for current logged-in user.
    # @param [String] period: daily or weekly
    # @param [String] calories_out: Goal value; integer.
    # @param [String] active_minutes: Goal value; integer.
    # @param [String] floors: Goal value; integer.
    # @param [String] distance: Goal value; in the format X.XX or integer.
    # @param [String] steps: Goal value; integer.
    # @return [Hash] response data from Fitbit API
    def update_activity_goals(user_id: '-', period:, calories_out: nil, active_minutes: nil, floors: nil, distance: nil, steps: nil)
      opts = {caloriesOut: calories_out, activeMinutes: active_minutes, floors: floors, distance: distance, steps: steps}
      return post("#{API_URI}/user/#{user_id}/activities/goals/#{period}.json", opts)
    end

    # The Get Lifetime Stats endpoint retrieves the user's activity statistics in the format
    # requested using units in the unit system which corresponds to the Accept-Language header
    # provided. Activity statistics includes Lifetime and Best achievement values from the My
    # Achievements tile on the website dashboard. Response contains both statistics from the
    # tracker device and total numbers including tracker data and manual activity log entries
    # as seen on the Fitbit website dashboard.
    # @param [String] user_id: The encoded ID of the user. Use "-" (dash) for current logged-in user.
    # @return [Hash] response data from Fitbit API
    def lifetime_stats(user_id: '-')
      return get("#{API_URI}/user/#{user_id}/activities.json")
    end
  end
end
