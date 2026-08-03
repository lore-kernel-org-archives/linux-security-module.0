Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4A026F476
	for <linux-security-module@vger.kernel.org>; Mon,  3 Aug 2026 22:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785796276; cv=none; b=dV2wdJU1FdwzPZ3WYureoHxlS7iSE10nmlRqfh7sWJRywgKp94pH5qhJsXO6be/ffu9vS0spVktAaVcaMxAkXAiOnG2JdXeopf7iAtu7ZMfOcKt0IcsMcbY1fhKdtpHaHygropS3RPCBlg1hRkiBp1LOyd1IPa7ShKR3RcHX6hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785796276; c=relaxed/simple;
	bh=OyF12uxUsJ4oS++bL0cvVgZF4MoR38wWKA4onFazqYM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PTOnqurU/i4FGndA9Ts0vU4gkPR8LQxxOW5Re/cj7OwS3xlaWb6HEWil/cIktPKmbLfd3Eh8GAp8wRYg+rnwnPZEDmWwu0LRU/yQTHvN57EjcLYY+0dE8tHOLmjDPCwdMslMXEakBMeqG9ArTtrCRcIsE5Y391r5dYoa8u1+BP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K3OFnuu8; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3OFnuu8"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-8200ca16f26so1175757b3.3
        for <linux-security-module@vger.kernel.org>; Mon, 03 Aug 2026 15:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785796274; x=1786401074; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VixFhYhiyWucYwqK+vkqrLa8QhNCgUSiWRqAtXrr9VM=;
        b=K3OFnuu8As0jlpfw5ero1U4WobH4hHcxxF1BJz9gkCIQSvAP3alfl3HR3y1SRF0L49
         V3l9p4Ym4BolxGdXVj0+kFX+33wkIzYfVHNiWBGJSnYXXywf+5fJnVRTUJeaoMC9Z/+x
         2Wo2yM+cntpTkPJBVWiJYiG2yJt0TJmIp6VrodykHjHYgTwj/rvhifYxwW9fuzszjxPo
         460NUOrKp7XPXmuE8lZhOZsIAx7gPOJGHWlqhyfeMA8zDr8ra8/1kC59Qtd6ftf7tgP7
         fmL6tl5n/+tNsbWpdt7YyHk6jhGrIaRJy19RfOwTde82+/chikXqADVsrIf1LARVQ11E
         fF/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785796274; x=1786401074;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VixFhYhiyWucYwqK+vkqrLa8QhNCgUSiWRqAtXrr9VM=;
        b=smtvxrToPUNAxr6wfpwTeKZ4eyRh/riZvmF8Lp9/5P2teMPPJM6t1nC5TUYzNSNnm+
         hYo+up5VBVg/BQDkA1uka67iedMuch2gSIRSWGW4BgvY71R63wZ3Zsbu3/BVoPfYHJ49
         dqi7x1sAprnacpqrlBE84c7GOliXItCamnFcecWBA5gyDZU8e6TdChSHiUGNCAhGH8tA
         lHEfg4qSelfW4KWloYePb2OsyV+AiwJ+eG4/p1LKKjNNhtrNv0ySDtCdahhwTmJuBZ5m
         e2hkVIXPete+dnSY9NaVg/pmLNlNW72/Mb1yxWkHkvBK/joobls8FIcB+bkNNJd3D6SE
         aeVw==
X-Forwarded-Encrypted: i=1; AHgh+Rpy1MDnHsLqzcWLAjzCBrs8SUIgGNQeg2mqesc/AGeGk22JMlII1OMLbDaq/Azcr+OC9N5VY0UPJA6tJIHrARgyeX3o1+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF0gcrSTZx7LH2P2sQDjU4LTk4UwPG4KZHoi3PntddKqfLu7p9
	CoZjKU6JF4+wGZEoPCWkhmNHfuMe/cQJc1m6TOkUF4rnDgj0aHoKN7IO
X-Gm-Gg: AR+sD10DxM7yykUxWoEUMlF219Mm5hZJPPq4OmEaAcxao2upvsNvAPPWh0oA4dMGbMR
	16u0fq4NtXlXLZJim+b1l4xBuZrLzFtf+aKzj9yEkAB74QFGk7C8aP7hCE7R3k7pEp0ZtTz54Yd
	kc3FbaqQcD5bLgtpaHBXHMs8uw2TpwvcE6ZN47cO8RiTzQVvX2mzrauv8cLG+GiECoZj0RJsT4R
	5g+JNvULCn5ehp4NOY5DIJtyXQxS/EqatWqbuTrkmkSKgST8+DB0/Nc6DWo0CyaOe5gdV96xY2y
	0GuuLrEFSCXeM6AnX3Z26j8I/EHt3bntLwny7kMQSj37bg4Tn2fA45955emsox8uHnuX7+TumCk
	N4BxdwrmD+8Xk6oJ6ZM9WiumtL+iTxuYFuVlcZV0xTbuVkaX5554VV6LCWdzuvSsfvMZ6v3HCzj
	NOG0ladS/Trp1Pu/MC63DyfXqabsNW4aE6/w2U1xY4PXTPAsPdCEro44zpCg8LhIU5vXggcuHx3
	KlhFllYUkJdB8yyE2xCu9U=
