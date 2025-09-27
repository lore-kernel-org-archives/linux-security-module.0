Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch [84.16.66.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BECC72639
	for <linux-security-module@vger.kernel.org>; Sat, 27 Sep 2025 19:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758999652; cv=none; b=dZ2B8em6aly/S5LxNhVRwUIdLVCGnAa3/h814GJOQhrDf4v7SfbdN13AP36gmK6WeJwWPnCMcxUEo/8E734ZmcPMkiktTcs1SH+uz2LIEjNBo4zqa9RDuOElIvw3gue4bkzkYFfhdfGcP8nAnKFscCDRROOuHdpg1OJvDpUjUq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758999652; c=relaxed/simple;
	bh=KYA+dk5R463AswkrgxgDFq1JmceWPrG4OBUIDyRRzFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dtj6M0s5FSqF6KLP+GESsX6+O7kA7gYsK+Sqp8gbUoPj5L8K1JmBUCwrb7iW/bu9kMCpDTGZbFbU+6zytrv3qtZsiyr39zzIHbq2yBZITgIsWBVVOmksNsRKTS/5OTqex49+H9kx/iBoUynNpXfqpu7AuTukXiq2SJlRAwQ/f3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=OvvfW2gw; arc=none smtp.client-ip=84.16.66.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="OvvfW2gw"
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6b])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4cYxcD6LGCzgQR;
	Sat, 27 Sep 2025 21:00:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1758999644;
	bh=qc1O5ke9TT/OlddnPQup6GczLvIeBNcFYVu6optFNb0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OvvfW2gwbUEUVyBkcIeaTLc5Ju1ELEKmPA9Lm/0RGMJ2Ut8qMdr7E6VtLyY5i9Nns
	 JVSR9PNBSSJ+yWQxzXgKS/kFe/L+NrICwowfMiIio/qObxYhJsY6/P16xVKvjTaJA6
	 FRInhfs3RHm6Gf2XPCejlyu6aqD7QB5C6wb7OOAo=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4cYxcD23gPzFBR;
	Sat, 27 Sep 2025 21:00:44 +0200 (CEST)
Date: Sat, 27 Sep 2025 21:00:43 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tingmao Wang <m@maowtm.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Jan Kara <jack@suse.cz>, linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH 1/6] landlock: Add a place for flags to layer rules
Message-ID: <20250927.ivat2tho0Uom@digikod.net>
References: <cover.1757376311.git.m@maowtm.org>
 <841550c5d7bbc7ffcd74f85ee659caf1e29cff67.1757376311.git.m@maowtm.org>
 <20250919.oanahnoon2Za@digikod.net>
 <a43a9985-cf62-482b-9a2d-fce463ca69b0@maowtm.org>
 <20250924.wu8Ieku8aiph@digikod.net>
 <090e272e-64b4-4c56-9928-0e0be0288e64@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <090e272e-64b4-4c56-9928-0e0be0288e64@maowtm.org>
X-Infomaniak-Routing: alpha

On Sat, Sep 27, 2025 at 04:43:50PM +0100, Tingmao Wang wrote:
> On 9/24/25 10:20, Mickaël Salaün wrote:
> > On Mon, Sep 22, 2025 at 12:52:19AM +0100, Tingmao Wang wrote:
> >> [...]
> >> "accumulative".  Therefore if this (different "quietness" for different
> >> access bits) becomes a strong need, we should probably consider some way
> >> of implementing it, rather than expecting a sandboxer to do this two-layer
> >> hack.  (But implementing this does have the potential to result in needing
> >> to have a (number of access bits) x (number of layers) matrix...)
> > 
> > Yes, that will indeed increase the size of rules, which is why I'm not
> > sure if it worth it.
> 
> In addition to the size of each rule, another concern is that we would
> need another layer_mask_t[LANDLOCK_NUM_ACCESS_FS] matrix on the stack in
> order to correctly accumulate quiet bits when multiple access bits are
> requested, and the quiet bits are only set on some of them / spread out
> between different objects.  For example, for this 1 layer domain:
> 
> /         quiet: r
>   /etc    quiet: w
> 
> request: /etc/file rw
>     # This should not audit log, but if we only keep one accumulated bit
>     # per layer, we would not be able to tell that all access bits are
>     # eventually "covered" by quiet flags.
> 
> The alternative approach you suggested below would get rid of this
> situation as well.
> 
> > 
> > The alternative I was thinking about is to only increase the size of
> > struct landlock_ruleset (which would be negligible) to include sets of
> > quiet access rights.  A request to such access right *on* a quiet object
> > would never be logged.  I think this approach is flexible enough and
> > doesn't increase much the complexity.  This would also be useful to not
> > log access rights that don't have associated rules (e.g. scopes), and
> > then no identified objects.  To avoid the kind of hack you pointed out,
> > this feature should probably be part of this patch series though.  What
> > do you think?
> 
> This seems reasonable to me, especially if we don't think that having
> separate quiet access bit controls for each object would be a common need.
> Although if for some reason such control is needed, one might still be
> tempted to use the kind of two layer hack I mentioned.  Maybe some program
> would like to quiet reads globally but only quiet writes to /run...?
> 
> But maybe later on when we get to have supervised domains, the supervisor
> can tell Landlock whether to audit log or not for individual denied
> requests, or do such logging itself, therefore offering fine-grained
> control without hacks, and could potentially be more flexible e.g. only
> log once per request per process, etc.
> 
> I think the most obvious way to implement this is to add a field to struct
> landlock_ruleset_attr, and landlock_create_ruleset would use the passed in
> size to determine if the quiet access bits field should be read or not?

Yes

> 
> Also, do we want to consider calling this something else instead, like
> "suppress_audit"?

Quiet is simpler (similar to the LANDLOCK_RESTRICT_SELF_LOG_* flags) and
if we get other ways to log actions this will also be used.  For the
supervisor case, that would be useful to not forward a request to the
supervisor.  The *_LOG_* flags could be used the same way too (even if
"LOG" may be a subset of the supervisor capabilities).  Do you think
that would be OK?  Dedicated flags would be more flexible but also a bit
more complex.  Is it worth it?  In any case, the semantic and need
should be quite similar.
