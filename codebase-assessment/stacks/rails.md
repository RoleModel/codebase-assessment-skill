# Rails

Loaded when the `Gemfile` names `rails`. If `rails-audit` is installed, its
`references/security_checklist.md` is the full checklist; this file lists what
AI-built Rails apps get wrong most.

## Security sinks

- `config/master.key` or a `.env` with real values committed. Credentials
  belong in `config/credentials.yml.enc`.
- `skip_before_action :authenticate_user!`, and controllers that load records
  with `Model.find(params[:id])` instead of `current_user.models.find`.
- `params.permit!`, or permitted attributes that let a user set ownership,
  roles, prices, or state.
- Hand-rolled auth. Rails' built-in authentication generator or Devise is the
  fix.

## Unknowns to list

Env vars and credentials set on the host, and whether background jobs run in
production.
