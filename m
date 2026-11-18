Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=83.166.143.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795021234;
	b=U0J3qF6BpDhxQMzxyJnrSFVmNVhrVw7t+grK/6QigbwHld+Hzfx1luXojnB+y7Q4CfQm
	 bIC4Sj38jBHgzEgiWTSatVbnga6ZaMN0ZAA7a9Hr1wFjC/eFkO7DnI8vnCZfOLq47fVdt
	 i/B9UqUodwqpsHyZ++yuZWdYSFNNxYXL2ooUUMYURO7jbhlyiJWzflnlcD9/wPCJ6/M5R
	 BhUgWqKfpqW1URJvcDwNSEkiVrXpwlB3OgBtnm72qqH3C5rBUvyUI8bIw15XzB7uUahxG
	 5BpGuWouPL3yDAV4wg9iVtI1UUnEJOJL8eDFCoP/JeQqEjoS5M0aLfiYKgCEm+8IO4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795021234;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 X-Infomaniak-Routing;
	bh=o3t6ocqFvEquDP51sptBzlVVhSR5uyDVH+RFqB7EJg4=;
	b=BAroJtn8369fNhDoueOOOhPVDTScg89j2od947NaLuVc2S0QsXurbEtPZ5/e0wEJzR2s
	 Klpm0eFCdrZZdqtq+z381k38RnzqRvnLOY/XlLzR4enYDrUFIojS5VDPyYMCva0Yjfy8Z
	 qCG22NC+/kI4DSCMmbYdrEZc7rHrC3dfrxAHVNMujwug9qxFIaJd037X3+XXf3nIUmtCg
	 R7IHUaJnRbfFnomaeRB2kiKReCsvJAgSQN/16qnZhqtCzZ/9jrcIt55O3ZdLQj1jB/pNO
	 oSIs5peBLUV9lDvxPuv+1oHyCnlCex7oKJoLHPumNWcbld1wGcO2Xc9uiT0MlCZY5bQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=digikod.net;
	spf=pass smtp.mailfrom=digikod.net;
	dkim=pass header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b="J1bjyA/p";
	arc=none smtp.remote-ip=83.166.143.175
Received: from smtp-8faf.mail.infomaniak.ch (smtp-8faf.mail.infomaniak.ch [83.166.143.175])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8D5606A320
	for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2026 17:00:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B8D5606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=J1bjyA/p
Received: from smtp-4-0001 (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jV7C25sVKzffQ;
	Wed, 18 Nov 2026 18:00:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1795021230;
	bh=o3t6ocqFvEquDP51sptBzlVVhSR5uyDVH+RFqB7EJg4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J1bjyA/pfmdrIMPC7ebXqWQpCSqcWMiNCnIK1xMdnh9v8CJ7p7Q7TgMaJg/KHjOkE
	 qNwXrbntQy4+n9w8rXg6t52IHEw+lgig5uQTwFp4ZokIGTlNVYb9c/yYXkNdDnUvAd
	 xwpt7WFQ++ZN63uhF9VRJ3AlI4DbNtjKxIKl8Dzc=
Received: from unknown by smtp-4-0001 (Postfix) with ESMTPA id 4jV7Bz45JJz4RG;
	Wed, 18 Nov 2026 18:00:27 +0100 (CET)
Date: Wed, 18 Nov 2026 18:00:27 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: Ada Smith <adasmithgt@gmail.com>, Hungyu Lin <dennylin0707@gmail.com>, 
	James Morris <jmorris@namei.org>, Josef Bacik <josef@toxicpanda.com>, 
	Paul Moore <paul@paul-moore.com>, Serge Hallyn <serge@hallyn.com>, 
	Serge Hallyn <sergeh@kernel.org>, kernel-team@cloudflare.com, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 2/6] landlock: Mediate CAP_SYS_RAWIO for mappings
 below mmap_min_addr
Message-ID: <20261118.Phu0OoSh4ahY@digikod.net>
References: <20261117101157.2520463-1-mic@digikod.net>
 <20261117101157.2520463-3-mic@digikod.net>
 <avxjfHybQBcATFKV@google.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <avxjfHybQBcATFKV@google.com>
X-Infomaniak-Routing: alpha

