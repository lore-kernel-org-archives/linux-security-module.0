Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch [45.157.188.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D1A15A864
	for <linux-security-module@vger.kernel.org>; Mon, 25 May 2026 20:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779741571; cv=none; b=sYFPPV4vrMZn9GP04YhyRRmHAoU5S7hWL11drwY61+/B8QhBgtwUy/MNpG6Q1oaOQmWnYxLVWlSR37/drWkflisStxDq4jhU4cBtr6C64hWDraX74UYkEXs8J80DudFL71rH2A3KYcwCZ0AHzZ+AaaZA0sqYxNrYH7YclF4zSh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779741571; c=relaxed/simple;
	bh=U73BwgvfHY6Pa6l/wdIgDkBRZPXesJiNOkMlhzF0NI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hT/ji0S2+aA08GdAQqQwejG+FaNFnSA9kcQGTT5oWbCqWPy+HYjEyhMhufn7rohDRPQCevrPpWSm7ATguAhFYOp0IBxq+yeJVPWBbKCehm3Lctn1YzT9ntppVrpIOj/9/gVUz61tyjR3mA/r+RDXHSN3gg9ijW0psqKiKiyZJ8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=cyGjFJG0; arc=none smtp.client-ip=45.157.188.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="cyGjFJG0"
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gPSRB0j1nzW5b;
	Mon, 25 May 2026 22:39:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1779741557;
	bh=9M+tLad4oa+LIcuJI3d0cIMhKpk7rnx2i6+Ofcca9Ng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cyGjFJG03CQt23CZtQME8aZUbnv9b364tRE6Vgm7ESEoFMpJ8i/TsYmRdKrx1CkTq
	 opMITTAhntSjIqgr8USRX5x4W+SNObx/kW1IwmsB3KQDT0MYNQv0aeR0h6BXelBSHt
	 KjYO5jHQrwqN6zTegWla5s3GUt4udkCsX6CI7umc=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4gPSR93Tx4zn3v;
	Mon, 25 May 2026 22:39:17 +0200 (CEST)
Date: Mon, 25 May 2026 22:39:16 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Justin Suess <utilityemal77@gmail.com>
Cc: Tingmao Wang <m@maowtm.org>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>, Jan Kara <jack@suse.cz>, Abhinav Saxena <xandfury@gmail.com>, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v8 1/9] landlock: Add a place for flags to layer rules
Message-ID: <20260525.quoPhoh6ma3k@digikod.net>
References: <cover.1775490344.git.m@maowtm.org>
 <6f418b431ccf88636ea3a1b930d14bfdcd420233.1775490344.git.m@maowtm.org>
 <20260523.Uephughee8as@digikod.net>
 <617fdd53-6612-4f6f-b0e0-16d85985487b@maowtm.org>
 <ahMLLwnDO7g64h63@zenbox>
 <42a06f7c-abb5-4f2d-8428-8d122047e8d4@maowtm.org>
 <ahNx8CNCeqhU_Ide@zenbox>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ahNx8CNCeqhU_Ide@zenbox>
X-Infomaniak-Routing: alpha

