Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CC937F727
	for <linux-security-module@vger.kernel.org>; Wed,  8 Jul 2026 13:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783517990; cv=none; b=u6WiclmpJPdvdCxR9iabxVKSJqnKwK/aq4SUMpySlzPXgNLXuuJHykB2/irkzrlRU67u9F5h5Bt0up7c3S+4iW9vrs4IiTMMhXsE7BKKDi7NMASALm23s1g814KRyBv0z9/r1N9gT1PFxR8vynfPUAlKxmBGIIqMRulvd/J0E80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783517990; c=relaxed/simple;
	bh=cSEac3BC/5IwZYF129Y2/ZN33jLOvAYQxXnRVkKTb5w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OeVISCN2QDItN7SgLj4R3HvJ0jzq1guKgeFNiZpkZL5JRpQtG1iUnG+NXhTCxdIwd59aA+rN4lvCLg2l0CUTH/N5FENRNCBuYkOnM9OkBXohLtldYVIJlG89tOGZx8OmzXSGXX3Axh8E/l5ofMjuUUtFgVP8p92y540IaERdqWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U5hmdI9U; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U5hmdI9U"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-66666bad8beso876064d50.3
        for <linux-security-module@vger.kernel.org>; Wed, 08 Jul 2026 06:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783517988; x=1784122788; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RNZ4qnzUEsBUz3T3Cfb7/PSgzfan47uROs+sdgCd5Mk=;
        b=U5hmdI9UT1aMia+cBA8j0R+xswQlUv6W70Qs8ZCOaKB5YUfRtJEjEfkL2/vSb/5pYc
         kPGip62qiQLhvuKe42xfshinAFDFyApE39zVIa7vhIUvXTxg5EeMRO6iJF3J6GegRMB8
         yBmQtJmHpq40LUQ/AbUS7/QuUW2Mncqt0qAh560o4QtAv5lMGxGwTJHO8jvHAoVuepb6
         Jv+uudTSD38EzHl/tASY6DHHlNvNcIxTAqusxte/dL/yKIp63LGrBbvQUFmPZTCd0fKb
         Arh1SCefcu12yfPceDaO2m9Xpc1VQM0LYrOoeZr7TLNG20lfF7Pk4wjkuaWn3gznq2dE
         aXEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783517988; x=1784122788;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RNZ4qnzUEsBUz3T3Cfb7/PSgzfan47uROs+sdgCd5Mk=;
        b=UfkOCz+dysJj50YxoT0PZxIk+/eXiy6UQXbSL93vuQDaA8aQ1li6lq6VJtId4Wzcq3
         AfQ8GOPg3fC+tjF3eI1v/twEA6Qfvd+0en4QY2ciGQoGnwI7mfMKAsUp7ZPFuH69cyjk
         rt5rrKePGsxyJ+Mr3RcPQVroqOM68t8g36TBOPPVfHaoB1YJdI+DuSWQ7wg5NEbNL2xm
         4vbInsre1Rhkz14f4V+fdjfMyO60Lylrxv7cFCFzvZNC3q18ffUKC/rDYrk8ei1+cTp7
         G93WCUdfZyR4D1cp43hjv97S/odV66gdFepJMnvEsQaIKjcJil8T4ZE2jiJVTBJSBm7g
         DYoA==
X-Forwarded-Encrypted: i=1; AHgh+RpfBSoiSoSbw59KpMbiMA5Fc7N8vVM2xW/ya4dk0iqB8lL4UNBarSgyAi1qtCEFjue9vOhZeZhzFAo4IAqgTt3yu3+7uKE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyq9DXawn+qWrt58K6LFR5v+NzCEW3vjahzGgMRIuX10drIITy
	FO3k85D5BEItxICtd12nEBVS3WlS4LyQcnPeN7TjQ+5CcPceMjDeVIfY
X-Gm-Gg: AfdE7ck9nMIDcNxLnK4nVvGq8JS67Z/7bkaRrH6npWQt8wx2fNvjdK5WVeKDHGobYA4
	rsete/zh+MgC2+et1ngvf4Si/0Id1kusoegz770q0ZfAeH9G+3PxwjqJrKMV+TylMMSWI66R/25
	ebEyW2Vzp7JfFgLSb7HmRQTvc6BjN2zYie2WJP84YD8DFrcMWSvuAd13rPMwNXv9At8vEE61Lv3
	CR3g90/JDlQPfpJOmEnOO6dyLaMhjxeGajir9WNlzqOdZlWqAtVuXg8j152X9tjfLcmeMvlxiPR
	l2bXYLp7OmByQybcmHnJK1NYlwGNlpJfxbdrtsKdrRobneW/SXCLRfPoVZbfDQNpi/rqCbvMKrf
	4ti7l96bTB/kNJdUE2KYiAqT+oE47rXp2bum18AMwZCeXQG8qmvYl7FN+TQYnh+DSl9Gm1dbosr
	JkE+0TIZ1KKOFKHE/52AuNar2RDoAGAEhs/JLuPAz1YkgV3jc=
X-Received: by 2002:a05:690e:1306:b0:65e:c81:3a6c with SMTP id 956f58d0204a3-6679f00f471mr1726182d50.15.1783517987369;
        Wed, 08 Jul 2026 06:39:47 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:717c:ccb8:c362:d995])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-667877a2db1sm2087969d50.6.2026.07.08.06.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 06:39:46 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: mic@digikod.net,
	linux-security-module@vger.kernel.org
