Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.157.188.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794525887;
	b=pcpOKiMEaJTOryUwDsHnQFD7gR0+5CZT+NP+Fcj/ikNkCwfBw5izNDjnrOrAOYBboLDO
	 8V/rxE1RcBbPf6aaSNfspfulrWjOYMS2lbsyybh6mo0cCSFUHP7Z4bxJzA5/vbpKWd0Id
	 l7KxxgwuszmLL4nupj4RDHlV77ePXK2Oa09KToqoEW6DL717GMlHyvRTcSKIVHEnBN++8
	 8Bgm+8jrJiWMCOBUp37mZ7DCIwcG1s3XLYFN9zmugdGl7wfsr7t5rTvGK8pvWZIpv+6H3
	 qMQDWDnC5uqw/hayYF/kOCAQzJfTzw8M8//vSU6iGas5XGBYeoQ9Hlmkk2gO6j6tvUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794525887;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 X-Infomaniak-Routing;
	bh=SBso64oK39dyJqvvG6z0kQ0CzGdmCukLXdwDTdgEq84=;
	b=c5XCmVfDfV6mZhmUoxmFhjjDHKbfWAvnIAIZbekf/pUwwrvhOF92W1oknpHvOYHrrkva
	 JgZWrVqmgr3CcSicf0Ic6xe9ros7+/eMh+m4ZcjXAe0v355vWyMO20t+drpWltcLoH690
	 PHpLR88VqEGv5D7cD4qwkNZkKu3ctBN47RmGKjXv1l/2NFDHsJGDpiO1x0MmNtCLqN8XA
	 ePwgWHvWgoi0sQO7zpEHLl+9wjI5i5d+0YlTTSmJ7QjQonW0tQ9y8cEGmDg9yP04IJjqQ
	 E9KckUlvQXFshfuMdxnw4566J+X4gY7hec2VO0EEAl4nBMD7M6zQDl71bF/qevTKevQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=digikod.net;
	spf=pass smtp.mailfrom=digikod.net;
	dkim=pass header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b="epQo/Lpq";
	arc=none smtp.remote-ip=45.157.188.10
Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch [45.157.188.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D996606A31C
	for <linux-security-module@vger.kernel.org>; Thu, 12 Nov 2026 23:24:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D996606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=epQo/Lpq
Received: from smtp-4-0001 (unknown [IPv6:2001:1600:7:10::a6c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jQc113PNjzw0g;
	Fri, 13 Nov 2026 00:24:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1794525877;
	bh=SBso64oK39dyJqvvG6z0kQ0CzGdmCukLXdwDTdgEq84=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=epQo/Lpqt31iqGNs1CTdoCzrQap1csyH+3HN1LM5uv+b6Jg47SIQof/WaniJdaLIz
	 7RjsnYBT4bZS5aDRejgzQbQERlm3577tTqfJbYM+5OAuwKkfjZXygCaQW01wbba75H
	 6M/Fs2+cfh3fC+wtCToUWV0O4k1HylxCDNKfKzd0=
Received: from unknown by smtp-4-0001 (Postfix) with ESMTPA id 4jQc103nHFzW99;
	Fri, 13 Nov 2026 00:24:36 +0100 (CET)
Date: Fri, 13 Nov 2026 00:24:32 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Cc: linux-security-module@vger.kernel.org, Dwi Siswanto <me@dw1.io>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Subject: Re: [PATCH 0/3] landlock: Fix REFER in layered domains
Message-ID: <20261113.phis0MeiFohy@digikod.net>
References: <20261030102411.12985-1-gnoack3000@gmail.com>
 <20261030.060f232cddbd@gnoack.org>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261030.060f232cddbd@gnoack.org>
X-Infomaniak-Routing: alpha

On Fri, Oct 30, 2026 at 03:29:56PM +0100, Günther Noack wrote:
> On Fri, Oct 30, 2026 at 11:24:07AM +0100, Günther Noack wrote:
> > This patchset
> > =============
> > 
> > This patchset fixes the issue in three commits:
> > 
> > 1) The fix, which should be backportable to older kernels
> >    and which is CC'd to stable@.
> 
> To be more precise, the fix needs to go in 7.2, 6.18 and 6.12.
> Other stable releases predate 6.7 where the bug was introduced.
> 
> It does unfortunately not apply cleanly on the stable kernels 7.2,
> 6.18 and 6.12, but I have backported versions.
> 
> (Differences: In the stable versions, the affected helper function was
> still in ruleset.h instead of domain.h.  In 6.12, the constant name
> did not have a _ prefix yet.  In 6.12 in the tests, the
> drop_access_rights() helper didn't exist.)
> 
> 
> > 2) Regression selftests.
> > 3) A more elegant fix for newer kernels,
> >    which is intentionally *not* CC'd to stable@,
> >    because it would break on older kernels.
> > 
> >    In newer kernels, we already add the "REFER" access right to the
> >    handled access rights when we merge the ruleset into the new
> >    domain, so there is no additional calculation to do for it.
> > 
> > 
> > Please let me know what you think!
> 
> P.S. Mickaël: Specifically, I'd like to know whether you think this
> warrants an erratum.  If yes, here is a tentative wording:

Yes, this warrants an erratum because independently stacking filessytem
and network or scope policies is legitimate but an unfixed kernel may
be overly restrictive by denying FS_REFER operations that every policy
allows individually.  It can then be useful to know when to tweak such
layered policies or when it's fixed.

> 
> 
>    Erratum 5: Correct REFER semantics when layering Landlock policies
>    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
>    This fix addresses an issue where, when multiple Landlock ruleset
>    are layered, Landlock would restrict LANDLOCK_ACCESS_FS_REFER
>    operations which would have been allowed by the same rulesets
>    individually.
> 
>    This change ensures that a LANDLOCK_ACCESS_FS_REFER operation is
>    allowed in a layered domain if all of the enforced rulesets allow
>    it individually as well.

I think these paragraphs can be merged and simplified a bit.

> 
>    Impact:
> 
>    This occurs in situations where one of the layers does not handle
>    any filesystem access rights, but one of the other layers does.  In
>    that case, the non-filesystem layer is interpreted to deny the
>    LANDLOCK_ACCESS_FS_REFER right.

Overall, this looks good to me.

> 
> 
> –Günther
> 
