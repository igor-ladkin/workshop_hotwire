class ApplicationChannel < ApplicationCable::Channel
  extend Turbo::Streams::Broadcasts
  extend Turbo::Streams::StreamName
  include Turbo::Streams::StreamName::ClassMethods
  include ActionView::RecordIdentifier
end
