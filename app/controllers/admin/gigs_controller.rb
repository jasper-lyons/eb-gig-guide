module Admin
  class GigsController < Admin::ApplicationController
    def default_sorting_attribute
      :id
    end

    def default_sorting_direction
      :desc
    end

    def resource_params
      raw = super.to_h.with_indifferent_access

      if raw[:venue_id].to_s.start_with?("new:")
        name = raw[:venue_id].delete_prefix("new:")
        raw[:venue_id] = Venue.find_or_create_by!(name: name).id
      end

      if raw[:act_ids].is_a?(Array)
        @act_ids_in_order = raw[:act_ids].reject(&:blank?).map do |id|
          if id.to_s.start_with?("new:")
            Act.find_or_create_by!(name: id.delete_prefix("new:")).id.to_s
          else
            id
          end
        end
        raw[:act_ids] = @act_ids_in_order
      end

      ActionController::Parameters.new(raw).permit!
    end

    def create
      @resource = resource_class.new(resource_params)
      if @resource.save
        update_act_positions(@resource)
        redirect_to [:admin, @resource], notice: translate_with_resource("create.success")
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if requested_resource.update(resource_params)
        update_act_positions(requested_resource)
        redirect_to [:admin, requested_resource], notice: translate_with_resource("update.success")
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def social_post
      @start_date = Date.parse(params[:start_date]) rescue nil
      @end_date = Date.parse(params[:end_date]) rescue nil

      if @start_date && @end_date
        @days = Gig.where(date: @start_date..@end_date)
                   .order(date: :asc, doors: :asc)
                   .group_by { |gig| gig.date }
      end
    end

    private

    def update_act_positions(gig)
      return unless @act_ids_in_order
      @act_ids_in_order.each_with_index do |act_id, idx|
        gig.acts_gig.find_by(act_id: act_id)&.update_column(:position, idx)
      end
    end
  end
end
