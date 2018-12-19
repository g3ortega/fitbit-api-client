module Fitbit
  class Client
    # The Get Sleep Logs endpoint returns a summary and list of a user's sleep log entries as
    # well as minute by minute sleep entry data for a given day in the format requested. The
    # endpoint response includes summary for all sleep log entries for the given day (including
    # naps.)
    # @param [String] user_id: The encoded ID of the user. Use "-" (dash) for current logged-in user.
    # @param [String] date: The date of records to be returned. In the format yyyy-MM-dd.
    # @return [Hash] response data from Fitbit API
    def sleep_logs(user_id: '-', date: Date.today)
      return get("#{API_URI}/user/#{user_id}/sleep/date/#{date}.json")
    end

    # The Get Sleep Time Series endpoint returns time series data in the specified range for a
    # given resource in the format requested using units in the
    # {https://dev.fitbit.com/docs/basics/#units unit system} that corresponds to the
    # Accept-Language header provided.
    # @overload sleep_time_series(date:, period:)
    #   @param [String] user_id: The encoded ID of the user. Use "-" (dash) for current logged-in user.
    #   @param [String] resource_path: The resource path; see the Resource Path Options below for a list of options.
    #   @param [String] date: The end date of the period specified in the format yyyy-MM-dd or today.
    #   @param [String] period: The range for which data will be returned. Options are 1d, 7d, 30d, 1w, 1m, 3m, 6m, 1y, or max.
    # @overload sleep_time_series(base_date:, end_date:)
    #   @param [String] user_id: The encoded ID of the user. Use "-" (dash) for current logged-in user.
    #   @param [String] resource_path: The resource path; see the Resource Path Options below for a list of options.
    #   @param [String] base_date: The range start date, in the format yyyy-MM-dd or today.
    #   @param [String] end_date: The end date of the range.
    # @return [Hash] response data from Fitbit API
    def sleep_time_series(user_id: '-', resource_path:, date: nil, period: nil, base_date: nil, end_date: nil)
      if date and period
        return get("#{API_URI}/user/#{user_id}/#{resource_path}/date/#{date}/#{period}.json")
      elsif base_date and end_date
        return get("#{API_URI}/user/#{user_id}/#{resource_path}/date/#{base_date}/#{end_date}.json")
      else
        raise StandardError
      end
    end

    # The Log Sleep endpoint creates a log entry for a sleep event and returns a response in the
    # format requested. Keep in mind that it is NOT possible to create overlapping log entries
    # or entries for time periods that DO NOT originate from a tracker. Sleep log entries appear
    # on website's sleep tracker interface according to the date on which the sleep event ends.
    # @param [String] user_id: The encoded ID of the user. Use "-" (dash) for current logged-in user.
    # @param [String] start_time: start time
    # @param [String] duration: duration
    # @param [String] date
    # @return [Hash] response data from Fitbit API
    def log_sleep(user_id: '-', start_time:, duration:, date:)
      opts = {startTime: start_time, duration: duration, date: date}
      post("#{API_URI}/user/#{user_id}/sleep.json", opts)
    end

    # The Delete Sleep Log endpoint deletes a user's sleep log entry with the given ID.
    # @param [String] user_id: The encoded ID of the user. Use "-" (dash) for current logged-in user.
    # @param [String] log_id: ID of the sleep log to be deleted.
    # @return [Hash] response data from Fitbit API
    def delete_sleep_log(user_id: '-', log_id:)
      delete("#{API_URI}/user/#{user_id}/sleep/#{log_id}.json")
    end
  end
end
