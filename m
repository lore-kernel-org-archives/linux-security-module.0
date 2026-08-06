Received: from smtp-190d.mail.infomaniak.ch (smtp-190d.mail.infomaniak.ch [185.125.25.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E758386C3E
	for <linux-security-module@vger.kernel.org>; Thu,  6 Aug 2026 18:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786040563; cv=none; b=Bzh9V+R0KzZ0x204CWeLB0C6ydcUQkRE4822MUPajH9f1JSLpYpH/miqN8J9s4POMnov0s0WdibkUUp9M6Ojp8X11YNf7/suQ+IVW4MNID8AbadCKVoCczmXvxrsia5bFcOxwylkh5yJBLBS+aOFb53hKXpdzaLtXbYM0j9Ovx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786040563; c=relaxed/simple;
	bh=tYhCPR/p1dIylhqo/4gogghe/Y53GJToTMhfUKziksE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tcn6wrcex15w3XHScIkRwLhADCx/ff95gZgUsVYVkJa07QUleBkWcHMfJTbOJdrz60kU31w9je2i+69PlUVmQ46BLXhzVu56YmbCjNoDbvFEYxdDWkue4R/mZIX2AK58BRjtlW0+9fN7BxupP1pWJSP9EF3NdfTNbDmCtebsGRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=B700aHzI; arc=none smtp.client-ip=185.125.25.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="B700aHzI"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hGFxk15rVzptN;
	Thu,  6 Aug 2026 20:22:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1786040553;
	bh=CPCaJA4uE6ayhvMabN61LedcBDZYbdp1mEfUu0RLIr0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B700aHzIH87+7Ai9qusG3ITeQikmmRmzlgMx4TwwbIHfOVT8ZGM4BOUbzTSuDNI25
	 5iLE6Dtan8IcHmNWO4l1DhtYrpNXKMXVwKWZVrFj4/2RjobmZY2dy36oB8JvdYzMA4
	 Wj+mjZ5wws5G4EYdiaIjnXcSOIu9h0BwA8RjL8Es=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4hGFxj00k3zQsG;
	Thu,  6 Aug 2026 20:22:32 +0200 (CEST)
Date: Thu, 6 Aug 2026 20:22:32 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tingmao Wang <m@maowtm.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Christian Brauner <brauner@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, 
	Justin Suess <utilityemal77@gmail.com>, Kees Cook <kees@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Matthieu Buffet <matthieu@buffet.re>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	kernel-team@cloudflare.com, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/17] landlock: Split struct landlock_domain from
 struct landlock_ruleset
Message-ID: <20260806.ietae9xohDat@digikod.net>
References: <20260406143717.1815792-1-mic@digikod.net>
 <20260406143717.1815792-4-mic@digikod.net>
 <4e2adbc9-22df-45a1-b270-674bb9224bb7@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4e2adbc9-22df-45a1-b270-674bb9224bb7@maowtm.org>
X-Infomaniak-Routing: alpha

On Sun, Apr 12, 2026 at 05:27:51PM +0100, Tingmao Wang wrote:
> On 4/6/26 15:37, Mickaël Salaün wrote:
> > [...]
> > @@ -197,10 +179,10 @@ static void build_check_ruleset(void)
> >   *
> >   * Return: 0 on success, -errno on failure.
> >   */
> > -static int insert_rule(struct landlock_rules *const rules,
> > -		       const struct landlock_id id,
> > -		       const struct landlock_layer (*layers)[],
> > -		       const size_t num_layers)
> > +int landlock_rule_insert(struct landlock_rules *const rules,
> > +			 const struct landlock_id id,
> > +			 const struct landlock_layer (*layers)[],
> > +			 const size_t num_layers)
> 
> Maybe this is slightly off topic, but previously I've found this function,
> along with create_rule and merge_tree, to be quite confusing, because the
> logic for three different use cases (creating a copy of an old domain,
> merging a new layer into this domain, and inserting a new rule into an
> unmerged ruleset) are mixed in the code, and personally now that I'm
> reading it again I still find these functions to be hard to reason about.
> Therefore, given that we're refactoring these areas, I think this might be
> a good opportunity to rewrite them (while getting the necessary testing
> for this rewrite "for free" as part of this whole domain refactor).
> 
> For example, for this snippet:
> 
> 		/* Only a single-level layer should match an existing rule. */
> 		if (WARN_ON_ONCE(num_layers != 1))
> 			return -EINVAL;
> 
> Someone unfamiliar with how this function is being used by its caller may
> not realize that the reason the comment is true is because the only use
> case where we have multiple layers in @layers being passed into this
> function is when we're copying an existing domain into a new domain, and
> so we should never match something that already exists.
> 
> Also, further along in this function, there is this snippet:
> 
> 		/*
> 		 * Intersects access rights when it is a merge between a
> 		 * ruleset and a domain.
> 		 */
> 		new_rule = create_rule(id, &this->layers, this->num_layers,
> 				       &(*layers)[0]);
> 
> I also found the comment to be confusing because it's not "intersect"ing
> anything (it's adding a new layer to an existing rule in the domain when
> the object pointed to by "id" exists already in the domain, and the
> intersection is only a consequence of how Landlock works when there are
> multiple layers).  This realization is made harder by the fact that a few
> lines above we just OR'd the access rights (for modification of an
> unmerged ruleset), and so it makes it sound like it's doing a similar
> thing except with AND instead of OR.
> 
> I think it might make sense to have separate functions, even if they result in some slight code duplication, for use by:
> 
> 1. Copying a domain: inherit_ruleset() -> inherit_tree() -> _____()
>     RB tree search to find the insertion point + create_rule().  Maybe
>     this logic could just be in inherit_tree() without creating a separate
>     function?
> 2. Merging a rule into a domain: merge_ruleset() -> merge_tree() -> _____()
>     insert_or_append_rule()?  RB tree search, call create_rule() to create
>     a new rule with the new layer added, then either
>     rb_link_node()+rb_insert_color() or rb_replace_node().
> 
> Neither functions above will contain any actual logical AND/OR.
> 
> 3. Inserting a new rule into an unmerged ruleset: landlock_add_rule() -> ... -> _____()
>     insert_or_update_rule()?  RB tree search, and either update the access
>     rights of an existing rule in-place (as we currently do), or create a
>     new rule if the search fails.
> 
> We could create a utility static function or macro for the shared RB tree
> search code.
> 
> How does this sound?

This sounds good, but not in this series. The first part of this series
is mainly about moving code, and I'd like to avoid unnecessary churn
because the domain split is already a heavy prerequisite.  Once this
series land, a patch to improve the existing code would be welcome.
