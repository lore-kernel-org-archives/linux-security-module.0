Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0F73FC9
	for <linux-security-module@vger.kernel.org>; Sat, 10 Jan 2026 10:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768041449; cv=none; b=dEkj6M0872s+clNuYOp1qIP0oYn340sZ4w7nyVWPOc1Mjk5CvsBI1b23BBr1X4IFLA0RjKnn7eOmaXEWcK5SyLU3rXOuJv/0Pv2LLUxJip/iIJf2YOJzH6yhtDQ1hDTGsKKFZb/vARBVn2pdMOBf+NCJA19qTVxe0IEuLyA4F6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768041449; c=relaxed/simple;
	bh=nT1+Ao/xMODKa2RjbXVxGEzG0F5baJ+hSb+evBaOQ3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oiGhrIG/vxMlZ4CfoxVtrqtqvIMniyGWBZEqLO32NHd1x4pqdS5gHkKwfM1fg+LGwpISsMsz1v9hI06fzblrEx5UzXzX2E+dCfLZrdEAltLu/LGJwjXFB3ntCFUVz7e5h6GfzQ+3bRuPQU0F+YMI4vWAWf7F4Oay9Y80pVcD8dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wb4ELosH; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wb4ELosH"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6505d3b84bcso7864483a12.3
        for <linux-security-module@vger.kernel.org>; Sat, 10 Jan 2026 02:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768041446; x=1768646246; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PNwXCMoZrGX4H7GweaSGvKj56ZtlFhwdQtJ3U1EZfBo=;
        b=Wb4ELosHNTXmXBOwrnCTxTAw0djqIFGqv6AgXkpAyIS1HaTwAbqls+zfxkUKayx1OK
         /ZASBndc22b09wqV90kk/NKKxyIUHkBzaFBC8rP64H0plVXbEswO2Y4uuO0uu+L5Dg/A
         qaPwRPiq6DqnPE31BcMAbel7ZUUQx0rw9OJbquDKZqPD9Xa176gny5MYsAFWV5qfs2al
         QeaF6A30OZ1lxEOd/0B2IslmJfgttlzxNhxmEeddxbKxF6BSPBUVryvrfCmmsbOj3wl1
         VD7espVjQXt8cQFHyOcfRvIxhhYzgHYN3cyYbRB0466Z0RxTUIVS2plMvJhUspCUdy4G
         KrAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768041446; x=1768646246;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PNwXCMoZrGX4H7GweaSGvKj56ZtlFhwdQtJ3U1EZfBo=;
        b=JHpEhjrbhzglIyAEGG0lzcw0theAp9H9rOX0lxwEHMuc/YfElcO8ncY9CkCEQOMoRj
         KNjvnUgcjVo5TfCmKQr/5wT0Zzcvr4D/0hMPlXiAHFRqA64cRU+pa+KE67lNmrB//hSi
         q0zO/WKRR1PP7qf9elijNkIPSVex804UGxrx0ua7E+NO1TvmjHdyWgJmQxdvDH5fYwkm
         MXIRX1AW8kCIDWJ57KQfFoGMDQis7PVKB82rK5lOxBgOM0QlKkcqJy+DBhSU4/XjUGOm
         RxSbqlcroorJotCS8gvZ0QE1Np2AOe00D6zkIeuZ6jfBDTNIg2ZCl4rs7OADJ0Qo4kch
         qLvg==
X-Forwarded-Encrypted: i=1; AJvYcCWRzgQm0ieQlqeiXo+aIUMLyv2vQMxOlyTy2FOZGg4K2XyQmdXDwR5QO63Xj04NJydvFwC3GAmcYV3iSZmlypnVVEzAiHw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2Ecc7IKNAhc19oRIdmg982Brj3hgOqQs2hK89aDhNHhAl5Gvu
	vPOsXV5KEo1d6rMyE1LElZ48uUV9RHgAzFwyUeQ+xxSD32KztxgMip7r
