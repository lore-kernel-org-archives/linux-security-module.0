Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0021A1798F
	for <linux-security-module@vger.kernel.org>; Mon,  8 Sep 2025 21:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757365493; cv=none; b=AhIj1jq2gToKvo9msblFiKbQJ+XfsANmxwsZBpu5qucCw0C0/32teuxXmf4t4KznyNIUEm3QWLCzLEnFLmhXiSX806FSGxLPLx3tFfro9d7vXocGyG4ZS8txA2NTX//07se1HMmIgzBSOeHPilCJJ5u22U0IPAQxQqSx+3Jtbto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757365493; c=relaxed/simple;
	bh=a4lFCFQ4PtfVYWKgEt//qlAxL3emGlM9rC/dmhCosbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eSJayBeKKT0F1QwfrnFU5OwkjPnoXxwrx2wpUSr/Wwljj30oOi5QUD9REEvSPvcV6MLsNP7cC6jTzTKO8cDO2ReT+p7pDpCCpGxJtw2y4YWvg80KarSZ4W7VU6y067gpRMnqkNLTSH5XW1kCt7q3/XoKPeGpREajNEcl+HAUnqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=XVg/a8I2; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="XVg/a8I2"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-77246079bc9so5817211b3a.3
        for <linux-security-module@vger.kernel.org>; Mon, 08 Sep 2025 14:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1757365491; x=1757970291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UWxRVwHPNOe+2+uiVd3wk2fsjrxz2AYil0l5iSqXIwk=;
        b=XVg/a8I2pxab29Y6sxQCIFKa1ozzh69n6fMdHbmiAUAYzGW14C79Q2sF9GRcgofRxP
         la5aRKl8CcZtIzYUW6YBHWaxaZzXvH9iiPlXV/Q8hvToUOf9+2nXcvIrtb57E19uVmEF
         TtSxcEtXMmVjVWHzf96hNNkbC4Bifc3teEXiIm+znrMrMmrqSZ5/HkC1GYjqwW7RhtsK
         qr4P+ys44PdiHROyV8/x26zu77ip/jV1Gvpe2WgPjzBQ07DrM1ErPUQgwRxbbivog8mc
         YFqa8JsApCNbqOGqQSpFki+MlClrQAMGZ5Bldvi0NZycJXaxEZYzdm21J5y5Q9Js+txk
         jvRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757365491; x=1757970291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UWxRVwHPNOe+2+uiVd3wk2fsjrxz2AYil0l5iSqXIwk=;
        b=Qibg+wsjxBDjEFItFTR00e8c+DkOdp/kkhjLl8nbZhY9WUpQ6payc83qQ3wrJxgBaR
         TzEechA+qVHtYH4BHATu1QJiyfR6nHqvwqli7f3vNsmj37JNgcJVug+sBIe6blSE/YNA
         qqvPaOCR7SDZJcnv4DVEm/DKH0RvZE1SsSy6eCP1C7VvzDozvPZH+CspA8TeH51ztvn7
         yNVe9MN0B4RMDjH6etYQ9jCK153D+UGGwP6V9wvQKaA2PiIc7tYCcTX1m5RV/I6R/9I8
         BM5Xp04zmE5Xmu3UkjlHThRiw31z5zkeinMkzKvDplFpsRS/L0+89xsGzsYUh3aDqLKd
         PS4w==
X-Forwarded-Encrypted: i=1; AJvYcCU6yuLRziTFwczKSztEAXkg6hbKcbFuXTl4MEOZaPcWnYgYw9ymWMdxt1PyHFjr8AEmi/mNCRBEN8taOAgWTHmoCNU6H1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqSuMsW5F2ziMrOXGM3CufH1kYM/ywyBerZKs5GKzg2KJpZRO7
	HyZrhpjRhSyb0TCPVbLI1PegkoGWvw3TiVmWdavNE9DsQjbPDI3JctbCLPV+H2WPGOkFo5+gJDU
	IBHQVxBt/1MmoWt2cdCeAr0NfRgeWFMyDZFB2fZuY
