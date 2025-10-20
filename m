Received: from smtp-42ae.mail.infomaniak.ch (smtp-42ae.mail.infomaniak.ch [84.16.66.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706462F7AA8
	for <linux-security-module@vger.kernel.org>; Mon, 20 Oct 2025 21:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760995352; cv=none; b=fXwDNdKK5irrsUsEkiJsEgjEFxP1hfAxckuvM+1StSxSUV99jq9UACZlkBIyMCu/6dw+Zmr3npFRSZKBdg2FsDvJMggXZD4RubXR4J8e5jpQaadzBm1NHvjXu2ljlg5lH+UAt07WSAQWcodBUbtqAVansonq0cTfQkN2aPeBhuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760995352; c=relaxed/simple;
	bh=NlkkrPi57ds3mWdhR6ed9ipH9QOthqzQVm/P/haeziA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aCixvY3m8eli1maLmDm5zxkBq+cQIrNf2UQnfXYmlAsG7bQwsNGEFq2GZ1I7XMHIT66snMDxUY7I6BFO2uRi5SU78hU9llafNU54Z1aIDFlTv6m5CLBvOgTz+PvivXAKt9slFTYJVUiyBNEKz8rGRKAYtHgyTGM027QoQpAFvVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=SJFA+uZF; arc=none smtp.client-ip=84.16.66.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="SJFA+uZF"
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4cr6592LvnzZJR;
	Mon, 20 Oct 2025 22:11:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1760991085;
	bh=P5PO4Q7nS688FcUzHE794CAyDrLgzyKOCLM9tI3cbPQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SJFA+uZFUdyOlR+tANnMJMzpDmlukmLkMERHPScpOqEXJszK0i2j+pxndtOTDBdVM
	 5S9gMIxSyy6zl9+2OmCoD9ywMyzLEU9fM1Y8zhRDsTuI0qXISx6FbDrp0FWGTjsgSa
	 BSSI1E6HjIhMB5YUqAVw8z0hxqV55N8cnoi1RXrA=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4cr6585BbDzLGx;
	Mon, 20 Oct 2025 22:11:24 +0200 (CEST)
Date: Mon, 20 Oct 2025 22:11:23 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tingmao Wang <m@maowtm.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Jan Kara <jack@suse.cz>, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 6/6] Implement quiet for optional accesses
Message-ID: <20251020.ee9Ru8Aegai3@digikod.net>
References: <cover.1759686613.git.m@maowtm.org>
 <d9a05ea8fe3b825087351f22c550854dcad02555.1759686613.git.m@maowtm.org>
 <20251015.sohxe1NohFei@digikod.net>
 <326e24ff-8887-46ff-bad9-f30a6daca351@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <326e24ff-8887-46ff-bad9-f30a6daca351@maowtm.org>
X-Infomaniak-Routing: alpha

On Sun, Oct 19, 2025 at 06:45:55PM +0100, Tingmao Wang wrote:
> On 10/15/25 20:09, Mickaël Salaün wrote:
> > [...]
> > On Sun, Oct 05, 2025 at 06:55:29PM +0100, Tingmao Wang wrote:
> >> [..]
> >> diff --git a/security/landlock/domain.c b/security/landlock/domain.c
> >> index a647b68e8d06..0f611ad516be 100644
> >> --- a/security/landlock/domain.c
> >> +++ b/security/landlock/domain.c
> >> @@ -212,6 +212,29 @@ landlock_get_deny_masks(const access_mask_t all_existing_optional_access,
> >>  	return deny_masks;
> >>  }
> >>  
> > 
> > Just using u8 is confusing.  Please document what is the "type" of the
> > returned value, and use a dedicated typedef instead of u8 (see my other
> > comment about static_assert).  This typedef should probably be named
> > optional_access_t and have a size less or equal to access_t's one.
> > 
> >> +u8 landlock_get_quiet_optional_accesses(
> >> +	const access_mask_t all_existing_optional_access,
> >> +	const deny_masks_t deny_masks,
> >> +	const struct collected_rule_flags rule_flags)
> >> +{
> >> +	const unsigned long access_opt = all_existing_optional_access;
> >> +	size_t access_index = 0;
> >> +	unsigned long access_bit;
> >> +	u8 quiet_optional_accesses = 0;
> > 
> > As for deny_masks_t, we should define an "optional_access_t" type with
> > appropriate safeguard to guarantee that it can always hold all optional
> > access rights (see static_assert for deny_masks_t in access.h).
> > 
> > We should also copy the WARN_ON_ONCE() check from
> > get_layer_from_deny_masks().
> 
> I don't see how that WARN_ON_ONCE is applicable here since we're no longer
> dealing with the `optional_access`...  Can you clarify?

WARN_ON_ONCE(access_opt != _LANDLOCK_ACCESS_FS_OPTIONAL);

> 
> > 
> >> [...]
> >> @@ -80,13 +88,24 @@ struct landlock_file_security {
> >>  	struct landlock_cred_security fown_subject;
> >>  };
> >>  
> >> -#ifdef CONFIG_AUDIT
> >> +static void build_check_file_security(void)
> > 
> > You can move this function to fs.c and call it in
> > hook_file_alloc_security() instead.
> > 
> >> +{
> >> +	const struct landlock_file_security file_sec = {
> >> +		.quiet_optional_accesses = ~0,
> >> +		.fown_layer = ~0,
> >> +	};
> >> +
> >> +	/*
> >> +	 * Make sure quiet_optional_accesses has enough bits to cover all
> >> +	 * optional accesses
> >> +	 */
> >> +	BUILD_BUG_ON(__const_hweight8(file_sec.quiet_optional_accesses) <
> > 
> > We should be able to use HWEIGHT() instead.
> 
> I tried it and unfortunately it doesn't seem to work :(
> 
> 	security/landlock/fs.c: In function ‘build_check_file_security’:
> 	./include/linux/compiler.h:201:82: error: expression in static assertion is not constant
> 	  201 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg, ...) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
> 	      |                                                                                  ^~~~
> 	././include/linux/compiler_types.h:577:23: note: in definition of macro ‘__compiletime_assert’
> 	  577 |                 if (!(condition))                                       \
> 	      |                       ^~~~~~~~~
> 	././include/linux/compiler_types.h:597:9: note: in expansion of macro ‘_compiletime_assert’
> 	  597 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
> 	      |         ^~~~~~~~~~~~~~~~~~~
> 	./include/linux/build_bug.h:39:37: note: in expansion of macro ‘compiletime_assert’
> 	   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
> 	      |                                     ^~~~~~~~~~~~~~~~~~
> 	./include/linux/build_bug.h:50:9: note: in expansion of macro ‘BUILD_BUG_ON_MSG’
> 	   50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
> 	      |         ^~~~~~~~~~~~~~~~
> 	security/landlock/fs.c:1769:9: note: in expansion of macro ‘BUILD_BUG_ON’
> 	 1769 |         BUILD_BUG_ON(HWEIGHT(file_sec.quiet_optional_accesses) <
> 	      |         ^~~~~~~~~~~~
> 	./include/linux/build_bug.h:17:9: note: in expansion of macro ‘__BUILD_BUG_ON_ZERO_MSG’
> 	   17 |         __BUILD_BUG_ON_ZERO_MSG(e, ##__VA_ARGS__, #e " is true")
> 	      |         ^~~~~~~~~~~~~~~~~~~~~~~
> 	./include/asm-generic/bitops/const_hweight.h:37:23: note: in expansion of macro ‘BUILD_BUG_ON_ZERO’
> 	   37 | #define HWEIGHT64(w) (BUILD_BUG_ON_ZERO(!__builtin_constant_p(w)) + __const_hweight64(w))
> 	      |                       ^~~~~~~~~~~~~~~~~
> 	./include/asm-generic/bitops/const_hweight.h:42:22: note: in expansion of macro ‘HWEIGHT64’
> 	   42 | #define HWEIGHT(w)   HWEIGHT64((u64)w)
> 	      |                      ^~~~~~~~~
> 	security/landlock/fs.c:1769:22: note: in expansion of macro ‘HWEIGHT’
> 	 1769 |         BUILD_BUG_ON(HWEIGHT(file_sec.quiet_optional_accesses) <
> 	      |                      ^~~~~~~
> 

Indeed, it works with Clang but not GCC.

Consistently always using __const_hweight64() might help avoid future
issue if quiet_optional_accesses grows more than 8 bits though.

> > 
> >> +		     __const_hweight64(_LANDLOCK_ACCESS_FS_OPTIONAL));
> >> +	/* Makes sure all layers can be identified. */
> >> +	BUILD_BUG_ON(file_sec.fown_layer < LANDLOCK_MAX_NUM_LAYERS - 1);
> >> +}
> >>  
> >> -/* Makes sure all layers can be identified. */
> >> -/* clang-format off */
> >> -static_assert((typeof_member(struct landlock_file_security, fown_layer))~0 >=
> >> -	      LANDLOCK_MAX_NUM_LAYERS);
> >> -/* clang-format off */
> >> +#ifdef CONFIG_AUDIT
> >>  
> >>  #endif /* CONFIG_AUDIT */
> >>  
> >> @@ -107,6 +126,7 @@ struct landlock_superblock_security {
> >>  static inline struct landlock_file_security *
> >>  landlock_file(const struct file *const file)
> >>  {
> >> +	build_check_file_security();
> >>  	return file->f_security + landlock_blob_sizes.lbs_file;
> >>  }
> >>  
> >> -- 
> >> 2.51.0
> 
