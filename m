Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch [84.16.66.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7070C283FC5
	for <linux-security-module@vger.kernel.org>; Mon,  9 Feb 2026 18:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770660218; cv=none; b=GvgU7tpJeTdzwhevJrBGO6A4N6ABRkqfptr1N4XCriPa2B7GWPIIViZkpiVG1b+NnY8sB5ANyaXTbfXDuzu3s5qBxhHwXtAdpxWuN0lvMBun/Ej9Q375KN9p1ucgEvKiV+18KGZqHwCIGCi8a53Ed4HZHfycNZM/sLVcOuiQSSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770660218; c=relaxed/simple;
	bh=JuIosbftybgXJ0xK9QNuxbqUK8H2vVfK9v86vbP4z/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DV3u6ryvqObHynHG01tSc8GmSXyY/AwSQ4m1LJxErVdieJbTGUS9EwYFM8kkwZF7dOn2TVM8oAo8c/CIOridpM+avVhan/TzmX0bXJLSmILLYxeVs0+263mlQg+thyqpQb3VgMrn9hE6NN3AVDzKwDZCGtT31676PhBrJ+lYPuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=0QdtHthb; arc=none smtp.client-ip=84.16.66.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="0QdtHthb"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4f8sxt4WQ4ztG;
	Mon,  9 Feb 2026 19:03:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1770660210;
	bh=v475FHh9ENrmSGffKH6eKkmxupq9nftpaCtoVyeDj3A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0QdtHthbQ9Gpbf8/Ye6HMOcm1q/jMFmFw9uPXANcs0PJ3ZYJzhEdJKvm3FM5SBi9Y
	 ppU8EhXxQPbXIfDZzoKn0qz1Fr1NZwDSBdK79IVetAA0g2cd7JCl9EAdunyCW/7LOv
	 xOhct4srTycCRRPaF6/wq//NCF65Z3kv0HDXIRhk=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4f8sxs5b1szS2x;
	Mon,  9 Feb 2026 19:03:29 +0100 (CET)
Date: Mon, 9 Feb 2026 19:03:28 +0100
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
Message-ID: <20260209.epiCai9phaeF@digikod.net>
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

We should test this case too.
tools/testing/selftests/coredump/coredump_socket_* should help.

> > +
> > +	/* Only stream, dgram and seqpacket sockets are restricted. */
> > +	if (type != SOCK_STREAM && type != SOCK_DGRAM && type != SOCK_SEQPACKET)
> > +		return 0;
