Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch [45.157.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1182B38171F
	for <linux-security-module@vger.kernel.org>; Mon,  9 Feb 2026 17:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770658621; cv=none; b=NdAIPW1PoUTv5pYs/tDmlWXtUJMd7Gy8s4XgSnqKOyLQWEZEJvbl4XlVSv7WzygXvjG3TrsmGlPX7ic62kHAqqG08n7cORB0rI0hnXJ3UmoMm5nYsoUkFXNhHlre4chyUHO4W1K6qMXTfDEFeqIfTPLzyCuzuFcdwsOupQ4Va3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770658621; c=relaxed/simple;
	bh=wU06l4AZmsjVxc12fvuyFvaDbMeQqOXvWjDH+Yx14k4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qgG0+ho6O+bNLCCKzy9JMbuXTV70RmqQ7kVNUY9q+98emRFwGdV4WzmGO2i5esXdmg9YMQOCK7lWP0JevVNKaynJFQL4x79YVrt4c/c4Hy7mP2yZX1woQ0kXTnv52g+o2fRFnpy/F9fI7msEOy+/Vv45P7gRV8R7qq8RdW+eO4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=Pba72qfo; arc=none smtp.client-ip=45.157.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="Pba72qfo"
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6c])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4f8s9R0vfpznlC;
	Mon,  9 Feb 2026 18:28:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1770658106;
	bh=Wg8I223cyoiMF55Vvtdc/KvgQcFxp+SlbYahMWf0qWA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pba72qfo1buAo/OCH8t3uK69kvN/iQjNB4irqG1TfdV2kBhmnsS2jDXJcr5rWYbyS
	 jYIv2qkXcDkwvxAPCNlyMp+2uwpJuKgnEYI1tgZpbW71bfJEM6x/0PtJtjwZTOaWBY
	 nSrrun1IS2VO7gGxbcOnQlrJAeoIb1i/OvlGMZwY=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4f8s9Q38pnzVSt;
	Mon,  9 Feb 2026 18:28:26 +0100 (CET)
Date: Mon, 9 Feb 2026 18:28:24 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>, 
	John Johansen <john.johansen@canonical.com>, Tingmao Wang <m@maowtm.org>, 
	Justin Suess <utilityemal77@gmail.com>, Jann Horn <jannh@google.com>, 
	linux-security-module@vger.kernel.org, Samasth Norway Ananda <samasth.norway.ananda@oracle.com>, 
	Matthieu Buffet <matthieu@buffet.re>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	konstantin.meskhidze@huawei.com, Demi Marie Obenour <demiobenour@gmail.com>, 
	Alyssa Ross <hi@alyssa.is>, Tahera Fahimi <fahimitahera@gmail.com>
Subject: Re: [PATCH v4 2/6] landlock: Control pathname UNIX domain socket
 resolution by path
Message-ID: <20260209.IWeigh1theik@digikod.net>
References: <20260208231017.114343-1-gnoack3000@gmail.com>
 <20260208231017.114343-3-gnoack3000@gmail.com>
 <aYm1RWtV6Af-zEHf@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aYm1RWtV6Af-zEHf@google.com>
X-Infomaniak-Routing: alpha

On Mon, Feb 09, 2026 at 11:21:57AM +0100, Günther Noack wrote:
> On Mon, Feb 09, 2026 at 12:10:12AM +0100, Günther Noack wrote:
> > +static int hook_unix_find(const struct path *const path, struct sock *other,
> > +			  int flags)
> > +{
> > +	const struct landlock_ruleset *dom_other;
> > +	const struct landlock_cred_security *subject;
> > +	struct layer_access_masks layer_masks;
> > +	struct landlock_request request = {};
> > +	static const struct access_masks fs_resolve_unix = {
> > +		.fs = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
> > +	};
> > +	int type = other->sk_type;
> > +
> > +	/* Lookup for the purpose of saving coredumps is OK. */
> > +	if (flags & SOCK_COREDUMP)
> > +		return 0;
> > +
> > +	/* Only stream, dgram and seqpacket sockets are restricted. */
> > +	if (type != SOCK_STREAM && type != SOCK_DGRAM && type != SOCK_SEQPACKET)
> > +		return 0;
> 
> FYI: This is a (highly speculative) safeguard, because these three
> socket types are the only ones that exist in AF_UNIX (compare unix(7),
> 2nd paragraph).
> 
> In the (highly unlikely) case that someone adds a fourth AF_UNIX
> socket type, this means that Landlock will start permitting
> connections to these sockets unconditionally.
> 
> I am unsure whether the safeguard is useful, or whether we should
> rather group that (highly unlikely) future socket type together with
> the existing ones.  *If you have opinions, I'd be interested.*
> 
> The fact that these are the only existing AF_UNIX socket types is also
> the reason why it does not matter that we are now (in v4) taking the
> type value from the server-side sk instead of the client socket.  The
> check will either way always pass as long as only these three types
> are the only ones.
> 
> For now (and probably for another few decades :)), as long as these
> are the only AF_UNIX types, it does not make a difference though
> whether the check is there or not.

You can remove these type checks.  We're building Landlock access
control wrt to the (moving) current state of Linux, and the goal is to
cover most/useful access types that currently make sense.  Once access
type is implemented, it should handle (by default) future features
related to the kernel object to make sure a sandbox is well covered.
This LANDLOCK_ACCESS_FS_RESOLVE_UNIX right is really about UNIX sockets
that can be resolved through the filesystem, so this should handle
current and potential future UNIX sockets as well.

If a new named UNIX socket type is created, Landlock should handle that
with this access right, unless there is a specific semantic (e.g.
coredump), in which case we'll update the access right, and potentially
add a new one if it makes sense.

I was thinking about calling WARN_ON_ONCE() but this is not worth it.
