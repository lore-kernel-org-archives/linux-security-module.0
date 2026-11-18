Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.125.25.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795021287;
	b=IY8GPh7Nt6qT9Iy+S2tnspq/InNcHJBj/hdgjiRjX26XgGyvN+XAqmy+DNE/dhzVxzGa
	 804faX9cY2NXWLs2K1EiZZsVmPpf1SDwIKZgGVst7zZTQEeNIeUqYs4co2c6lhSkN9RZg
	 OgwAGJALB4BSPl5xSKgquy3OjxuaADWO6C4sMN17ng3VhAuUhB5m4RmFpVI7rdFpq/EZ+
	 XuLjCDB4uNmVD/97Qwq9jBGlfuz/JAvTAuc0UhMUbbZ77cXWW+xJ55oNGflX984wbuNMU
	 OS1UL7o94rcyUWrTNEOAgu9VZH37v4aD6x/mmiabb3uWTlbTFpNA+qFIttobcVIURDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795021287;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 X-Infomaniak-Routing;
	bh=ooxeFkFKsKCR8G8wrgoKSTGcXvfw78FmflozaOOLeH8=;
	b=i9e4/hPYX865IWWGXN/Gi6OMxdRroGGEvD158Raqkh67lG/xBX4cNXq5cD8rT7DAyoGW
	 4tFkL709jAh9c5YrGE0DWlaPHnf7soJpVuyDxGLqih+OEn/j2ntAT4Uf5Iz/jxnE9ZKel
	 Sppnb0QVGQbwDMVdTqBKZ+gVbJiNwjbJIk6MvRYaEvsptrM38ZCQbBOnaK5CnveaVY/oi
	 a+/zWCHZcTtOdLvHUpZPlXhma3KBe7EA2cfjJTLH8biaNZXwA+8+mGCdMUCTrrK0cKczg
	 po/A/Sj/QB88DZ9eqbtt+4JDLOqS1xi5p/C1jnX6OWOlfnLTh2kZoCvvD3XfezdEPlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=digikod.net;
	spf=pass smtp.mailfrom=digikod.net;
	dkim=pass header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b="p58/vams";
	arc=none smtp.remote-ip=185.125.25.15
Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch [185.125.25.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D980606A32A
	for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2026 17:01:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D980606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=p58/vams
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jV7D41bBfzfbw;
	Wed, 18 Nov 2026 18:01:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1795021283;
	bh=ooxeFkFKsKCR8G8wrgoKSTGcXvfw78FmflozaOOLeH8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p58/vamsaZz6/8/h+2BmEuCASjVUeyLwuSaoa5FSJ/IpB23EL5AWhzNWuEjFBbcTT
	 5L0/jSjW3aWTpoRen/2j8Dnet+Oyks+HaMqvWYwM/pCyHgbaaceE4dadIcG7R6OhLU
	 AWIVMVJBB10lF5lQAOmpNMqu1NQ3s+CnEd7bUkAM=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4jV7D312nFz1dX;
	Wed, 18 Nov 2026 18:01:23 +0100 (CET)
Date: Wed, 18 Nov 2026 18:01:22 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: Ada Smith <adasmithgt@gmail.com>, Hungyu Lin <dennylin0707@gmail.com>, 
	James Morris <jmorris@namei.org>, Josef Bacik <josef@toxicpanda.com>, 
	Paul Moore <paul@paul-moore.com>, Serge Hallyn <serge@hallyn.com>, 
	Serge Hallyn <sergeh@kernel.org>, kernel-team@cloudflare.com, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 3/6] landlock: Mediate CAP_SETPCAP for inheritable
 capabilities
Message-ID: <20261118.noo1uNoh7vey@digikod.net>
References: <20261117101157.2520463-1-mic@digikod.net>
 <20261117101157.2520463-4-mic@digikod.net>
 <avx1r36MHsxhAzSf@google.com>
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
In-Reply-To: <avx1r36MHsxhAzSf@google.com>
X-Infomaniak-Routing: alpha