X-Received: by 2002:a53:c745:0:b0:668:43a3:9db2 with SMTP id 956f58d0204a3-6694f17d897mr10477606d50.32.1785796274214;
        Mon, 03 Aug 2026 15:31:14 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:6253:b407:801c:a745])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6694903782fsm6420774d50.21.2026.08.03.15.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 15:31:13 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: gnoack3000@gmail.com,
	mic@digikod.net
Cc: linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH v3 0/4] Implement LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS
Date: Mon,  3 Aug 2026 18:31:04 -0400
Message-ID: <20260803223109.707353-1-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Howdy

This series adds a new landlock_restrict_self(2) flag:
LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS.

The flag sets the no_new_privs attribute of the calling thread only
once the enforcement of the ruleset succeeded: no_new_privs is set if
and only if the landlock_restrict_self(2) call succeeds.  Following
Mickaël's feedback [2] on v2 [1], the "atomic" framing is gone: this is
an ordering guarantee, not atomicity, and the wording now reflects that
throughout the series.

Semantics:

A single call replaces the usual prctl(PR_SET_NO_NEW_PRIVS) +
landlock_restrict_self(2) pair.  Because no_new_privs is set by the
call itself, the no_new_privs/CAP_SYS_ADMIN precondition is fulfilled
by construction, so the flag is usable by unprivileged processes.  This
is safe for the same reason the prctl(2) pair is: the executed programs
can either gain privileges or be restricted, never both.

The two states cannot diverge.  A failed call (invalid ruleset FD,
E2BIG, ENOMEM, interrupted TSYNC, ...) leaves no_new_privs unchanged,
and a successful call never returns without no_new_privs set: the
attribute is set past the last point of failure, right before
commit_creds(), which cannot fail.

Combined with LANDLOCK_RESTRICT_SELF_TSYNC, no_new_privs is set on all
threads with the same guarantee: each sibling thread sets it in the
commit phase of the TSYNC protocol, after its all-or-nothing barrier,
so either every thread gets both the domain and no_new_privs, or none
does.  This also makes it possible to set no_new_privs process-wide in
one call, which prctl(2) cannot do.

The flag requires a ruleset: calls with a ruleset_fd of -1 are
rejected.  Such a call would be nothing more than a Landlock-flavored
prctl(PR_SET_NO_NEW_PRIVS), and rejecting it keeps the option of giving
it a meaning later.  As a consequence of the fulfilled precondition, an
unprivileged caller passing unknown flag bits together with this flag
receives EINVAL instead of EPERM; the selftests pin this error ordering
as well.

The Landlock ABI version is bumped to 11.

Test coverage:

base_test checks that a successful call sets no_new_privs without a
prior prctl(2) nor CAP_SYS_ADMIN, that a failed call (invalid ruleset
FD or layer maximum) leaves it unchanged, that the flag requires a
ruleset FD, and the updated EPERM/EINVAL ordering.  tsync_test checks
that TSYNC sets no_new_privs on sibling threads along with the domain,
and that a TSYNC call failing on the layer maximum leaves it unset on
every thread.

Changes since v2:

- Reworded "atomically" to the ordering guarantee in the commit
  messages, kdocs and documentation, per Mickaël's feedback.
- Explained the valid-ruleset requirement in the first patch's commit
  message.
- Ran clang-format on the selftests and added max-layers failure tests
  checking E2BIG and that no_new_privs stays unset.
- Mentioned the selftest renames in the commit message.
- Updated the documentation tutorial (restrict_flags gated on the ABI
  version, prctl(2) call skipped when the flag is used) and explained
  that not setting no_new_privs is risky even when it is not required.
- New patch: the sandboxer sample now uses the flag by default, gated
  on the ABI version, with a prctl(2) fallback.

Per-patch changelogs are below each patch.

[1] https://lore.kernel.org/linux-security-module/20260717220320.1030123-1-utilityemal77@gmail.com/
[2] https://lore.kernel.org/linux-security-module/20260731.at2Zilei1ech@digikod.net/

Justin Suess (4):
  landlock: Add LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS
  selftests/landlock: Test LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS
  landlock: Document LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS
  samples/landlock: Add LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS to sampler

 Documentation/userspace-api/landlock.rst      | 47 +++++++--
 include/uapi/linux/landlock.h                 | 13 +++
 samples/landlock/sandboxer.c                  | 16 ++-
 security/landlock/limits.h                    |  2 +-
 security/landlock/syscalls.c                  | 28 ++++--
 security/landlock/tsync.c                     |  8 +-
 security/landlock/tsync.h                     |  4 +-
 tools/testing/selftests/landlock/base_test.c  | 99 ++++++++++++++++++-
 tools/testing/selftests/landlock/tsync_test.c | 72 ++++++++++++++
 9 files changed, 263 insertions(+), 26 deletions(-)


base-commit: 308bc78f1e577439ca61ec77842a5a3ba7e8bbce
-- 
2.54.0

