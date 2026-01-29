Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AC1371061
	for <linux-security-module@vger.kernel.org>; Thu, 29 Jan 2026 07:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769673406; cv=none; b=WCZ8eAMeeKiKQCcsKy6DfhGt/zy7qb1+DB4waU63Usmk/vwN+AgxKmrsCE2LC4p9BXsz6GnRIcjFsajBXSk2xV33SWI7YWa3tlU55vvbT7LD4TLTG2C7ROcsF3CvBRyHtQu1hjS5O64XDbMjKrlNFBlcszSy6sa7RTNtqkJ0SKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769673406; c=relaxed/simple;
	bh=N1k5Pgsor/7m83SDkTM9dDzLaVd5tMo0jzbWQ+RTtqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FZ/CtWI+nJ78QfUBG9zSB94PypyXoCBtTXuWNhJun1MX3a7MD/YiKAha5/t2dCMZcnuv+CARPmTgVX4PPzk3zulL0XYYEAUgBawEq/WCQWQ6uVvIrYFL2lNEndEjQNqnk7CSNRsX8bOHACDQLnMXmIDs6VMt52ZCElSr2z9R3dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Phee7q9+; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Phee7q9+"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47f5c2283b6so5020105e9.1
        for <linux-security-module@vger.kernel.org>; Wed, 28 Jan 2026 23:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769673403; x=1770278203; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j178g8zVMYE+jI/MB2yCSraVRg88oiFctZr49sf8QO4=;
        b=Phee7q9+NYP1Vxm1OuorV4r91JHuE4Km8Gw+BH7jXmzAj6ZEKMEB9li479mz5D0Tlg
         ppMIZygzW50caSnmlBMV6oTS3AAlBuFrwRmpV59ECIO/vFA0EulhQJaVwhNIVPF0rXJU
         Y7o9IJcmd/NTZoGFoacAzmxVMlUMfsZQx1+MDCdDGNtmyl4yXdvB/Uh8CzadgwYp7kKu
         eNRDUFcPKt8gksnDmiD5TrIL2vHUNwh+VHWnKd7uDLtsTVJzE2KT7+WC64nvIhDhfy48
         S7vG/bdVZsciibkFWBWnYIk6YELOkDIRqlYCAWqLAmNNBN5rPgrzRe63iJNO4DEPiXO/
         Sq/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769673403; x=1770278203;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j178g8zVMYE+jI/MB2yCSraVRg88oiFctZr49sf8QO4=;
        b=m3z39zcseJMj5K6w5g0HXQE0c+ySqWk02h3qihsadUFxdpoxWqEFqeNadqKkPx/nG1
         Kps5hxHT73wBpkmQNYWpb3scDgy9g0AUEfUSgBL7DE6GMdBj+jWKbDjgVD7ewpRSh0iC
         02eeWzaSqZzVYkafW7iVuSV3zHu73FUHeVMp2LsUCOOFNxCRXhrklsUU72NK1UeQ8pYU
         0IrzxKrDqD/GSe2BWM0mA/G5DJc3ndqB7C0d9/TozDKMy9/+Qy9v4oHOI8dQhzdjl+DU
         8nkKrF8E++0n0HCjQOP9PxS5ykBlJgf2AmPzTL/IYtZfjAY8ohXqWRSM+Ujg0U5UH2Mp
         190Q==
X-Gm-Message-State: AOJu0YyBOVSYiWdHd/xGmqIGyZeFYqOWF94Ikhqaq8YTZR7ZQFQONTvM
	E1R3chXVPzdSMdlgp8nFvps92B4x2f+ShQYUw5lM+PHpH+I88Dehk38J
X-Gm-Gg: AZuq6aLLH7Th6/v94/BtRAtyQOfccjVJcU3car1G2o9HrY5Q3HrkQOmHr7xiuPVWGoC
	kiPdXWZIerfJswpYxao3wuOV8lC4C2cO2a/WEFCdsa2sCJpKKkelFO6t93JcDtuT1U0jHOhsvll
	NFVQ3t94zvjZLy08DJTVNQRmfduKCX2VRDuo4F3Ly4nYQZOoeI3sRFh4sqDhxQsj1t7z840Fc1H
	RVF+6d55sfV6HalrQTtaLSO4PnlLGExaGkYHGBhyqbGklopRte9dBXCRw91mr7aRAhz/xMRb0is
	xMxWbyd6CGUypfCBPQCExL196R0CB28SAURaCARmxOxXgJOOP9Lr+xo9FYPFK/5mggKWlF8mDRo
	bY+XGZxJDnQkO4+Ts7+QLtfbNcKaxLIRrbWJULoR9cum1yG0ROA2Zu2p1GHSGN5CA37Nld7EVCS
	XCYZpCTuzTk8u+j5dBxrGinu06ZHoarX3v/wks
X-Received: by 2002:a05:600c:4f95:b0:477:af8d:203a with SMTP id 5b1f17b1804b1-48069c66b3bmr95134225e9.27.1769673403097;
        Wed, 28 Jan 2026 23:56:43 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e132368csm11568529f8f.31.2026.01.28.23.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 23:56:42 -0800 (PST)
