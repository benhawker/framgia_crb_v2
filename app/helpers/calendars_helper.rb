module CalendarsHelper
  def btn_via_permission user, event, fdata = nil
    user_calendar = user.user_calendars.find_by calendar: event.calendar
    return if user_calendar.nil?

    # btn = render "events/buttons/btn_copy", url: "/events/new?fdata=#{fdata}"
    # btn = "" if event.calendar.is_default? || user_calendar.permission_id == 4
    if Settings.permissions_can_make_change.include? user_calendar.permission_id
      btn = render "events/buttons/btn_cancel"
      btn += render "events/buttons/btn_edit",
        url: "/events/#{event.id}/edit?fdata=#{fdata}"
      btn += render "events/buttons/btn_save"
      btn += render "events/buttons/btn_delete", event_id: event.id
    elsif user_calendar.permission_id == 3
      btn = render "events/buttons/btn_detail",
        url: "/events/#{event.id}"
    end
    btn.html_safe
  end

  def link_via_permission event, fdata = nil
    user_calendar = current_user.user_calendars.find_by calendar: event.calendar
    return if user_calendar.permission_id == 4

    if Settings.permissions_can_make_change.include? user_calendar.permission_id
      link = render "events/links/link_view", url: "/events/#{event.id}"
      link += render "events/links/link_edit", url: "/events/#{event.id}/edit?fdata=#{fdata}"
    elsif user_calendar.permission_id == 3
      link = render "events/links/link_view", url: "/events/#{event.id}"
    end
    link.html_safe
  end

  def confirm_popup_repeat_events action
    render "events/confirm_popup_repeat", action: action
  end

  def is_event_controller?
    params[:controller] == "events"
  end

  def is_new_action?
    %w(new create).include? action_name
  end
end
