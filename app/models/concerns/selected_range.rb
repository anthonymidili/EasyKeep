module SelectedRange
  extend ActiveSupport::Concern

  module ClassMethods
    def by_selected_range(view_by, active_date)
      column =
          if self.name == 'Service'
            :performed_on
          elsif self.name == 'Payment'
            :received_on
          end
      time_range = (active_date.send("beginning_of_#{view_by}")..active_date.send("end_of_#{view_by}"))
      where(column => time_range)
    end
  end
end
