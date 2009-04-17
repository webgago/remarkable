module Remarkable
  module ActiveRecord
    module Matchers
      class ValidatePresenceOfMatcher < Remarkable::ActiveRecord::Base #:nodoc:
        arguments :collection => :attributes, :as => :attribute
        optional  :message

        collection_assertions :allow_nil?
        default_options :message => :blank, :allow_nil => false
      end

      # Ensures that the model cannot be saved if one of the attributes listed is not present.
      #
      # == Options
      #
      # * <tt>:message</tt> - value the test expects to find in <tt>errors.on(:attribute)</tt>.
      #   Regexp, string or symbol. Default = <tt>I18n.translate('activerecord.errors.messages.blank')</tt>
      #
      # == Examples
      #
      #   should_validate_presence_of :name, :phone_number
      #   it { should validate_presence_of(:name, :phone_number) }
      #
      def validate_presence_of(*args)
        ValidatePresenceOfMatcher.new(*args).spec(self)
      end
    end
  end
end