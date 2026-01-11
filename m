Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBB71F30A4
	for <linux-security-module@vger.kernel.org>; Sun, 11 Jan 2026 20:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768164674; cv=none; b=gRmuH9jIR8Sb9wNPwwpRHjsuHL4If/56OWPoFS00wR9LyEE9jm2Uf1aM8VjgqzSp92uWOa//BsJAhGnlIJ8kv9+JqvuRZUSuVXgDqh0qYsBrJ87+J/sZHygLWFkx3uEJt3eUQzlVtMFGXREX7bgDjfwamREailk/1L4WYFp6iWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768164674; c=relaxed/simple;
	bh=DkPkTlL2l44AjExSTbcv7sBVgwUYqOKg/Kgy1mB1yqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FGqLa9ne7AgY857S+T7+Q6PlzmmEbTP+CmxuE02b8iwMPSuesU8wrUwuBdguhxrJ6XYzKsG1kkPoXXl4vnnbDEsJ9vj18zU33CudnRtlJ1oS3ssLtrOJVyhSxlzc11/AjXUSjLPXXu46CyYhPkJJSgPM4soa/OL4jD6qGmcg4SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jqu5MFGm; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqu5MFGm"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b8722834679so7984466b.0
        for <linux-security-module@vger.kernel.org>; Sun, 11 Jan 2026 12:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768164671; x=1768769471; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BwYuM9Rpca+b6K2WV8sICcXpeDHfxJW23A2tVTkLv9A=;
        b=jqu5MFGmPe8QJyLKHgfLXUk7eMUlFx62dHwSecQfmIbWyHwofLZVpgI6z2xtYtaKSy
         RPkFptYGuDtR2XH9TSxynvtmiT2FsMxNAyR5HDlS/ydx1C9phBY6ilAo7IZBLKOXz00K
         Mpxa/5P6OxbVA53k5x8d/wj3oCwh0law5t6zykuT6t79jd4CEoRDebSeAMYrUUi8Lcr5
         eSgl40ju13XFD/akrhRqpyzyCSCJlrS/UMmefj2U/m0t5twGCMDG5WV9pOwvqRGtlKHl
         V4CsHVArncmgQT5Jd2fw8kgjE/WybcNaNYPwLuHwETzm2GpBxkpsZSfHpHUMO9W3VKiV
         Zd1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768164671; x=1768769471;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BwYuM9Rpca+b6K2WV8sICcXpeDHfxJW23A2tVTkLv9A=;
        b=i/CB2FjPykBHHf4PVfZO8EzUAlO2Jy2bbhuQE/6vEOI/bsiqxWNudmsEwuxcUCkH5N
         fvF8GB9/Ppi03bcdMwYKuOsukrydwuFrLPPjhK5PzL8Jk24kJc90NAROFN5weHei8HDK
         F5yy/z6h1qUTM53bQHeRN8GGeLxcUevJaHAksSbEQZ7YMXpkK+h0UYpEjuDY/e1PdYSh
         gz4a+LeoSPKhlpGIMSqlwbvV38sv1U75YgLenrIWVeQNiawe+LOssPkRlUc6MRZv2Bee
         qs5AQoOeBEQLnUzXenDzNrE7kR0qhr6lTu8x7RNQtVfCQQyGPdcj1sFpQDC+EbKcdE+I
         7buA==
X-Gm-Message-State: AOJu0YxMZHhf5WaVB9sn0t14guckrt6ScFy6CiRhPWnLCsHlGvv9TmrZ
	E80fD+PRHbD3zLWTd744Bnsfx58aQdQV3exUYnWeD1ocDF/Tw0bmeyht
