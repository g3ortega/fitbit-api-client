module Fitbit
  class Client
    # The Get Friends endpoint returns data of a user's friends in the format requested using
    # units in the unit system which corresponds to the Accept-Language header provided.
    # @param [String] user_id: The encoded ID of the user. Use "-" (dash) for current logged-in user.
    # @return [Hash] response data from Fitbit API
    def friends(user_id: '-')
      return get("#{API_URI}/user/#{user_id}/friends.json")
    end

    # The Get Friends Leaderboard endpoint gets the user's friends leaderboard in the format
    # requested using units in the unit system which corresponds to the Accept-Language header
    # provided. Authorized user (self) is also included in the response. Leaderboard has last
    # seven (7) days worth of data (including data from the previous six days plus today's data
    # in real time).
    # @param [String] user_id: The encoded ID of the user. Use "-" (dash) for current logged-in user.
    # @return [Hash] response data from Fitbit API
    def friends_leaderboard(user_id: '-')
      return get("#{API_URI}/user/#{user_id}/friends/leaderboard.json")
    end

    # The Invite Friend endpoint creates an invitation to become friends with the authorized
    # user. A successful request returns a 201 status code and an empty response body.If the
    # invitedUserEmail value is provided, the standard friendship invitation email is sent to
    # the specified recipient to be accepted or rejected later. If the invitedUserId is
    # provided, the invitation is created silently and can only be fetched through the Get
    # Invitations endpoint. Both invitation types can be accepted or rejected via the Accept
    # Invitation endpoint.
    # @note Be careful when using the Invite Friend endpoint and, as always, adhere to the Terms
    #   of Service. Though Fitbit has organic limits on allowed number of invitations, your
    #   application's workflow must not allow users to send bulk invitations to users. Doing so
    #   could be considered SPAM.
    # @overload invite_friend(invite_user_email:)
    #   @param [String] invite_user_email: Invite User Email
    # @overload invite_friend(invite_user_id:)
    #   @param [String] invite_user_id: Invite User ID
    # @return [Hash] response data from Fitbit API
    def invite_friend(invited_user_email: nil, invited_user_id: nil)
      opts = Hash.new
      unless invited_user_email.nil?
        opts['invitedUserEmail'] = invited_user_email
      end
      unless invited_user_id.nil?
        opts['invitedUserId'] = invited_user_id
      end

      return post("#{API_URI}/user/-/friends/invitations.json", opts)
    end

    # The Get Friend Invitations endpoint returns a list of invitations to become friends with a
    # user in the format requested.
    # @param [String] user_id: The encoded ID of the user. Use "-" (dash) for current logged-in user.
    # @return [Hash] response data from Fitbit API
    def friend_invitations(user_id: '-')
      return get("#{API_URI}/user/#{user_id}/friends/invitations.json")
    end

    # The Respond to Friend Invitation endpoint accepts or rejects an invitation to become
    # friends with inviting user.
    # @param [String] from_user_id: Encoded ID of user from which to accept or reject invitation.
    # @param [Boolean] accept: Accept or reject invitation. 'true' or 'false'.
    # @return [Hash] response data from Fitbit API
    def respond_to_friend_invitation(from_user_id:, accept: true)
      return post("#{API_URI}/user/-/friends/invitations/#{from_user_id}.json", {accept: accept})
    end
  end
end
