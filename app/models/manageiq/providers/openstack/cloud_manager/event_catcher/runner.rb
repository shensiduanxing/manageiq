class ManageIQ::Providers::Openstack::CloudManager::EventCatcher::Runner < ManageIQ::Providers::BaseManager::EventCatcher::Runner
  include ManageIQ::Providers::Openstack::EventCatcherMixin

  def add_openstack_queue(event_hash)
    EmsEvent.add_queue('add_openstack', @cfg[:ems_id], event_hash)
  end
end
