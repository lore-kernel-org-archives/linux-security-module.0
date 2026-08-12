Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2EC372B50;
	Wed, 12 Aug 2026 15:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786547117; cv=none; b=d6/VcLj1wjQNXv/2UXJSZJW5Vm+julT3ZriWAEy+j0vLkhHwMeaEZW/9R6NEQM/sXy98EYP86AegKgyvHrNOsd8QcJTU5ox6mXpFzu4/ePBHFlC7JIGu1nAM9w+dHBI0HiP+P1B3pYzfQGMG5yCMOZQcZ4KgLIrkCGAawaZo6t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786547117; c=relaxed/simple;
	bh=NBrKaFEIxE5Z6Dx6ESMvW7CYI2E30pWd0pCH+p0OAr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bv6KKQHX1HVHl7EQY3L8u5siQ4JBF8N8uogi+bE0SpsRUM7aEHcqOebhHDvb4/vuhmpe32KpfmDH7QbR1F1Y2V1RyF33AOLQI9gmXTBhb1yRExXlEcIKyZQstwOiWgbhREqQ63I4zUwjihnbmNNm6/pqpeUBWqHjsEeOR+MG9z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com; spf=unknown smtp.mailfrom=mail.hallyn.com; dkim=pass (2048-bit key) header.d=hallyn.com header.i=@hallyn.com header.b=XvVWRqIc; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=tempfail smtp.mailfrom=mail.hallyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hallyn.com header.i=@hallyn.com header.b="XvVWRqIc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hallyn.com; s=mail;
	t=1786546776; bh=NBrKaFEIxE5Z6Dx6ESMvW7CYI2E30pWd0pCH+p0OAr8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XvVWRqIcVj4l+Hn25LZ7coTRxql9Rtobc3U5wAwcRR1IqqqqArLi0iRsfecPdkaAB
	 d09zSdibBmakYiCqJc8O8smWI9awXM2guC5a5E0QJTJo/Mqes47gXVrBmiV2IbOxxM
	 SD8me3GQTbcaXg+n+WRbA5jgBDNyILelFXbWSNocXzZWsrrINTikHNen+VGH+vZEfN
	 wEH9I65iWPQbLIoTimsK83i7ESW2hsxCVSVKTt8nuw4r5r6z3TG6nG7ItrzdrT3fIR
	 wBaDgK6hKoQe1ft61TBks5xZY5mGnqOXiZO2htAW07BaAS6L+uhouGIDjPgO0lIN+q
	 k+rUNZpSLpYJQ==
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 1B51FCAB; Wed, 12 Aug 2026 09:59:35 -0500 (CDT)
Date: Wed, 12 Aug 2026 09:59:35 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Jann Horn <jannh@google.com>, Serge Hallyn <sergeh@kernel.org>,
	Eric Paris <eparis@redhat.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	audit@vger.kernel.org
Subject: Re: [PATCH] cred: clarify that task_struct::cred is only for the
 current task
Message-ID: <anyKVxRCiWy/g0Cn@mail.hallyn.com>
References: <20260806-cred-nonrcu-annotation-fix-v1-1-5fd149b2ab54@google.com>
 <2bdf79f45c5eb2ea66d59904418081c5@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2bdf79f45c5eb2ea66d59904418081c5@paul-moore.com>

On Mon, Aug 10, 2026 at 03:41:54PM -0400, Paul Moore wrote:
> On Aug  6, 2026 Jann Horn <jannh@google.com> wrote:
> > 
> > The `cred` field in task_struct is currently marked as __rcu, but that's
> > not true: It can point to credentials from access_override_creds(), which
> > do not get freed with RCU delay.
> > 
> > What actually protects task_struct::cred is that accessing it is only
> > permitted for the current task (except for setting up a child during fork()
> > or tearing down a dead process).
> > (There is currently code in Smack that violates this rule, but that's a bug
> > and causes UAF, I have sent a separate fix for that.)
> > 
> > Clarify this, remove the __rcu marker, and remove RCU helpers from all
> > accesses to this field.
> > 
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> > For context:
> > There have been at least two UAFs of struct cred that I'm aware of, both
> > caused by wrong use of task_struct::cred:
> > 
> >  - https://git.kernel.org/linus/a3727a8bac0a9e77c70820655fd8715523ba3db7
> >  - https://lore.kernel.org/all/20260806-smack-uaf-fix-v1-1-26426d389a26@google.com/
> > ---
> >  include/linux/cred.h  | 17 +++++++++++------
> >  include/linux/sched.h |  8 ++++++--
> >  kernel/auditsc.c      |  5 +++--
> >  kernel/cred.c         |  2 +-
> >  security/lsm_init.c   |  2 +-
> >  5 files changed, 22 insertions(+), 12 deletions(-)
> 
> This looks good to me, with one small nit below, but as we are at -rc7
> I think this is best kept until after the upcoming merge window so it
> has more than a few days in linux-next.  I'm going to merge this into
> lsm/dev-staging with the expectation of merging it into lsm/dev after
> the upcoming merge window closes.  If anyone wishes to object to this
> patch or add their own review/ACK/test tag before then, please do.
> 
> Thanks Jann.
> 

Thanks.  FWIW I did also look at this closely.

Reviewed-by: Serge Hallyn <serge@hallyn.com>

> > diff --git a/security/lsm_init.c b/security/lsm_init.c
> > index 7c0fd17f1601..1328a2ceef4b 100644
> > --- a/security/lsm_init.c
> > +++ b/security/lsm_init.c
> > @@ -476,7 +476,7 @@ int __init security_init(void)
> >  						    blob_sizes.lbs_inode, 0,
> >  						    SLAB_PANIC, NULL);
> >  
> > -	if (lsm_cred_alloc((struct cred *)unrcu_pointer(current->cred),
> > +	if (lsm_cred_alloc((struct cred *)current->cred,
> >  			   GFP_KERNEL))
> 
> Just a FYI, but I pulled the GFP_KERNEL up on the line above while
> merging since it now fits.
> 
> --
> paul-moore.com
