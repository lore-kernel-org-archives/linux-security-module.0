Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch [185.125.25.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483142DF6F4
	for <linux-security-module@vger.kernel.org>; Fri,  9 Jan 2026 11:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767956712; cv=none; b=Fc2QsNbCiQkyP21gKP/uEkd3DTcwXbTVa/kNYF4RnlOoRqs1TLI1gb0t3h05rhgCmoceUyQ9h8Vu9+LHOy/fWen+jRsLaDoNBQ3WH93TfFOmeTVORsFKJcKGBhFXtau/ZIJaFT0KHSD97LRQ9UDM1la0Qxl0XAgMD6cZR0cH3oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767956712; c=relaxed/simple;
	bh=ojhe3oD0nx/Uu2gSbQpxzC6n1hh3Ys0xLRnJHFE89nY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IwDekso73DLcHTGcNUMa8f8uhhHt7bUf/sNs0gsqc01QER3fmNTbrMQncukfLlq3w3zLM5aCPduina0ZCqW5s7Al8/qoT2u/rs7+bMQJh3o/UUR3BjxO9w2ckk5fHWw5N45hN2LLOnWiWaC0Rt2Si3npzjheQrf5m1MF+IeM+b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=Q4xN/ctT; arc=none smtp.client-ip=185.125.25.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="Q4xN/ctT"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dndnp5HrNzwgm;
	Fri,  9 Jan 2026 11:49:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1767955790;
	bh=kX+znXY4xQErhrEC9M5LVHzUVJkmM+s/e8YUhxEJNjY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q4xN/ctTircRVwdHxSi30/s6s4v7fbSGuDSZ3KuPb1vVMmxb+uJJ+4xwV4kTBD7xl
	 7C5iC5kCyNRaf4IC0U+0xdkjRVt3T4YYU9CFgmeG2U9wdbbYhVoJ0aU0JPbPsCtIjP
	 rlvWDEkT0JjePp3AdkYoR4w0Q4haRwHBgvLKBCRw=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4dndnn6Q2Dz3Fl;
	Fri,  9 Jan 2026 11:49:49 +0100 (CET)
Date: Fri, 9 Jan 2026 11:49:48 +0100
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
Message-ID: <20260109.uukiph8ii0Je@digikod.net>
References: <20260101134102.25938-1-gnoack3000@gmail.com>
 <20260101134102.25938-2-gnoack3000@gmail.com>
 <20260109.Thoot8ooWai7@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260109.Thoot8ooWai7@digikod.net>
X-Infomaniak-Routing: alpha

On Fri, Jan 09, 2026 at 11:41:30AM +0100, Mickaël Salaün wrote:
> Good, I'll pick that in my -next branch.
> 
> Nit: The prefix should be "selftests/landlock"
> 
> On Thu, Jan 01, 2026 at 02:40:58PM +0100, Günther Noack wrote:
> > Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> > ---
> >  tools/testing/selftests/landlock/fs_test.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> > index 37a5a3df712ec..16503f2e6a481 100644
> > --- a/tools/testing/selftests/landlock/fs_test.c
> > +++ b/tools/testing/selftests/landlock/fs_test.c
> > @@ -4400,6 +4400,7 @@ TEST_F_FORK(layout1, named_unix_domain_socket_ioctl)
> >  	EXPECT_EQ(0, test_fionread_ioctl(cli_fd));
> >  
> >  	ASSERT_EQ(0, close(cli_fd));
> > +	ASSERT_EQ(0, close(srv_fd));

I'll also replace these ASSERT_EQ() with EXPECT_EQ().

> >  }
> >  
> >  /* clang-format off */
> > -- 
> > 2.52.0
> > 
> > 
