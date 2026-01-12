Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [84.16.66.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD03364050
	for <linux-security-module@vger.kernel.org>; Mon, 12 Jan 2026 16:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768233890; cv=none; b=UetrazizK1t6gCvQ+qL2MCa2E51l2qiRvYcP8jKDdORab2woSpdzPKs1kbLlVKjJ8fo2aab89k46Cmg0Kv8dNe1568GJqp3oFIMYtCb292I0A5EuX03OyGll4p8kxn75oy9jsH1LuG3qA2ibCcBJ9E3eYjI1RPgKg72pqbW2/kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768233890; c=relaxed/simple;
	bh=cZFC7BnR2MK9mogjzb0MEUPztYFPKAZEkgRoF8YULO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oOPYD5he2k7AWwmvvgjSW5fUP9+17Kr1lR9A1cwr60GBfC8weLjrHcIep20cZn6gMdA6jRzl/SScMGuTqxdI0pdo7b3ei0EBfbKZb9unnPyQ6lpzpWqGtux9BTW7dC91QYidNfhbUvDfFffDSzCll4fPkfbAjlGP5CgFrq2juF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=F3wGFyuy; arc=none smtp.client-ip=84.16.66.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="F3wGFyuy"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dqcdg2vbpzgJB;
	Mon, 12 Jan 2026 17:04:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1768233879;
	bh=8IDxyNo2/3Rg3u7Y2rYSpdCLfdR2xiDFy3jiZWUzLXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F3wGFyuyWfSi+f5VQgAWDYjjwAy+ltrkoqSpVwRHTXfYMHmZdAY9/YTXJfvUXO88h
	 ML09oqLJbrPc03iccI18bL5PBMeUCzFgsaHyV3Y6GCXLd8m3amV4oKynz1v/o5aznP
	 9Zb3rrBeneDSRKspbsZ8L5sJuxvXfPSviaJmei/8=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4dqcdf0xw0zfZv;
	Mon, 12 Jan 2026 17:04:38 +0100 (CET)
Date: Mon, 12 Jan 2026 17:04:36 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, 
	linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>, 
	Justin Suess <utilityemal77@gmail.com>, Samasth Norway Ananda <samasth.norway.ananda@oracle.com>, 
	Matthieu Buffet <matthieu@buffet.re>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	konstantin.meskhidze@huawei.com, Demi Marie Obenour <demiobenour@gmail.com>, 
	Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>, 
	Tahera Fahimi <fahimitahera@gmail.com>
Subject: Re: [RFC PATCH 1/5] landlock/selftests: add a missing close(srv_fd)
 call
Message-ID: <20260112.ahjeeCaish6e@digikod.net>
References: <20260101134102.25938-1-gnoack3000@gmail.com>
 <20260101134102.25938-2-gnoack3000@gmail.com>
 <20260109.Thoot8ooWai7@digikod.net>
 <20260109.uukiph8ii0Je@digikod.net>
 <20260110.789827dda36e@gnoack.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260110.789827dda36e@gnoack.org>
X-Infomaniak-Routing: alpha

On Sat, Jan 10, 2026 at 11:37:20AM +0100, Günther Noack wrote:
> On Fri, Jan 09, 2026 at 11:49:48AM +0100, Mickaël Salaün wrote:
> > On Fri, Jan 09, 2026 at 11:41:30AM +0100, Mickaël Salaün wrote:
> > > Good, I'll pick that in my -next branch.
> > > 
> > > Nit: The prefix should be "selftests/landlock"
> > > 
> > > On Thu, Jan 01, 2026 at 02:40:58PM +0100, Günther Noack wrote:
> > > > Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> > > > ---
> > > >  tools/testing/selftests/landlock/fs_test.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > > 
> > > > diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> > > > index 37a5a3df712ec..16503f2e6a481 100644
> > > > --- a/tools/testing/selftests/landlock/fs_test.c
> > > > +++ b/tools/testing/selftests/landlock/fs_test.c
> > > > @@ -4400,6 +4400,7 @@ TEST_F_FORK(layout1, named_unix_domain_socket_ioctl)
> > > >  	EXPECT_EQ(0, test_fionread_ioctl(cli_fd));
> > > >  
> > > >  	ASSERT_EQ(0, close(cli_fd));
> > > > +	ASSERT_EQ(0, close(srv_fd));
> > 
> > I'll also replace these ASSERT_EQ() with EXPECT_EQ().
> 
> Fair enough. I would normally prefer ASSERT here, because that would
> be more symmetric with the corresponding setup steps, but it feels not
> worth bikeshedding over this.

My thinking is that a close() call will not have any impact on the
tests, and it's worth cleaning things as much as possible, but an error
should not happen anyway.

As you said a few years ago (or as I remember it), we should use EXPECT
as much as possible, especially when checks don't impact following
checks.  At least, that's how I see things now. ;)

> 
> The selftests, both Landlock and others, are inconsistent in how they
> use ASSERT and EXPECT, especially for close().

Indeed.  I try to make sure the new Landlock tests use EXPECT for
close() though.  It's difficult to explain when to use ASSERT or EXPECT,
especially because they are used everywhere, and we may not even
agree...

> I wish we had an
> easier way to do state teardown in the selftests without having to tie
> it to a FIXTURE()...
> 
> –Günther
> 
