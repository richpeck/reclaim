class Contact < Claim

  ###########################################################
  ###########################################################
  ##         _____             _             _             ##
  ##        /  __ \           | |           | |            ##
  ##        | /  \/ ___  _ __ | |_ __ _  ___| |_           ##
  ##        | |    / _ \| '_ \| __/ _` |/ __| __|          ##
  ##        | \__/\ (_) | | | | || (_| | (__| |_           ##
  ##        \____/\___/|_| |_|\__\__,_|\___|\__|           ##
  ##                                                       ##
  ###########################################################
  ###########################################################
  ##           Allows users to contact owners              ##
  ###########################################################
  ###########################################################

  ###########################################################
  ###########################################################

  ########################
  ##   Class (public)   ##
  ########################

  ########################
  ## Instance (private) ##
  ########################

  # => Private
  # => Allows us to manage the system without exposing methods publicly
  private

    # => Validations
    # => Becuse this is a subclass of Claim, we need to skip validations
    def skip_validations
      true
    end

    # => Email
    # => Sends email to app/site owner
    def send_email
      true
    end

    # => Hubspot destroy
    # => This needs to be implemented into admin area
    # => Destroys hubspot listings from hubspot_id
    def hubspot_destroy
      true
    end

  ###########################################################
  ###########################################################

end
