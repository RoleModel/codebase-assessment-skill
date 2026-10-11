# Rails

- Check `config/credentials` vs. committed `.env` / `master.key`.
- Look for `skip_before_action :authenticate_user!` and controllers that load records with `find(params[:id])` instead of scoping to `current_user`.
- Strong params: `params.permit!` is a fail for `input`.
- Prefer Rails' built-in authentication or Devise over hand-rolled auth.
