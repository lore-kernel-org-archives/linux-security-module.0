Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C323655C4;
	Sat, 10 Oct 2026 18:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791658007; cv=none; b=UyyPsem3zLhMpaQQS7t/zTr6M1alTVbISXVQL/cezrP3RCdJqClaCqbJoDQJqA42iACImPtyq+KMgXtdwU72GWiw45GqXTA9xx0b3I4Hwj3WjrQRSvnZVBDtv/wfOChCk0oEuT908f49GhiM+b8mt9lz713NZWkptQczLhXMdPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791658007; c=relaxed/simple;
	bh=y1L05zcKgA73pU3ZnElg/HftGoD1JHs1cE2H1AU+dSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q84k7Eq5BmQyvmKZeEKw+Jvq2WLT9g+enP8uioMsyssufQZDFRdIKaHCpP8ekMZtRE1sX+0+ZiQRFqk9tf+DfN7Gjp3/JXjczhZmPvX7yW8mXM7zvJYSjOxWs138yMpAirMlnEHvLLGI2o7DDgwoclOMJt3d8/MA5bSVUlj9qUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ggJ6FbSO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ggJ6FbSO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D8731F000FF;
	Sat, 10 Oct 2026 18:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791658005;
	bh=C98FiK+YL3y0X4TbHtA7usT/gRc7m/onuo4oq/5kBx0=;
	h=Date:From:List-Id:To:Cc:Subject:References:In-Reply-To;
	b=ggJ6FbSOeOrX+/e9InmRNEZnbyoeVzsz2AgASzHScQgv4RkT9MTrY/1I3+57/X+cS
	 O8+vWKQ4VW+tHqSl6331fOkVkLPT+FMxzgfeM4acaEAB0ILhaHC+ajs1rcp6DgvRzJ
	 7OzS5L22Gol/RjEikj2Lgs1hCzsB8xZSA1yTgiWuDtzmIp/Kp8N/RCtNXLwCza4ZTc
	 ZmSoSmK9NdTYs2tH8uBUE9TjRtzHZzGjuz+6VlgQIS29dPVaUWHUzaeRqUXA+KDU6C
	 4A/Ykf4iqtc4PNxeiJsPpGbHtt1zlB8h8csEWcabToupAAwrAe29Ycov17CZVebguJ
	 kXMp+vG2tCjRA==
Date: Sat, 10 Oct 2026 19:46:40 +0100
From: Nathan Chancellor <nathan@kernel.org>
To: Alejandro Colomar <alx+linux-hardening@kernel.org>
Cc: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Tingmao Wang <m@maowtm.org>, linux-security-module@vger.kernel.org,
	Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev,
	syzbot+a0eecb22de4d821a9e5d@syzkaller.appspotmail.com
Subject: Re: [PATCH] landlock: Drop __counted_by from landlock_domain.layers
Message-ID: <20261010184640.GA40038@ax162>
References: <6ac91e98.bbc4c7f9.15faa7.0023.GAE@google.com>
 <20261010164450.194439-1-ngocthang2710.1999@gmail.com>
 <asp9mzpa4eJWvij0@debian>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <asp9mzpa4eJWvij0@debian>

On Sat, Oct 10, 2026 at 08:05:48PM +0200, Alejandro Colomar wrote:
> Hello Nguyen,
> 
> > Date: 2026-10-10 23:44:49+0700
> > From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
> >
> > With clang 22 and CONFIG_FORTIFY_SOURCE, the second
> > landlock_restrict_self() call hits a bogus fortify report in
> > inherit_ruleset():
> > 
> >   memcpy: detected buffer overflow: 16 byte read of buffer size 0
> >   Call Trace:
> >    __fortify_panic
> >    landlock_merge_ruleset+0xc46/0xc90
> >    __se_sys_landlock_restrict_self+0x2bc/0xd40
> > 
> > layers[] lives in an anonymous struct inside the anonymous union
> > that overlays work_free.  For such a flexible array, clang computes the
> > address of the __counted_by counter as the start of the array instead of
> > &num_layers.  The bound is then read from layers[0], i.e. from
> > the first layer's configuration, which is not a count.  The same layout
> > crashes clang itself in a standalone test.
> > 
> > The annotation was added as documentation, so drop it rather than
> > restructure the union.  Keep the information in the member comment.
> > 
> > Reported-by: syzbot+a0eecb22de4d821a9e5d@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=a0eecb22de4d821a9e5d
> > Fixes: bd3a19800dd1 ("landlock: Add counted_by in landlock_domain")
> > Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
> > ---
> > Reproduced with clang 22.1.8 and FORTIFY_SOURCE on mic/next (64b9e6eff524):
> > the second landlock_restrict_self() hits the report, while 16 nested
> > restricts run clean with this patch.  Mickaël, if you prefer to just drop
> > bd3a19800dd1 from next, that works as well.
> 
> Is this reproducible with Clang 23 or later?
> 
> Should __counted_by() expand to nothing for bogus versions of Clang?
> That would allow using it, and just ignore Clang when it's broken,
> rather than not using safety features.

This is actively being discussed/investigated in another thread but yes,
we will be marking clang versions affected by this problem as broken for
__counted_by:

  https://lore.kernel.org/20261007-b4-landlock-fix-domain-fortify-panic-v1-1-042e9108f5f8@oss.qualcomm.com/

> >  security/landlock/domain.h | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/security/landlock/domain.h b/security/landlock/domain.h
> > index 60e8eb2d6ac2..4bf1555a4349 100644
> > --- a/security/landlock/domain.h
> > +++ b/security/landlock/domain.h
> > @@ -246,8 +246,12 @@ struct landlock_domain {
> >  			 * properly handle merged rulesets without overlapping
> >  			 * access rights.  These layers are set once and never
> >  			 * changed for the lifetime of the domain.
> > +			 *
> > +			 * Not annotated with __counted_by(@num_layers): clang
> > +			 * miscomputes the counter address for a FAM nested in an
> > +			 * anonymous struct within a union, which trips FORTIFY.
> >  			 */
> > -			struct layer_config layers[] __counted_by(num_layers);
> > +			struct layer_config layers[];
> >  		};
> >  	};
> >  };
> > -- 
> > 2.43.0
> > 
> > 
> 
> -- 
> <https://www.alejandro-colomar.es>



-- 
Cheers,
Nathan