Date: Thu, 29 Jan 2026 08:56:37 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>,
	Justin Suess <utilityemal77@gmail.com>,
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2 3/3] landlock: transpose the layer masks data structure
Message-ID: <20260129.691d9b85a887@gnoack.org>
References: <20260125195853.109967-1-gnoack3000@gmail.com>
 <20260125195853.109967-4-gnoack3000@gmail.com>
 <20260128.quaido7ia0Xu@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260128.quaido7ia0Xu@digikod.net>

On Wed, Jan 28, 2026 at 10:34:02PM +0100, Mickaël Salaün wrote:
> On Sun, Jan 25, 2026 at 08:58:53PM +0100, Günther Noack wrote:
> > Tradeoffs:
> > 
> > This change improves performance, at a slight size increase to the
> > layer masks data structure.
> > 
> > At the moment, for the filesystem access rights, the data structure
> > has the same size as before, but once we introduce the 17th filesystem
> > access right, it will double in size (from 32 to 64 bytes), as
> 
> ...for all access rights (e.g. even if there is no new network one)

Added.

> > --- a/security/landlock/audit.c
> > +++ b/security/landlock/audit.c
> > @@ -180,38 +180,21 @@ static void test_get_hierarchy(struct kunit *const test)
> >  
> >  #endif /* CONFIG_SECURITY_LANDLOCK_KUNIT_TEST */
> >  
> > +/* get_denied_layer - get the youngest layer that denied the access_request */
> 
> /* Get the youngest layer that denied the access_request. */

OK, done.  I also changed to non-docstring style for the
access_mask_subset() helper.

> 
> >  static size_t get_denied_layer(const struct landlock_ruleset *const domain,
> >  			       access_mask_t *const access_request,
> > -			       const layer_mask_t (*const layer_masks)[],
> > -			       const size_t layer_masks_size)
> > +			       const struct layer_access_masks *masks)
> >  {
> > -	const unsigned long access_req = *access_request;
> > -	unsigned long access_bit;
> > -	access_mask_t missing = 0;
> > -	long youngest_layer = -1;
> > -
> > -	for_each_set_bit(access_bit, &access_req, layer_masks_size) {
> > -		const layer_mask_t mask = (*layer_masks)[access_bit];
> > -		long layer;
> > -
> > -		if (!mask)
> > -			continue;
> > -
> > -		/* __fls(1) == 0 */
> > -		layer = __fls(mask);
> > -		if (layer > youngest_layer) {
> > -			youngest_layer = layer;
> > -			missing = BIT(access_bit);
> > -		} else if (layer == youngest_layer) {
> > -			missing |= BIT(access_bit);
> > +	for (int i = ARRAY_SIZE(masks->access) - 1; i >= 0; i--) {
> 
> size_t i

This is one of the two places where this didn't work.

The loop goes from top to bottom here, and the "i >= 0" check would
always be true for a size_t.

If there is a more idiomatic way to write that loop, I can switch to
it, but would otherwise lean towards keeping it as it is?


> > +		if (masks->access[i] & *access_request) {
> > +			*access_request &= masks->access[i];
> > +			return i;
> >  		}
> >  	}
> >  
> > -	for_each_set_bit(access_bit, &access_opt, layer_masks_size) {
> > -		const layer_mask_t mask = (*layer_masks)[access_bit];
> > +	for (int i = ARRAY_SIZE(masks->access) - 1; i >= 0; i--) {
> 
> size_t i

Ditto, the loop goes from top to bottom here.


> > +		const access_mask_t denied = masks->access[i] & optional_access;
> > +		const unsigned long newly_denied = denied & ~all_denied;
> >  


> > -static bool
> > -scope_to_request(const access_mask_t access_request,
> > -		 layer_mask_t (*const layer_masks)[LANDLOCK_NUM_ACCESS_FS])
> > +static bool scope_to_request(const access_mask_t access_request,
> > +			     struct layer_access_masks *masks)
> >  {
> > -	const unsigned long access_req = access_request;
> > -	unsigned long access_bit;
> > +	bool saw_unfulfilled_access = false;
> >  
> > -	if (WARN_ON_ONCE(!layer_masks))
> > +	if (WARN_ON_ONCE(!masks))
> >  		return true;
> >  
> > -	for_each_clear_bit(access_bit, &access_req, ARRAY_SIZE(*layer_masks))
> > -		(*layer_masks)[access_bit] = 0;
> > -
> > -	return is_layer_masks_allowed(layer_masks);
> > +	for (size_t i = 0; i < ARRAY_SIZE(masks->access); i++) {
> > +		masks->access[i] &= access_request;
> > +		if (masks->access[i])
> 
> {
> 
> > +			saw_unfulfilled_access = true;
> 
> break;
> }

Two lines above, this loop mutates masks->access[...]:

  masks->access[i] &= access_request

If we break the loop early, we would not actually scope it down to the
request entirely?  Is this safe?

> > +	}
> > +	return !saw_unfulfilled_access;
> >  }

–Günther
