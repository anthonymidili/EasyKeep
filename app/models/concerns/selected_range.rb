module SelectedRange
  extend ActiveSupport::Concern

  module ClassMethods

    # Scope to find all services or payments in a selected time range using the view_by and active_date cookies.
    def by_selected_range(view_by, active_date)
      column_name = set_column_name
      time_range = (active_date.send("beginning_of_#{view_by}")..active_date.send("end_of_#{view_by}"))
      where(column_name => time_range)
    end

  private

    def set_column_name
      @set_column_name ||=
          if self.name == 'Service'
            :performed_on
          elsif self.name == 'Payment'
            :received_on
          end
    end

  end
end