X-Gm-Gg: AY/fxX6hUp1zFpiq+/2nLN3xLWzH1NiJAFatVnOy9qZNDDdXzJJU3CK9Q0CKJffO0S8
	JAJSu3UzcJVqVzBtCxreIe9e11V1nhoPsBzg/f0D+jgYm2b2Twd+f+i/s13n3MixSPQd/97HPZr
	PFYrDDqFsuKWYeCTNGYRZSJp1SwxMGNh+8hMwBbh2oKuJULLsns/3sUUG92AwRK2yi3PAMovBgG
	iw73Ph0RtcZOHYZQKi8LaTyKPu8erGTuVBCZPLIdYIFIZiCkScpmVrRpn/Dpfi9K4I5aIDNmJrs
	Q6wMrecBGGOhcw2SaKkOB0tf7PR9GWoCQjtWtQ5dgZFnQZ0EJF+OX/BeSyDQwHWdabVHYuv2ElY
	QKXGvudzJ1nm8u+D5HoP6+2pExCPqnwinhJmWttAF4sOl3sLWrD5VYShx4as9QflF73C/vzJPlO
	J7ojk8zI+sEdEtF4gWhbCgYAk95xTJzOUGMdBdrbh8qZRp8CA=
X-Google-Smtp-Source: AGHT+IFFbOb/Mdkezqn253junJ+oUj8fNh2kn7kynr/38rQebJjMgHE6JG1TkLGSjFVmnr5GsxQDPA==
X-Received: by 2002:a05:6402:278f:b0:64d:3b22:a595 with SMTP id 4fb4d7f45d1cf-65097dea481mr11627058a12.12.1768041446045;
        Sat, 10 Jan 2026 02:37:26 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507bf6648fsm12358874a12.28.2026.01.10.02.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 02:37:25 -0800 (PST)
Date: Sat, 10 Jan 2026 11:37:20 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org,
	Tingmao Wang <m@maowtm.org>, Justin Suess <utilityemal77@gmail.com>,
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	Demi Marie Obenour <demiobenour@gmail.com>,
	Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>,
	Tahera Fahimi <fahimitahera@gmail.com>
Subject: Re: [RFC PATCH 1/5] landlock/selftests: add a missing close(srv_fd)
 call
Message-ID: <20260110.789827dda36e@gnoack.org>
References: <20260101134102.25938-1-gnoack3000@gmail.com>
 <20260101134102.25938-2-gnoack3000@gmail.com>
 <20260109.Thoot8ooWai7@digikod.net>
 <20260109.uukiph8ii0Je@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260109.uukiph8ii0Je@digikod.net>

On Fri, Jan 09, 2026 at 11:49:48AM +0100, Mickaël Salaün wrote:
> On Fri, Jan 09, 2026 at 11:41:30AM +0100, Mickaël Salaün wrote:
> > Good, I'll pick that in my -next branch.
> > 
> > Nit: The prefix should be "selftests/landlock"
> > 
> > On Thu, Jan 01, 2026 at 02:40:58PM +0100, Günther Noack wrote:
> > > Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> > > ---
> > >  tools/testing/selftests/landlock/fs_test.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> > > index 37a5a3df712ec..16503f2e6a481 100644
> > > --- a/tools/testing/selftests/landlock/fs_test.c
> > > +++ b/tools/testing/selftests/landlock/fs_test.c
> > > @@ -4400,6 +4400,7 @@ TEST_F_FORK(layout1, named_unix_domain_socket_ioctl)
> > >  	EXPECT_EQ(0, test_fionread_ioctl(cli_fd));
> > >  
> > >  	ASSERT_EQ(0, close(cli_fd));
> > > +	ASSERT_EQ(0, close(srv_fd));
> 
> I'll also replace these ASSERT_EQ() with EXPECT_EQ().

Fair enough. I would normally prefer ASSERT here, because that would
be more symmetric with the corresponding setup steps, but it feels not
worth bikeshedding over this.

The selftests, both Landlock and others, are inconsistent in how they
use ASSERT and EXPECT, especially for close().  I wish we had an
easier way to do state teardown in the selftests without having to tie
it to a FIXTURE()...

–Günther
