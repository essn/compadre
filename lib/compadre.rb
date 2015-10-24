require "compadre/engine"

module Compadre
  def self.configure
    yield self
  end

  def self.resource_name
    (@resource_name || "user").split("_").map(&:capitalize).join("")
  end

  def self.resource_name=(resource_name)
    @resource_name = resource_name
  end
end