On Tue, Nov 17, 2026 at 04:41:35PM +0100, Günther Noack wrote:
> On Tue, Nov 17, 2026 at 11:11:53AM +0100, Mickaël Salaün wrote:
> > A process in a domain that denies CAP_SETPCAP could still add
> > capabilities outside of its permitted set to its inheritable set with
> > capset(2), if it held CAP_SETPCAP.  cap_capset() checks CAP_SETPCAP with
> > cap_capable() in cap_inh_is_capped(), so the check never reaches
> > hook_capable().  Through file inheritable capabilities, such a set can
> > grant new permitted capabilities on execve() when no_new_privs is not
> > set, which is possible for a domain enforced by a task holding
> > CAP_SYS_ADMIN.
> > 
> > Add a Landlock capset hook that checks CAP_SETPCAP against the domain
> > under the same condition as cap_capset().  As with the mmap_addr hook,
> > LSMs implement their own policy in this hook: SELinux checks capset with
> > its own permission.
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
> > https://patch.msgid.link/20261110202436.2408244-4-mic@digikod.net
> > - Add Serge Hallyn's Acked-by.
> > ---
> >  security/landlock/cap.c | 30 ++++++++++++++++++++++++++++++
> >  1 file changed, 30 insertions(+)
> > 
> > diff --git a/security/landlock/cap.c b/security/landlock/cap.c
> > index 10e1ca772b9c..c89e8d76db8c 100644
> > --- a/security/landlock/cap.c
> > +++ b/security/landlock/cap.c
> > @@ -91,6 +91,35 @@ static int hook_capable(const struct cred *cred, struct user_namespace *ns,
> >  	return check_cap(cred, cap, opts);
> >  }
> >  
> > +/**
> > + * hook_capset - Restrict inheritable capability changes
> > + *
> > + * @new: New credentials (unused).
> > + * @old: Current credentials.
> > + * @effective: New effective set (unused).
> > + * @inheritable: New inheritable set.
> > + * @permitted: New permitted set (unused).
> > + *
> > + * cap_capset() requires CAP_SETPCAP to add inheritable capabilities that are
> > + * not in the old permitted set, but calls cap_capable() directly, which skips
> > + * hook_capable().
> 
> It has taken me a bit of time to wrap my head around this one.
> 
> cap_capset() starts with:
> 
> 	if (cap_inh_is_capped() &&
> 	    !cap_issubset(*inheritable,
> 			  cap_combine(old->cap_inheritable,
> 				      old->cap_permitted)))
> 		/* incapable of using this inheritable set */
> 		return -EPERM;
> 
> where cap_inh_is_capped() returns true if it does *not* have CAP_SETPCAP.
> 
> So when this Landlock hooks gets called, cap_capset() has already
> checked that we either have CAP_SETPCAP or inheritable ⊆
> (old->inheritable ⋃ old->permitted).  So the Landlock hook can check
> for the cap_issubset(...) condition to see whether CAP_SETPCAP had to
> be "used".
> 
> Maybe it would be easier to phrase it like that?
> 
> 
> (A more specific nit about this comment, "calls cap_capable()
> *directly*" has confused me a bit, since cap_capset() calls
> cap_capable() only *indirectly* through cap_inh_is_capped().  Maybe
> "promptly", or "immediately" would be better?)

I agree, the v3 should address your concerns.

> 
> > Check the same condition against the domain.  commoncap runs
> > + * first, so this only sees requests that commoncap allowed.  capset(2) discards
> > + * @new if this hook fails, so nothing is committed.
> > + *
> > + * Return: 0 if allowed, -EPERM if CAP_SETPCAP use is denied.
> > + */
> > +static int hook_capset(struct cred *new, const struct cred *old,
> > +		       const kernel_cap_t *effective,
> > +		       const kernel_cap_t *inheritable,
> > +		       const kernel_cap_t *permitted)
> > +{
> > +	if (cap_issubset(*inheritable,
> > +			 cap_combine(old->cap_inheritable, old->cap_permitted)))
> > +		return 0;
> > +
> > +	return check_cap(old, CAP_SETPCAP, CAP_OPT_NONE);
> > +}
> > +
> >  /**
> >   * hook_mmap_addr - Restrict mappings below dac_mmap_min_addr
> >   *
> > @@ -113,6 +142,7 @@ static int hook_mmap_addr(unsigned long addr)
> >  
> >  static struct security_hook_list landlock_hooks[] __ro_after_init = {
> >  	LSM_HOOK_INIT(capable, hook_capable),
> > +	LSM_HOOK_INIT(capset, hook_capset),
> >  	LSM_HOOK_INIT(mmap_addr, hook_mmap_addr),
> >  };
> >  
> > -- 
> > 2.56.0
> > 
> 
> Reviewed-by: Günther Noack <gnoack@google.com>
> 
> Code checks out, only minor comments about the documentation.  It has
> taken me a bit to understand how the Landlock hook's logic matches the
> one in cap_capset().
> 
> —Günther
