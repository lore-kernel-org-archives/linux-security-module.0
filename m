Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch [84.16.66.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D51142E77
	for <linux-security-module@vger.kernel.org>; Mon,  6 Jan 2025 15:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736176814; cv=none; b=Ic3wGUAYSdeZ2rIM4M6l6Xe4uFCtWYo1mHhMpliUnEhVH9WteemKPOGApUiphORFIQtgWNu+INYo1Cdy/lr4RIHHngmc52TTzVLQqbndQf8myPW5NV46t/s/YuN+ha/QsDnOYljTMZyqkjSCjEvkXE9Onmjnfrf3/JS6Uu5FF2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736176814; c=relaxed/simple;
	bh=vwHBOt6iONXGGX7UT/v+0Yp5z3ziwQyf6Q/9uHCmOAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=De/TMnD2uOMW053cNdIbduaz8e3kzbF2MOAxBqSljE5axujrQiUH5LPkQb2zTmLmP9ESfVHI/FTeYnyRzcau+y8nXDioRO1qY4GYrvWch9Arjt4aXZ/ArRVZ9vZEgUqg6yImGEcAJsyWF2sBMTN3NqSfGQlr8obNnOionA1/79w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=zTk6B9nJ; arc=none smtp.client-ip=84.16.66.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="zTk6B9nJ"
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:0])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YRcZF2TDFzRGM;
	Mon,  6 Jan 2025 15:51:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1736175077;
	bh=KuVQD6wAY45w0l1DqU9Y6QxnqSoKglws61eC3Phr3FE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zTk6B9nJ7LMoNvcMFbvnH2NBfqWlsxEJY/LcudOZmokGeQ2z3Y91YbYirrGW+IDFB
	 HZm6Iv8HFojgV3UpK2K08n5t+dMGe1sctq2HEmVnhR/2559ikUqSSiZK6J2gX/8luK
	 mpGbRUc6ScELqLLCBRSkHW4f3FEcQLTSH2z9inn0=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4YRcZD2xPNzb3Q;
	Mon,  6 Jan 2025 15:51:16 +0100 (CET)
Date: Mon, 6 Jan 2025 15:51:15 +0100
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
Subject: Re: [PATCH v3 10/23] landlock: Log domain properties and release
Message-ID: <20250106.ohgh8Zeu6coo@digikod.net>
References: <20241122143353.59367-11-mic@digikod.net>
 <237bfe2be7b4ba5d59b3b832c23622bb@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <237bfe2be7b4ba5d59b3b832c23622bb@paul-moore.com>
X-Infomaniak-Routing: alpha

On Sat, Jan 04, 2025 at 08:23:51PM -0500, Paul Moore wrote:
> On Nov 22, 2024 =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net> wrote:
> > 
> > TODO: Update sample with audit's creation time and now-removed parent
> > hierarchy
> > 
> > Asynchronously log domain information when it first denies an access.
> > This minimize the amount of generated logs, which makes it possible to
> > always log denials since they should not happen (except with the new
> > LANDLOCK_RESTRICT_SELF_LOGLESS flag).  These records are identified by
> > AUDIT_LANDLOCK_DOM_INFO.
> > 
> > Log domain deletion with the AUDIT_LANDLOCK_DOM_DROP record type when
> > a domain was previously logged.  This makes it possible for user space
> > to free potential resources when a domain ID will never show again.
> > 
> > The logged domain properties include:
> > - the domain ID
> > - creation time
> > - its creator's PID
> > - its creator's UID
> > - its creator's executable path (exe)
> > - its creator's command line (comm)
> > 
> > This require each domain to save some task properties at creation time:
> > time, PID, credentials, exe path, and comm.
> > 
> > It should be noted that we cannot use audit event's serial numbers
> > because there may not be any related event.  However, it is still useful
> > to use the same potential timestamp instead of a close one.  What really
> > matter is how old the related Landlock domain is, not the uniquiness of
> > the creation time.  If audit is not enabled, Landlock creates its own
> > timestamp.  This timestamp will be exposed to user space with a future
> > unprivileged interface.
> > 
> > Audit event sample for a first denial:
> > 
> >   type=LL_DENY msg=audit(1732186800.349:44): domain=195ba459b blockers=ptrace opid=1 ocomm="systemd"
> >   type=LL_DOM_INFO msg=audit(1732186800.349:44): domain=195ba459b creation=1732186800.345 pid=300 uid=0 exe="/root/sandboxer" comm="sandboxer"
> >   type=SYSCALL msg=audit(1732186800.349:44): arch=c000003e syscall=101 success=no [...] pid=300 auid=0
> 
> As mentioned in patch 9/23, I don't want subsystems external to audit
> to access the audit timestamp information, so the "creation=" field
> in the audit event would need to be removed.  Assuming that the timestamp
> was used either to reference the original domain creation and/or simply
> provide some additional information for analysis, all of that information
> should already be in the audit log, assuming of course that you are
> logging domain creation (which you should, at least as an option).

