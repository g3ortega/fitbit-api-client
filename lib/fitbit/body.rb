module Fitbit
  class Client
    # The Get Body Fat Logs API retrieves a list of all user's body fat log entries for a given
    # day in the format requested. Body fat log entries are available only to authorized user.
    # If you need to fetch only the most recent entry, you can use the Get Body Measurements
    # endpoint.
    # @overload body_fat_logs(user_id: '-', date:)
    #   @param [String] user_id: The encoded ID of the user. Use "-" (dash) for current logged-in user.
    #   @param [String] date: The date in the format yyyy-MM-dd.
    # @overload body_fat_logs(user_id: '-', date:, period:)
    #   @param [String] user_id: The encoded ID of the user. Use "-" (dash) for current logged-in user.
    #   @param [String] date: The date in the format yyyy-MM-dd.
    #   @param [String] period: The period to retrieve body fat
    # @overload body_fat_logs(user_id: '-', base_date:, end_date:)
    #   @param [String] user_id: The encoded ID of the user. Use "-" (dash) for current logged-in user.
    #   @param [String] base_date: The end date when period is provided; range start date when a date range is provided. In the format yyyy-MM-dd or today.
    #   @param [String] end_date: Range end date when date range is provided. Note: The range should not be longer than 31 days.
    # @return [Hash] response data from Fitbit API
    def body_fat_logs(user_id: '-', date: nil, period: nil, base_date: nil, end_date: nil)
      if date and period
        return get("#{API_URI}/user/#{user_id}/body/log/fat/date/#{date}/#{period}.json")
      elsif date
        return get("#{API_URI}/user/#{user_id}/body/log/fat/date/#{date}.json")
      elsif base_date and end_date
        return get("#{API_URI}/user/#{user_id}/body/log/fat/date/#{base_date}/#{end_date}.json")
      else
        raise StandardError
      end
    end

    # The Log Body Fat API creates a log entry for body fat and returns a response in the
    # format requested.
    # @note The returned Body Fat Log IDs are unique to the user, but not globally unique.
    # @param [String] user_id: The encoded ID of the user. Use "-" (dash) for current logged-in user.
    # @param [String] fat: Body fat; in the format X.XX, in the unit system that corresponds to the Accept-Language header provided.
    # @param [String] date: Log entry date; in the format yyyy-MM-dd.
    # @param [String] time: Time of the measurement; hours and minutes in the format HH:mm:ss, set to the last second of the day if not provided.
    # @return [Hash] response data from Fitbit API
    def log_body_fat(user_id: '-', fat:, date:, time: nil)
      opts = {fat: fat, date: date, time: time}
      post("#{API_URI}/user/#{user_id}/body/log/fat.json", opts)
    end

    # The Delete Body Fat Log API deletes a user's body fat log entry with the given ID.
    # @param [String] user_id: The encoded ID of the user. Use "-" (dash) for current logged-in user.
    # @param [String] log_id: The ID of the body fat log entry.
    # @return [Object] response data from Fitbit API
    def delete_body_fat_log(user_id: '-', log_id:)
      delete("#{API_URI}/user/#{user_id}/body/log/fat/#{log_id}.json")
    end

    # The Get Body Time Series API returns time series data in the specified range for a given
    # resource in the format requested using units in the
    # {https://dev.fitbit.com/docs/basics/#unit-systems unit systems} that corresponds to the
    # Accept-Language header provided.
    # @note If you provide earlier dates in the request, the response retrieves only data since
    #   the user's join date or the first log entry date for the requested collection.
    # @overload body_fat_time_series(date:, period:)
    #   @param [String] user_id: The encoded ID of the user. Use "-" (dash) for current logged-in user.
    #   @param [String] resource_path: The resource path. Options are "bmi", "fat", or "weight".
    #   @param [String] date: The end date of the period specified in the format yyyy-MM-dd or today.
    #   @param [String] period: The range for which data will be returned. Options are 1d, 7d, 30d, 1w, 1m, 3m, 6m, 1y, or max.
    # @overload body_fat_time_series(base_date:, end_date:)
    #   @param [String] user_id: The encoded ID of the user. Use "-" (dash) for current logged-in user.
    #   @param [String] resource_path: The resource path. Options are "bmi", "fat", or "weight".
    #   @param [String] base_date: The range start date, in the format yyyy-MM-dd or today.
    #   @param [String] end_date: The end date of the range.
    # @return [Hash] response data from Fitbit API
    def body_fat_time_series(user_id: '-', date: nil, period: nil, base_date: nil, end_data: nil)
      if date and period
        return get("#{API_URI}/user/#{user_id}/body/log/fat/date/#{date}/#{period}.json")
      elsif base_date and end_date
        return get("#{API_URI}/user/#{user_id}/body/log/fat/date/#{base_date}/#{end_date}.json")
      else
        raise StandardError
      end
    end

    # The Get Body Goals API retrieves a user's current body fat percentage or weight goal
    # using units in the unit systems that corresponds to the Accept-Language header provided
    # in the format requested.
    # @param [String] user_id: The encoded ID of the user. Use "-" (dash) for current logged-in user.
    # @param [String] goal_type: weight or fat
    # @return [Hash] response data from Fitbit API
    def body_goals(user_id: '-', goal_type:)
      return get("#{API_URI}/user/#{user_id}/body/log/#{goal_type}/goal.json")
    end

    # The Update Body Fat Goal API creates or updates user's fat percentage goal.
    # @param [String] user_id: The encoded ID of the user. Use "-" (dash) for current logged-in user.
    # @param [String] fat: Target body fat percentage; in the format X.XX.
    # @return [Hash] response data from Fitbit API
    def update_body_fat_goal(user_id: '-', fat:)
      opts = {fat: fat}
      post("#{API_URI}/user/[user-id]/body/log/fat/goal.json", opts)
    end

    # The Update Weight Goal API creates or updates user's fat or weight goal using units in
    # the {https://dev.fitbit.com/docs/basics/#unit-systems unit systems} that corresponds to
    # the Accept-Language header provided in the format requested.
    # @param [String] user_id: The encoded ID of the user. Use "-" (dash) for current logged-in user.
    # @param [String] start_date: Weight goal start date; in the format yyyy-MM-dd.
    # @param [String] start_weight: Weight goal start weight; in the format X.XX, in the unit systems that corresponds to the Accept-Language header provided.
    # @param [String] weight: Weight goal target weight; in the format X.XX, in the unit systems that corresponds to the Accept-Language header provided; required if user doesn't have an existing weight goal.
    # @return [Hash] response data from Fitbit API
    def update_weight_goal(user_id: '-', start_date:, start_weight:, weight: nil)
      opts = {startDate: start_date, startWeight: start_weight, weight: weight}
      post("#{API_URI}/user/#{user_id}/body/log/weight/goal.json", opts)
    end

    # The Get Weight Logs API retrieves a list of all user's body weight log entries for a
    # given day using units in the
    # {https://dev.fitbit.com/docs/basics/#unit-systems unit systems} which corresponds to the
    # Accept-Language header provided. Body weight log entries are available only to authorized
    # user. Body weight log entries in response are sorted exactly the same as they are
    # presented on the Fitbit website.
    # @overload weight_logs(user_id: '-', date:)
    #   @param [String] date: The date in the format YYYY-mm-dd.
    # @overload weight_logs(user_id: '-', date:, period:)
    #   @param [String] date: The date in the format YYYY-mm-dd.
    #   @param [String] period: The date range period. One of 1d, 7d, 30d, 1w, 1m.
    # @overload weight_logs(user_id: '-', base_date:, end_date:)
    #   @param [String] base_date: The end date when period is provided, in the format yyyy-MM-dd; range start date when a date range is provided.
    #   @param [String] end_date: Range end date when date range is provided. Note: The period must not be longer than 31 days.
    # @return [Hash] response data from Fitbit API
    def weight_logs(user_id: '-', date: nil, period: nil, base_date: nil, end_date: nil)
      if date and period
        return get("#{API_URI}/user/#{user_id}/body/log/weight/date/#{date}/#{period}.json")
      elsif date
        return get("#{API_URI}/user/#{user_id}/body/log/weight/date/#{date}.json")
      elsif base_date and end_date
        return get("#{API_URI}/user/#{user_id}/body/log/weight/date/#{base_date}/#{end_date}.json")
      else
        raise StandardError
      end
    end

    # The Log Weight API creates log entry for a body weight using units in the
    # {https://dev.fitbit.com/docs/basics/#unit-systems unit systems} that corresponds to the
    # Accept-Language header provided and get a response in the format requested.
    # @note The returned Weight Log IDs are unique to the user, but not globally unique.
    # @param [String] user_id: The encoded ID of the user. Use "-" for current logged-in user.
    # @param [String] weight: Weight; in the format X.XX
    # @param [String] date: Log entry date; in the format yyyy-MM-dd.
    # @param [String] time: Time of the measurement; hours and minutes in the format HH:mm:ss, set to the last second of the day if not provided
    # @return [Hash] response data from Fitbit API
    def log_weight(user_id: '-', weight:, date:, time: nil)
      opts = {weight: weight, date: date, time: time}
      post("#{API_URI}/user/#{user_id}/body/log/weight.json", opts)
    end

    # The Delete Weight Log API deletes a user's body weight log entry with the given ID.
    # @param [String] user_id: The encoded ID of the user. Use "-" (dash) for current logged-in user.
    # @param [String] log_id: The ID of the body weight log entry.
    # @return [Hash] response data from Fitbit API
    def delete_weight_log(user_id: '-', log_id:)
      delete("#{API_URI}/user/#{user_id}/body/log/weight/#{log_id}.json")
    end
  end
end
