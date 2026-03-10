Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch [84.16.66.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D617536EAA5
	for <linux-security-module@vger.kernel.org>; Tue, 10 Mar 2026 17:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773162798; cv=none; b=g0pzcOquEUm5H0+BV5e/9rqhsyHOEPajRgANL88PbKIP/633tZDPDKth6slxSgkqgldI9s9473Arnf1OUX7PRfMohwufxTlIYx3XO2YZ+IIKAkNTKDRteh5ZHrIU9lCHro3jAM/WjJ48SBGFR/tfNybbA7BLYHpAI1jic61wnug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773162798; c=relaxed/simple;
	bh=xeToOvNEwpa3A4eyTQX8PBHrK7f4R6dIRLoQCNeZiSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YbaKxLlP72zLlQ9A3gE3Xg4YCuAzFdribqjd4SoLAieInhfPQvFIMUB+D2y1YMeS93OEWBI2ZNtmcesg67QL69tdMPRegg4RJH0UXmLC6sp+CzKRHWjkpZB2amg7VYI7WHk+8aGH+9cECviDD+obSh+jkURAwKzUV7jYy31gmcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=wFP1oy6w; arc=none smtp.client-ip=84.16.66.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="wFP1oy6w"
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6b])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fVgSS5dWTzZy2;
	Tue, 10 Mar 2026 18:13:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1773162792;
	bh=ENks/O83P4rtY55sHUzGU+wZvWgmqzW/95fxIvaZgC8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wFP1oy6wr1IdegcotnvsCGgA7fEbd0FB0MuPTOCZsop1bdlY2bp1lEl2a0kFOO1av
	 mLWwR/cMrpYH2GpeQe8eweMRlFpDYyyI4ofUZoVbSEjff28EkZytODAG3YlNCXS1aP
	 W/nck3eeJmrm17GxbBA5ZPudNRBfEvTlkCZid8+E=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4fVgSS2jYTzt7k;
	Tue, 10 Mar 2026 18:13:12 +0100 (CET)
Date: Tue, 10 Mar 2026 18:13:05 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: linux-security-module@vger.kernel.org
Subject: Re: [PATCH v1 1/4] landlock: Fix kernel-doc warning for
 pointer-to-array parameters
Message-ID: <20260310.eifae9Yeiwo1@digikod.net>
References: <20260304193134.250495-1-mic@digikod.net>
 <abAaPmuYskAkubF9@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <abAaPmuYskAkubF9@google.com>
X-Infomaniak-Routing: alpha

On Tue, Mar 10, 2026 at 02:18:54PM +0100, Günther Noack wrote:
> On Wed, Mar 04, 2026 at 08:31:24PM +0100, Mickaël Salaün wrote:
> > The insert_rule() and create_rule() functions take a
> > pointer-to-flexible-array parameter declared as:
> > 
> >   const struct landlock_layer (*const layers)[]
> > 
> > The kernel-doc parser cannot handle a qualifier between * and the
> > parameter name in this syntax, producing spurious "Invalid param" and
> > "not described" warnings.
> > 
> > Introduce landlock_layer_array_t as a typedef for the flexible array
> > type so the parameter can be written as:
> > 
> >   const landlock_layer_array_t *const layers
> > 
> > This is the same type but kernel-doc parses it correctly, while
> > preserving the pointer-to-array type safety that prevents callers from
> > accidentally passing a pointer to a single element.
> > 
> > Cc: Günther Noack <gnoack@google.com>
> > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > ---
> >  security/landlock/ruleset.c | 4 ++--
> >  security/landlock/ruleset.h | 8 ++++++++
> >  2 files changed, 10 insertions(+), 2 deletions(-)
> > 
> > diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
> > index 419b237de635..a61ced492f41 100644
> > --- a/security/landlock/ruleset.c
> > +++ b/security/landlock/ruleset.c
> > @@ -108,7 +108,7 @@ static bool is_object_pointer(const enum landlock_key_type key_type)
> >  
> >  static struct landlock_rule *
> >  create_rule(const struct landlock_id id,
> > -	    const struct landlock_layer (*const layers)[], const u32 num_layers,
> > +	    const landlock_layer_array_t *const layers, const u32 num_layers,
> >  	    const struct landlock_layer *const new_layer)
> >  {
> >  	struct landlock_rule *new_rule;
> > @@ -205,7 +205,7 @@ static void build_check_ruleset(void)
> >   */
> >  static int insert_rule(struct landlock_ruleset *const ruleset,
> >  		       const struct landlock_id id,
> > -		       const struct landlock_layer (*const layers)[],
> > +		       const landlock_layer_array_t *const layers,
> >  		       const size_t num_layers)
> >  {
> >  	struct rb_node **walker_node;
> > diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
> > index 9d6dc632684c..87d52031fb5a 100644
> > --- a/security/landlock/ruleset.h
> > +++ b/security/landlock/ruleset.h
> > @@ -37,6 +37,14 @@ struct landlock_layer {
> >  	access_mask_t access;
> >  };
> >  
> > +/*
> > + * Flexible array of Landlock layers, used for pointer-to-array function
> > + * parameters that reference either a stack-allocated layer array or a rule's
> > + * flexible array member (struct landlock_rule.layers).  This typedef avoids
> > + * the complex (*const name)[] syntax that the kernel-doc parser cannot handle.
> > + */
> > +typedef struct landlock_layer landlock_layer_array_t[];
> > +
> >  /**
> >   * union landlock_key - Key of a ruleset's red-black tree
> >   */
> > -- 
> > 2.53.0
> > 
> 
> Thanks for the reminder on the other thread; I skipped over this one
> indeed. I am hesitant about this patch because it seems to be at odds
> with the Linux kernel coding style on the use of typedef:
> 
> https://www.kernel.org/doc/html/v4.17/process/coding-style.html#typedefs
> 
> It says:
> 
>     the rule should basically be to NEVER EVER use a typedef unless
>     you can clearly match one of those rules.
> 
> The rules being:
> 
>     (a) totally opaque object whose contents we want to hide
>         (I don't think that is the purpose here; the example in
> 	the style guide is to keep generic code from playing with
> 	hardware-specific page table entry structures)
>     (b) integer types (not applicable)
>     (c) when using sparse (not applicable)
>     (d) some types identical to C99 types (not applicable)
>     (e) types safe for use in userspace (not applicable)
> 
> It seems that the easier option might be to drop the "const" between
> the pointer and the type, if apparently we are the only ones doing
> this?

Yeah, this is simpler.

> 
> FWIW, I have put these consts as well to be consistent with Landlock
> style, but I am also not convinced that they buy us much;
> 
> * In a type like "const u8 *buf", when the type is part of a function
>   signature, that is a guarantee to the caller that the function won't
>   modify the buffer contents through the pointer.
> 
> * However, in a type like "u8 *const buf", the const is not a
>   guarantee to the caller, but only a constraint on the function
>   implementation that the pointer is not rewired to point elsewhere.
>   It is not clear to me that this adds much in implementation safety.

I prefer to have const variables where possible to look for changes in
patches that could then have indirect impact on initial invariants.

But for this case, I prefer to have the doc linter covering C files.

I'll send a v2 for this change only, I'll merge the other patches.

> 
> WDYT?
> 
> —Günther
> 
