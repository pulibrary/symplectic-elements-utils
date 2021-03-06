# frozen_string_literal: true

module Symplectic
  module Elements
    def self.root_path
      File.dirname(__FILE__)
    end

    autoload(:XML, File.join(root_path, 'elements', 'xml'))
    autoload(:CSV, File.join(root_path, 'elements', 'csv'))
    autoload(:UserFeed, File.join(root_path, 'elements', 'user_feed'))
    autoload(:Client, File.join(root_path, 'elements', 'client'))
  end
end
