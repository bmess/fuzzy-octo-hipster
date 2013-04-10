# 'base' is an environment, don't worry about it for now.
base:

  # We're saying "everyone" should run the 'vim' salt state we're about to
  # create.
  '*':
    - vim

  # Now we're stating all minions with the 'dev' role, run the following
  # salt state.
  'role : dev':
    - match: grain
    - apache
