require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module UpToDate
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    config.x.default_post_image = 'https://images.pexels.com/photos/20782836/pexels-photo-20782836/free-photo-of-modern-building.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'
    config.x.image_rand_categories = %w[nature travel pretty sky landscape blur background car business]
    config.active_job.queue_adapter = :litejob
  end
end
