Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch [185.125.25.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438AC1DF72D
	for <linux-security-module@vger.kernel.org>; Mon,  6 Jan 2025 14:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736174726; cv=none; b=FhwXCbCcxvlIw4r/XbVuAJOdmhE8BUWVpEL/ZtYwxMHcCIcJ+NgcD1XvbgdO8S9C28gmFShowSTe+0zFBgyiidvYtxg8zBWKd0IuzPbZ49AJXqZHnC3k9qUAxGJ4QOfBer+KA6sd89tg0vgizEQRkM68jk+8N5all4sGp/QShgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736174726; c=relaxed/simple;
	bh=iaHl8nghDHNJxJao3QdubCWEH//IuAIMsoU86J+saEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T3vFgjBs07Q3+r8wp0Tls016GR2esf7SYlBELvSiMzlciPCPFGBvJkmldHYdQrfiPSvUPbZq5emk3Jj19CbUvTzJDhw3USqLZB4J154smmz7WcmPsWbWw3GM3Tc+ilnR61sMSAselIfJw1P+Q4rf7cItBYwCgvIVgZx/USZguE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=ggIr0Yq0; arc=none smtp.client-ip=185.125.25.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="ggIr0Yq0"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YRcRH6mYSzZT;
	Mon,  6 Jan 2025 15:45:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1736174715;
	bh=oNLP5oydomS3aCb4h3+wfUEil3g0RqPdOGQcOcB85Oc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ggIr0Yq0hJXLkfwkjIfniDQr+sGHW2Vt4Tja99Ba2ihSyNEk5bbHouQvTPzuHgwAd
	 xitlb+3s+TU2zWEsUMpAUbFfdA1Tg42jyplrJFxyv/1D5My0OrhsLr9UKpbR4hw8pY
	 dZLLjZHJ3cq+yhzTsZMjcNkpTAhusUbBXuw5Poz0=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4YRcRG2yC2zHvL;
	Mon,  6 Jan 2025 15:45:14 +0100 (CET)
Date: Mon, 6 Jan 2025 15:45:10 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Paul Moore <paul@paul-moore.com>
Cc: Eric Paris <eparis@redhat.com>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Ben Scarlato <akhna@google.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Charles Zaffery <czaffery@roblox.com>, Francis Laniel <flaniel@linux.microsoft.com>, 
	James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@google.com>, Kees Cook <kees@kernel.org>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Phil Sutter <phil@nwl.cc>, 
	Praveen K Paladugu <prapal@linux.microsoft.com>, Robert Salvet <robert.salvet@roblox.com>, 
	Shervin Oloumi <enlightened@google.com>, Song Liu <song@kernel.org>, 
	Tahera Fahimi <fahimitahera@gmail.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 8/23] landlock: Log ptrace denials
Message-ID: <20250106.wohB1leet2vu@digikod.net>
References: <20241122143353.59367-9-mic@digikod.net>
 <a0181404db7048781857521d010d0658@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a0181404db7048781857521d010d0658@paul-moore.com>
X-Infomaniak-Routing: alpha

