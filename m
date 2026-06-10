Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855BF1A6806;
	Wed, 10 Jun 2026 22:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781129497; cv=none; b=AwLXwpwC4gmXWJH+raFynaiEcbS7COGnFjgTGVO9+xpGhJ/7zte/R7LfogAQKFWvuIYPR6Ya9PIUB3DO9ooYrWfgg5aZeQj6N1s5Nn5nlgONt1S6v1VXQrgp5rNlrW4RrthAzfvuHGUXLnA0Ojb8vBoOhIlO2BuC2UDiZovGO2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781129497; c=relaxed/simple;
	bh=xF+48qVtle438MW1KRajLhHeNxcY6i9Z/XjwfCxfzLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mxZhXMY8/YH3jbZyU73O0gWGzPXGPwYIJdN3ue4jz4IGn8BUq+psqTR6RQnRGJbFDfxl3/RxGtiB8iBOUiDkS8OL2lpnRwLnNxeMuywNNciYb92exCBPoI1hiUT9K/n+KG/j7NQsyoP4cC73Km7G2o8AN7VXucerVcQikY5s7T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M9VI3DIU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M9VI3DIU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29E411F00893;
	Wed, 10 Jun 2026 22:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781129496;
	bh=ktUakYQu5MH9dAuUQxQWwYgXWoKAT9adYy2tQZq3QDE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=M9VI3DIUDEq0chQveTtskz2xh/5weU+6t/Aq1Nkv9ZVxUo6yvIAiUDQZEKioU6cKj
	 E+Z3cHlnv9UFNZb+HwJdLqxPDNKDN3wfKw79cGKujJ2ucPkKKk9c6b4lvmNRUuQEmB
	 z96R53uWbuSCRt0+mNG6rZ5Eb9tZ7XkePkTj+WDmFrW4d9djLp83L/mr892sTpNBg1
	 SoTGs8ivHBKp0CgtgNTheENkR/ZiSG6yxCICFL/sB13LJeCEWlLHSm5fRrwQQGH0ii
	 uF3+jYnCRehCdWzL9WEnfZPNKm7IYXtyX0YGVSd/aI4I+BbtgsUh0oHh+NxP1JKEqq
	 qMxeVb6kNobMQ==
Date: Wed, 10 Jun 2026 15:11:36 -0700
From: Kees Cook <kees@kernel.org>
To: Mohammed EL Kadiri <med08elkadiri@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	linux-security-module@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cred: prevent slab cache merging for cred_jar
Message-ID: <202606101510.7F6F4118@keescook>
References: <20260606142558.13809-1-med08elkadiri@gmail.com>
 <202606101345.D1BDA8BBE2@keescook>
 <CAAMeuQSZdNiCaAMYOnQE3q-Y9325PAbwVsJmTmKSS9a=NG7wcQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAMeuQSZdNiCaAMYOnQE3q-Y9325PAbwVsJmTmKSS9a=NG7wcQ@mail.gmail.com>

On Wed, Jun 10, 2026 at 10:07:24PM +0100, Mohammed EL Kadiri wrote:
> Hi Kees,
> 
> Thanks for the review!
> Following Vlastimil and Jarkko's feedback on the key_jar patch, should
> I send a v2 here as well with similar commit message modification:
> removing CVE references, dropping the skbuff comparison, and framing
> it as hardening?

It wouldn't hurt, yeah. I have that kind of already in my head while I
read these patches, but it would be better for other folks to see it
framed more accurately.

-Kees

> 
> Thanks,
> Mohammed
> 
> On Wed, Jun 10, 2026 at 9:45 PM Kees Cook <kees@kernel.org> wrote:
> >
> > On Sat, Jun 06, 2026 at 03:25:58PM +0100, Mohammed EL Kadiri wrote:
> > > The cred_jar slab cache holds struct cred objects, which contain
> > > process credentials: uid, gid, euid, egid, and capability sets.
> > > Overwriting any of these fields is sufficient for privilege escalation.
> > >
> > > On a default Ubuntu 6.17.0-23-generic system, cred_jar (named "cred"
> > > in sysfs) has 2 aliases, meaning 2 unrelated object types share its
> > > slab pages (object_size=184, objs_per_slab=42).
> > >
> > > Cross-cache heap exploitation relies on slab cache merging to achieve
> > > type confusion between unrelated kernel objects. CVE-2022-29582
> > > demonstrates this technique: an io_uring use-after-free is leveraged
> > > across cache boundaries through page-level reallocation, ultimately
> > > achieving root. struct cred is a primary target in this class of
> > > attacks due to the direct privilege escalation that results from
> > > corrupting any of its identity or capability fields.
> > >
> > > Add SLAB_NO_MERGE to ensure cred_jar receives dedicated slab pages,
> > > so that freed credential slots can only be reallocated as struct cred
> > > objects. The memory overhead is minimal: one struct cred exists per
> > > task, and with 42 objects per slab page, the cost of dedicated pages
> > > is negligible. There is zero performance impact on the allocation
> > > hot path.
> > >
> > > This follows the precedent set by skbuff_head_cache (net/core/skbuff.c)
> > > and key_jar (security/keys/key.c) which use SLAB_NO_MERGE for similar
> > > isolation requirements.
> > >
> > > Signed-off-by: Mohammed EL Kadiri <med08elkadiri@gmail.com>
> >
> > Yes please. :)
> >
> > Reviewed-by: Kees Cook <kees@kernel.org>
> >
> > --
> > Kees Cook

-- 
Kees Cook