X-Gm-Gg: AY/fxX7VNwwrQnk20+8qZeh6nN0gvGWJK9YQ0U2E325HKPSaf0pzdwKZ7abjo0HDQQm
	EWOQ08Qt40oybA/JRzZ+9C+r3+QaY9Jq74JTfjLkttdvYzawUVaD06kC1afQERMZge04/7ZX8ZT
	+Q2FYuvYT/p0a0TRIsJ5seQexaKo1Z8TCJpigE5carsYBATAO0aTnrIaKNmJVbNov5QzKGquSEJ
	CP4Q7LzZlk+D3B9L0wTLyzOL4HCKeffrtnURQNkTLYnyoOtymAktgJHCZ/Y8olpr7tg+IfH3SQl
	tKKk3KwXTBDyTkJRD63YAT3thop5KyosqoqFui7mKzRoh8Mi7+XzZEchYhk2toN4UB3PU2tFrZp
	FVzHmOEskDb7OmJuifYWYF/ZIc5UMepZvXMFV9cq65CNQiXAvpTCmmn22c6XsUy3ZTfAYbbV4ju
	E8DCjwIRDpz/wxlkpVbEcfLWUBKLmE2UnSZajN
X-Google-Smtp-Source: AGHT+IHiU7o3C91CAfKQtSsAWN5LHvYFzZCJuSmX1C5ur0sVnPtlmT1GnvHACj46wV48CdNEChjNPg==
X-Received: by 2002:a17:906:fe0d:b0:b84:42e5:2b7e with SMTP id a640c23a62f3a-b84453698cemr1499937266b.51.1768164670839;
        Sun, 11 Jan 2026 12:51:10 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b86fc303d7esm469533666b.2.2026.01.11.12.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 12:51:10 -0800 (PST)
Date: Sun, 11 Jan 2026 21:51:00 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>,
	Justin Suess <utilityemal77@gmail.com>,
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com
Subject: Re: [RFC PATCH 2/2] landlock: transpose the layer masks data
 structure
Message-ID: <20260111.7061e63f42f6@gnoack.org>
References: <20251230103917.10549-3-gnoack3000@gmail.com>
 <20251230103917.10549-7-gnoack3000@gmail.com>
 <20260109.hie6Teis2ha9@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260109.hie6Teis2ha9@digikod.net>

On Fri, Jan 09, 2026 at 05:18:43PM +0100, Mickaël Salaün wrote:
> This looks good overall but I need to spend more time reviewing it.
> 
> Because this changes may impact other ongoing patch series, I think I'll
> take this patch first to ease potential future fix backports.
> 
> On Tue, Dec 30, 2025 at 11:39:21AM +0100, Günther Noack wrote:
> > The layer masks data structure tracks the requested but unfulfilled
> > access rights during an operations security check.  It stores one bit
> > for each combination of access right and layer index.  If the bit is
> > set, that access right is not granted (yet) in the given layer and we
> > have to traverse the path further upwards to grant it.
> > 
> > Previously, the layer masks were stored as arrays mapping from access
> > right indices to layer_mask_t.  The layer_mask_t value then indicates
> > all layers in which the given access right is still (tentatively)
> > denied.
> > 
> > This patch introduces struct layer_access_masks instead: This struct
> > contains an array with the access_mask_t of each (tentatively) denied
> > access right in that layer.
> > 
> > The hypothesis of this patch is that this simplifies the code enough
> > so that the resulting code will run faster:
> > 
> > * We can use bitwise operations in multiple places where we previously
> >   looped over bits individually with macros.  (Should require less
> >   branch speculation)
> > 
> > * Code is ~160 lines smaller.
> 
> What about the KUnit test lines?

Those are counted as well. The 160 lines statistic is directly from
the diffstat in the cover letter.

(I removed the test_get_layer_deny_mask KUnit test, because the
function under test was also not needed any more. Other than that, the
KUnit tests are just adapted to test the equivalent logic with the new
data structure.)


> > Other noteworthy changes:
> > 
> > * Clarify deny_mask_t and the code assembling it.
> >   * Document what that value looks like
> >   * Make writing and reading functions specific to file system rules.
> >     (It only worked for FS rules before as well, but going all the way
> >     simplifies the code logic more.)
> > * In no_more_access(), call a new helper function may_refer(), which
> >   only solves the asymmetric case.  Previously, the code interleaved
> >   the checks for the two symmetric cases in RENAME_EXCHANGE.  It feels
> >   that the code is clearer when renames without RENAME_EXCHANGE are
> >   more obviously the normal case.
> 
> It would be interesting to check the stackframe diff.  You can use
> scripts/stackdelta for that, see
> https://git.kernel.org/mic/c/602acfb541195eb35584d7a3fc7d1db676f059bd

