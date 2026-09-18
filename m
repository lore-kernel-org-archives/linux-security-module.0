Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch [45.157.188.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08455415F25
	for <linux-security-module@vger.kernel.org>; Fri, 18 Sep 2026 18:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789757467; cv=none; b=AY7FnQra60j7OVTPH1r2rTJ8nY1HV2C3MM8a4kxMSAS15jdKMl9n0usOuUKkC4/JiN0HQPf2uNdEB2LMBJNlkaNsNGCUpSh9YgnkTheZ2Ny6vJ4jCE9f5A5KHuPNgTcXrSuLlChuMVkG6MBAyyuVJ0ffdBJdCPSE969B07IkXc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789757467; c=relaxed/simple;
	bh=CI81u7eo9Z0IvKindsUW30a2ArUqaS3RZ3F71i2tONs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kNadMSlh64yX6K8GKFphtY0YogLWlOFy49dtil+Y+Vdq+X5SS4Qml94/bUObZbqBSdtZaNpXon5YhIDGiGcdt35jT/YrjdY3WFbq1xEj2HmI6NTMxHuL6vaZHXyj+GX//bMHYG0bnC1Qj0LDMBRMy/GgVYV7PYS26GPoYo6BQq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=lbdOyKR9; arc=none smtp.client-ip=45.157.188.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="lbdOyKR9"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hmhXN0bfzz7SJ;
	Fri, 18 Sep 2026 20:50:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1789757443;
	bh=FTOhGZVoEfxPjlBp4lu1sHfIY58JGyUm8Bc947duE48=;
	h=From:To:Cc:Subject:Date:From;
	b=lbdOyKR95vAOEUjZcOcqmOO57hnhjVwywuDezfwPTxFQj4wLFcSQFoO+JWAOg37aV
	 +0drMLQq3IB8pJpj3Ok9FVhJyg9Atx9KGJxej4J/S0QvikYrhR+gbJF9icEDCzp2GT
	 lg2DP4pzHTEcyheXqQAOpphdr7h3OhbMyA34rgtU=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4hmhXL5VSDzKnh;
	Fri, 18 Sep 2026 20:50:42 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Paul Moore <paul@paul-moore.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	bpf@vger.kernel.org,
	kernel-team@cloudflare.com,
	linux-security-module@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v1 0/9] landlock: Fix tracepoint policy context
Date: Fri, 18 Sep 2026 20:50:23 +0200
Message-ID: <20260918185036.608651-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Hi,

The Landlock tracepoints added during this development cycle need
correction before their interface reaches a released kernel.  For typed
BPF consumers, the number, order, and types of TP_PROTO arguments define
the callback contract and must be correct before release.  Topology
denials render as an empty blocker mask, network denials encode one
checked endpoint through ambiguous source and destination port fields,
and callbacks omit the actual ptrace tracer, effective signal, and
add-rule flags.

This series keeps the events focused on Landlock policy context.  It
uses kernel fixed-width aliases and derives trace blockers from the same
authoritative request state as audit.  Successful add-rule callbacks
carry validated per-call flags and access rights, while growable masks
passed by value use fixed u64 carriers.

The rule events become landlock_add_rule_path_beneath,
landlock_add_rule_net_port, landlock_check_rule_inode, and
landlock_check_rule_net_port.  These pre-release renames necessarily
update tracefs paths, typed-BPF attachments, selftests, and
documentation, but avoid carrying misleading names into the released
interface.

Network denial callbacks receive a sanitized copy of the checked
endpoint, and tracefs reports one signed port, with -1 meaning that no
port was checked.  Ptrace and signal callbacks receive the actual tracer
and effective signal.  Beyond the event-name churn, only blocker and
port rendering changes are visible through tracefs; the remaining
context is available to typed BPF.

The series changes no enforcement decision, UAPI, or audit output.
Event preparation remains behind the existing static-key checks.
Selftests cover the renamed events and both rendering changes, and the
documentation limits the contract to policy context while directing
consumers to generic tracepoints for operational context.

This series applies on top of v7.3-rc3.

Regards,

Mickaël Salaün (9):
  landlock: Fix tracepoint fixed-width type names
  landlock: Fix filesystem denial blocker reporting
  landlock: Fix rule tracepoint context
  landlock: Fix network denial trace context
  landlock: Report the actual ptrace tracer
  landlock: Report the effective signal number
  selftests/landlock: Test filesystem denial blockers
  selftests/landlock: Test network denial context
  landlock: Fix tracepoint contract documentation

 Documentation/trace/events-landlock.rst       |  52 +--
 include/trace/events/landlock.h               | 291 ++++++++++-------
 security/landlock/fs.c                        |  10 +-
 security/landlock/log.h                       |  52 ++-
 security/landlock/net.c                       |  42 ++-
 security/landlock/task.c                      |  87 ++++--
 security/landlock/trace.c                     |  71 ++++-
 tools/testing/selftests/landlock/fs_test.c    |  28 +-
 tools/testing/selftests/landlock/net_test.c   | 295 ++++++++++--------
 tools/testing/selftests/landlock/trace.h      |  59 ++--
 .../selftests/landlock/trace_fs_test.c        | 130 ++++++--
 tools/testing/selftests/landlock/trace_test.c |  51 +--
 12 files changed, 735 insertions(+), 433 deletions(-)


base-commit: fd73f4a6659897191fa0d40695fe370925dd3780
-- 
2.55.0

