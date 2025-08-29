module ApplicationHelper
  # Returns classes for a sidebar nav item.
  # path: URL or path helper to evaluate with current_page?
  # opts: optional extra classes
  def nav_item_classes(path, opts = {})
    base = %w[group flex flex-col items-center text-xs font-medium p-2 rounded-lg transition duration-200 ease-in-out cursor-pointer]
    # Color scheme support (default :blue, optional :red etc.)
    scheme = (opts[:scheme] || :blue).to_sym
    case scheme
    when :red
      inactive = %w[bg-red-50 text-red-600 hover:bg-red-600 hover:text-white]
      active = %w[bg-red-600 text-white]
    else # :blue fallback
      inactive = %w[bg-blue-50 text-blue-600 hover:bg-blue-600 hover:text-white]
      active = %w[bg-blue-600 text-white]
    end

    # Active detection
    # Priority: explicit active_if override > computed logic
    if opts.key?(:active_if)
      is_active = !!opts[:active_if]
    else
      is_active = false
      unless opts[:force_inactive] || path.blank?
        is_active = if opts[:match] == :prefix && path.present?
          request.path.start_with?(path)
        elsif path == root_path
          request.path == root_path
        else
          current_page?(path)
        end
      end
    end

    classes = base + (is_active ? active : inactive)
    classes += Array(opts[:extra]) if opts[:extra]
    classes.join(" ")
  end
end
