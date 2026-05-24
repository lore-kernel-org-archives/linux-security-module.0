Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0CD2D29C8
	for <linux-security-module@vger.kernel.org>; Sun, 24 May 2026 22:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779660485; cv=none; b=k3LYqbHKrDsdX9ptNOz3TsW8l/AYGyntoUIoCiXYeWItHBxmbA9zu5CRXgt3S651U2OuhFKOO7NxjdPKczUavhOjD4QfCkJ3HpVr1UKa3puECce8pehCFWum7P99ETAq27e4ko/h7J46Jijx2zKU73NEFDCKGoC6Hioe2XZGwlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779660485; c=relaxed/simple;
	bh=Mt1hyu4cL45OlC6dNw86ZDwzzkjfxB1xFC2UDe5ZMi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GZ+VnctQS5W6MjxGRqqJY0MiSqKMOe4Whb3WxaCi33gbAf3gysFr+x+rFcBWEen0lSlj5GF86z2zJv/66sOpx6Qs9flNfqBb7QpvjomNpT7qYW71LDK8a1jn0WxDCDJbI867s28RuMRei3yLhhkA6+w34LvK2PDo1sfzO1WXsNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HfSjSiWu; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfSjSiWu"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7bf0b1a47b1so92068107b3.0
        for <linux-security-module@vger.kernel.org>; Sun, 24 May 2026 15:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779660482; x=1780265282; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UPP0JuofFzXrHfop/LifCrhEEiE97pap0uKG3uoqPtg=;
        b=HfSjSiWuvI66dopvJj8cDrrgZJ1+35erswRgh6nBNCOnHivSNLtf7WZvpg7b0z9sRK
         5FQVxeRtqF9EJu+4+f/mDnjVKGV95dCuDBE+vacMJqC0JO2yug7AZ7/PchFWJTVuD4Dp
         LqKckUm7wa9hgDRlpkbPOxsyIXJhzbMJQ/4Jb4F1SewsrCgQ/DHDc9VIWqRnAw783kBL
         EyJsEQ8xleefX/olf2p927XKxI2n3oJ6LtLCcZMPuyyxdeXHmw4t57IJjqB4QAqdEPT+
         lBBbqlpjuN0xEpxB9PV2yDdtoAJ1+dfTul92EIZA+cFZKQ6eG7qGysZL2+8IRqebQ4Ku
         U4UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779660482; x=1780265282;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UPP0JuofFzXrHfop/LifCrhEEiE97pap0uKG3uoqPtg=;
        b=oJ4CveZmihtm4UyMdI/eikJMBZLhSyDjNrO9pdns+i7a+c4TFMRz9lDr0To/pcddJb
         pl2mDu6TW0ICVkM8K4SJQIU07UcSweAnwYDVxKRRRfXDgpcHjcg0RgV8QiZDR51vCH+A
         CGESqSBk880Un75W3mYBmJoi5gU6Z3BAkXo420H7NJlRBdNB18/MOOGjcIkgCxO5Icl7
         CSZfjaLCM3qSR6Hwd/8OFupdJDRpqB6F2Rwz2xrsYRYxC40YGsqXUpJD6Wi3/sbT3K6M
         qR3O6esFg42Z2rMjAKmHNTg5Hzjs9cdmIvsjvAhqwPbwf06h2C5fxxaEVeDo0LmoZ5zC
         i05g==
X-Forwarded-Encrypted: i=1; AFNElJ/gANidAhnxfT3iUs7ghHPcgT9wkZQgzFXnE4HTxEy+U4pNYWJDrevDuPt/vBxYBK11jMrQiDd0EcKUVQiztQor1x3YIXA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6W1AJdzjMm3h3JpOLoKX7yG0AOUcqdVsIBTW7IFOtbmVizJS+
	F9zuRVJGNv1RvYSZ4VwqDZejGDokHYC0kMR8s+TMETrypjMi4WtxU7a7