Acknowledged.  I did not get around to it yet, but put it on my todo
list.


> > Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> > ---
> >  security/landlock/access.h  |  10 +-
> >  security/landlock/audit.c   | 155 ++++++----------
> >  security/landlock/audit.h   |   3 +-
> >  security/landlock/domain.c  | 120 +++----------
> >  security/landlock/domain.h  |   6 +-
> >  security/landlock/fs.c      | 350 ++++++++++++++++--------------------
> >  security/landlock/net.c     |  10 +-
> >  security/landlock/ruleset.c |  78 +++-----
> >  security/landlock/ruleset.h |  18 +-
> >  9 files changed, 290 insertions(+), 460 deletions(-)

460 - 290 is 170.  Well, almost 160. :)


> > diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
> > index dfcdc19ea2683..d20e28d38e9c9 100644
> > --- a/security/landlock/ruleset.c
> > +++ b/security/landlock/ruleset.c
> > @@ -622,49 +622,24 @@ landlock_find_rule(const struct landlock_ruleset *const ruleset,
> >   * request are empty).
> >   */
> >  bool landlock_unmask_layers(const struct landlock_rule *const rule,
> > -			    const access_mask_t access_request,
> > -			    layer_mask_t (*const layer_masks)[],
> > -			    const size_t masks_array_size)
> > +			    struct layer_access_masks *masks)
> >  {
> > -	size_t layer_level;
> > -
> > -	if (!access_request || !layer_masks)
> > +	if (!masks)
> >  		return true;
> >  	if (!rule)
> >  		return false;
> >  
> > -	/*
> > -	 * An access is granted if, for each policy layer, at least one rule
> > -	 * encountered on the pathwalk grants the requested access,
> > -	 * regardless of its position in the layer stack.  We must then check
> > -	 * the remaining layers for each inode, from the first added layer to
> > -	 * the last one.  When there is multiple requested accesses, for each
> > -	 * policy layer, the full set of requested accesses may not be granted
> > -	 * by only one rule, but by the union (binary OR) of multiple rules.
> > -	 * E.g. /a/b <execute> + /a <read> => /a/b <execute + read>
> > -	 */
> 
> Why removing this comment?

I did not understand why the comment was discussing this higher level
picture when the surrounding function landlock_unmask_layers() is only
concerned with a single rule.  Should this comment be better moved
elsewhere?

I don't feel strongly about it and re-reading it, the comment is still
true.  In doubt, I can also just put it back into the same function
again.  Let me know what you prefer.


> > -	for (layer_level = 0; layer_level < rule->num_layers; layer_level++) {
> > -		const struct landlock_layer *const layer =
> > -			&rule->layers[layer_level];
> > -		const layer_mask_t layer_bit = BIT_ULL(layer->level - 1);
> > -		const unsigned long access_req = access_request;
> > -		unsigned long access_bit;
> > -		bool is_empty;
> > +	for (int i = 0; i < rule->num_layers; i++) {
> > +		const struct landlock_layer *l = &rule->layers[i];
> >  
> > -		/*
> > -		 * Records in @layer_masks which layer grants access to each requested
> > -		 * access: bit cleared if the related layer grants access.
> > -		 */
> > -		is_empty = true;
> > -		for_each_set_bit(access_bit, &access_req, masks_array_size) {
> > -			if (layer->access & BIT_ULL(access_bit))
> > -				(*layer_masks)[access_bit] &= ~layer_bit;
> > -			is_empty = is_empty && !(*layer_masks)[access_bit];
> > -		}
> > -		if (is_empty)
> > -			return true;
> > +		masks->access[l->level - 1] &= ~l->access;
> >  	}
> > -	return false;
> > +
> > +	for (int i = 0; i < LANDLOCK_MAX_NUM_LAYERS; i++) {
> > +		if (masks->access[i])
> > +			return false;
> > +	}
> > +	return true;
> >  }
> >  
> >  typedef access_mask_t

–Günther
