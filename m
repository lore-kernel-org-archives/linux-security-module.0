Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36BCEAD5
	for <linux-security-module@vger.kernel.org>; Thu, 26 Sep 2024 13:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727356328; cv=none; b=rjNOr8eW5xPxYpqjAUsxcUiiq05MXSkAKHcygwZ7McBP8YS6zFvxBIl1WZFQ2DiOjrAhCtsbLFLsOzboIgQcbqyY/PcQZsBM9bNqpr360aDfuMMbTe2nA+ZigPKPX78Rc/owbk4YM/l+otKUucYEuFguuqXTkpxBtWSlafNNF/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727356328; c=relaxed/simple;
	bh=BWj99G8m5swZj8ALfS7UT0wTFawz7K0I06+GB61NPS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hsj7jU1RKdH8e6m9/ulzbQVeUvvov/yMJrNryUlP0GXgom2L48cPoe0iVz9rk4vKl1WdpwHULEKGr8iv8NaThTmNU9Mre5zhC5vxFBCIBgfNhj1Y6ZJUCQniYV6aHOdS19cr5qEeXEcUaxka80sq9a5Gn54Gfft3V8asAhszyoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id C50B481E; Thu, 26 Sep 2024 08:11:57 -0500 (CDT)
Date: Thu, 26 Sep 2024 08:11:57 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org,
	serge@hallyn.com
Subject: Re: [RFC PATCH] capabilities: remove cap_mmap_file()
Message-ID: <20240926131157.GA683524@mail.hallyn.com>
References: <20240925192018.15290-2-paul@paul-moore.com>
 <dd386a1f-9245-45ae-b0fe-d07d1dec5100@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd386a1f-9245-45ae-b0fe-d07d1dec5100@schaufler-ca.com>

On Wed, Sep 25, 2024 at 12:45:20PM -0700, Casey Schaufler wrote:
> On 9/25/2024 12:20 PM, Paul Moore wrote:
> > The cap_mmap_file() LSM callback returns the default value for the
> > security_mmap_file() LSM hook and can be safely removed.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> 
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>

Reviewed-by: Serge Hallyn <serge@hallyn.com>

> 
> > ---
> >  security/commoncap.c | 7 -------
> >  1 file changed, 7 deletions(-)
> >
> > diff --git a/security/commoncap.c b/security/commoncap.c
> > index cefad323a0b1..3d103069903b 100644
> > --- a/security/commoncap.c
> > +++ b/security/commoncap.c
> > @@ -1428,12 +1428,6 @@ int cap_mmap_addr(unsigned long addr)
> >  	return ret;
> >  }
> >  
> > -int cap_mmap_file(struct file *file, unsigned long reqprot,
> > -		  unsigned long prot, unsigned long flags)
> > -{
> > -	return 0;
> > -}
> > -
> >  #ifdef CONFIG_SECURITY
> >  
> >  static const struct lsm_id capability_lsmid = {
> > @@ -1453,7 +1447,6 @@ static struct security_hook_list capability_hooks[] __ro_after_init = {
> >  	LSM_HOOK_INIT(inode_killpriv, cap_inode_killpriv),
> >  	LSM_HOOK_INIT(inode_getsecurity, cap_inode_getsecurity),
> >  	LSM_HOOK_INIT(mmap_addr, cap_mmap_addr),
> > -	LSM_HOOK_INIT(mmap_file, cap_mmap_file),
> >  	LSM_HOOK_INIT(task_fix_setuid, cap_task_fix_setuid),
> >  	LSM_HOOK_INIT(task_prctl, cap_task_prctl),
> >  	LSM_HOOK_INIT(task_setscheduler, cap_task_setscheduler),