As explained in this patch, we don't want to (and cannot realistically)
log domain creations.  That would make the audit support for Landlock
unusable.  Moreover, these information is useless and only add noise
unless there is a denial, hence this asynchronous approach.  However,
users may want to log some syscalls, including landlock_restrict_self(),
and it would make audit logs more consistent using the same timestamp as
the Landlock domain creation time.  I'm wondering why exposing this
timestamp to the kernel would be an issue whereas it is already exposed
to user space.

If you're really opposed to it I can create a new unrelated timestamp
specific to Landlock.

> 
> Also, is there a good reason why the LL_DOM_INFO information can't be
> recorded in the LL_DENY (or LL_ACCESS) record?  I think that would be
> preferable.

The goal of the standalone LL_DOM_INFO record type is to limit useless
log verbosity.  Including this information in LL_DENY would have two
downsides:
- it would increases the length of *all* LL_DENY messages
- it would make it more difficult to extend this new mixed messages with
  access-related informations (e.g. file property) and domain-related
  informations (and associate them with either the object or the
  domain).

I prefer to have clear semantic with distinct and dedicated audit record
types.  Relying on different record type also enable users to
efficiently filter them.

> 
> > Audit event sample for logged domains deletion:
> > 
> >   type=LL_DOM_DROP msg=audit(1732186800.393:45): domain=195ba459b
> > 
> > Cc: Günther Noack <gnoack@google.com>
> > Cc: Paul Moore <paul@paul-moore.com>
> > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > Link: https://lore.kernel.org/r/20241122143353.59367-11-mic@digikod.net
> > ---
> > Questions:
> > - Should we also log the creator's loginuid?
> > - Should we also log the creator's sessionid?
> 
> Creation of a Landlock domain can only happen through the Landlock
> syscalls, yes?  If so, that information should already be logged in
> the associated syscall record (see the "auid=" and "ses=" fields )and
> we generally try to avoid duplicating information across records in
> the same audit event.

The specificity of Landlock compared to existing supported systems is
that we cannot log domain creation for the reason I explain before.
We might extend the asynchronous LL_DOM_INFO message with such
information in the future though.

> 
> > Changes since v2:
> > - Fix docstring.
> > - Fix log_status check in log_hierarchy() to also log
> >   LANDLOCK_LOG_DISABLED.
> > - Add audit's creation time to domain's properties.
> > - Use hexadecimal notation for domain IDs.
> > - Remove domain's parent records: parent domains are not really useful
> >   in the logs.  They will be available with the upcoming introspection
> >   feature though.
> > - Extend commit message with audit's timestamp explanation.
> > 
> > Changes since v1:
> > - Add a ruleset's version for atomic logs.
> > - Rebased on the TCP patch series.
> > - Rename operation using "_" instead of "-".
> > - Rename AUDIT_LANDLOCK to AUDIT_LANDLOCK_RULESET.
> > - Only log when audit is enabled, but always set domain IDs.
> > - Don't log task's PID/TID with log_task() because it would be redundant
> >   with the SYSCALL record.
> > - Remove race condition when logging ruleset creation and logging
> >   ruleset modification while the related file descriptor was already
> >   registered but the ruleset creation not logged yet.
> > - Fix domain drop logs.
> > - Move the domain drop record from the previous patch into this one.
> > - Do not log domain creation but log first domain use instead.
> > - Save task's properties that sandbox themselves.
> > ---
> >  include/uapi/linux/audit.h   |  2 +
> >  security/landlock/audit.c    | 74 ++++++++++++++++++++++++++++++++++++
> >  security/landlock/audit.h    |  7 ++++
> >  security/landlock/domain.c   | 41 ++++++++++++++++++++
> >  security/landlock/domain.h   | 43 +++++++++++++++++++++
> >  security/landlock/ruleset.c  |  7 ++++
> >  security/landlock/ruleset.h  |  1 +
> >  security/landlock/syscalls.c |  1 +
> >  8 files changed, 176 insertions(+)
> > 
> > diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> > index 60c909c396c0..a72f7b3403be 100644
> > --- a/include/uapi/linux/audit.h
> > +++ b/include/uapi/linux/audit.h
> > @@ -147,6 +147,8 @@
> >  #define AUDIT_IPE_CONFIG_CHANGE	1421	/* IPE config change */
> >  #define AUDIT_IPE_POLICY_LOAD	1422	/* IPE policy load */
> >  #define AUDIT_LANDLOCK_DENY	1423	/* Landlock denial */
> > +#define AUDIT_LANDLOCK_DOM_INFO	1424	/* Landlock domain properties */
> > +#define AUDIT_LANDLOCK_DOM_DROP	1425	/* Landlock domain release */
> 
> See my comment about regarding AUDIT_LANDLOCK_DOM_INFO.
> 
> Similar to my previous comments regarding AUDIT_LANDLOCK_DENY, it might
> be a good idea to change AUDIT_LANDLOCK_DOM_DROP to simply
> AUDIT_LANDLOCK_DOM and use an "op=" field to indicate a drop, creation,
> or other event.

