class ContactsController < InheritedResources::Base
  respond_to :html
  actions :index, :show, :new, :edit, :create, :update

  before_filter :mark_removed_phone_numbers_for_destruction, :only => :update

  private
    def mark_removed_phone_numbers_for_destruction
      params[:contact][:phone_numbers_attributes].each_value do |attributes|
        attributes[:_destroy] = attributes[:id].present? && attributes.values_at(:kind, :label, :value).all?(&:blank?)
      end
    end
end
