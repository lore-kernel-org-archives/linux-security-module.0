Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349D425B085
	for <linux-security-module@vger.kernel.org>; Sun, 24 May 2026 14:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779633968; cv=none; b=euilrtvfA1aALZMP+qtWz7w31rGac8Ac9xuEPlU5BGIEQmKrdm5j/G5rXkoBpz1o0eJAW8qI4UA761Y2FxQ17cikgl9Orf0fpjXWHDCD0imTzVOXUMNM6H8aGxL2hf2sPT4JwBIyxyaUlaYk7UxzbNvB2tqgXxvQorM+iViWrMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779633968; c=relaxed/simple;
	bh=MQ3t4gwQj5eUvk0EqiJtMxfRsy0THlimC/ELRbfgu6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JXVOyGGJsem97XBpE9ApQWqmzzJOkVnaEUCyz6RcAghPpBV0aYP2RRUeNIEv3QjZTn17AJvmZqNVIzogLd68/MZ1qNVAlvJDJ5qMp2q3Fk2KBfM6DQotO3PwIwcWbtMvRZrn687AkPjU/ytAkegq+l5k2PtXKMPdEBM7iKIoBQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KhRj0iee; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KhRj0iee"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-6530287803cso8853711d50.1
        for <linux-security-module@vger.kernel.org>; Sun, 24 May 2026 07:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779633964; x=1780238764; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HDlPr4FBvDjIjS+3E+sSPHDYvjA2zegNPbMF8QfBjp4=;
        b=KhRj0ieeI5m+9W1fRoNuUV83oPvwO4i7Q5zj/eSNDcn9mQbQILDFam+JAJ7zEtFIG4
         q+0EbA3fb+DRMfWX5cAAEjhGJyHO2eWY6l+Gk/CPnHo922Djsse+IJU/q1kV09k3qV6Q
         qrCLy+RRcXeqZqaNfJUwrxuPr/7FDTBYWfHerLGS8/EddwoFBnMKuEGDm+Js+g3aDd7s
         I5d8kz3p/V4+kvSXM8BfkIEq0qj8LYVnzGwv5F6Zj2va6om7aikUnxWwlcTEHEJyFIpF
         cJK+oHpq8Z22TmdcU69Rq8WWhkdpVyJV4Gw9HcAkk9dQVxoMpnitbATgLxtHOk5IpeTD
         n28A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779633964; x=1780238764;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HDlPr4FBvDjIjS+3E+sSPHDYvjA2zegNPbMF8QfBjp4=;
        b=PEN4MKn6bxzOFEC9lhSdTdpjAJlueH8xcoU0uBC+1+6r6SQq3mULDG5YueZFGesnEq
         oSXziyx+Lgh9M5KrbIlnafYw0EJcJBCkVdvX0314css4nZ1332+BkEFqADBdNoloojqk
         MCjogMMAhzJN+3gDxUutWb7dnYT9Yde3lH7sQGrEUdfPWN/Zm5x0SzJIqlEyfMiBRmiK
         ukzdU0z2CPN6aNJoHYIlj8LTHRTFoG3jvutPjHv/JvXF61oVhnpODrOH6cnV+xueRabL
         +JDqv68Sau/0F+vNfVTF5q7zfXMdhjKdjDKM6xVveTQCPJsimZHZdJd7qHGItklpsp7X
         39gw==
X-Forwarded-Encrypted: i=1; AFNElJ/P1un7tzvojhonIU+taETy8BTnjJUy0D8ADn9s8vXcd4y9SuIFsfSbo8QT/P8UuwY+8FMU4jr/ZcIxd2zi5lrSizCgOkc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTyx2beCTvV0nvheVxF4HPz/6FkfX3+xuq16GYmK2pICifPmZg
	PMAg0Ma1TVaGZDdLafMLk/wlSAQgOyEjhH3HOWU584W362gLh9Q+XYPigMB+JA==
X-Gm-Gg: Acq92OFUD9oeEsCrtX6Od+ctKGk9LE36dHQvs2zvWxuoW9qiAnEBy4IDu7vLt+f1Bg3
	vNXg4IPZCrAoQFPtcHIEd0K7SCa2PtsVn85UCY/McUBwXeWAPJmykVwmUPb5bIHHww/paIAHY29
	dwtuEBAFtPt84h2jdWkqzpBOxTt1cH2YEKwJWG4SP2IfwIFwQgIOTK1CRgKPXWg8CFwseaOCtK0
	fNv3ryOkJt0vny0aAu2Ci3wcYL+UobZ3wI/QLt66iRRYf0bS4CMj6AdtEcWpWQO3NtuXxP8HzYx
	yV9/ePjOHehlpzFjoaqVTfuPVizMFqbMEsyYm01NKkSR3WDav+7EThnaYBYJZEKdIIudddZtnly
	DwKYcnrjI68Or58HjaI9cqwSB8taGhYFZ0+6DWNqIv7EL+Zh5yQKaN0wmKP25P9iV6kQACrOqNa
	EPQfIJ8wfBujBaL3Ig7xya20JA4cBPDb5ezYrfsBe/P/4a2jsJ/500tBtnHEe3HtYig0E4
X-Received: by 2002:a05:690c:c9b:b0:7bd:6a98:58d7 with SMTP id 00721157ae682-7d3361b9144mr123074587b3.38.1779633964056;
        Sun, 24 May 2026 07:46:04 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:cf18:78cf:cf2b:a481])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7d38c4363e7sm33426907b3.39.2026.05.24.07.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 07:46:03 -0700 (PDT)
Date: Sun, 24 May 2026 10:46:03 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: Tingmao Wang <m@maowtm.org>
Cc: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>, Jan Kara <jack@suse.cz>, Abhinav Saxena <xandfury@gmail.com>, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v8 1/9] landlock: Add a place for flags to layer rules
Message-ID: <ahMLLwnDO7g64h63@zenbox>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <617fdd53-6612-4f6f-b0e0-16d85985487b@maowtm.org>

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
This approach seems best.
> static_assert(LANDLOCK_NUM_ACCESS_NET <= LANDLOCK_NUM_ACCESS_FS);
> static_assert(LANDLOCK_NUM_SCOPE <= LANDLOCK_NUM_ACCESS_FS);
> struct layer_mask {
> 	access_mask_t access:LANDLOCK_NUM_ACCESS_FS;
> 	bool quiet:1;
> };

Other way to do it could be an (anonymous?) union.

union {
  access_mask_t fs_access:LANDLOCK_NUM_ACCESS_FS;
  access_mask_t net_access:LANDLOCK_NUM_ACCESS_NET;
  access_mask_t scope_access:LANDLOCK_NUM_SCOPE;
}

The union should be sized to fit the largest field automatically.

That way you don't have to change this when adding new access rights
and avoid the brittle static_asserts.

Not sure about the alignment implications here though.
> struct layer_masks {
> 	struct layer_mask layer[LANDLOCK_MAX_NUM_LAYERS];
> };
> 
>    (Maybe we can just make struct layer_masks a typedef to
>    layer_mask[LANDLOCK_MAX_NUM_LAYERS] instead?  But currently not sure if
>    there are any gotchas with a typedef like that)
> 
Typedefs are generally discouraged for structs and pointers in the
kernel coding style.

https://docs.kernel.org/process/coding-style.html
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