Using a dedicated audit record type enables users to efficiently filter
according to their type, and (in this specific case, sightly) reduce log
size.

> 
> > diff --git a/security/landlock/audit.c b/security/landlock/audit.c
> > index eab6b3a8a231..2d0a96797dd4 100644
> > --- a/security/landlock/audit.c
> > +++ b/security/landlock/audit.c
> > @@ -8,8 +8,11 @@
> >  #include <kunit/test.h>
> >  #include <linux/audit.h>
> >  #include <linux/lsm_audit.h>
> > +#include <linux/pid.h>
> > +#include <linux/uidgid.h>
> >  
> >  #include "audit.h"
> > +#include "cred.h"
> >  #include "domain.h"
> >  #include "ruleset.h"
> >  
> > @@ -30,6 +33,41 @@ static void log_blockers(struct audit_buffer *const ab,
> >  	audit_log_format(ab, "%s", get_blocker(type));
> >  }
> >  
> > +static void log_node(struct landlock_hierarchy *const node)
> > +{
> > +	struct audit_buffer *ab;
> > +
> > +	if (WARN_ON_ONCE(!node))
> > +		return;
> > +
> > +	/* Ignores already logged domains.  */
> > +	if (READ_ONCE(node->log_status) == LANDLOCK_LOG_RECORDED)
> > +		return;
> > +
> > +	ab = audit_log_start(audit_context(), GFP_ATOMIC,
> > +			     AUDIT_LANDLOCK_DOM_INFO);
> > +	if (!ab)
> > +		return;
> > +
> > +	WARN_ON_ONCE(node->id == 0);
> 
> It seems like you might want to move the WARN_ON assertion up with the
> other WARN_ON check?

I wanted to limit this check but only do it before actually using this
ID.

> 
> > +	audit_log_format(ab, "domain=%llx creation=%llu.%03lu pid=%d uid=%u",
> > +			 node->id,
> > +			 /* See audit_log_start() */
> > +			 (unsigned long long)node->creation.tv_sec,
> > +			 node->creation.tv_nsec / 1000000, pid_nr(node->pid),
> > +			 from_kuid(&init_user_ns, node->cred->uid));
> > +	audit_log_d_path(ab, " exe=", &node->exe);
> > +	audit_log_format(ab, " comm=");
> > +	audit_log_untrustedstring(ab, node->comm);
> > +	audit_log_end(ab);
> > +
> > +	/*
> > +	 * There may be race condition leading to logging of the same domain
> > +	 * several times but that is OK.
> > +	 */
> > +	WRITE_ONCE(node->log_status, LANDLOCK_LOG_RECORDED);
> > +}
> > +
> >  static struct landlock_hierarchy *
> >  get_hierarchy(const struct landlock_ruleset *const domain, const size_t layer)
> >  {
> 
> --
> paul-moore.com
> 
