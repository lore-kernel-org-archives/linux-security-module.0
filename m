Received: from smtp-190d.mail.infomaniak.ch (smtp-190d.mail.infomaniak.ch [185.125.25.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7528F1E51FA
	for <linux-security-module@vger.kernel.org>; Tue, 18 Feb 2025 19:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739906475; cv=none; b=W3msAgIEQ2aFuciIhj4p8vHtssUkPB0tt/Yw04kBHAXDTan2Qay/6F6ZE1tD11JAJI+m49Vw7G4j53PMYcE/kwBO412AaXzpC1o1i5XNobw7/kuY6W9FqkfH8I0lTtBJ4ib+0tTw1ngpXe5VQlmurK7u9xMbTqNkmxeDQNV0n7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739906475; c=relaxed/simple;
	bh=g6pM5p59DtafRScJvERQT6s7kkxvi1A/0/KvljZlntI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U++jAd8NOkXgaIRzSrOPFfd35s6YqUuoJdttC2Q3m8FiV+hUfeaFV0ekNzkV0iiLQDu9woOVF81fJ1re78yvFvweU/sGStfD72oLgGgQfa/yV1/fW+3OIBBOuUWA8ANf5ojnWLFc7CJo+digcTYOxCwySxMqPo2RpyeTpIVD7Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=CDVyVVOx; arc=none smtp.client-ip=185.125.25.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="CDVyVVOx"
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:1])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Yy8Wn35pzzsHM;
	Tue, 18 Feb 2025 20:21:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1739906469;
	bh=TP/4KcQ7PwfLgx3GavNd5mFGIeNpg/wtdpDBEjPeE/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CDVyVVOxAKCow0jCQYaGujlvPHO5NV/YpVTGwRGnowb3Tx7KNADx/EvFsqplMLc8t
	 RvOrGeXFrsl2IdL71gM5tIZOZudNlDlXK40iDkqsGrkIlEGCYKd769GZKnl2c8TRrV
	 BeDZkTXErKsW+Ea2ZirTN2QM2GJJmgSHgogoszGw=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Yy8Wm4VQ8z41;
	Tue, 18 Feb 2025 20:21:08 +0100 (CET)
Date: Tue, 18 Feb 2025 20:21:08 +0100
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
Subject: Re: [PATCH v5 10/24] landlock: Add AUDIT_LANDLOCK_DOMAIN and log
 domain status
Message-ID: <20250218.aePeer3oole2@digikod.net>
References: <20250131163059.1139617-11-mic@digikod.net>
 <7ed44e7b0e371302d29be95789cd1a57@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7ed44e7b0e371302d29be95789cd1a57@paul-moore.com>
X-Infomaniak-Routing: alpha

