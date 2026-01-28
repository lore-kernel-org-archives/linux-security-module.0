Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch [45.157.188.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423992E62D1
	for <linux-security-module@vger.kernel.org>; Wed, 28 Jan 2026 21:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769636947; cv=none; b=Qaj8w4qWwR44ZsV/jfkz0VGW/bwnNE3lWAZhitGqw6q6lmTqO5l9muN8mUG6xO24EOawvqSs5kcmZVZpoQuqEK1qyabQUWSEo5EJwp9D6ghQFGeIlol+g+W6kxx8ZJ4TmSm/fU+p9J6Jvh920Gy5ApYn1qP75OSpxcF4roj2cno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769636947; c=relaxed/simple;
	bh=4aS8ZhSZAiIABJfxXD7j6jQSUPZNWw6khTBlY64G+Dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YSliRYrPu1mKTXV2wvDFDJgyTx/lC5BEw6rfteMtnEbA8kOV4nU3cSTYglVExT1i9X7AS80HGR2HAR+SbHAwFCl+YCc+p0oTlhMIhwUbpPDN/S4E+jNkS5vt7D5oLJYNDbycqRe24tgufYpLwMaKrJfri+Kt9TzN5H7r0XGO+8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=M1cVSPnt; arc=none smtp.client-ip=45.157.188.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="M1cVSPnt"
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6c])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4f1bWf42TZzk3t;
	Wed, 28 Jan 2026 22:49:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1769636942;
	bh=Om/vEuoVO0NzQRVD7siTNDrxDHC+B+SaR9Br4TEw9Ng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M1cVSPntHhEYtcjsv45i1BweQhNWcQ1QYnTgZZ4a6TSnjk4uutFewf1DXAk/eW6EA
	 k0rNS9DDaW/xwUfPA9M809FwjPzAkZjGF7FOn6xmRhuQB6LV6IApB8clOkl69oDhpx
	 T6A1uZVshDU67QrkFoYeCc9lyg+DtPuDaYj0uZjY=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4f1bWd2tBYz7FC;
	Wed, 28 Jan 2026 22:49:01 +0100 (CET)
Date: Wed, 28 Jan 2026 22:49:00 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>, 
	Tingmao Wang <m@maowtm.org>
Cc: linux-security-module@vger.kernel.org, 
	Justin Suess <utilityemal77@gmail.com>, Samasth Norway Ananda <samasth.norway.ananda@oracle.com>, 
	Matthieu Buffet <matthieu@buffet.re>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	konstantin.meskhidze@huawei.com
Subject: Re: [RFC PATCH 2/2] landlock: transpose the layer masks data
 structure
Message-ID: <20260128.jaeXie7ez2xu@digikod.net>
References: <20251230103917.10549-3-gnoack3000@gmail.com>
 <20251230103917.10549-7-gnoack3000@gmail.com>
 <20260120.haeCh4li9Vae@digikod.net>
 <20260123.13e99fee0197@gnoack.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260123.13e99fee0197@gnoack.org>
X-Infomaniak-Routing: alpha

Re-CCing everyone since I guess they were accidentally removed.

On Fri, Jan 23, 2026 at 10:33:42PM +0100, Günther Noack wrote:
> Hello!
> 
> On Wed, Jan 21, 2026 at 11:22:28PM +0100, Mickaël Salaün wrote:
> > The goal of the initial design was to minimize the amount of memory wrt
> > the number of different access rights because the maximum number of
> > layers is 16 whereas access rights could grow up to 64.
> > 
> > Transposing the matrix increases the memory footprint in theory but
> > because we still need the struct layer_access_masks matrix, it should
> > actually be better.  See stack usage delta with audit (generated with
> > check-linux.sh):
> 
> Thanks for the review and for doing these measurements!
> 
> >   landlock_unmask_layers       208  80   -128
> >   landlock_init_layer_masks    192  96   -96
> >   landlock_log_denial          176  80   -96
> >   current_check_access_path    336  304  -32
> >   current_check_refer_path     592  560  -32
> >   hook_file_open               352  320  -32
> >   hook_file_send_sigiotask     176  160  -16
> >   hook_file_truncate           112  96   -16
> >   hook_move_mount              128  112  -16
> >   hook_ptrace_access_check     192  176  -16
> >   hook_ptrace_traceme          160  144  -16
> >   hook_sb_mount                128  112  -16
> >   hook_sb_pivotroot            128  112  -16
> >   hook_sb_remount              128  112  -16
> >   hook_sb_umount               128  112  -16
> >   hook_task_kill               176  160  -16
> >   current_check_access_socket  336  352  +16
> >   is_access_to_paths_allowed   384  400  +16
> > 
> > ...and stack usage delta without audit:
> > 
> >   landlock_unmask_layers       208  80   -128
> >   landlock_init_layer_masks    192  96   -96
> >   hook_file_open               208  192  -16
> >   current_check_access_socket  176  208  +32
> 
> These stack usage measurement look as expected.  With the current set
> of 16 FS access rights, the matrix for the FS case is 16x16 bits (32
> bytes), both in the old code and after the refactoring.
> 
> The differences we see above are therefore not savings in the data
> structure itself, but due to the code simplifications in surrounding
> functions where we now need fewer function parameters and local
> variables.
> 
> > However, when we'll add the next access right, access_mask_t will be u32
> > instead of u16, and stack usage delta will increase:
> > 
> >   current_check_access_socket  352  384  +32
> >   hook_file_open               320  352  +32
> >   current_check_access_path    304  352  +48
> >   current_check_refer_path     560  608  +48
> >   is_access_to_paths_allowed   400  464  +64
> 
> The data structure grows by 32 bytes, and access_mask_t grows by 2
> bytes (but is as local variable probably aligned to 64 bit boundary).
> These functions all have the layer masks as local variables, so it is
> expected that they grow.

