class Rufo::DebugFormatter < Rufo::Formatter
  def check(kind)
    if current_token_kind != kind
      bug "Expected token #{kind}, not #{current_token_kind}"
    end
  end

  def consume_keyword(value)
    check :on_kw
    if current_token_value != value
      bug "Expected keyword #{value}, not #{current_token_value}"
    end
    super
  end

  def consume_op(value)
    check :on_op
    if current_token_value != value
      bug "Expected op #{value}, not #{current_token_value}"
    end
    write value
    next_token
  end
end
