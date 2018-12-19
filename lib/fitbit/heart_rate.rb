module Fitbit
  class Client
    # The Get Heart Rate Time Series endpoint returns time series data in the specified range
    # for a given resource in the format requested using units in the
    # {https://dev.fitbit.com/docs/basics/#unit-systems unit systems} that corresponds to the
    # Accept-Language header provided.If you specify earlier dates in the request, the response
    # will retrieve only data since the user's join date or the first log entry date for the
    # requested collection.
    # @overload heart_rate_time_series(user_id: '-', date:, period)
    #   @param [String] user_id: The encoded ID of the user. Use "-" (dash) for current logged-in user.
    #   @param [String] date: The end date of the period specified in the format yyyy-MM-dd or today.
    #   @param [String] period: The range for which data will be returned. Options are 1d, 7d, 30d, 1w, 1m.
    # @overload heart_rate_time_series(user_id: '-', base_date:, end_date:)
    #   @param [String] user_id: The encoded ID of the user. Use "-" (dash) for current logged-in user.
    #   @param [String] base_date: The range start date, in the format yyyy-MM-dd or today.
    #   @param [String] end_date: The end date of the range.
    # @return [Hash] response data from Fitbit API
    def heart_rate_time_series(user_id: '-', date: nil, period: nil, base_date: nil, end_date: nil)
      if date and period
        return get("#{API_URI}/user/#{user_id}/activities/heart/date/#{date}/#{period}.json")
      elsif base_date and end_date
        return get("#{API_URI}/user/#{user_id}/activities/heart/date/#{base_date}/#{end_date}.json")
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
    # requirements. Only select applications are granted access and Fitbit reserves the right to
    # limit this access. To request access, email api@fitbit.com. The Get Heart Rate Intraday
    # Time Series endpoint returns the intraday time series for a given resource in the format
    # requested. If your application has the appropriate access, your calls to a time series
    # endpoint for a specific day (by using start and end dates on the same day or a period of
    # 1d), the response will include extended intraday values with a one-minute detail level for
    # that day. Unlike other time series calls that allow fetching data of other users, intraday
    # data is available only for and to the authorized user.
    # @overload heart_rate_intraday_time_series(user_id: '-', base_date:, end_date:, detail_level:)
    #   @param [String] user_id: The encoded ID of the user. Use "-" (dash) for current logged-in user.
    #   @param [String] base_date: The range start date, in the format yyyy-MM-dd or today.
    #   @param [String] end_date: The end date of the range.
    #   @param [String] detail_level: Number of data points to include. Either 1sec or 1min.
    # @overload heart_rate_intraday_time_series(user_id: '-', base_date:, end_date:, start_time:, end_time:, detail_level:)
    #   @param [String] user_id: The encoded ID of the user. Use "-" (dash) for current logged-in user.
    #   @param [String] base_date: The range start date, in the format yyyy-MM-dd or today.
    #   @param [String] end_date: The end date of the range.
    #   @param [String] start_time: The start of the period, in the format HH:mm.
    #   @param [String] end_time: The end of the period, in the format HH:mm.
    #   @param [String] detail_level: Number of data points to include. Either 1sec or 1min.
    # @overload heart_rate_intraday_time_series(user_id: '-', date:, detail_level:)
    #   @param [String] user_id: The encoded ID of the user. Use "-" (dash) for current logged-in user.
    #   @param [String] date: The date, in the format yyyy-MM-dd or today.
    #   @param [String] detail_level: Number of data points to include. Either 1sec or 1min.
    # @overload heart_rate_intraday_time_series(user_id: '-', date:, start_time:, end_time:, detail_level:)
    #   @param [String] user_id: The encoded ID of the user. Use "-" (dash) for current logged-in user.
    #   @param [String] date: The date, in the format yyyy-MM-dd or today.
    #   @param [String] start_time: The start of the period, in the format HH:mm.
    #   @param [String] end_time: The end of the period, in the format HH:mm.
    #   @param [String] detail_level: Number of data points to include. Either 1sec or 1min.
    # @return [Hash] response data from Fitbit API
    def heart_rate_intraday_time_series(user_id: '-', date: nil, base_date: nil, end_date: nil, start_time: nil, end_time: nil, detail_level: nil)
      if base_date and end_date and detail_level and start_time and end_time
        return get("#{API_URI}/user/#{user_id}/activities/heart/date/#{base_date}/#{end_date}/#{detail_level}/time/#{start_time}/#{end_time}.json")
      elsif base_date and end_date and detail_level
        return get("#{API_URI}/user/#{user_id}/activities/heart/date/#{base_date}/#{end_date}/#{detail_level}.json")
      elsif date and detail_level and start_time and end_time
        return get("#{API_URI}/user/#{user_id}/activities/heart/date/#{date}/1d/#{detail_level}/time/#{start_time}/#{end_time}.json")
      elsif date and detail_level
        return get("#{API_URI}/user/#{user_id}/activities/heart/date/#{date}/1d/#{detail_level}.json")
      else
        raise StandardError
      end
    end
  end
end
