Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch [45.157.188.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAC72741CD
	for <linux-security-module@vger.kernel.org>; Tue, 27 May 2025 14:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748357637; cv=none; b=jhEeUoh+xgkxkq57Y5g9seDmBW6g9yZtaCn1VJnhf6j7imr09TJ9MwOv06SQCYvlEcG+xGAVJdVfoEobfi73JIMdkDpMcLWmMlT/zvaknD1kTWXKc4EAyl7JZ23ZjXIwXTig38e3iVQEXwauWID+KX5QQpPLxh9HVK57eA9tDc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748357637; c=relaxed/simple;
	bh=y+kf6FZ78SNpdS0lJD/HvXjiqbntxH0UnTlA/8xV3E0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=luLesisb9j25kPWibkxuu+uWlcBuE2DrVS7hQ9krdoOfYG4WZ8WgkikL3mwXX3AuI67T+RVAPfRCrNRcQ+cUdo5KAAZjLf7Nbju9tD5alj90P/9AN256E4jDl4cwQNLWavz/160yTl+oC9x/AiY1TgOp1JCRSSAYcJxGSfJIefg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=X25roJ7i; arc=none smtp.client-ip=45.157.188.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="X25roJ7i"
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6b])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4b6Fy756mGz6DY;
	Tue, 27 May 2025 16:53:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1748357631;
	bh=YQsWDTbk+8nCd4vOhNhHJZ7oUq8L9poJ2eC7UYVAl80=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X25roJ7i6WqfD5Z416w6vhXYapd2CWr2+5kYIY99EUrBGo370bwgCvoAmPE/4iD6k
	 noOODrwW38WLfKENGUNSlz0nEd+NTahTEVBcAOohWOUrxKZ4DL3cRfnA7y23Y5NNJo
	 hNKGXhCvKrEnOsCsPtc7v0xD962SVnD5z6HmVyg0=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4b6Fy66Q2kz5qS;
	Tue, 27 May 2025 16:53:50 +0200 (CEST)
Date: Tue, 27 May 2025 16:53:50 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tingmao Wang <m@maowtm.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Daniel Burgener <dburgener@linux.microsoft.com>, Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, 
	Kees Cook <kees@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Matthieu Buffet <matthieu@buffet.re>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Ryan Sullivan <rysulliv@redhat.com>, 
	Shervin Oloumi <enlightened@google.com>, linux-security-module@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 4/5] landlock: Add landlock_add_rule_fs tracepoint
Message-ID: <20250527.tei5tuRohg6r@digikod.net>
References: <20250523165741.693976-1-mic@digikod.net>
 <20250523165741.693976-5-mic@digikod.net>
 <d61717c2-df30-4cd2-a14e-e05ca9f69892@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d61717c2-df30-4cd2-a14e-e05ca9f69892@maowtm.org>
X-Infomaniak-Routing: alpha

On Mon, May 26, 2025 at 07:37:52PM +0100, Tingmao Wang wrote:
> On 5/23/25 17:57, Mickaël Salaün wrote:
> > Add a tracepoint for Landlock path_beneath rule addition.  This is
> > useful to tie a Landlock object with a file for debug purpose.
> > 
> > Allocate the absolute path names when adding new rules.  This is OK
> > because landlock_add_rule(2) is not a performance critical code.
> > 
> > Here is an example of landlock_add_rule_fs traces:
> >    ruleset=0x000000007e3b1c4a key=inode:0xffff888004f59260 allowed=0xd dev=0:16 ino=306 path=/usr
> >    ruleset=0x000000007e3b1c4a key=inode:0xffff888004f59240 allowed=0xffff dev=0:16 ino=346 path=/root
> > 
> > TODO: Use Landlock IDs instead of kernel addresses to identify Landlock
> > objects (e.g. inode).
> 
> Do you mean like the u64 domain ID for audit, but for objects?  Since there
> currently isn't a u64, non-pointer ID, I guess we would have to create one
> for the object just for tracing?

Yes, this is the idea.  Landlock objects are scarce so it should not
change much.  Another advantage of using a Landlock ID is that there is
no risk for confusion (i.e. they are not recycled).  I'm not sure if
it's worth it though.

> 
> My understanding is that kernel pointers are not hidden from the root user /
> someone who can read traces, so maybe just printing the pointer is good
> enough?

In theory printed kernel pointers should be hashed, but I guess in
practice and especially with eBPF, kernel addresses may not be really
hidden.

On the other hand, providing a pointer to an eBPF program enables us to
inspect the related data structure.  However, such pointer cannot be
dereferenced in TP_printk() because it is called after the tracepoint.

