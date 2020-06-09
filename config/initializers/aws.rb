# frozen_string_literal: true

Aws.config.update({
                    region: 'us-east-1',
                    credentials: Aws::Credentials.new(ENV['AKIA23SFJGO6L5HSURFF'], ENV['NfnwNK0+3mut4BMu+UE6yep0njFy3L1oUPXRa+O2'])
                  })

S3_BUCKET = Aws::S3::Resource.new.bucket(ENV['tuiteable'])