X-Gm-Gg: Acq92OG5ZTU/Mq9CrjoC4rtEASFgn9B9coESq2cJQb6nYfr14LF4WNd8dx+NasUarRt
	vWNQWFSZwjPNjZ8qxYU89FzaShxOYvP8rmVjFxJSwA6xBdx1m2L5TbMAS9t7uZBAybAKWkEyLoM
	LYpW7aazXqu4+dee6lD9CyKJrqZP56RTyvB0vLEVX6nGCPnOnL9itK9AZacWRnS+ZzRXSl9A8Cm
	YtvelCmrBAQUk32C+x/ickQqJ6kQekR+20vpULiK0cagrU8a7DmY9AHSVGOQ7K4k01mkgdOLOYu
	FuLDq5mFFlM0VjJI7H3DcE+yBjujbYZqgl1UFjtueOJ7fbXZxiYHzpAyahbEtudXoCKF3FQWQDX
	8fVffYqdinRXmRsJ3PG1TNFtVAmuOERYhmI7NWAgh+eUqEMfag9dfMowWQcDN67mDCpae1uBDMi
	O/73mWWw+Dh0mHab6Sugb8UU3o5q6YxaaqEP2901Tn6Vd8hSJboo8Co1C/aBxgXI0i/oTF
X-Received: by 2002:a05:690c:3681:b0:7b2:7dc9:35f6 with SMTP id 00721157ae682-7d336aa7b3bmr137529517b3.45.1779660482529;
        Sun, 24 May 2026 15:08:02 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:cf18:78cf:cf2b:a481])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7d389d173eesm37968457b3.15.2026.05.24.15.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 15:08:01 -0700 (PDT)
Date: Sun, 24 May 2026 18:08:00 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: Tingmao Wang <m@maowtm.org>
Cc: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>, Jan Kara <jack@suse.cz>, Abhinav Saxena <xandfury@gmail.com>, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v8 1/9] landlock: Add a place for flags to layer rules
Message-ID: <ahNx8CNCeqhU_Ide@zenbox>
References: <cover.1775490344.git.m@maowtm.org>
 <6f418b431ccf88636ea3a1b930d14bfdcd420233.1775490344.git.m@maowtm.org>
 <20260523.Uephughee8as@digikod.net>
 <617fdd53-6612-4f6f-b0e0-16d85985487b@maowtm.org>
 <ahMLLwnDO7g64h63@zenbox>
 <42a06f7c-abb5-4f2d-8428-8d122047e8d4@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42a06f7c-abb5-4f2d-8428-8d122047e8d4@maowtm.org>