X-Gm-Gg: ASbGncsnELsV5M9ucjCnRrFdQBgE6yRNd2ssuHTdVEA797OR3NcfvaDhvAnRullgNKK
	8+3zYwcwxNkJHNA0QUmYoe0Pskkp+AwOqc0khLj9HNB0JifxRc6gZSr3qld2O6lq6YF6fzzHE3K
	vOTFm91/09m9UCJPqEG/ZM+fK8Pos9LUTTdRJaOGka+5Pv8GFxXA+U2DvZl1A92NVRA8rY8Vzxa
	c1lnURDVGig8SEfxg==
X-Google-Smtp-Source: AGHT+IE79+FIT2lX4STv+Qj4ZYvAyBp3s+l+jcg0XssqWBwViTVAGpnw+Z5FOAU+MwB1yvwYkfcgw1a6NpkNuJLIgkA=
X-Received: by 2002:a05:6a20:9186:b0:247:b1d9:77c with SMTP id
 adf61e73a8af0-2533e5731cfmr13792340637.3.1757365491255; Mon, 08 Sep 2025
 14:04:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9f35539de7188c6b853c55b76958a286131f5928.camel@huaweicloud.com>
 <20250902125457.2689519-1-roberto.sassu@huaweicloud.com> <82f22f97486622408bec772a9b025e301c8fa2f4.camel@linux.ibm.com>
 <CAHC9VhTGAcMTXHReinybpLzer7seCN+NUTHcFte+aU2oRNtNNg@mail.gmail.com> <0cccd05c0005d3b9e85ab92e35363cc69ea6a3f2.camel@linux.ibm.com>
In-Reply-To: <0cccd05c0005d3b9e85ab92e35363cc69ea6a3f2.camel@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 8 Sep 2025 17:04:39 -0400
X-Gm-Features: Ac12FXwlIo3NiwSuDYn-f8XtCjycRvjRK9k0DwZCt8BVbcg1kTR_F8_45fswT8k
Message-ID: <CAHC9VhRWt54V3nvRDpN_=gb5Fc68KznwDd7xhNmyGJw5+TQ5Dw@mail.gmail.com>
Subject: Re: [PATCH] ima,evm: move initcalls to the LSM framework
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, roberto.sassu@huawei.com
Cc: Mimi Zohar <zohar@linux.ibm.com>, linux-security-module@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org, 
	john.johansen@canonical.com, wufan@kernel.org, mic@digikod.net, 
	kees@kernel.org, mortonm@chromium.org, casey@schaufler-ca.com, 
	penguin-kernel@i-love.sakura.ne.jp, nicolas.bouchinet@oss.cyber.gouv.fr, 
	xiujianfeng@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 7, 2025 at 10:46=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> wr=
ote:
> On Sun, 2025-09-07 at 21:08 -0400, Paul Moore wrote:
> > On Sun, Sep 7, 2025 at 5:18=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com>=
 wrote:
> > > On Tue, 2025-09-02 at 14:54 +0200, Roberto Sassu wrote:
> > > > From: Paul Moore <paul@paul-moore.com>
> > >
> > > Remove above ...
> > >
> > > >
> > > > This patch converts IMA and EVM to use the LSM frameworks's initcal=
l
> > > > mechanism. It moved the integrity_fs_init() call to ima_fs_init() a=
nd
> > > > evm_init_secfs(), to work around the fact that there is no "integri=
ty" LSM,
> > > > and introduced integrity_fs_fini() to remove the integrity director=
y, if
> > > > empty. Both integrity_fs_init() and integrity_fs_fini() support the
> > > > scenario of being called by both the IMA and EVM LSMs.
> > > >
> > > > It is worth mentioning that this patch does not touch any of the
> > > > "platform certs" code that lives in the security/integrity/platform=
_certs
> > > > directory as the IMA/EVM maintainers have assured me that this code=
 is
> > > > unrelated to IMA/EVM, despite the location, and will be moved to a =
more
> > >
> > > This wording "unrelated to IMA/EVM" was taken from Paul's patch descr=
iption, but
> > > needs to be tweaked.  Please refer to my comment on Paul's patch.
> >
> > Minim, Roberto, would both of you be okay if I changed the second
> > paragraph to read as follows:
> >
> > "This patch does not touch any of the platform certificate code that
> > lives under the security/integrity/platform_certs directory as the
> > IMA/EVM developers would prefer to address that in a future patchset."
>
> That's fine.

Roberto, is it okay if I update your patch with the text above and use
it to replace my IMA/EVM patch in the LSM init patchset?  I'll retain
your From/Sign-off of course.

--=20
paul-moore.com
