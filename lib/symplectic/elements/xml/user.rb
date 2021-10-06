# frozen_string_literal: true

module Symplectic
  module Elements
    module XML
      class User
        def initialize(parent:)
          @parent = parent
          @document = @parent.document
        end

        def namespaces
          @parent.namespaces
        end

        def parent_element
          @parent_element ||= @parent.element
        end

        def element
          return if parent_element.nil?

          @element ||= parent_element.at_xpath('./api:user[last()]', **namespaces)
        end

        def title_element
          find_attribute_element('./api:title')
        end

        def title=(value)
          title_element.content = value
        end

        def initials_element
          find_attribute_element('./api:initials')
        end

        def initials=(value)
          initials_element.content = value
        end

        def first_name_element
          find_attribute_element('./api:first-name')
        end

        def first_name=(value)
          first_name_element.content = value
        end

        def last_name_element
          find_attribute_element('./api:last-name')
        end

        def last_name=(value)
          last_name_element.content = value
        end

        def known_as_element
          find_attribute_element('./api:known-as')
        end

        def known_as=(value)
          known_as_element.content = value
        end

        def suffix_element
          find_attribute_element('./api:suffix')
        end

        def suffix=(value)
          suffix_element.content = value
        end

        def email_element
          find_attribute_element('./api:email')
        end

        def email=(value)
          email_element.content = value
        end

        def authenticating_authority_element
          find_attribute_element('./api:authenticating-authority')
        end

        def authenticating_authority=(value)
          authenticating_authority_element.content = value
        end

        def username_element
          find_attribute_element('./api:username')
        end

        def username=(value)
          username_element.content = value
        end

        def proprietary_id_element
          find_attribute_element('./api:proprietary-id')
        end

        def proprietary_id=(value)
          proprietary_id_element.content = value
        end

        def primary_group_descriptor_element
          find_attribute_element('./api:primary-group-descriptor')
        end

        def primary_group_descriptor=(value)
          primary_group_descriptor_element.content = value
        end

        def is_academic_element
          find_attribute_element('./api:is-academic')
        end

        def is_academic=(value)
          is_academic_element.content = value == 'TRUE'
        end

        def is_login_allowed_element
          find_attribute_element('./api:is-login-allowed')
        end

        def is_login_allowed=(value)
          is_login_allowed_element.content = value == 'TRUE'
        end

        def is_current_staff_element
          find_attribute_element('./api:is-current-staff')
        end

        def is_current_staff=(value)
          is_current_staff_element.content = value == 'TRUE'
        end

        def arrive_date_element
          find_attribute_element('./api:arrive-date')
        end

        def arrive_date=(value)
          arrive_date_element.content = value
        end

        def leave_date_element
          find_attribute_element('./api:leave-date')
        end

        def leave_date=(value)
          leave_date_element.content = value
        end

        def generic_field_01_element
          find_attribute_element('./api:generic-field-01')
        end
        alias position_element generic_field_01_element

        def generic_field_01=(value)
          generic_field_01_element.content = value
        end
        alias position= generic_field_01=

        def generic_field_02_element
          find_attribute_element('./api:generic-field-02')
        end
        alias department_element generic_field_02_element

        def generic_field_02=(value)
          generic_field_02_element.content = value
        end
        alias department= generic_field_02=

        private

        def find_attribute_element(xpath)
          return if element.nil?

          element.at_xpath(xpath, **namespaces)
        end
      end
    end
  end
end