# frozen_string_literal: true

ActiveRecord.default_timezone = :local

class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
end