On Sun, May 24, 2026 at 07:20:19PM +0100, Tingmao Wang wrote:
> On 5/24/26 15:46, Justin Suess wrote:
> > On Sun, May 24, 2026 at 02:29:40AM +0100, Tingmao Wang wrote:
> >> On 5/23/26 21:48, Mickaël Salaün wrote:
> >>> [...]
> >>>> @@ -647,9 +648,14 @@ bool landlock_unmask_layers(const struct landlock_rule *const rule,
> >>>>  	 */
> >>>>  	for (size_t i = 0; i < rule->num_layers; i++) {
> >>>>  		const struct landlock_layer *const layer = &rule->layers[i];
> >>>> +		const layer_mask_t layer_bit = BIT_ULL(layer->level - 1);
> >>>>  
> >>>
> >>>>  		/* Clear the bits where the layer in the rule grants access. */
> >>>>  		masks->access[layer->level - 1] &= ~layer->access;
> >>>> +
> >>>> +		/* Collect rule flags for each layer. */
> >>>> +		if (rule_flags && layer->flags.quiet)
> >>>> +			rule_flags->quiet_masks |= layer_bit;
> >>>
> >>> Why not store the quiet bit in masks?  That would not only be "access"
> >>> bits anymore but it makes sense to store all this bits it the same
> >>> place.
> >>>
> >>> We should then probably rename struct layer_access_masks to just struct
> >>> layer_masks.
> >>>
> >>> We need to be careful to not increase too much the size of this struct
> >>> though while keeping the [LANDLOCK_MAX_NUM_LAYERS] approach if possible
> >>> (see Günther's commit that added it).
> >>
> >> Most uses of struct layer_access_masks do not actually care about the rule
> >> flags tho, e.g. in unmask_scoped_access, scope_to_request, or may_refer.
> >> Such a rename would touch 31 places (and only a few of them would actually
> >> touch the quiet flag).
> >>
> >> If we want to refactor to make this be in the layer_access_masks (then
> >> rename it), I guess there are 3 options, which do you prefer?
> >>
> >> 1. Add a u16 bitfield for which layers are quieted.  Future rule flags
> >>    will be additional bitfields.  struct layer_masks becomes 68 bytes (+4).
> >>
> >> struct layer_masks {
> >> 	access_mask_t access[LANDLOCK_MAX_NUM_LAYERS];
> >> 	layer_mask_t quiet_layers;
> >> };
> >>
> >> 2. Make the [LANDLOCK_MAX_NUM_LAYERS] array store both the access mask and
> >>    the quiet bit (or more bits for future rule flags).  Size of struct stays
> >>    the same.
> >>
> > This approach seems best.
> >> static_assert(LANDLOCK_NUM_ACCESS_NET <= LANDLOCK_NUM_ACCESS_FS);
> >> static_assert(LANDLOCK_NUM_SCOPE <= LANDLOCK_NUM_ACCESS_FS);
> >> struct layer_mask {
> >> 	access_mask_t access:LANDLOCK_NUM_ACCESS_FS;
> >> 	bool quiet:1;
> >> };
> > 
> > Other way to do it could be an (anonymous?) union.
> > 
> > union {
> >   access_mask_t fs_access:LANDLOCK_NUM_ACCESS_FS;
> >   access_mask_t net_access:LANDLOCK_NUM_ACCESS_NET;
> >   access_mask_t scope_access:LANDLOCK_NUM_SCOPE;
> > }
> > 
> > The union should be sized to fit the largest field automatically.
> > 
> > That way you don't have to change this when adding new access rights
> > and avoid the brittle static_asserts.
> > 
> > Not sure about the alignment implications here though.
> 
> Unfortunately this forces struct layer_mask to be 2x as large:
> https://godbolt.org/z/5P9b4rrMW
> 
Yeah I guess the compiler can't pack the fields with differing types.

*In theory* you could make everything a _BitInt or something but it
seems better to do what you had below.
> But it turns out I could have just used MAX, seems to compile for me:
> 
> struct layer_mask {
> 	access_mask_t access
> 		: MAX(LANDLOCK_NUM_ACCESS_FS,
> 		      MAX(LANDLOCK_NUM_ACCESS_NET, LANDLOCK_NUM_SCOPE));
> 	bool quiet : 1;
> };
This works perfectly.

Mickaël's suggestion (except w/ all three access right classes like
you have here, think he missed LANDLOCK_NUM_SCOPE) is very close
to this.
> struct layer_masks {
> 	struct layer_mask layer[LANDLOCK_MAX_NUM_LAYERS];
> };
> 
> Maybe we could #define LANDLOCK_NUM_ACCESS_MAX to be MAX(...) then use it
> here.
> 
> I'm still not sure if putting the collected rule flags in struct
> layer_(access_)masks is a good idea tho.  Passing a separate struct
> collected_rule_flags to the functions that needs to deal with rule flags
> (quiet, and later, no inherit / has no inherit descendant) seems quite
> practical to me.

(Not sure how stingy we gotta be with stack space)

There's a *slight* stack space advantage to keeping them together.

If you pass by value, (separate layer_access_masks, collected_rule_flags),
those structs must be individually padded and aligned. Which may or may not
make a difference, it's dependent on alignment and architecture.

Whereas if we keep them all together, we only pad once.

If you pass by pointer, you have to allocate stack space for each
pointer, so passing it all at once saves sizeof(collected_rule_flags*)
bytes in the pass by pointer case.

Either way it's probably a couple bytes at worst, so probably nothing to
worry about.

The more compelling argument is that we don't know how future paths
will use rule flags, so keeping it all together reduces churn later
if a function ends up needing to access flags. Moreover, it makes those
messy function signatures in fs.h/c a little less hairy, and easy to
refactor later.

