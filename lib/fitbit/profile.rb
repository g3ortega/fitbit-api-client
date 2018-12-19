module Fitbit
  class Client
    # The Get Profile endpoint returns a user's profile. The authenticated owner receives all
    # values. However, the authenticated user's access to other users' data is subject to those
    # users' privacy settings. Numerical values are returned in the unit system specified in the
    # Accept-Language header.
    # @param [String] user_id: The encoded ID of the user. Use "-" (dash) for current logged-in user.
    # @return [Hash] response data from Fitbit API
    def profile(user_id: '-')
      return get("#{API_URI}/user/#{user_id}/profile.json")
    end

    # Numerical values are accepted in the unit system specified in the Accept-Language header.
    # @param [String] user_id: The encoded ID of the user. Use "-" (dash) for current logged-in user.
    # @param [Hash] opts: opts
    # @return [Hash] response data from Fitbit API
    def update_profile(user_id: '-', opts: {})
      return post("#{API_URI}/user/#{user_id}/profile.json", opts)
    end

    # The Get Badges endpoint retrieves the user's badges in the format requested. Response
    # includes all badges for the user as seen on the Fitbit website badge locker (both activity
    # and weight related.) The endpoint returns weight and distance badges based on the user's
    # unit profile preference as on the website.
    # @param [String] user_id: The encoded ID of the user. Use "-" (dash) for current logged-in user.
    # @return [Hash] response data from Fitbit API
    def badges(user_id: '-')
      return get("#{API_URI}/user/#{user_id}/badges.json")
    end
  end
end