On Sat, Jan 04, 2025 at 08:23:49PM -0500, Paul Moore wrote:
> On Nov 22, 2024 =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net> wrote:
> > 
> > Add audit support to ptrace_access_check and ptrace_traceme hooks.
> > 
> > Add a new AUDIT_LANDLOCK_DENY record type dedicated to any Landlock
> > denials.
> > 
> > Log the domain ID restricting the action, the domain's blockers that are
> > missing to allow the requested access, and the target task.
> > 
> > The blockers are implicit restrictions (e.g. ptrace), or explicit access
> > rights (e.g. filesystem), or explicit scopes (e.g. signal).
> > 
> > For the ptrace_access_check case, we log the current/parent domain and
> > the child task.  For the ptrace_traceme case, we log the parent domain
> > and the parent task.  Indeed, the requester is the current task, but the
> > action would be performed by the parent task.
> > 
> > The quick return for non-landlocked tasks is moved from task_ptrace() to
> > each LSM hooks.
> > 
> > Audit event sample:
> > 
> >   type=LL_DENY msg=audit(1732186800.349:44): domain=195ba459b blockers=ptrace opid=1 ocomm="systemd"
> >   type=SYSCALL msg=audit(1732186800.349:44): arch=c000003e syscall=101 success=no [...] pid=300 auid=0
> > 
> > Cc: Günther Noack <gnoack@google.com>
> > Cc: Paul Moore <paul@paul-moore.com>
> > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > Link: https://lore.kernel.org/r/20241122143353.59367-9-mic@digikod.net
> > ---
> > Changes since v2:
> > - Log domain IDs as hexadecimal number: this is a more compact notation
> >   (i.e. at least one less digit), it improves alignment in logs, and it
> >   makes most IDs start with 1 as leading digit (because of the 2^32
> >   minimal value).  Do not use the "0x" prefix that would add useless
> >   data to logs.
> > - Constify function arguments.
> > 
> > Changes since v1:
> > - Move most audit code to this patch.
> > - Rebase on the TCP patch series.
> > - Don't log missing access right: simplify and make it generic for rule
> >   types.
> > - Don't log errno and then don't wrap the error with
> >   landlock_log_request(), as suggested by Jeff.
> > - Add a WARN_ON_ONCE() check to never dereference null pointers.
> > - Only log when audit is enabled.
> > - Don't log task's PID/TID with log_task() because it would be redundant
> >   with the SYSCALL record.
> > - Move the "op" in front and rename "domain" to "denying_domain" to make
> >   it more consistent with other entries.
> > - Don't update the request with the domain ID but add an helper to get
> >   it from the layer masks (and in a following commit with a struct
> >   file).
> > - Revamp get_domain_id_from_layer_masks() into
> >   get_level_from_layer_masks().
> > - For ptrace_traceme, log the parent domain instead of the current one.
> > - Add documentation.
> > - Rename AUDIT_LANDLOCK_DENIAL to AUDIT_LANDLOCK_DENY.
> > - Only log the domain ID and the target task.
> > - Log "blockers", which are either implicit restrictions (e.g. ptrace)
> >   or explicit access rights (e.g. filesystem), or scopes (e.g. signal).
> > - Don't log LSM hook names/operations.
> > - Pick an audit event ID folling the IPE ones.
> > - Add KUnit tests.
> > ---
> >  include/uapi/linux/audit.h  |   3 +-
> >  security/landlock/Makefile  |   2 +-
> >  security/landlock/audit.c   | 137 ++++++++++++++++++++++++++++++++++++
> >  security/landlock/audit.h   |  52 ++++++++++++++
> >  security/landlock/domain.c  |  21 ++++++
> >  security/landlock/domain.h  |  17 +++++
> >  security/landlock/ruleset.c |   3 +
> >  security/landlock/task.c    |  91 ++++++++++++++++++------
> >  8 files changed, 302 insertions(+), 24 deletions(-)
> >  create mode 100644 security/landlock/audit.c
> >  create mode 100644 security/landlock/audit.h
> >  create mode 100644 security/landlock/domain.c
> > 
> > diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> > index 75e21a135483..60c909c396c0 100644
> > --- a/include/uapi/linux/audit.h
> > +++ b/include/uapi/linux/audit.h
> > @@ -33,7 +33,7 @@
> >   * 1100 - 1199 user space trusted application messages
> >   * 1200 - 1299 messages internal to the audit daemon
> >   * 1300 - 1399 audit event messages
> > - * 1400 - 1499 SE Linux use
> > + * 1400 - 1499 access control messages
> 
> Thank you :)
> 
> I'm also reminded once again that the original audit devs stubbornly
> used "SE Linux" instead of "SELinux" :/
> 
> >   * 1500 - 1599 kernel LSPP events
> >   * 1600 - 1699 kernel crypto events
> >   * 1700 - 1799 kernel anomaly records
> > @@ -146,6 +146,7 @@
> >  #define AUDIT_IPE_ACCESS	1420	/* IPE denial or grant */
> >  #define AUDIT_IPE_CONFIG_CHANGE	1421	/* IPE config change */
> >  #define AUDIT_IPE_POLICY_LOAD	1422	/* IPE policy load */
> > +#define AUDIT_LANDLOCK_DENY	1423	/* Landlock denial */
> 
> Generally speaking, we don't really encode denial/allowed verdicts into
> the audit record type, instead we ask that developers use a field like
> "access=" to indicate that an action was allowed or denied.
> 
> How about AUDIT_LANDLOCK_ACCESS ?

A stronger type with the "denied" semantic makes more sense to me,
especially for Landlock which is unprivileged, and it makes it clear
that it should only impact performance and log size (i.e. audit log
creation) for denied actions.  Having dedicated record types enables
users to easily and efficiently filter log with audit rules.
AUDIT_LANDLOCK_DENY is also a clear signal that something unexpected is
ongoing (see the LANDLOCK_RESTRICT_SELF_LOGLESS flag).  The next patch
series will also contain a new kind of audit rule to specifically
identify the origin of the policy that created this denied event, which
should make more sense.

Because of its unprivileged nature, Landlock will never log granted
accesses by default.  In the future, we might want a permissive-like
mode for Landlock, but this will be optional, and I would also strongly
prefer to add new audit record types for new semantics.  That would also
help log parsers to stick to the current deny-only semantic and avoid
misinterpretations or even noise from debug/test log entries.
