# frozen_string_literal: true

module ApplicationHelper
  ACTIVE_NAV_CLASSES = 'bg-gray-900 text-white px-3 py-2 rounded-md text-sm font-medium'
  NAV_CLASSES = 'text-gray-300 hover:bg-gray-700 hover:text-white px-3 py-2 rounded-md text-sm font-medium'

  def header_text(controller_name)
    return 'Contacts' if controller_name == 'contacts'

    'Import Contacts'
  end

  def current_controller_nav_class(nav_text, controller_name)
    return ACTIVE_NAV_CLASSES if nav_text == controller_name

    NAV_CLASSES
  end
end
