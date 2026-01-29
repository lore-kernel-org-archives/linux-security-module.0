Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch [185.125.25.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F28B33123C
	for <linux-security-module@vger.kernel.org>; Thu, 29 Jan 2026 17:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769706119; cv=none; b=MRgIRYDqC00Dtwj3M0CfPH5mFFvl0XGUbFn7LvtGG3OUdHMkl20jzTiKYEMYUFEe6wfOooCQ671qOrPuc40oclEqLABloQWy8pjGf5jYSNsOKyCsBHMfbQgPZloIts+F7umbWWDITneeM821mcIU6pCfb217qWx/yJlpZxMGp5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769706119; c=relaxed/simple;
	bh=U4WyCeQChFMuy41P5A2vLBuJ/eBgLNn4T6U8NfJimFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RAWB1RCdwKcJYvUDzGVTMSWlMgMoXtY1FKLTcFCcy15EzVVyoQJcJSgiBfzz7dweTNaxCJx8WjqfN7SUy2ZJtIdDSgIJPiGVdGf7Oduc4PhXK5kxvraoVbTrYGa8EL2IHl0KCVtjZ3V+OTGgzDxZKboKDE5b/YRh2HTiuuAhVEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=NEgcZU30; arc=none smtp.client-ip=185.125.25.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="NEgcZU30"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4f24wv419Yz190g;
	Thu, 29 Jan 2026 17:54:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1769705647;
	bh=ERj3V1ipmVycRcOwGx7oB3Mac1lMmuWJmm29/NlaobM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NEgcZU3042Agzyt8YP1TjScK3IXWFYEnBPEIhVOL/ym826sS3zD9w4Sh+ab6U4IZq
	 4/IO7X/RfuIEvqbHd2lsw7kivroKMjXl/AylOTjteHGbtQxddmmUkuzsB90G9puwb7
	 3MdKas+chd55z0wYpZFS+KIEASAAdxdfsl0QgBHk=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4f24wt39SbzqlM;
	Thu, 29 Jan 2026 17:54:06 +0100 (CET)
Date: Thu, 29 Jan 2026 17:54:01 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Cc: linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>, 
	Justin Suess <utilityemal77@gmail.com>, Samasth Norway Ananda <samasth.norway.ananda@oracle.com>, 
	Matthieu Buffet <matthieu@buffet.re>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	konstantin.meskhidze@huawei.com, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2 3/3] landlock: transpose the layer masks data structure
Message-ID: <20260129.xahm6Ue7raL3@digikod.net>
References: <20260125195853.109967-1-gnoack3000@gmail.com>
 <20260125195853.109967-4-gnoack3000@gmail.com>
 <20260128.quaido7ia0Xu@digikod.net>
 <20260129.691d9b85a887@gnoack.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260129.691d9b85a887@gnoack.org>
X-Infomaniak-Routing: alpha

On Thu, Jan 29, 2026 at 08:56:37AM +0100, Günther Noack wrote:
> On Wed, Jan 28, 2026 at 10:34:02PM +0100, Mickaël Salaün wrote:
> > On Sun, Jan 25, 2026 at 08:58:53PM +0100, Günther Noack wrote:
> > > Tradeoffs:
> > > 
> > > This change improves performance, at a slight size increase to the
> > > layer masks data structure.
> > > 
> > > At the moment, for the filesystem access rights, the data structure
> > > has the same size as before, but once we introduce the 17th filesystem
> > > access right, it will double in size (from 32 to 64 bytes), as
> > 
> > ...for all access rights (e.g. even if there is no new network one)
> 
> Added.
> 
> > > --- a/security/landlock/audit.c
> > > +++ b/security/landlock/audit.c
> > > @@ -180,38 +180,21 @@ static void test_get_hierarchy(struct kunit *const test)
> > >  
> > >  #endif /* CONFIG_SECURITY_LANDLOCK_KUNIT_TEST */
> > >  
> > > +/* get_denied_layer - get the youngest layer that denied the access_request */
> > 
> > /* Get the youngest layer that denied the access_request. */
> 
> OK, done.  I also changed to non-docstring style for the
> access_mask_subset() helper.
> 
> > 
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
> > > -		const layer_mask_t mask = (*layer_masks)[access_bit];
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
> > > +	for (int i = ARRAY_SIZE(masks->access) - 1; i >= 0; i--) {
> > 
> > size_t i
> 
> This is one of the two places where this didn't work.
> 
> The loop goes from top to bottom here, and the "i >= 0" check would
> always be true for a size_t.
> 
> If there is a more idiomatic way to write that loop, I can switch to
> it, but would otherwise lean towards keeping it as it is?

Indeed.  We can use ssize_t as in get_hierarchy().

> 
> 
> > > +		if (masks->access[i] & *access_request) {
> > > +			*access_request &= masks->access[i];
> > > +			return i;
> > >  		}
> > >  	}
> > >  
> > > -	for_each_set_bit(access_bit, &access_opt, layer_masks_size) {
> > > -		const layer_mask_t mask = (*layer_masks)[access_bit];
> > > +	for (int i = ARRAY_SIZE(masks->access) - 1; i >= 0; i--) {
> > 
> > size_t i
> 
> Ditto, the loop goes from top to bottom here.
> 
> 
> > > +		const access_mask_t denied = masks->access[i] & optional_access;
> > > +		const unsigned long newly_denied = denied & ~all_denied;
> > >  
> 
> 
> > > -static bool
> > > -scope_to_request(const access_mask_t access_request,
> > > -		 layer_mask_t (*const layer_masks)[LANDLOCK_NUM_ACCESS_FS])
> > > +static bool scope_to_request(const access_mask_t access_request,
> > > +			     struct layer_access_masks *masks)
> > >  {
> > > -	const unsigned long access_req = access_request;
> > > -	unsigned long access_bit;
> > > +	bool saw_unfulfilled_access = false;
> > >  
> > > -	if (WARN_ON_ONCE(!layer_masks))
> > > +	if (WARN_ON_ONCE(!masks))
> > >  		return true;
> > >  
> > > -	for_each_clear_bit(access_bit, &access_req, ARRAY_SIZE(*layer_masks))
> > > -		(*layer_masks)[access_bit] = 0;
> > > -
> > > -	return is_layer_masks_allowed(layer_masks);
> > > +	for (size_t i = 0; i < ARRAY_SIZE(masks->access); i++) {
> > > +		masks->access[i] &= access_request;
> > > +		if (masks->access[i])
> > 
> > {
> > 
> > > +			saw_unfulfilled_access = true;
> > 
> > break;
> > }
> 
> Two lines above, this loop mutates masks->access[...]:
> 
>   masks->access[i] &= access_request
> 
> If we break the loop early, we would not actually scope it down to the
> request entirely?  Is this safe?

You're right, don't add this break.  BTW, would a test catch it?

> 
> > > +	}
> > > +	return !saw_unfulfilled_access;
> > >  }
> 
> –Günther
> 
