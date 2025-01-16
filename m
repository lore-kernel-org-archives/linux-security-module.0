Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch [185.125.25.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAD41DE3C5
	for <linux-security-module@vger.kernel.org>; Thu, 16 Jan 2025 10:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737024692; cv=none; b=X9iPpJdH+fWikqCdkN1yvG9wqzhue7g6LBDL6wDUwtccscjXbMrE4ckVy+XCqSgzlW2R7c1AEXnQ4Z/4weLzD6rPihs5eZN9FsSrOrrfAuwOaam/vf+SobOIakYL5DoJe6emG0Wl7yAR8vQlcrxczDp//bmyEkeZRAQBRtQ+ojA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737024692; c=relaxed/simple;
	bh=YAy33FGSFekk5hzd+OL7VZLpj/sGMDsllaxu9voHzEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TaJ4jLFMrxzNsIonAn6SDu0rywtgl3D9+ApxDeeuJBpsh4hfSsikiyQ0+IP1KcCN1vPmH9l3TLrWVX6cwfu5x2mEpKVCkJa3sK4PSSDtAi/Y5HvhNHs+bkTR185otBhH00cjn6DVZlsdV/ey7wolf15/Cv7wxe2Di7WyT4u3ICY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=j2dtBPk6; arc=none smtp.client-ip=185.125.25.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="j2dtBPk6"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YYfml1H0YzQ4n;
	Thu, 16 Jan 2025 11:51:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1737024679;
	bh=+ydta1TiSkTXYD1bcuV/JBI+gFeU/VGVRK4/KKLgKbI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j2dtBPk6TMusvjqEBbF+uw2MWiCRozTs4wVEde/HG/MulPYZjTRwZGDVHth0zbPeK
	 EnteKi1SO5l793tyAhsP101i8w5aAvae1TG4AJ/do2++exqJDASU4X+TNd9Nzl3LmL
	 ByPs2YcbH0+fvY/glw2a7Jhw2R5D7EPtDT/LcVRI=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4YYfmk2FllzDKV;
	Thu, 16 Jan 2025 11:51:18 +0100 (CET)
Date: Thu, 16 Jan 2025 11:51:17 +0100
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
Subject: Re: [PATCH v4 9/30] landlock: Add AUDIT_LANDLOCK_DOM_{INFO,DROP} and
 log domain properties
Message-ID: <20250116.eeThieR7aiph@digikod.net>
References: <20250108154338.1129069-10-mic@digikod.net>
 <1a169f22750aec9db4d7a377a4f99733@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1a169f22750aec9db4d7a377a4f99733@paul-moore.com>
X-Infomaniak-Routing: alpha

On Wed, Jan 15, 2025 at 06:53:07PM -0500, Paul Moore wrote:
> On Jan  8, 2025 =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net> wrote:
> > 
> > Asynchronously log domain information when it first denies an access.
> > This minimize the amount of generated logs, which makes it possible to
> > always log denials since they should not happen (except with the new
> > LANDLOCK_RESTRICT_SELF_QUIET flag).  These records are identified with
> > the new AUDIT_LANDLOCK_DOM_INFO type.
> > 
> > The AUDIT_LANDLOCK_DOM_INFO message contains:
> > - the "domain" ID which is described,
> > - the "creation" time of this domain,
> > - a minimal set of properties to easily identify the task that loaded
> >   the domain's policy with landlock_restrict_self(2): "pid", "uid",
> >   executable path ("exe"), and command line ("comm").
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
> > The AUDIT_LANDLOCK_DOM_INFO record follows the first AUDIT_LANDLOCK_DENY
> > record for the same domain, which is always followed by AUDIT_SYSCALL
> > and AUDIT_PROCTITLE.  This is in line with the audit logic to first
> > record the cause of an event, and then add context with other types of
> > record.
> > 
> > Audit event sample for a first denial:
> > 
> >   type=LANDLOCK_DENY msg=audit(1732186800.349:44): domain=195ba459b blockers=ptrace opid=1 ocomm="systemd"
> >   type=LANDLOCK_DOM_INFO msg=audit(1732186800.349:44): domain=195ba459b creation=1732186800.345 pid=300 uid=0 exe="/root/sandboxer" comm="sandboxer"
> >   type=SYSCALL msg=audit(1732186800.349:44): arch=c000003e syscall=101 success=no [...] pid=300 auid=0
> > 
> > Audit event sample for a following denial:
> > 
> >   type=LANDLOCK_DENY msg=audit(1732186800.372:45): domain=195ba459b blockers=ptrace opid=1 ocomm="systemd"
> >   type=SYSCALL msg=audit(1732186800.372:45): arch=c000003e syscall=101 success=no [...] pid=300 auid=0
> >
> > Log domain deletion with the new AUDIT_LANDLOCK_DOM_DROP record type
> > when a domain was previously logged.  This makes it possible for log
> > parsers to free potential resources when a domain ID will never show
> > again.
> > 
> > The AUDIT_LANDLOCK_DOM_DROP message contains:
> > - the "domain" ID which is being freed,
> > - the number of "denials" accounted to this domain, which is at least 1.
> > 
> > The number of denied access requests is useful to easily check how many
> > access requests a domain blocked and potentially if some of them are
> > missing in logs because of audit rate limiting or audit rules.  Rate
> > limiting could also drop this record though.
> 
> Wait, what rate limiting?  Landlock shouldn't be adding any audit event
> rate limiting beyond the queue management knobs built into the audit
> subsystem.  If you are comfortable rate limiting the logging of an event
> it is a good sign that it probably shouldn't be an audit event.

I was talking about current audit's rate limiting.

> 
> The audit subsystem is for security releveant events, not diagnostic,
> debugging, or other "nice to know" messages.

I agree, my goal was to only log denials with the minimal required
information to make sense of it.  "minimal" may be subjective though :)