On Fri, Feb 14, 2025 at 05:52:49PM -0500, Paul Moore wrote:
> On Jan 31, 2025 =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net> wrote:
> > 
> > Asynchronously log domain information when it first denies an access.
> > This minimize the amount of generated logs, which makes it possible to
> > always log denials since they should not happen (except with the new
> > LANDLOCK_RESTRICT_SELF_QUIET flag).  These records are identified with
> > the new AUDIT_LANDLOCK_DOMAIN type.
> > 
> > The AUDIT_LANDLOCK_DOMAIN message contains:
> > - the "domain" ID which is described;
> > - the "status" which can either be "allocated" or "deallocated";
> > - the "mode" which is for now only "enforcing";
> > - for the "allocated" status, a minimal set of properties to easily
> >   identify the task that loaded the domain's policy with
> >   landlock_restrict_self(2): "pid", "uid", executable path ("exe"), and
> >   command line ("comm");
> > - for the "deallocated" state, the number of "denials" accounted to this
> >   domain, which is at least 1.
> > 
> > This requires each domain to save these task properties at creation
> > time in the new struct landlock_details.  A reference to the PID is kept
> > for the lifetime of the domain to avoid race conditions when
> > investigating the related task.  The executable path is resolved and
> > stored to not keep a reference to the filesystem and block related
> > actions.  All these metadata are stored for the lifetime of the related
> > domain and should then be minimal.  The required memory is not accounted
> > to the task calling landlock_restrict_self(2) contrary to most other
> > Landlock allocations (see related comment).
> > 
> > The AUDIT_LANDLOCK_DOMAIN record follows the first AUDIT_LANDLOCK_ACCESS
> > record for the same domain, which is always followed by AUDIT_SYSCALL
> > and AUDIT_PROCTITLE.  This is in line with the audit logic to first
> > record the cause of an event, and then add context with other types of
> > record.
> > 
> > Audit event sample for a first denial:
> > 
> >   type=LANDLOCK_ACCESS msg=audit(1732186800.349:44): domain=195ba459b blockers=ptrace opid=1 ocomm="systemd"
> >   type=LANDLOCK_DOMAIN msg=audit(1732186800.349:44): domain=195ba459b status=allocated mode=enforcing pid=300 uid=0 exe="/root/sandboxer" comm="sandboxer"
> >   type=SYSCALL msg=audit(1732186800.349:44): arch=c000003e syscall=101 success=no [...] pid=300 auid=0
> > 
> > Audit event sample for a following denial:
> > 
> >   type=LANDLOCK_ACCESS msg=audit(1732186800.372:45): domain=195ba459b blockers=ptrace opid=1 ocomm="systemd"
> >   type=SYSCALL msg=audit(1732186800.372:45): arch=c000003e syscall=101 success=no [...] pid=300 auid=0
> > 
> > Log domain deletion with the "deallocated" state when a domain was
> > previously logged.  This makes it possible for log parsers to free
> > potential resources when a domain ID will never show again.
> > 
> > The number of denied access requests is useful to easily check how many
> > access requests a domain blocked and potentially if some of them are
> > missing in logs because of audit rate limiting or audit rules.  Rate
> > limiting could also drop this record though.
> > 
> > Audit event sample for a deletion of a domain that denied something:
> > 
> >   type=LANDLOCK_DOMAIN msg=audit(1732186800.393:46): domain=195ba459b status=deallocated denials=2
> > 
> > Cc: Günther Noack <gnoack@google.com>
> > Cc: Paul Moore <paul@paul-moore.com>
> > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > Link: https://lore.kernel.org/r/20250131163059.1139617-11-mic@digikod.net
> > ---
> > Changes since v4:
> > - Rename AUDIT_LANDLOCK_DOM_{INFO,DROP} to AUDIT_LANDLOCK_DOMAIN and add
> >   a "status" field, as requested by Paul.
> > - Add a harcoded "mode=enforcing" to leave room for a potential future
> >   permissive mode, as suggested by Paul.
> > - Remove the "creation" timestamp, as suggested by Paul.
> > - Move LANDLOCK_PATH_MAX_SIZE to domain.h, check the size of the
> >   greatest landlock_details at build time, and improve comments.
> > - Improve audit check in landlock_log_drop_domain().
> > - Add missing headers.
> > - Fix typo in comment.
> > - Rebase on top of the landlock_log_denial() and subject type changes.
> > 
> > Changes since v3:
> > - Log number of denied access requests with AUDIT_LANDLOCK_DOM_DROP
> >   records, suggested by Tyler.
> > - Do not store a struct path pointer but the resolved string instead.
> >   This enables us to not block unmount of the initially restricted task
> >   executable's mount point.  See the new get_current_info() and
> >   get_current_exe().  A following patch add tests for this case.
> > - Create and allocate a new struct landlock_details for initially
> >   restricted task's information.
> > - Remove audit_get_ctime() call, as requested by Paul.  We now always
> >   have a standalone timestamp per Landlock domain creations.
> > - Fix docstring.
> > 
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
> >  include/uapi/linux/audit.h  |   1 +
> >  security/landlock/audit.c   |  90 ++++++++++++++++++++++++++++++--
> >  security/landlock/audit.h   |   7 +++
> >  security/landlock/domain.c  | 101 ++++++++++++++++++++++++++++++++++++
> >  security/landlock/domain.h  |  68 ++++++++++++++++++++++++
> >  security/landlock/ruleset.c |   6 +++
> >  6 files changed, 270 insertions(+), 3 deletions(-)
> 
> Some minor questions below, but from an audit perspective this is okay.
> 
> Acked-by: Paul Moore <paul@paul-moore.com> (Audit)
> 
> > diff --git a/security/landlock/audit.c b/security/landlock/audit.c
> > index b0dde6bcfb76..a5b055306757 100644
> > --- a/security/landlock/audit.c
> > +++ b/security/landlock/audit.c
> > @@ -8,6 +8,8 @@
> >  #include <kunit/test.h>
> >  #include <linux/audit.h>
> >  #include <linux/lsm_audit.h>
> > +#include <linux/pid.h>
> > +#include <linux/uidgid.h>
> >  
> >  #include "audit.h"
> >  #include "cred.h"
> > @@ -31,6 +33,40 @@ static void log_blockers(struct audit_buffer *const ab,
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
> > +			     AUDIT_LANDLOCK_DOMAIN);
> 
> You use __GFP_NOWARN in the other calls to audit_log_start(), did you
> mean to use it here as well?

Good catch, this is at least inconsistent.

