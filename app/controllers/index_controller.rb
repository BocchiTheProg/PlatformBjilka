class IndexController < ApplicationController
  def select_type; end

  def home
    @services = Service.all
    @services_by_type = group_services_by_type(@services)
  end

  private

  def group_services_by_type(services)
    services_by_type = {}
    services.each do |service|
      services_by_type[service[:service_type]] ||= []
      services_by_type[service[:service_type]] << service
    end
    services_by_type
  end
end
