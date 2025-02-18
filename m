Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch [83.166.143.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D401242C0B
	for <linux-security-module@vger.kernel.org>; Tue, 18 Feb 2025 19:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739906392; cv=none; b=MFNxdDBS5NL0GwToxfAJ3+dS0tkGUwkocuRV9Ru5vWoTczdCsYI0UA7r6R+d164R0+dY1xOPJ5jOyrE6h650IfMqfG9hMblPHi8+jwji6ZcuXzdmeToqvtulWAovybd4MRN766IUxsLxfdzzj+wdZ96XmHNCfKaTprlMdXsGwKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739906392; c=relaxed/simple;
	bh=qS/3EyDtsIqq4BE7T5sae2EOy9MZhOOp7/5dyYC0fTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dY5CyRGVGqz+4vDe0TvKR9bfQSmZ4aRglWM56Mq74FfGSBt3RK632et0sMt4/ckM53PJ4DTZYeIInpc7uh3AUQ7S/Bm27srVNwLNhKRl0xNpefvnM2vQfG3zhoNU9QlueV1I4gZqK1vgwwWZnejm147pXRAawFE7Oxg1eZVnyIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=VRDuQEP5; arc=none smtp.client-ip=83.166.143.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="VRDuQEP5"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Yy8V359myzcxT;
	Tue, 18 Feb 2025 20:19:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1739906379;
	bh=N2t6NqopJ550I8j1hKd9Uj6iHTea8v4FXcTZuUpaFOM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VRDuQEP5M5HOSq3KKR7anyr0vbLSDHysQc2LE6VzYlK+WGGPcKv3IpEjc2gpd7zY3
	 9t4bf09TESJHQxPMco46a0TPUbjiNURpBUAPB8ghbkMWDX3PWo0eQ1ybZeyIlV+259
	 MbZ8mnS7HLjGWpy70olKehfmcSa3F+Vhk9ofNbqc=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Yy8V14TGtzyC2;
	Tue, 18 Feb 2025 20:19:37 +0100 (CET)
Date: Tue, 18 Feb 2025 20:19:36 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Paul Moore <paul@paul-moore.com>
Cc: Eric Paris <eparis@redhat.com>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Ben Scarlato <akhna@google.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Charles Zaffery <czaffery@roblox.com>, Daniel Burgener <dburgener@linux.microsoft.com>, 
	Francis Laniel <flaniel@linux.microsoft.com>, James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>, 
	Jeff Xu <jeffxu@google.com>, Jorge Lucangeli Obes <jorgelo@google.com>, 
	Kees Cook <kees@kernel.org>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	Phil Sutter <phil@nwl.cc>, Praveen K Paladugu <prapal@linux.microsoft.com>, 
	Robert Salvet <robert.salvet@roblox.com>, Shervin Oloumi <enlightened@google.com>, 
	Song Liu <song@kernel.org>, Tahera Fahimi <fahimitahera@gmail.com>, 
	Tyler Hicks <code@tyhicks.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v5 9/24] landlock: Add AUDIT_LANDLOCK_ACCESS and log
 ptrace  denials
Message-ID: <20250218.uuBaiB2woloo@digikod.net>
References: <20250131163059.1139617-10-mic@digikod.net>
 <715d3d6c220bfd818bf50175cf14fd3c@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <715d3d6c220bfd818bf50175cf14fd3c@paul-moore.com>
X-Infomaniak-Routing: alpha

