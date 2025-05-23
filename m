Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch [84.16.66.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7FE297116
	for <linux-security-module@vger.kernel.org>; Fri, 23 May 2025 16:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748019481; cv=none; b=ryVdfsjj+J0oXuFXk3WeLX0KBBU1o7Zm17AihfUkd5//pwON4oCzjKqEf0SG6BLW8cbtxIXtO9NX0T0iBMHxcRhBXqaLIuGyeAuwPIX2Ln/7KxwxePFUnCcnjznHPhzIbBlib8MfZqdcun37uPoAajsgmRM5AwMXIKxHpJkTlb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748019481; c=relaxed/simple;
	bh=AuEqfyOM+2M+kJH1W+E0BKDYc/4gC3489fplTUkiyg0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gaFy6teUAIpcBTQZ2ZqLRTY70BDEHn+OZA8TBMKU9lYLHkjqOkxUUTLEklAySMDb16Rx+4gTaRe3wTeqzH5+YpzVk0YTRlUbnYpp18ZAkhPl6gjWSvVUcOsAxeG+BB36Yxb2T6fuQYEzMuTaxvDVhJWsvpx/37jk9gIh0uGNvHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=DdyGENMZ; arc=none smtp.client-ip=84.16.66.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="DdyGENMZ"
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4b3rv062ltzfcj;
	Fri, 23 May 2025 18:57:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1748019468;
	bh=yCnQwaSlLqRMn1OhK7lne/Tos9ZsvKgFoIagtHHu7wM=;
	h=From:To:Cc:Subject:Date:From;
	b=DdyGENMZ1msg+uHfDwkcqpvHoVSQbrXPeZdmy9FsXYsZTcuBsEu607qFVo18jIpkt
	 xHSlrFAVS20gO8ODen+UdkARvudBDXAeqJke8czmvTYvSAHFiQ/xG7tG8YFiUFDwUg
	 4o9+P2VIoKvH9nYJbBmIHAm0vWVt5DltZ2MPd0VM=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4b3rtz3wp7zBsk;
	Fri, 23 May 2025 18:57:47 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Tingmao Wang <m@maowtm.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Daniel Burgener <dburgener@linux.microsoft.com>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Kees Cook <kees@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Ryan Sullivan <rysulliv@redhat.com>,
	Shervin Oloumi <enlightened@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-security-module@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [RFC PATCH v1 0/5] Landlock tracepoints
Date: Fri, 23 May 2025 18:57:36 +0200
Message-ID: <20250523165741.693976-1-mic@digikod.net>
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

This series adds two tracepoints to Landlock, one tied to rule addition,
and another to rule checking.  With these new tracepoints, we can see
all steps leading to an access decision.  They can be directly used with
/sys/kernel/tracing/events/landlock/* or attached by eBPF programs to
get a more complete view of Landlock internals.

This new feature is useful to trouble shoot policy issues, and it should
also limit the need for custom debugging kernel code when developing new
Landlock features.

Landlock already has audit support, which enables us to log denied
access requests.  Audit is useful to identify security issues or sandbox
misconfiguration.  However, it might not be enough to debug Landlock
policies.  The main differences with audit events is that traces are
disabled by default, can be very verbose, and can be filtered according
to process and Landlock properties (e.g. domain ID).

As for audit, this tracing feature may expose sensitive information and
must then only be accessible to the system administrator.

This RFC only fully supports filesystem rules but the next series will
also support network rules.  Tests are also missing for now.

Regards,

Mickaël Salaün (5):
  landlock: Rename landlock_id to landlock_rule_ref
  landlock: Merge landlock_find_rule() into landlock_unmask_layers()
  tracing: Add __print_untrusted_str()
  landlock: Add landlock_add_rule_fs tracepoint
  landlock: Add landlock_check_rule tracepoint

 MAINTAINERS                                |   1 +
 include/linux/trace_events.h               |   3 +
 include/trace/events/landlock.h            | 124 ++++++++++++++
 include/trace/stages/stage3_trace_output.h |   4 +
 include/trace/stages/stage7_class_define.h |   1 +
 kernel/trace/trace_output.c                |  40 +++++
 security/landlock/Makefile                 |  11 +-
 security/landlock/fs.c                     | 178 +++++++++++++--------
 security/landlock/fs.h                     |   3 +
 security/landlock/net.c                    |  18 +--
 security/landlock/ruleset.c                |  65 ++++----
 security/landlock/ruleset.h                |  15 +-
 security/landlock/trace.c                  |  15 ++
 13 files changed, 365 insertions(+), 113 deletions(-)
 create mode 100644 include/trace/events/landlock.h
 create mode 100644 security/landlock/trace.c


base-commit: a5806cd506af5a7c19bcd596e4708b5c464bfd21
-- 
2.49.0

