Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch [84.16.66.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF14E311969
	for <linux-security-module@vger.kernel.org>; Sun, 24 May 2026 20:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779654924; cv=none; b=kZzxUApHLa0icCZF26gV25jeG9bhFdsVpToqmHYFLaTSMRSWiFso4AqoWGdNAGIEgwYwrCxBi6a7SeXlECynyS4FBLDAIpsJ2iVCXcXkQgxtxvzVD4r9kO6TX2MSz+PR7iCy/2O/XyztIgrRGlXEhkwkJQ8mmbzTQaWMi9E0LAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779654924; c=relaxed/simple;
	bh=zhZBG2PtFwJnqu74JwJtW/1/0FajzDe5kLMlYhbRRbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NDhPOJV2Hdj/t94aHr8JcDSlbwS9JGU2rx5dFo0xrBAOVgwb5qt98GWBA7qB/rFJbuYranVCX5r7gkgxUZfVI3u4Cx12op3P/HhRSP6+UxXktYr9l94DcEyy+2O6vhkEJqkbIg/Uwq1O9UC+A5AyM3T2VuY2PZZBCUFYGmWJWqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=nolnHB3T; arc=none smtp.client-ip=84.16.66.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="nolnHB3T"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gNrNt5Xt7z16Hq;
	Sun, 24 May 2026 22:35:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1779654910;
	bh=mkC/prNRSH+uwZacVBfisIoSvthfPQd/hrnRe68J/Jo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nolnHB3TBrzrolbXi0jFawGJ8XcmGPhoJ2txsj83elSs16HoJjRCGHBTYy/Dtv8sW
	 AzyZEik2Ds6vxVwMYr58HExm/lTIj8ZjPvgkd/DqlWM+xFNRxaReJtmPlCLUSVIXCK
	 PADG4J+kx1xoKkn4fCTUHA9RgNxI5OXpx1bATzSs=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4gNrNt0MqGzmtf;
	Sun, 24 May 2026 22:35:09 +0200 (CEST)
Date: Sun, 24 May 2026 22:35:05 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tingmao Wang <m@maowtm.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>, 
	Justin Suess <utilityemal77@gmail.com>, Jan Kara <jack@suse.cz>, Abhinav Saxena <xandfury@gmail.com>, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v8 1/9] landlock: Add a place for flags to layer rules
Message-ID: <20260524.eFiz4hahrami@digikod.net>
References: <cover.1775490344.git.m@maowtm.org>
 <6f418b431ccf88636ea3a1b930d14bfdcd420233.1775490344.git.m@maowtm.org>
 <20260523.Uephughee8as@digikod.net>
 <617fdd53-6612-4f6f-b0e0-16d85985487b@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <617fdd53-6612-4f6f-b0e0-16d85985487b@maowtm.org>
X-Infomaniak-Routing: alpha

