Paperclip.interpolates :class_without_unscoped do |attachment, style|
  return super() if attachment.nil? && style_name.nil?
  attachment.instance.class.name.underscore.gsub("_unscoped", "").pluralize
end if Object.const_defined?('Paperclip')