Cc: gnoack@google.com,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH 0/3] Implement LANDLOCK_RESTRICT_SELF_NNP_ON_EXEC
Date: Wed,  8 Jul 2026 09:39:24 -0400
Message-ID: <20260708133928.852999-1-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Good morning,

This series adds a new landlock_restrict_self(2) flag:
LANDLOCK_RESTRICT_SELF_NNP_ON_EXEC.

This flag stages a bit in the Landlock credentials indicating that the
next successful execution will set the no_new_privs attribute while
committing its new credentials.

Differences from prctl(PR_SET_NO_NEW_PRIVS):

PR_SET_NO_NEW_PRIVS takes effect immediately: it prevents gaining
privileges through set-user-ID, set-group-ID and file capabilities
starting with the very next execve(2).

LANDLOCK_RESTRICT_SELF_NNP_ON_EXEC instead only sets the task's
no_new_privs attribute once the next execve(2) is guaranteed to succeed
(past its point of no return, in bprm_committing_creds), after any
privilege gain through set-user-ID, set-group-ID or file capabilities
has already taken place.  The executed program then runs with
no_new_privs, so subsequent executions cannot gain privileges.  A
failed execve(2) leaves no_new_privs untouched.

Use cases:

Enforcing a Landlock ruleset requires that the calling process either
already has no_new_privs set or possesses CAP_SYS_ADMIN.  This series
does not grant any exception to this rule; for a caller that already
has no_new_privs set, the flag is effectively a no-op.  It is therefore
mostly useful for CAP_SYS_ADMIN callers that need to execute programs
that legitimately escalate privileges (e.g. transition to another
user), while ensuring that further executions cannot gain privileges.

Consider a sandbox launcher that depends on a set-user-ID helper, such
as launching applications through bubblewrap on distributions where
unprivileged user namespaces are disabled and bwrap is installed
set-user-ID root.  The launcher cannot set PR_SET_NO_NEW_PRIVS before
the execution, as that would neuter the very helper it depends on:

  sandbox launcher (CAP_SYS_ADMIN)
  |
  | landlock_restrict_self(-1, LANDLOCK_RESTRICT_SELF_NNP_ON_EXEC)
  V
  /usr/bin/bwrap (set-user-ID root: honored for this execution;
  |               no_new_privs set once the execution is past its
  |               point of no return)
  V
  sandboxed application (runs with no_new_privs; cannot gain
                         privileges through any further execution, and
                         may enforce its own Landlock ruleset without
                         CAP_SYS_ADMIN)

This flag also closes a gap for CAP_SYS_ADMIN callers of
landlock_restrict_self(2) itself.  The no_new_privs/CAP_SYS_ADMIN
requirement exists to keep set-user-ID programs from running confused
inside a sandbox they do not expect.  However, a privileged process
that enforces a domain without setting no_new_privs leaves that hole
open for all of its descendants: anything running in the domain may
still execute a set-user-ID binary, which then runs privileged under a
restricted view of the system.  A privileged process that needs one
legitimate set-user-ID/set-group-ID transition currently has to choose
between breaking that transition (setting no_new_privs first) or
leaving the hole open for the lifetime of the domain.
LANDLOCK_RESTRICT_SELF_NNP_ON_EXEC allows the one intended transition
and then closes the hole.

Design:

This flag is implemented simply: a bit is stored in the Landlock
credential blob (struct landlock_cred_security) indicating whether the
next execution should set no_new_privs when it commits its new
credentials.

The bit is not coupled to any ruleset and, like
LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF, may be passed with no
ruleset (i.e. ruleset_fd = -1).  It may also be combined with
LANDLOCK_RESTRICT_SELF_TSYNC to propagate the staged state to sibling
threads, each thread then setting no_new_privs at its own next
execve(2).

The staged bit is inherited across fork(2) and persists in the
credentials until the next successful execution.  To consume it,
Landlock handles the bprm_committing_creds hook, which runs while the
credentials of the new program are being committed: if the bit is set,
task_set_no_new_privs(current) is called and the bit is cleared.

Again, this flag does not bypass the requirement to either have
CAP_SYS_ADMIN or no_new_privs already set to call
landlock_restrict_self(2).

The Landlock ABI version is bumped to 11.

Test coverage:

The new nnp_on_exec fixture generates a shell script that reads the
NoNewPrivs value from /proc/self/status and exits with it.  The
variants select the conditions under which the flag is tested (with
and without a ruleset, with and without CAP_SYS_ADMIN/no_new_privs
already set, with and without TSYNC, etc.), then compare no_new_privs
before the execution and in the executed script.  The ruleset variants
also check that a ruleset passed along the flag is enforced
immediately, unlike the staged no_new_privs.

Justin Suess (3):
  landlock: Add LANDLOCK_RESTRICT_SELF_NNP_ON_EXEC
  selftests/landlock: Test LANDLOCK_RESTRICT_SELF_NNP_ON_EXEC
  landlock: Document LANDLOCK_RESTRICT_SELF_NNP_ON_EXEC

 Documentation/userspace-api/landlock.rst     |  21 +-
 include/uapi/linux/landlock.h                |  36 ++-
 security/landlock/cred.c                     |  22 ++
 security/landlock/cred.h                     |   8 +
 security/landlock/limits.h                   |   2 +-
 security/landlock/syscalls.c                 |  54 +++-
 tools/testing/selftests/landlock/base_test.c | 259 ++++++++++++++++++-
 7 files changed, 382 insertions(+), 20 deletions(-)

-- 
2.54.0