On Sun, May 24, 2026 at 02:29:40AM +0100, Tingmao Wang wrote:
> On 5/23/26 21:48, Mickaël Salaün wrote:
> > This patch doesn't build.
> 
> Missed a hunk in this patch (ended up in the next one), will add.
> 
> >> @@ -797,20 +803,28 @@ is_access_to_paths_allowed(const struct landlock_ruleset *const domain,
> >>  	}
> >>  
> >>  	if (unlikely(dentry_child1)) {
> >> +		/*
> >> +		 * Get the layer masks for the child dentries for use by domain
> >> +		 * check later.  The rule_flags for child1 should have been
> >> +		 * included in rule_flags_parent1 already (cf.
> >> +		 * collect_domain_accesses), and is not relevant for domain check,
> >> +		 * so we don't have to pass it to landlock_unmask_layers.
> >> +		 */
> >>  		if (landlock_init_layer_masks(domain, LANDLOCK_MASK_ACCESS_FS,
> >>  					      &_layer_masks_child1,
> >>  					      LANDLOCK_KEY_INODE))
> >>  			landlock_unmask_layers(find_rule(domain, dentry_child1),
> >> -					       &_layer_masks_child1);
> >> +					       &_layer_masks_child1, NULL);
> >>  		layer_masks_child1 = &_layer_masks_child1;
> >>  		child1_is_directory = d_is_dir(dentry_child1);
> >>  	}
> >>  	if (unlikely(dentry_child2)) {
> >> +		/* See above comment for why NULL is passed as rule_flags_masks. */
> > 
> > rule_flags_masks doesn't exist.
> 
> I guess I was probably referring to the rule_flags argument - will fix.
> 
> >> [...]
> >> @@ -647,9 +648,14 @@ bool landlock_unmask_layers(const struct landlock_rule *const rule,
> >>  	 */
> >>  	for (size_t i = 0; i < rule->num_layers; i++) {
> >>  		const struct landlock_layer *const layer = &rule->layers[i];
> >> +		const layer_mask_t layer_bit = BIT_ULL(layer->level - 1);
> >>  
> > 
> >>  		/* Clear the bits where the layer in the rule grants access. */
> >>  		masks->access[layer->level - 1] &= ~layer->access;
> >> +
> >> +		/* Collect rule flags for each layer. */
> >> +		if (rule_flags && layer->flags.quiet)
> >> +			rule_flags->quiet_masks |= layer_bit;
> > 
> > Why not store the quiet bit in masks?  That would not only be "access"
> > bits anymore but it makes sense to store all this bits it the same
> > place.
> > 
> > We should then probably rename struct layer_access_masks to just struct
> > layer_masks.
> > 
> > We need to be careful to not increase too much the size of this struct
> > though while keeping the [LANDLOCK_MAX_NUM_LAYERS] approach if possible
> > (see Günther's commit that added it).
> 
> Most uses of struct layer_access_masks do not actually care about the rule
> flags tho, e.g. in unmask_scoped_access, scope_to_request, or may_refer.
> Such a rename would touch 31 places (and only a few of them would actually
> touch the quiet flag).

Most of these places are tests.

> 
> If we want to refactor to make this be in the layer_access_masks (then
> rename it), I guess there are 3 options, which do you prefer?
> 
> 1. Add a u16 bitfield for which layers are quieted.  Future rule flags
>    will be additional bitfields.  struct layer_masks becomes 68 bytes (+4).
> 
> struct layer_masks {
> 	access_mask_t access[LANDLOCK_MAX_NUM_LAYERS];
> 	layer_mask_t quiet_layers;
> };
> 
> 2. Make the [LANDLOCK_MAX_NUM_LAYERS] array store both the access mask and
>    the quiet bit (or more bits for future rule flags).  Size of struct stays
>    the same.
> 
> static_assert(LANDLOCK_NUM_ACCESS_NET <= LANDLOCK_NUM_ACCESS_FS);
> static_assert(LANDLOCK_NUM_SCOPE <= LANDLOCK_NUM_ACCESS_FS);
> struct layer_mask {
> 	access_mask_t access:LANDLOCK_NUM_ACCESS_FS;
> 	bool quiet:1;
> };

Yes, like Justin, I prefer this approach too.  Some improvements:

// In limits.h:
#define LANDLOCK_MAX_NUM_ACCESSES \
	MAX(LANDLOCK_NUM_ACCESS_FS, LANDLOCK_NUM_ACCESS_NET)

// In access.h:
struct layer_mask {
	access_mask_t access:LANDLOCK_MAX_NUM_ACCESSES;
#ifdef CONFIG_AUDIT
	bool quiet:1; // I'm not sure if using bool would work for all
	// architectures though, but we can make sure with the following
	// assert.
#endif /* CONFIG_AUDIT */
};
static_assert(sizeof(struct layer_mask), sizeof(access_mask_t));

> struct layer_masks {
> 	struct layer_mask layer[LANDLOCK_MAX_NUM_LAYERS];
> };
> 
>    (Maybe we can just make struct layer_masks a typedef to
>    layer_mask[LANDLOCK_MAX_NUM_LAYERS] instead?  But currently not sure if
>    there are any gotchas with a typedef like that)

The only typedefs used in Landlock are for potentially growing types. So
no need for typedef here.

> 
> 3. Mirror layer_access_masks::access[] - add a
>    rule_flags[LANDLOCK_MAX_NUM_LAYERS] too.  struct layer_masks becomes 80
>    bytes (+16).
> 
> struct rule_flags {
> 	bool quiet:1;
> };
> struct layer_masks {
> 	/**
> 	 * @access: The unfulfilled access rights for each layer.
> 	 */
> 	access_mask_t access[LANDLOCK_MAX_NUM_LAYERS];
> 	struct rule_flags rule_flags[LANDLOCK_MAX_NUM_LAYERS];
> };
> 
> (3 seems very wasteful to me)
> 