In fact, I guess we should probably provide kernel addresses (to the
trace context), but I'm not sure if we should print IDs or just kernel
addresses.  It might be handy to easily map a Landlock domain pointer to
its ID in the audit log, but that would require to also copy IDs in the
trace context...  It looks like this is how works sock tracepoints (e.g.
skaddr, but I'm not sure if void * is only there to avoid dereferencing
this pointer in TP_printk).

My understanding is that with eBPF we can read a kernel address from the
trace context without race condition wrt TP_print() which may be called
when the address was already recycled (which could lead to misleading
concurrent traces).

Steven, is it correct? Any advice?

> 
> > 
> > Cc: Günther Noack <gnoack@google.com>
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Tingmao Wang <m@maowtm.org>
> > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > ---
> >   MAINTAINERS                     |  1 +
> >   include/trace/events/landlock.h | 68 +++++++++++++++++++++++++++++++++
> >   security/landlock/Makefile      | 11 +++++-
> >   security/landlock/fs.c          | 22 +++++++++++
> >   security/landlock/fs.h          |  3 ++
> >   security/landlock/trace.c       | 14 +++++++
> >   6 files changed, 117 insertions(+), 2 deletions(-)
> >   create mode 100644 include/trace/events/landlock.h
> >   create mode 100644 security/landlock/trace.c
> > 
> > > [...]
> > > diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> > index 73a20a501c3c..e5d673240882 100644
> > --- a/security/landlock/fs.c
> > +++ b/security/landlock/fs.c
> > @@ -36,6 +36,7 @@
> >   #include <linux/types.h>
> >   #include <linux/wait_bit.h>
> >   #include <linux/workqueue.h>
> > +#include <trace/events/landlock.h>
> >   #include <uapi/linux/fiemap.h>
> >   #include <uapi/linux/landlock.h>
> > @@ -345,6 +346,27 @@ int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
> >   	mutex_lock(&ruleset->lock);
> >   	err = landlock_insert_rule(ruleset, ref, access_rights);
> >   	mutex_unlock(&ruleset->lock);
> > +
> > +	if (!err && trace_landlock_add_rule_fs_enabled()) {
> > +		const char *pathname;
> > +		/* Does not handle deleted files. */
> > +		char *buffer __free(__putname) = __getname();
> > +
> > +		if (buffer) {
> > +			const char *absolute_path =
> > +				d_absolute_path(path, buffer, PATH_MAX);
> > +			if (!IS_ERR_OR_NULL(absolute_path))
> > +				pathname = absolute_path;
> > +			else
> > +				pathname = "<too_long>";
> 
> Not sure if it's necessary to go that far, but I think d_absolute_path
> returns -ENAMETOOLONG in the too long case, and -EINVAL in the "not possible
> to construct a path" case (I guess e.g. if it's an anonymous file or
> detached mount).  We could add an else if branch to check which case it is
> and use different strings.

I mimicked the audit behavior but we can indeed add another case.

> 
> > +		} else {
> > +			/* Same format as audit_log_d_path(). */
> > +			pathname = "<no_memory>";
> > +		}
> > +		trace_landlock_add_rule_fs(ruleset, &ref, access_rights, path,
> > +					   pathname);
> > +	}
> > +
> >   	/*
> >   	 * No need to check for an error because landlock_insert_rule()
> >   	 * increments the refcount for the new object if needed.
> > diff --git a/security/landlock/fs.h b/security/landlock/fs.h
> > index bf9948941f2f..60be95ebfb0b 100644
> > --- a/security/landlock/fs.h
> > +++ b/security/landlock/fs.h
> > @@ -11,6 +11,7 @@
> >   #define _SECURITY_LANDLOCK_FS_H
> >   #include <linux/build_bug.h>
> > +#include <linux/cleanup.h>
> >   #include <linux/fs.h>
> >   #include <linux/init.h>
> >   #include <linux/rcupdate.h>
> > @@ -128,4 +129,6 @@ int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
> >   			    const struct path *const path,
> >   			    access_mask_t access_hierarchy);
> > +DEFINE_FREE(__putname, char *, if (_T) __putname(_T))
> 
> Out of curiosity why not put this in include/linux/fs.h (seems to compile
> for me when added there)?

I moved it here for this RFC but the next patch series will put it in
linux/fs.h

> 
> > +
> >   #endif /* _SECURITY_LANDLOCK_FS_H */
> > diff --git a/security/landlock/trace.c b/security/landlock/trace.c
> > new file mode 100644
> > index 000000000000..98874cda473b
> > --- /dev/null
> > +++ b/security/landlock/trace.c
> > @@ -0,0 +1,14 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Landlock - Tracepoints
> > + *
> > + * Copyright © 2025 Microsoft Corporation
> > + */
> > +
> > +#include <linux/path.h>
> > +
> > +#include "access.h"
> > +#include "ruleset.h"
> > +
> > +#define CREATE_TRACE_POINTS
> > +#include <trace/events/landlock.h>
> 
> 