On Tue, Nov 17, 2026 at 03:23:56PM +0100, Günther Noack wrote:
> On Tue, Nov 17, 2026 at 11:11:52AM +0100, Mickaël Salaün wrote:
> > Until now, a process in a domain that denies CAP_SYS_RAWIO could still
> > map memory below the vm.mmap_min_addr limit if it held this capability.
> > cap_mmap_addr() is commoncap's mmap_addr hook, and it checks
> > CAP_SYS_RAWIO with cap_capable(), not security_capable(), so the check
> > never reaches hook_capable().  Mapping the lowest pages is what this
> > limit protects against, because it helps to exploit kernel NULL pointer
> > dereferences.
> > 
> > Add a Landlock mmap_addr hook that checks CAP_SYS_RAWIO against the
> > domain under the same condition as cap_mmap_addr().  With the same
> > vm.mmap_min_addr value, the hook only denies mappings for which
> > commoncap required the capability.  security_mmap_addr() stops at
> > commoncap's error, so processes without the capability get the same
> > result as before.  This also covers the x86 vm86(2) and vm86old(2)
> > system calls, which use the same check for address 0.
> > 
> > Making cap_mmap_addr() call capable() would also fix this, but it would
> > send every low mapping through the capable hook of all LSMs (SELinux,
> > AppArmor, SafeSetID, BPF LSM programs), adding capability checks that
> > their policies never had to handle.  For instance, SELinux checks
> > mmap_zero in its own mmap_addr hook and keeps it separate from the
> > capability on purpose.  LSMs with their own policy for low mappings
> > implement it in this hook, so Landlock does the same.
> > 
> > Cc: Günther Noack <gnoack@google.com>
> > Cc: Paul Moore <paul@paul-moore.com>
> > Cc: Serge Hallyn <serge@hallyn.com>
> > Acked-by: Serge Hallyn (AMD) <sergeh@kernel.org>
> > Fixes: 97c8386f1d74 ("landlock: Enforce capability restrictions")
> > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > ---
> > 
> > Changes since v1:
> > https://patch.msgid.link/20261110202436.2408244-3-mic@digikod.net
> > - Add Serge Hallyn's Acked-by.
> > ---
> >  security/landlock/cap.c | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> > 
> > diff --git a/security/landlock/cap.c b/security/landlock/cap.c
> > index fa59118e3486..10e1ca772b9c 100644
> > --- a/security/landlock/cap.c
> > +++ b/security/landlock/cap.c
> > @@ -9,6 +9,7 @@
> >  #include <linux/cred.h>
> >  #include <linux/lsm_audit.h>
> >  #include <linux/lsm_hooks.h>
> > +#include <linux/security.h>
> >  #include <uapi/linux/landlock.h>
> >  
> >  #include "cap.h"
> > @@ -90,8 +91,29 @@ static int hook_capable(const struct cred *cred, struct user_namespace *ns,
> >  	return check_cap(cred, cap, opts);
> >  }
> >  
> > +/**
> > + * hook_mmap_addr - Restrict mappings below dac_mmap_min_addr
> > + *
> > + * @addr: Address of the new mapping.
> > + *
> > + * cap_mmap_addr() requires CAP_SYS_RAWIO to map below dac_mmap_min_addr, but
> > + * calls cap_capable() directly, which skips hook_capable().  Check the same
> > + * condition against the domain.  commoncap runs first, so this only sees
> > + * mappings that commoncap allowed.
> > + *
> > + * Return: 0 if allowed, -EPERM if CAP_SYS_RAWIO use is denied.
> > + */
> > +static int hook_mmap_addr(unsigned long addr)
> > +{
> > +	if (addr >= dac_mmap_min_addr)
> > +		return 0;
> > +
> > +	return check_cap(current_cred(), CAP_SYS_RAWIO, CAP_OPT_NONE);
> > +}
> > +
> >  static struct security_hook_list landlock_hooks[] __ro_after_init = {
> >  	LSM_HOOK_INIT(capable, hook_capable),
> > +	LSM_HOOK_INIT(mmap_addr, hook_mmap_addr),
> >  };
> >  
> >  __init void landlock_add_cap_hooks(void)
> > -- 
> > 2.56.0
> > 
> 
> Reviewed-by: Günther Noack <gnoack@google.com>
> 
> Looks good; I compared this against the commoncap implementation of
> the same hook, and the logic checks out.
> 
> 
> Minor nit, in case you end up sending a V3; I found the commit message
> a bit wordy.

Indeed, I'll send a v3 with your feedback.

> 
> It makes intuitively sense that the commoncap LSM does not want to
> invoke functions which themselves call into LSM hooks, even if it's
> just a safeguard to prevent accidental recursion or deep call stacks.
> 
> So for the few cases where commoncap checks capabilities directly, we
> need to do the equivalent checks in the same LSM hooks in Landlock.
> That means, we replicate the logic from the commoncap hook if
> necessary and treat it like a capability use that came in through the
> normal hook.  This is similar to what SELinux already does as well.
> 
> What I would have found useful to discuss in this commit message would
> have been the story of PF_SUPERPRIV:
> 
> commoncap sets PF_SUPERPRIV when granting the capability use, and
> Landlock does not undo that when it rejects the capability use.  In my
> understanding this is OK because the flag only gets used in "legacy
> accounting" use cases and the consequences are benign.  The
> interaction with SELinux is already the same as well - it does not
> unset that flag.

Good catch!  I think it should not be addressed by this series but I
just sent a fix for that:
https://lore.kernel.org/r/20261118165603.2573289-1-mic@digikod.net

> 
> —Günther
> 
