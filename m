Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch [83.166.143.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4213222DF84
	for <linux-security-module@vger.kernel.org>; Tue,  3 Jun 2025 12:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748954870; cv=none; b=VkyFqLVdHHnRMDvD5Y7Z2XBGXL9O874u/UZi2TiTPVrdJQYXCyCRVBfwxXrzydCw8iSQYbwCaiGcgwvt8Vk0IqOMGku9uDqG9/jDNVlVTQUExoQbvx8ksgleSPy0+OChQK35K2VzaJvJ4SyaK2VY+DC1yr7MB1PW8DA8vtK5pD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748954870; c=relaxed/simple;
	bh=66SovfWGN9Zxx8wjldJ7efmNnw7GrmCwtfjfNwHmRMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kGLjSNOcVcmr/PKHwbkJTbKoJlkE7B91I2Q4I09PVImRP0CdEsigkLfumn/cH/5DkvmlZh1BIxIAN88U2jmxVp41QFWtKGsSy8L4iX5RtXH79Y992gCP5zYjcqmW8AZ3vW/PqB4+7ydnOIdPSmiFV4Nn8YvPZdXFt1rOW/Rfkxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=L3Tby4ME; arc=none smtp.client-ip=83.166.143.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="L3Tby4ME"
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6c])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4bBVqH4VDZz18W6;
	Tue,  3 Jun 2025 14:47:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1748954859;
	bh=6bFgdneUrLdUXI8k0T/OnlBfpWZz00dJVHS7SYqxRSc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L3Tby4ME/IxgnXg/9Y5+/rVyeBpxij3Ym52HAHLkdrdpA4UF3pHH0xsvhE7RMkkch
	 IcWWuxYqynt1kVcozhgbuO23z/axTe2VhkuQUsmTO2jLfIolvqcTj6gP8mIq8kNXwg
	 GpGrxyCt/XXaw6oZGAKp7h5i4kTouPikCUyrA2n4=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4bBVqG2vMPzVjy;
	Tue,  3 Jun 2025 14:47:38 +0200 (CEST)
Date: Tue, 3 Jun 2025 14:47:37 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Song Liu <song@kernel.org>
Cc: Tingmao Wang <m@maowtm.org>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, kpsingh@kernel.org, mattbobrowski@google.com, 
	amir73il@gmail.com, repnop@google.com, jlayton@kernel.org, josef@toxicpanda.com, 
	gnoack@google.com
Subject: Re: [PATCH bpf-next 2/4] landlock: Use path_parent()
Message-ID: <20250603.uavoo2aBucoh@digikod.net>
References: <20250528222623.1373000-1-song@kernel.org>
 <20250528222623.1373000-3-song@kernel.org>
 <027d5190-b37a-40a8-84e9-4ccbc352bcdf@maowtm.org>
 <CAPhsuW5BhAJ2md8EgVgKM4yiAgafnhxT9aj_a4HQkr=+=vug-g@mail.gmail.com>
 <CAPhsuW6W+HR8BOVTCbM+AVYCEzuoSR21RWUpaEE0xvOpv8Zbog@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW6W+HR8BOVTCbM+AVYCEzuoSR21RWUpaEE0xvOpv8Zbog@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Mon, Jun 02, 2025 at 05:10:21PM -0700, Song Liu wrote:
> On Mon, Jun 2, 2025 at 6:36 AM Song Liu <song@kernel.org> wrote:
> >
> > On Sat, May 31, 2025 at 6:51 AM Tingmao Wang <m@maowtm.org> wrote:
> > [...]
> > > I'm not sure if the original behavior was intentional, but since this
> > > technically counts as a functional changes, just pointing this out.
> >
> > Thanks for pointing it out! I think it is possible to keep current
> > behavior. Or we can change the behavior and state that clearly
> > in the commit log. Mickaël, WDYT?
> >
> > >
> > > Also I'm slightly worried about the performance overhead of doing
> > > path_connected for every hop in the iteration (but ultimately it's
> > > Mickaël's call).  At least for Landlock, I think if we want to block all
> >
> > Maybe we need a flag to path_parent (or path_walk_parent) so
> > that we only check for path_connected when necessary.
> 
> More thoughts on path_connected(). I think it makes sense for
> path_parent (or path_walk_parent) to continue walking
> with path_connected() == false. This is because for most security
> use cases, it makes sense for umounted bind mount to fall back
> to the permissions of the original mount OTOH, it also makes sense
> for follow_dotdot to reject this access at path lookup time. If the
> user of path_walk_parent decided to stop walking at disconnected
> path, another check can be added at the caller side.

I agree.

> 
> If there are no objections, I will remove the path_connected check
> from path_walk_parent().

Sounds good.  The documentation should explain this rationale and
highlight the differences with follow_dotdot().

> 
> Thanks,
> Song
> 