On Sun, May 24, 2026 at 06:08:00PM -0400, Justin Suess wrote:
> On Sun, May 24, 2026 at 07:20:19PM +0100, Tingmao Wang wrote:
> > On 5/24/26 15:46, Justin Suess wrote:
> > > On Sun, May 24, 2026 at 02:29:40AM +0100, Tingmao Wang wrote:
> > >> On 5/23/26 21:48, Mickaël Salaün wrote:
> > >>> [...]
> > >>>> @@ -647,9 +648,14 @@ bool landlock_unmask_layers(const struct landlock_rule *const rule,
> > >>>>  	 */
> > >>>>  	for (size_t i = 0; i < rule->num_layers; i++) {
> > >>>>  		const struct landlock_layer *const layer = &rule->layers[i];
> > >>>> +		const layer_mask_t layer_bit = BIT_ULL(layer->level - 1);
> > >>>>  
> > >>>
> > >>>>  		/* Clear the bits where the layer in the rule grants access. */
> > >>>>  		masks->access[layer->level - 1] &= ~layer->access;
> > >>>> +
> > >>>> +		/* Collect rule flags for each layer. */
> > >>>> +		if (rule_flags && layer->flags.quiet)
> > >>>> +			rule_flags->quiet_masks |= layer_bit;
> > >>>
> > >>> Why not store the quiet bit in masks?  That would not only be "access"
> > >>> bits anymore but it makes sense to store all this bits it the same
> > >>> place.
> > >>>
> > >>> We should then probably rename struct layer_access_masks to just struct
> > >>> layer_masks.
> > >>>
> > >>> We need to be careful to not increase too much the size of this struct
> > >>> though while keeping the [LANDLOCK_MAX_NUM_LAYERS] approach if possible
> > >>> (see Günther's commit that added it).
> > >>
> > >> Most uses of struct layer_access_masks do not actually care about the rule
> > >> flags tho, e.g. in unmask_scoped_access, scope_to_request, or may_refer.
> > >> Such a rename would touch 31 places (and only a few of them would actually
> > >> touch the quiet flag).
> > >>
> > >> If we want to refactor to make this be in the layer_access_masks (then
> > >> rename it), I guess there are 3 options, which do you prefer?
> > >>
> > >> 1. Add a u16 bitfield for which layers are quieted.  Future rule flags
> > >>    will be additional bitfields.  struct layer_masks becomes 68 bytes (+4).
> > >>
> > >> struct layer_masks {
> > >> 	access_mask_t access[LANDLOCK_MAX_NUM_LAYERS];
> > >> 	layer_mask_t quiet_layers;
> > >> };
> > >>
> > >> 2. Make the [LANDLOCK_MAX_NUM_LAYERS] array store both the access mask and
> > >>    the quiet bit (or more bits for future rule flags).  Size of struct stays
> > >>    the same.
> > >>
> > > This approach seems best.
> > >> static_assert(LANDLOCK_NUM_ACCESS_NET <= LANDLOCK_NUM_ACCESS_FS);
> > >> static_assert(LANDLOCK_NUM_SCOPE <= LANDLOCK_NUM_ACCESS_FS);
> > >> struct layer_mask {
> > >> 	access_mask_t access:LANDLOCK_NUM_ACCESS_FS;
> > >> 	bool quiet:1;
> > >> };
> > > 
> > > Other way to do it could be an (anonymous?) union.
> > > 
> > > union {
> > >   access_mask_t fs_access:LANDLOCK_NUM_ACCESS_FS;
> > >   access_mask_t net_access:LANDLOCK_NUM_ACCESS_NET;
> > >   access_mask_t scope_access:LANDLOCK_NUM_SCOPE;
> > > }
> > > 
> > > The union should be sized to fit the largest field automatically.
> > > 
> > > That way you don't have to change this when adding new access rights
> > > and avoid the brittle static_asserts.
> > > 
> > > Not sure about the alignment implications here though.
> > 
> > Unfortunately this forces struct layer_mask to be 2x as large:
> > https://godbolt.org/z/5P9b4rrMW
> > 
> Yeah I guess the compiler can't pack the fields with differing types.
> 
> *In theory* you could make everything a _BitInt or something but it
> seems better to do what you had below.
> > But it turns out I could have just used MAX, seems to compile for me:
> > 
> > struct layer_mask {
> > 	access_mask_t access
> > 		: MAX(LANDLOCK_NUM_ACCESS_FS,
> > 		      MAX(LANDLOCK_NUM_ACCESS_NET, LANDLOCK_NUM_SCOPE));
> > 	bool quiet : 1;
> > };
> This works perfectly.
> 
> Mickaël's suggestion (except w/ all three access right classes like
> you have here, think he missed LANDLOCK_NUM_SCOPE) is very close
> to this.
> > struct layer_masks {
> > 	struct layer_mask layer[LANDLOCK_MAX_NUM_LAYERS];
> > };
> > 
> > Maybe we could #define LANDLOCK_NUM_ACCESS_MAX to be MAX(...) then use it
> > here.

LANDLOCK_NUM_ACCESS_MAX looks like a better name (even if it also
include scopes).

> > 
> > I'm still not sure if putting the collected rule flags in struct
> > layer_(access_)masks is a good idea tho.  Passing a separate struct
> > collected_rule_flags to the functions that needs to deal with rule flags
> > (quiet, and later, no inherit / has no inherit descendant) seems quite
> > practical to me.
> 
> (Not sure how stingy we gotta be with stack space)
> 
> There's a *slight* stack space advantage to keeping them together.
> 
> If you pass by value, (separate layer_access_masks, collected_rule_flags),
> those structs must be individually padded and aligned. Which may or may not
> make a difference, it's dependent on alignment and architecture.
> 
> Whereas if we keep them all together, we only pad once.
> 
> If you pass by pointer, you have to allocate stack space for each
> pointer, so passing it all at once saves sizeof(collected_rule_flags*)
> bytes in the pass by pointer case.
> 
> Either way it's probably a couple bytes at worst, so probably nothing to
> worry about.
> 
> The more compelling argument is that we don't know how future paths
> will use rule flags, so keeping it all together reduces churn later
> if a function ends up needing to access flags. Moreover, it makes those
> messy function signatures in fs.h/c a little less hairy, and easy to
> refactor later.

Agreed
