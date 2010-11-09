# encoding: utf-8

module MiniTest::Assertions
  def assert_not_same exp, act, msg = nil
    msg = message(msg) {
      data = [mu_pp(act), act.object_id, mu_pp(exp), exp.object_id]
        "Expected %s (oid=%d) to be the same as %s (oid=%d)" % data
    }
    assert !exp.equal?(act), msg
  end
end
