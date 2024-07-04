# frozen_string_literal: true

class SupportController < ApplicationController
  def support
    @support_form = SupportForm.new
  end

  def new
    @support_form = SupportForm.new(support_form_params)

    render :support and return if @support_form.invalid?

    case @support_form.i_need_help_with.to_sym
    when :using_forms
      redirect_to :help_using_forms
    when :about_forms
      redirect_to :question_about_forms
    when :other_government_service
      redirect_to "https://www.gov.uk/contact", status: :see_other, allow_other_host: true
    end
  end

  def help_using_forms
    @support_form = SupportForm.new(i_need_help_with: :using_forms)
    render :form
  end

  def question_about_forms
    @support_form = SupportForm.new(i_need_help_with: :about_forms)
    render :form
  end

  def submit
    @support_form = SupportForm.new(support_form_params)

    if @support_form.submit
      render :confirmation
    else
      render :form
    end
  end

private

  def support_form_params
    params
      .require(:support_form)
      .permit(:i_need_help_with, :message, :question, :name, :email_address)
  end
end