On Fri, Feb 14, 2025 at 05:52:47PM -0500, Paul Moore wrote:
> On Jan 31, 2025 =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net> wrote:
> > 
> > Add a new AUDIT_LANDLOCK_ACCESS record type dedicated to an access
> > request denied by a Landlock domain.  AUDIT_LANDLOCK_ACCESS indicates
> > that something unexpected happened.
> > 
> > For now, only denied access are logged, which means that any
> > AUDIT_LANDLOCK_ACCESS record is always followed by a SYSCALL record with
> > "success=no".  However, log parsers should check this syscall property
> > because this is the only sign that a request was denied.  Indeed, we
> > could have "success=yes" if Landlock would support a "permissive" mode.
> > We could also add a new field for this mode to AUDIT_LANDLOCK_DOMAIN
> > (see following commit).
> >
> > By default, the only logged access requests are those coming from the
> > same executed program that enforced the Landlock restriction on itself.
> > In other words, no audit record are created for a task after it called
> > execve(2).  This is required to avoid log spam because programs may only
> > be aware of their own restrictions, but not the inherited ones.
> > 
> > Following commits will allow to conditionally generate
> > AUDIT_LANDLOCK_ACCESS records according to dedicated
> > landlock_restrict_self(2)'s flags.
> > 
> > The AUDIT_LANDLOCK_ACCESS message contains:
> > - the "domain" ID restricting the action on an object,
> > - the "blockers" that are missing to allow the requested access,
> > - a set of fields identifying the related object (e.g. task identified
> >   with "opid" and "ocomm").
> > 
> > The blockers are implicit restrictions (e.g. ptrace), or explicit access
> > rights (e.g. filesystem), or explicit scopes (e.g. signal).  This field
> > contains a list of at least one element, each separated with a comma.
> > 
> > The initial blocker is "ptrace", which describe all implicit Landlock
> > restrictions related to ptrace (e.g. deny tracing of tasks outside a
> > sandbox).
> > 
> > Add audit support to ptrace_access_check and ptrace_traceme hooks.  For
> > the ptrace_access_check case, we log the current/parent domain and the
> > child task.  For the ptrace_traceme case, we log the parent domain and
> > the parent task.  Indeed, the requester is the current task, but the
> > action would be performed by the parent task.
> > 
> > Audit event sample:
> > 
> >   type=LANDLOCK_ACCESS msg=audit(1729738800.349:44): domain=195ba459b blockers=ptrace opid=1 ocomm="systemd"
> >   type=SYSCALL msg=audit(1729738800.349:44): arch=c000003e syscall=101 success=no [...] pid=300 auid=0
> > 
> > A following commit adds user documentation.
> > 
> > Add KUnit tests to check reading of domain ID relative to layer level.
> > 
> > The quick return for non-landlocked tasks is moved from task_ptrace() to
> > each LSM hooks.
> > 
> > Because the landlock_log_denial() function is only called when an access
> > is denied, the compiler should be able to optimize the struct
> > landlock_request initializations.  It is not useful to inline the
> > audit_enabled check because other computation are performed anyway, and
> > by the same landlock_log_denia() code.
> > 
> > Use scoped guards for RCU read-side critical sections.
> > 
> > Cc: Günther Noack <gnoack@google.com>
> > Cc: Paul Moore <paul@paul-moore.com>
> > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > Link: https://lore.kernel.org/r/20250131163059.1139617-10-mic@digikod.net
> > ---
> > Changes since v4:
> > - Rename AUDIT_LANDLOCK_DENY to AUDIT_LANDLOCK_ACCESS, requested by
> >   Paul.
> > - Make landlock_log_denial() get Landlock credential instead of Landlock
> >   domain to be able to filter on the domain_exe variable.
> > - Rebase on top of the migration from struct landlock_ruleset to struct
> >   landlock_cred_security.
> > - Rename landlock_init_current_hierarchy() to
> >   landlock_init_hierarchy_log().
> > - Rebase on top of the scoped guard patches.
> > - By default, do not log denials after an execution.
> > - Use scoped guards for RCU read-side critical sections.
> > 
> > Changes since v3:
> > - Extend commit message.
> > 
> > Changes since v2:
> > - Log domain IDs as hexadecimal number: this is a more compact notation
> >   (i.e. at least one less digit), it improves alignment in logs, and it
> >   makes most IDs start with 1 as leading digit (because of the 2^32
> >   minimal value).  Do not use the "0x" prefix that would add useless
> >   data to logs.
> > - Constify function arguments.
> > - Clean up Makefile entries.
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
> >  security/landlock/Makefile  |   5 +-
> >  security/landlock/audit.c   | 146 ++++++++++++++++++++++++++++++++++++
> >  security/landlock/audit.h   |  53 +++++++++++++
> >  security/landlock/domain.c  |  28 +++++++
> >  security/landlock/domain.h  |  22 ++++++
> >  security/landlock/ruleset.c |   6 ++
> >  security/landlock/task.c    |  96 ++++++++++++++++++------
> >  8 files changed, 334 insertions(+), 25 deletions(-)
> >  create mode 100644 security/landlock/audit.c
> >  create mode 100644 security/landlock/audit.h
> >  create mode 100644 security/landlock/domain.c
> 
> Based on previous discussions I'm under the impression that you are
> planning to add a Landlock "permissive" mode at some point in the
> future and based on the comments above you plan to add a "success="
> field to the _ACCESS record defined here.  There is no problem with
> adding fields to an existing record, but the general guidance is that
> new fields need to be added to the end of the record (limitations due
> the the audit userspace and poor guidance in the early days of audit).
> Assuming you are okay with that there is no need to change anything,
> but if you would prefer the "permissive=" field to occur somewhere
> else in the record you may want to consider adding a "permissive=no"
> now.  Otherwise this looks okay from an audit perspective.
> 
> [P.S. I just got to patch 10/24 and saw the enforcing field there,
>  the comments above still stand, but it looks like you chose to note
>  this in the _DOMAIN record, which is fine.]

The mode is indeed specified in the _DOMAIN record.  I think the
syscall's success field should be enough for users in most cases, no
need to duplicate information.

> 
> Acked-by: Paul Moore <paul@paul-moore.com> (Audit)
> 
> --
> paul-moore.com
> 
