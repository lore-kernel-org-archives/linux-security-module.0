Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch [84.16.66.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F25C7E765
	for <linux-security-module@vger.kernel.org>; Thu, 10 Oct 2024 09:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728551444; cv=none; b=s7g0/bCekPq81zA8S5YNDNDnG5Tarnj6x/L8OKWdIhdJ6uDKpuuwm/bGDvnBguFrO0P71g5aQJpSQJ4cBHW74+Gb0ey8+zvVSfRVJdMefjHCcSwQNvWO9sHHqW4nb91/zFSYlNKbfs7p9KpCYf4Y3r4BB95HyvV3oYD3DsZoL28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728551444; c=relaxed/simple;
	bh=B12YC9as2rR/Rt1j4+XTi5tIpSMgROYuxHJwaBH2/ow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RrSy8pVW7XydY++qz6mjiy8iJaMIXqyiKbZyiHns3y0J5nTAV7LVuHPPnMqldkI8V1CsIpDTLG5AUZAmhYvOWdMhoZF9hH7/YAwRoS86hwKZYF7ydCMa7tZEAdlUXq7mq3tRq9gmogae1oOuSUaKK5jyYobim8SMe9oPuX5Y5PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=I6nxLAji; arc=none smtp.client-ip=84.16.66.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="I6nxLAji"
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XPP9d69BQz1CVS;
	Thu, 10 Oct 2024 11:10:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1728551429;
	bh=8zUGaVu8iLjqEt+BtLQ15u4qOoiYKE6GrgioYJgFx3g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I6nxLAjixu7a5XfqbTVtsysKq1WHNMyLDaQomxNuVyd9yJwpxnozzKfE2pC2IO6bI
	 L86jWRcVD2fnYeq11VRpzTt61rI838GNOK3oaOj/lhIIKgAu94mDnqvH3bQ3sjJ3Kn
	 WObHiP9Pei6xwXf7vgh74nP6lDxSga0QjOvokLR4=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4XPP9c6BN7zQjZ;
	Thu, 10 Oct 2024 11:10:28 +0200 (CEST)
Date: Thu, 10 Oct 2024 11:10:25 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	Paul Moore <paul@paul-moore.com>, Tahera Fahimi <fahimitahera@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Matthieu Buffet <matthieu@buffet.re>
Subject: Re: [PATCH v1 1/3] landlock: Refactor filesystem access mask
 management
Message-ID: <20241010.ue4otees4Sie@digikod.net>
References: <20241001141234.397649-1-mic@digikod.net>
 <20241001141234.397649-2-mic@digikod.net>
 <20241005.a69458234f74@gnoack.org>
 <20241007.SheiFoom7Sei@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241007.SheiFoom7Sei@digikod.net>
X-Infomaniak-Routing: alpha

On Mon, Oct 07, 2024 at 03:00:34PM +0200, Mickaël Salaün wrote:
> On Sat, Oct 05, 2024 at 06:57:55PM +0200, Günther Noack wrote:
> > On Tue, Oct 01, 2024 at 04:12:32PM +0200, Mickaël Salaün wrote:
> > > Replace get_raw_handled_fs_accesses() with a generic
> > > landlock_merge_access_masks(), and replace the get_fs_domain()
> > > implementation with a call to the new landlock_filter_access_masks()
> > > helper.  These helpers will also be useful for other types of access.
> > > 
> > > Replace struct access_masks with union access_masks that includes a new
> > > "all" field to simplify mask filtering.
> > > 
> > > Cc: Günther Noack <gnoack@google.com>
> > > Cc: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
> > > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > > Link: https://lore.kernel.org/r/20241001141234.397649-2-mic@digikod.net
> > > ---
> > >  security/landlock/fs.c       | 21 ++++-----------
> > >  security/landlock/ruleset.h  | 51 +++++++++++++++++++++++++++---------
> > >  security/landlock/syscalls.c |  2 +-
> > >  3 files changed, 44 insertions(+), 30 deletions(-)
> > > 
> > > diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> > > index 7d79fc8abe21..a2ef7d151c81 100644
> > > --- a/security/landlock/fs.c
> > > +++ b/security/landlock/fs.c
> > > @@ -388,33 +388,22 @@ static bool is_nouser_or_private(const struct dentry *dentry)
> > >  		unlikely(IS_PRIVATE(d_backing_inode(dentry))));
> > >  }
> > >  
> > > -static access_mask_t
> > > -get_raw_handled_fs_accesses(const struct landlock_ruleset *const domain)
> > > -{
> > > -	access_mask_t access_dom = 0;
> > > -	size_t layer_level;
> > > -
> > > -	for (layer_level = 0; layer_level < domain->num_layers; layer_level++)
> > > -		access_dom |=
> > > -			landlock_get_raw_fs_access_mask(domain, layer_level);
> > > -	return access_dom;
> > > -}
> > > -
> > >  static access_mask_t
> > >  get_handled_fs_accesses(const struct landlock_ruleset *const domain)
> > >  {
> > >  	/* Handles all initially denied by default access rights. */
> > > -	return get_raw_handled_fs_accesses(domain) |
> > > +	return landlock_merge_access_masks(domain).fs |
> > >  	       LANDLOCK_ACCESS_FS_INITIALLY_DENIED;
> > >  }
> > >  
> > >  static const struct landlock_ruleset *
> > >  get_fs_domain(const struct landlock_ruleset *const domain)
> > >  {
> > > -	if (!domain || !get_raw_handled_fs_accesses(domain))
> > > -		return NULL;
> > > +	const union access_masks all_fs = {
> > > +		.fs = ~0,
> > > +	};
> > >  
> > > -	return domain;
> > > +	return landlock_filter_access_masks(domain, all_fs);
> > >  }
> > >  
> > >  static const struct landlock_ruleset *get_current_fs_domain(void)
> > > diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
> > > index 61bdbc550172..a816042ca8f3 100644
> > > --- a/security/landlock/ruleset.h
> > > +++ b/security/landlock/ruleset.h
> > > @@ -41,12 +41,19 @@ static_assert(BITS_PER_TYPE(access_mask_t) >= LANDLOCK_NUM_SCOPE);
> > >  static_assert(sizeof(unsigned long) >= sizeof(access_mask_t));
> > >  
> > >  /* Ruleset access masks. */
> > > -struct access_masks {
> > > -	access_mask_t fs : LANDLOCK_NUM_ACCESS_FS;
> > > -	access_mask_t net : LANDLOCK_NUM_ACCESS_NET;
> > > -	access_mask_t scope : LANDLOCK_NUM_SCOPE;
> > > +union access_masks {
> > > +	struct {
> > > +		access_mask_t fs : LANDLOCK_NUM_ACCESS_FS;
> > > +		access_mask_t net : LANDLOCK_NUM_ACCESS_NET;
> > > +		access_mask_t scope : LANDLOCK_NUM_SCOPE;
> > > +	};
> > > +	u32 all;
> > >  };
> > 
> > More of a style remark:
> > 
> > I wonder whether it is worth turning this into a union.
> > 
> > If this is for performance, I do not think is buys you much.  With
> > optimization enabled, it does not make much of a difference whether
> > you are doing the & on .all or whether you are doing it on the
> > individual fields.  (I tried it out with gcc.  The only difference is
> > that the & on the individual fields will at the end mask only the bits
> > that belong to these fields.)
> 
> This is not about performance but about maintainability and simplicity
> (to avoid future changes/errors).  Indeed, with this "all" field we
> don't need to update (or forget to update) the
> landlock_merge_access_masks() helper.  This function can be simple and
> generic to be used in the fs.c, net.c, and scope.c files.
> 
> > 
> > At the same time, in most places where struct access_masks is used,
> > the union is not necessary and might add to the confusion.
> 
> I think it should not be an issue, and it leverages the advantages of
> the previous access_masks_t with the ones of struct access_masks.
> 
> > 
> > 
> > >  
> > > +/* Makes sure all fields are covered. */
> > > +static_assert(sizeof(((union access_masks *)NULL)->all) ==
> > > +	      sizeof(union access_masks));
> > > +
> > >  typedef u16 layer_mask_t;
> > >  /* Makes sure all layers can be checked. */
> > >  static_assert(BITS_PER_TYPE(layer_mask_t) >= LANDLOCK_MAX_NUM_LAYERS);
> > > @@ -229,7 +236,7 @@ struct landlock_ruleset {
> > >  			 * layers are set once and never changed for the
> > >  			 * lifetime of the ruleset.
> > >  			 */
> > > -			struct access_masks access_masks[];
> > > +			union access_masks access_masks[];
> > >  		};
> > >  	};
> > >  };
> > > @@ -260,6 +267,31 @@ static inline void landlock_get_ruleset(struct landlock_ruleset *const ruleset)
> > >  		refcount_inc(&ruleset->usage);
> > >  }
> > >  
> > > +static inline union access_masks
> > > +landlock_merge_access_masks(const struct landlock_ruleset *const domain)
> > > +{
> > > +	size_t layer_level;
> > > +	union access_masks matches = {};
> > > +
> > > +	for (layer_level = 0; layer_level < domain->num_layers; layer_level++)
> > > +		matches.all |= domain->access_masks[layer_level].all;
> > > +
> > > +	return matches;
> > > +}
> > > +
> > > +static inline const struct landlock_ruleset *
> > > +landlock_filter_access_masks(const struct landlock_ruleset *const domain,
> > > +			     const union access_masks masks)
> > 
> > With this function name, the return type of this function is
> > unintuitive to me.  Judging by the name, I would have expected a
> > function that returns a "access_masks" value as well, similar to the
> > function one above (the remaining access rights after filtering)?
> 
> Fair
> 
> > 
> > In the places where the result of this function is returned directly,
> > I find myself jumping back to the function implementation to
> > understand what this means.
> > 
> > As a constructive suggestion, how about calling this function
> > differently, e.g.
> > 
> > bool landlock_any_access_rights_handled(
> >     const struct landlock_ruleset *const domain,
> >     struct access_masks masks);
> > 
> > Then the callers who previously did
> > 
> >    return landlock_filter_access_masks(dom, masks);
> > 
> > would now do
> > 
> >    if (landlock_any_access_rights_handled(dom, masks))
> >        return dom;
> >    return NULL;
> 
> I'm not sure if you're suggesting to return an union access_masks or a
> landlock_ruleset pointer.  Returning a ruleset/domain simplifies the
> work of callers so I'd prefer to keep that.
> 
> The "_any_access_rights_handled" doesn't have a verb, and it's not clear
> to me if it would return the handled access rights or something else.
> 
> What about renaming it landlock_mask_ruleset(dom, access_masks) instead?

Thinking more about it, using "mask" could mean that the access_masks
argument will indeed mask and we'll get the oposite.  What about
landlock_match_ruleset()?

> 
> For now, the variables named "domain" points to struct landlock_ruleset,
> but they will eventually point to a future struct landlock_domain.  So,
> I prefer to keep the name "ruleset" in helpers dealing with struct
> landlock_ruleset.  We'll need to change these helpers when we'll switch
> to landlock_domain anyway.
> 
> > 
> > This is more verbose, but IMHO verbose code is not inherently bad,
> > if it is also clearer.  And it's only two lines more.
