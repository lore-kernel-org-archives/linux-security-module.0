Received: from smtp-190d.mail.infomaniak.ch (smtp-190d.mail.infomaniak.ch [185.125.25.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CAC1F872D
	for <linux-security-module@vger.kernel.org>; Thu, 17 Jul 2025 17:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752773999; cv=none; b=dkl1iMZh+Cc/39J6v5Z9i7vY4yJEuMVs2d6LZkKGRrMeAS/nSssHumDD1Fp0aPbUpdn6abvYKyOUc9MrSsX1+drMOcMEMn6kgi4bgW4XoTOTqcB/g7YRGZrDNDcxUXkQQuU9c7WFQJiM1WFJiMvnl0s8RH5qOGRMvh/oq8rnVTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752773999; c=relaxed/simple;
	bh=kHaL02DxlO/amJ1+zcxcVlYqQFj3gNvSuHST674g1bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bPHNUQlzDq6sbjhzf7WrfpLAolOL47FUGoWeMoaF4+SLE3PD0Vy5jI6paqyVIBX/0UMy3wgzou34Kf2XtBeDXHHgr8JVNTYVSeaxfsOqrfP5ZNx6/FDgaGo9hGtqY3CwWlJuRD5BiiDZww4TxEpbP+aPty4eJmynlsjDfg+/mlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=JGPomn6k; arc=none smtp.client-ip=185.125.25.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="JGPomn6k"
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6c])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4bjg3y4pLszxMF;
	Thu, 17 Jul 2025 19:32:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1752773566;
	bh=FhUZljpV3e7kXgQWDft7JJeqq7WQKJ1k9+cgRe3Jnto=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JGPomn6khu/S+EtuC5HlQ43KacCkMVJV4ES8is4YXgIOR9My9wLU8Cx3CEkr1k8HF
	 HZnIGq5s/vmaCHc07QfC23oSBkMvJyTIAgQm4pIHQ8qGWAUPDAdmSihNxZwBy1Pb8F
	 5kg8fEI+Ux7MtVUvBd4xQAj+mstoB8p0YLb/TyF4=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4bjg3x5rsfz97W;
	Thu, 17 Jul 2025 19:32:45 +0200 (CEST)
Date: Thu, 17 Jul 2025 19:32:45 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tingmao Wang <m@maowtm.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Ben Scarlato <akhna@google.com>, 
	Christian Brauner <brauner@kernel.org>, Daniel Burgener <dburgener@linux.microsoft.com>, 
	Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, NeilBrown <neil@brown.name>, 
	Paul Moore <paul@paul-moore.com>, Song Liu <song@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 1/3] landlock: Fix handling of disconnected directories
Message-ID: <20250717.aeCheichee0i@digikod.net>
References: <20250711191938.2007175-1-mic@digikod.net>
 <20250711191938.2007175-2-mic@digikod.net>
 <4d23784f-03de-4053-a326-96a0fa833456@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4d23784f-03de-4053-a326-96a0fa833456@maowtm.org>
X-Infomaniak-Routing: alpha

On Mon, Jul 14, 2025 at 01:39:12PM +0100, Tingmao Wang wrote:
> On 7/11/25 20:19, Mickaël Salaün wrote:
> > [...]
> > @@ -800,6 +802,8 @@ static bool is_access_to_paths_allowed(
> >  		access_masked_parent1 = access_masked_parent2 =
> >  			landlock_union_access_masks(domain).fs;
> >  		is_dom_check = true;
> > +		memcpy(&_layer_masks_parent2_bkp, layer_masks_parent2,
> > +		       sizeof(_layer_masks_parent2_bkp));
> >  	} else {
> >  		if (WARN_ON_ONCE(dentry_child1 || dentry_child2))
> >  			return false;
> > @@ -807,6 +811,8 @@ static bool is_access_to_paths_allowed(
> >  		access_masked_parent1 = access_request_parent1;
> >  		access_masked_parent2 = access_request_parent2;
> >  		is_dom_check = false;
> > +		memcpy(&_layer_masks_parent1_bkp, layer_masks_parent1,
> > +		       sizeof(_layer_masks_parent1_bkp));
> 
> Is this memcpy meant to be in this else branch?  If parent2 is set, we
> will leave _layer_masks_parent1_bkp uninitialized right?

Good catch!  We should always initialize _layer_masks_parent1_bkp.
I'll move both _layer_masks_parent*_bkp initializations just before the
related allowed_parent* initialization.

> 
> >  	}
> >  
> >  	if (unlikely(dentry_child1)) {
