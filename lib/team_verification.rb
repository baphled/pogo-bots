require_relative './team_verification/processor'

module TeamVerification
  class InvalidPlayerImage < Exception; end
  class DiscordRoleNotFound < Exception; end

  def self.start(uri:)
    verification_processor = TeamVerification::Processor.new(uri: uri, image_processor: MiniMagick::Image)

    colour_array = verification_processor.colour_array
    colour_array.first
  end

  def self.complete(event:, team:)
    role_id = find_role_id(roles: event.server.roles, team: team)

    event.user.add_role(role_id)

    event.respond "**Verified**: #{event.user.name} as a member of team #{team}"
    event.respond "Type `!help` for more information"
  end

  def self.find_role_id(roles:, team:)
    found_role = roles.find { |role| role.name == team }
    role_id = found_role.id

    raise TeamVerification::DiscordRoleNotFound if role_id.nil?

    role_id
  end

  def self.contact_mods(event:, rgb:, uri:)

    admin_user = event.server.users.find { |u| u.name == ENV['DEVELOPER_DISCORD_NAME']}

    message = failed_verification_message(event: event, rgb: rgb, uri: uri)
    admin_user.pm(message)

    event.respond 'Unable to verify the players team'
  end

  def self.failed_verification_message(event:, rgb:, uri:)
    """
**Member**: #{event.user.name}
**Server**: #{event.server.name}
**RBG**: #{rgb.join(',')}
**Player Image**: #{uri}
    """
  end
end
