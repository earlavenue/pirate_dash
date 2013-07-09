class PagesController < ApplicationController
  before_filter :require_signin

  def dashboard
  end

  def refresh
    s3 = AWS::S3.new
    bucket = s3.buckets['omronfitness-km-data']
    revisions = bucket.objects.with_prefix('revisions').to_a

    #grab a smaller, more workable sample
    revisions_sample = revisions.sample(20)

    revisions_sample.each do |rev|
      fixed = "[#{rev.read.gsub(/\n/, ',').chop}]"
      JSON.parse(fixed).each do |event_hash|
        @event = Event.new
        @event.action = event_hash["_n"]
        @event.doer = event_hash["_p"]
        @event.event_time = event_hash["_t"]
        @event.save
      end
    end
    redirect_to dashboard_url
  end

  def activations
    @uploads = Upload.first(20)
  end

  def import_uploads
    Upload.import(params[:file])
    redirect_to activations_url
  end

end