Yes, but we should keep in mind that this grows for all type of access
rights: even if there is no new network access right, the cost will now
be the same for FS and network access checks, which was not the case
before (on purpose).

> 
> > 
> > Even if the cumulative stack usage delta seems reasonable, the commit
> > message should talk about these drawbacks.
> > 
> > I think the improved compiled code, and the overall simplification are
> > worth it.
> 
> You are right, the 17th access right will change it somewhat and I
> should add something to the commit message to explain my reasoning why
> this is OK.
> 
> Abstractly speaking, we have a matrix with 1 bit per layer and access
> right.  I illustrate below how this looks, it feels a bit simpler than
> explaining it in words.  (I am marking the access right / layer
> combinations with an "x" which are both an actual FS access right and
> which are in the first layer - assuming that this is our most common
> case.)
> 
> In the old way of representing that matrix, we are using a fixed 16
> bits to represent the set of layers where an access right is still
> needed (wasting 15/16 bits in the common case where only one layer is
> active), but we store the right number of access rights.  Because this
> representation was not using access_mask_t, the functions using it
> required more loops and conditionals.
> 
>                       layers
>                  fedcba98 76543210
>         access0  ________ _______x
>         access1  ________ _______x
>         access2  ________ _______x
>         access3  ________ _______x
>         access4  ________ _______x
>         access5  ________ _______x
>         access6  ________ _______x
>         access7  ________ _______x
>         access8  ________ _______x
>         access9  ________ _______x
>         accessa  ________ _______x
>         accessb  ________ _______x
>         accessc  ________ _______x
>         accessd  ________ _______x
>         accesse  ________ _______x
>         accessf  ________ _______x
> 
> In the new way of representing that matrix, we are using a fixed 16
> (soon 32) bits for the access rights (wasting 0 (soon 15) bits for FS
> access rights).  We also use a fixed number of layers (but this now
> becomes tractable to change).  We get simplified code and improved
> performance.
> 
>                    access rights
>                  fedcba98 76543210
>          layer0  xxxxxxxx xxxxxxxx
>          layer1  ________ ________
>          layer2  ________ ________
>          layer3  ________ ________
>          layer4  ________ ________
>          layer5  ________ ________
>          layer6  ________ ________
>          layer7  ________ ________
>          layer8  ________ ________
>          layer9  ________ ________
>          layera  ________ ________
>          layerb  ________ ________
>          layerc  ________ ________
>          layerd  ________ ________
>          layere  ________ ________
>          layerf  ________ ________
> 
> Once we introduce the 17th FS access right, the matrix will use a
> total of 64 instead of 32 bytes and look like this:
> 
>                             access rights
>                  11111111 11111111 00000000 00000000
>                  fedcba98 76543210 fedcba98 76543210
>          layer0  ________ _______x xxxxxxxx xxxxxxxx
>          layer1  ________ ________ ________ ________
>          layer2  ________ ________ ________ ________
>          layer3  ________ ________ ________ ________
>          layer4  ________ ________ ________ ________
>          layer5  ________ ________ ________ ________
>          layer6  ________ ________ ________ ________
>          layer7  ________ ________ ________ ________
>          layer8  ________ ________ ________ ________
>          layer9  ________ ________ ________ ________
>          layera  ________ ________ ________ ________
>          layerb  ________ ________ ________ ________
>          layerc  ________ ________ ________ ________
>          layerd  ________ ________ ________ ________
>          layere  ________ ________ ________ ________
>          layerf  ________ ________ ________ ________
> 
> 
> In my mind, it is a tradeoff where we get slightly better performance
> and simpler code at the cost of a slightly increased stack space.  But
> in my understanding, as long as we stay below the stack size limit,
> this should be acceptable.  (Also, this is only 64 bytes extra, the
> risk of exeeding stack space because of it seems low.)
> 
> 
> (P.S. A thing that we can try as a follow-up is:
> 
> Now that this is an array indexed by layer, it becomes easier to only
> look at the layers that are actually active.  In the common case,
> that means that we would be able to skip looking at these layers,
> and we might be able to save a few memory accesses.
> 
> Although, I am not sure it will improve performance - we should
> better measure the performance impact carefully; the matrix still fits
> in two cache lines.  It might not make a big difference how many of
> the adjacent layers we access, and it could be offset by having to
> pass the number of layers around and by loop unrolling tricks that the
> compiler can't use any more.)
> 
> 
> > On Tue, Dec 30, 2025 at 11:39:21AM +0100, Günther Noack wrote:
> > > The layer masks data structure tracks the requested but unfulfilled
> > > access rights during an operations security check.  It stores one bit
> > 
> > operation?
> 
> I missed the apostrophe: "operation's"
> 
> 
> > > for each combination of access right and layer index.  If the bit is
> > > set, that access right is not granted (yet) in the given layer and we
> > > have to traverse the path further upwards to grant it.
> 
> 
> > >  static size_t get_denied_layer(const struct landlock_ruleset *const domain,
> > >  			       access_mask_t *const access_request,
> > > -			       const layer_mask_t (*const layer_masks)[],
> > > -			       const size_t layer_masks_size)
> > > +			       const struct layer_access_masks *masks)
> > >  {
> > > -	const unsigned long access_req = *access_request;
> > > -	unsigned long access_bit;
> > > -	access_mask_t missing = 0;
> > > -	long youngest_layer = -1;
> > > -
> > > -	for_each_set_bit(access_bit, &access_req, layer_masks_size) {
> > > -		const access_mask_t mask = (*layer_masks)[access_bit];
> > > -		long layer;
> > > -
> > > -		if (!mask)
> > > -			continue;
> > > -
> > > -		/* __fls(1) == 0 */
> > > -		layer = __fls(mask);
> > > -		if (layer > youngest_layer) {
> > > -			youngest_layer = layer;
> > > -			missing = BIT(access_bit);
> > > -		} else if (layer == youngest_layer) {
> > > -			missing |= BIT(access_bit);
> > > +	for (int i = LANDLOCK_MAX_NUM_LAYERS - 1; i >= 0; i--) {
> > 
> > All the loop indexes should be size_t (same as before).
> > 
> > Instead of LANDLOCK_MAX_NUM_LAYERS, ARRAY_SIZE(masks->access) would be
> > better.
> 
> Done, will be fixed in next patch set version.
> 
> (I have also fixed all the other places where I could have used size_t
> and ARRAY_SIZE().  Omitting them from this email for brevity, but I
> looked at them all.)
> 
> (Remark on the side, I like being able to define the loop variable in
> the for loop, but I notice that we have not done that much so far. I
> assume this is OK?)

I think it is (was?) not in the guideline, but as long as checkpatch.pl
doesn't complain, it looks good to me.  I guess it's officially OK since
C11.

> 
> > > +		if (masks->access[i] & *access_request) {
> > > +			*access_request &= masks->access[i];
> > > +			return i;
> 
> 
> > > -static size_t
> > > -get_layer_from_deny_masks(access_mask_t *const access_request,
> > > -			  const access_mask_t all_existing_optional_access,
> > > -			  const deny_masks_t deny_masks)
> > > +/*
> > > + * get_layer_from_fs_deny_masks - get the layer which denied the access request
> > > + *
> > > + * As a side effect, stores the denied access rights from that layer(!) in
> > > + * *access_request.
> > > + */
> > > +static size_t get_layer_from_fs_deny_masks(access_mask_t *const access_request,
> > > +					   const deny_masks_t deny_masks)
> > 
> > I'm not a fan of this change.  We come from a generic approach to a
> > specific and hardcoded one.  This is simpler *for now*, but could we get
> > a better implementation?
> > 
> > Anyway, please create at least a dedicated patch for the
> > non-transposition changes.
> 
> OK, I'll have a look into decoupling these aspects of the change.
> (Not coded yet, but it's doable and would be cleaner for the patch
> organization.)
> 
> 
> > >  {
> > > -	const unsigned long access_opt = all_existing_optional_access;
> > > -	const unsigned long access_req = *access_request;
> > > -	access_mask_t missing = 0;
> > > +	const access_mask_t access_req = *access_request;
> > >  	size_t youngest_layer = 0;
> > > -	size_t access_index = 0;
> > > -	unsigned long access_bit;
> > > +	access_mask_t missing = 0;
> > >  
> > > -	/* This will require change with new object types. */
> > > -	WARN_ON_ONCE(access_opt != _LANDLOCK_ACCESS_FS_OPTIONAL);
> > > +	WARN_ON_ONCE((access_req | _LANDLOCK_ACCESS_FS_OPTIONAL) !=
> > > +		     _LANDLOCK_ACCESS_FS_OPTIONAL);
> > >  
> > > -	for_each_set_bit(access_bit, &access_opt,
