
# for some reason, this configuration setting is lost by the time we get
# to searches_controller.  So we have a *temporary* hack to set it again there.
PgSearch.multisearch_options = {
  using: [:tsearch, :trigram],
  ignoring: :accents
}

PgSearch.unaccent_function = "unaccent"