My initial though was that we should use __GFP_NOWARN for access
requests that can occure frequently, and common_lsm_audit() already uses
this flag, and the fact that audit events might not be logged at all for
other reasons (e.g. burst of entries).  But __GFP_NOWARN is not use for
all audit_log_start() calls.

For domain allocations and deallocations, this should rarely happen
during the life of a process, and it looked reasonable to warn about an
issue at this point.

Are there guidance about __GFP_NOWARN for audit or other subsystems?

> 
> > +	if (!ab)
> > +		return;
> > +
> > +	WARN_ON_ONCE(node->id == 0);
> > +	audit_log_format(
> > +		ab,
> > +		"domain=%llx status=allocated mode=enforcing pid=%d uid=%u exe=",
> > +		node->id, pid_nr(node->details->pid),
> > +		from_kuid(&init_user_ns, node->details->cred->uid));
> > +	audit_log_untrustedstring(ab, node->details->exe_path);
> > +	audit_log_format(ab, " comm=");
> > +	audit_log_untrustedstring(ab, node->details->comm);
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

> > @@ -106,16 +142,24 @@ void landlock_log_denial(const struct landlock_cred_security *const subject,
> >  	if (!is_valid_request(request))
> >  		return;
> >  
> > -	if (!unlikely(audit_context() && audit_enabled))
> > -		return;
> > -
> >  	youngest_layer = request->layer_plus_one - 1;
> >  	youngest_denied = get_hierarchy(subject->domain, youngest_layer);
> >  
> > +	/*
> > +	 * Consistently keeps track of the number of denied access requests
> > +	 * even if audit is currently disabled, if audit rules currently
> > +	 * exclude this record type, or if landlock_restrict_self(2)'s flags
> > +	 * quiet logs.
> > +	 */
> > +	atomic64_inc(&youngest_denied->num_denials);
> > +
> >  	/* Ignores denials after an execution. */
> >  	if (!(subject->domain_exec & (1 << youngest_layer)))
> >  		return;
> >  
> > +	if (!unlikely(audit_context() && audit_enabled))
> > +		return;
> > +
> 
> Not a big deal either way, but it seems like the check above should
> probably be in patch 09/24.

It is in 09/24 but it's moved in this patch because we need to count
denials consistently, see a few lines above.

> 
> >  	ab = audit_log_start(audit_context(), GFP_ATOMIC | __GFP_NOWARN,
> >  			     AUDIT_LANDLOCK_ACCESS);
> >  	if (!ab)
> > @@ -125,6 +169,46 @@ void landlock_log_denial(const struct landlock_cred_security *const subject,
> >  	log_blockers(ab, request->type);
> >  	audit_log_lsm_data(ab, &request->audit);
> >  	audit_log_end(ab);
> > +
> > +	/* Logs this domain if it is the first time. */
> > +	log_node(youngest_denied);
> > +}
> > +
> > +/**
> > + * landlock_log_drop_domain - Create an audit record when a domain is deleted
> > + *
> > + * @domain: The domain being deleted.
> > + *
> > + * Only domains which previously appeared in the audit logs are logged again.
> > + * This is useful to know when a domain will never show again in the audit log.
> > + *
> > + * This record is not directly tied to a syscall entry.
> > + *
> > + * Called by the cred_free() hook, in an uninterruptible context.
> > + */
> > +void landlock_log_drop_domain(const struct landlock_ruleset *const domain)
> > +{
> > +	struct audit_buffer *ab;
> > +
> > +	if (WARN_ON_ONCE(!domain->hierarchy))
> > +		return;
> > +
> > +	if (!unlikely(audit_enabled))
> > +		return;
> 
> I'm guessing you probably also want to check the audit context given
> that you are doing it elsewhere?

The context is NULL when this function is called, I guess because it is
not directly triggered by a syscall but deferred to the domain
deallocation.

> 
> > +	/* Ignores domains that were not logged.  */
> > +	if (READ_ONCE(domain->hierarchy->log_status) != LANDLOCK_LOG_RECORDED)
> > +		return;
> > +
> > +	ab = audit_log_start(audit_context(), GFP_ATOMIC,
> > +			     AUDIT_LANDLOCK_DOMAIN);
> > +	if (!ab)
> > +		return;
> > +
> > +	audit_log_format(ab, "domain=%llx status=deallocated denials=%llu",
> > +			 domain->hierarchy->id,
> > +			 atomic64_read(&domain->hierarchy->num_denials));
> > +	audit_log_end(ab);
> >  }
> >  
> >  #ifdef CONFIG_SECURITY_LANDLOCK_KUNIT_TEST
> 
> --
> paul-moore.com
> 