> 
> > Audit event sample for a deletion of a domain that denied something:
> > 
> >   type=LANDLOCK_DOM_DROP msg=audit(1732186800.393:46): domain=195ba459b denials=2
> 
> As mentioned earlier, I don't like the number of different Landlock
> specific audit record types that are being created.  I'm going to
> suggest combining the LANDLOCK_DOM_INFO and LANDLOCK_DOM_DROP
> records into one (LANDLOCK_DOM?) and using an "op=" field to indicate
> creation/registration or destruction/unregistration of the domain ID.

I can squash them but they're just not about the same semantic at all.
One is an asynchronous event that describe a domain, and the other is a
synchronous event that informs about the end of a domain.  I think it
would be a missed opportunity to have cleaner messages and to simplify
log parsers.  Out of curiosity, are there existing audit record types
that mix semantic like this?

I wanted to give users the ability to filter each kind of record.  We'll
not be able to differentiate each kind of record with audit rules if we
use the same record type.  I don't understand why adding more audit
record types is an issue.

If we use an "op" field to differentiate these two types of information,
it would probably be "op=information" instead of "op=creation" because
the audit's timestamp will not identify the creation time of this
domain.

> 
> > Cc: Günther Noack <gnoack@google.com>
> > Cc: Paul Moore <paul@paul-moore.com>
> > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > Link: https://lore.kernel.org/r/20250108154338.1129069-10-mic@digikod.net
> > ---
> > Questions about AUDIT_LANDLOCK_DOM_INFO messages (keeping in mind that
> > each logged metadata may need to be stored for the lifetime of each
> > domain):
> > - Should we also log the initially restricted task's loginuid?
> > - Should we also log the initially restricted task's sessionid?
> 
> ...
> 
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
> >  
> >  #define AUDIT_FIRST_KERN_ANOM_MSG   1700
> >  #define AUDIT_LAST_KERN_ANOM_MSG    1799
> > diff --git a/security/landlock/audit.c b/security/landlock/audit.c
> > index d90680a5026a..ccc591146f8a 100644
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
> >  #include "domain.h"
> > @@ -30,6 +32,43 @@ static void log_blockers(struct audit_buffer *const ab,
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
> > +	audit_log_format(
> > +		ab,
> > +		"domain=%llx creation=%llu.%03lu pid=%d uid=%u exe=", node->id,
> > +		/* See audit_log_start() */
> > +		(unsigned long long)node->details->creation.tv_sec,
> > +		node->details->creation.tv_nsec / 1000000,
> > +		pid_nr(node->details->pid),
> > +		from_kuid(&init_user_ns, node->details->cred->uid));
> > +	audit_log_untrustedstring(ab, node->details->exe_path);
> > +	audit_log_format(ab, " comm=");
> > +	audit_log_untrustedstring(ab, node->details->comm);
> > +	audit_log_end(ab);
> 
> I'm still struggling to understand why you need to log the domain's
> creation time if you are connecting various Landlock audit events for a
> single domain by the domain ID.  To be clear, I'm not opposed if you
> want to include it, it just seems like there is a disconnect between
> how audit is typically used and what you are proposing.

For the reasons explained in this commit message, domain's creation cannot
be logged synchronously as other audit events.  However, timestamps are
useful to place them in the logs and order them according to other log
messages (i.e. to enrich log with more metadata).  Without this domain's
creation timestamp, we cannot know when it was created.  This
information is not strictly required but I think it can help get back to
the creation/creator of a domain.  I'll remove it if you think it
doesn't make sense to have such information with audit or if it falls
into the "nice to know" category.

> 
> > +	/*
> > +	 * There may be race condition leading to logging of the same domain
> > +	 * several times but that is OK.
> > +	 */
> > +	WRITE_ONCE(node->log_status, LANDLOCK_LOG_RECORDED);
> > +}
> > +
> 
> --
> paul-moore.com
> 
