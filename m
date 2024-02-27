Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB3015531D
	for <linux-security-module@vger.kernel.org>; Tue, 27 Feb 2024 22:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709072053; cv=none; b=t5iSQycLdB6Np2700uPIo9BPB9tReRyIzynWWVYhW+wenx3JevnVyKF7K1CfNNJ7jrmS8t2wMWJ3IRkUX0Vk+bnbmUpS0Ypa2CsiweOBH75xxZVx6gebccZg9q5U7edLZ5Ml8G3DuHMJW3x1lauHmtQtHqjVJf1WjIcY5yTGd4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709072053; c=relaxed/simple;
	bh=zqNdet0cnYxR5tdxAeiTzCtzka8qTvfd46LDjmjCpT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IYYJ3Dd1m3y8Kh9U0Jg/vG87YLAx++cSpZzAa727Je1SvrSkJvUqMO68nsZp/qqkh6TmbUe2pJ/q9UieSd7ruDo5b8OpOfUqJZbStheLjrSFZhRET+eFrLbeqfBfn6JXCsRe3du7pFaPZ/KaRCVTkaHN+GSlGlFl4CSFj8DpgRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=YIEt4nxW; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YIEt4nxW"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dcc86086c9fso5040094276.3
        for <linux-security-module@vger.kernel.org>; Tue, 27 Feb 2024 14:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1709072050; x=1709676850; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z1lHK46c00j9c5AVxNh7l6QQvoesmPrCexEpKozkdkw=;
        b=YIEt4nxWg3rkcDVhUOT6Zj42MVF2gBuH1EaoEe/1JWOqTJ7u2CvVNRdJyEtlgrBKvA
         s21VglZjwQG46dFhvSO1DFGs+YIcX7hjYvImwrk7y+FLT4kQJC2erxQN9ATlE0zSTHzj
         IRf0dnxsvbBvBeh4cm60uErg+EkTiRl8mgHAUQLasO/2aLCN4sWeix6b2F7/1vgLrj9M
         ATpN37NbOsk8XyVuD0i4Rka/oCZgoaEC7hab2FGOxpEsmtQxLdQj8wwTaf5RglKzoXAD
         Sbd2U/xT584UbN3Sg9QI3sMGaiAIr0Oq75zG+hTHFdhP7kUeM8MXWODAkd3WW2xawk9B
         LAbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709072050; x=1709676850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z1lHK46c00j9c5AVxNh7l6QQvoesmPrCexEpKozkdkw=;
        b=aQjFbfOT3NCv0/Y0x91C8wD5TsR+la7fwT6HddNyFg0qqu3uluEkpHbe3JzdHw3+Hc
         93DdBqAE+DrKoIGUPN9b14d9ZozovuXFDyi6VAcylQMfnWhnyOONuEbYQxm8f2Vt1Kua
         f0xqswQldG7ZApAWZcuu61E6+d1Vddc0gbrYz+CEoT/SRkM8BMgMAP8NhcemKXqSLKZf
         sPZd3TORxQ4lQIkaBmjot0nW6Eizwdwn2VkzVzJJCYOadZ2UgX1MzXsz8lgp2/DTyvSO
         E8fP8TVivzkgjdp5bGMU1gzA3mc/Xer5YMyZKNkucfC6kp7cTFcAA75yAbfPQBMx5tWs
         vj2w==
X-Forwarded-Encrypted: i=1; AJvYcCXykzXAYSRtEdYt6Ny2EVaWUqowXkwXck9w7IXaiA63bEEYdCXNbsTlg5/YiqxA5KEGTws2n0t4Ru80jITx+nugMuzZGcEh41cX0sCmsZulQP23F2l1
X-Gm-Message-State: AOJu0YzJyYbHy/3XTZFz4s56VHA2F/cYK62yOEEfRf9OlcKqLgZWw4FA
	nDqzX0XUe0PCFIaHMjdLM1Jz7nbDGJBZFUfCtjAQXBUgm0jvllWrk/VIPFSuYAp4toF+auHV2Ie
	i2+eBjXHuA2BCFRFIzai2V07OGSizgnTo4JSl2kCSG+Y4zdk=
X-Google-Smtp-Source: AGHT+IGRVvvOY/VqcmO82mSRPFB0J3eVmQ9MxGbLqbRmchF/0OyQlRzjMchsC/uFbZTJZUF0dxbNTvAoF7VQECE+/vI=
X-Received: by 2002:a05:6902:100a:b0:dcc:1f6a:d755 with SMTP id
 w10-20020a056902100a00b00dcc1f6ad755mr838760ybt.39.1709072049607; Tue, 27 Feb
 2024 14:14:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223190546.3329966-1-mic@digikod.net> <20240223190546.3329966-2-mic@digikod.net>
 <CAHC9VhQGLmeL4Buh3ZzS3LuZ9Grut9s7KEq2q04DYUMCftrVkg@mail.gmail.com>
 <CAHC9VhTUux1j9awg8pBhHv_4-ZZH0_txnEp5jQuiRpAcZy79uQ@mail.gmail.com>
 <CAHC9VhQHpZZDOoPcCqRQJeDc_DOh8XGvhFF3M2wZse4ygCXZJA@mail.gmail.com> <CAHC9VhQL9REbeyP6Lp=0HT=0LryPnAOKAbBF4gH9c=cBbJxaFg@mail.gmail.com>
In-Reply-To: <CAHC9VhQL9REbeyP6Lp=0HT=0LryPnAOKAbBF4gH9c=cBbJxaFg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 27 Feb 2024 17:13:58 -0500
Message-ID: <CAHC9VhR2=bzVqHtcPH7-cSQRBnfphzzBQ4n9agXWMtasK9wh7Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] AppArmor: Fix lsm_get_self_attr()
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	John Johansen <john.johansen@canonical.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 5:09=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Tue, Feb 27, 2024 at 11:01=E2=80=AFAM Paul Moore <paul@paul-moore.com>=
 wrote:
> > On Mon, Feb 26, 2024 at 2:59=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > > On Fri, Feb 23, 2024 at 4:07=E2=80=AFPM Paul Moore <paul@paul-moore.c=
om> wrote:
> > > > On Fri, Feb 23, 2024 at 2:06=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <m=
ic@digikod.net> wrote:
> > > > >
> > > > > aa_getprocattr() may not initialize the value's pointer in some c=
ase.
> > > > > As for proc_pid_attr_read(), initialize this pointer to NULL in
> > > > > apparmor_getselfattr() to avoid an UAF in the kfree() call.
> > > > >
> > > > > Cc: Casey Schaufler <casey@schaufler-ca.com>
> > > > > Cc: John Johansen <john.johansen@canonical.com>
> > > > > Cc: Paul Moore <paul@paul-moore.com>
> > > > > Cc: stable@vger.kernel.org
> > > > > Fixes: 223981db9baf ("AppArmor: Add selfattr hooks")
> > > > > Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> > > > > ---
> > > > >  security/apparmor/lsm.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > If you like John, I can send this up to Linus with the related SELi=
nux
> > > > fix, I would just need an ACK from you.
> > >
> > > Reviewed-by: Paul Moore <paul@paul-moore.com>
> > >
> > > This patch looks good to me, and while we've still got at least two
> > > (maybe three?) more weeks before v6.8 is tagged, I think it would be
> > > good to get this up to Linus ASAP.  I'll hold off for another day, bu=
t
> > > if we don't see any comment from John I'll go ahead and merge this an=
d
> > > send it up to Linus with the SELinux fix; I'm sure John wouldn't be
> > > happy if v6.8 went out the door without this fix.
> >
> > I just merged this into lsm/stable-6.8 and once the automated
> > build/test has done it's thing and come back clean I'll send this,
> > along with the associated SELinux fix, up to Linus.  Thanks all.
>
> In off-list discussions with Micka=C3=ABl today it was noted that this
> patch also needs a fixup to the commit description so I've replaced it
> with the following:
>
>   "In apparmor_getselfattr() when an invalid AppArmor
>    attribute is requested, or a value hasn't been explicitly
>    set for the requested attribute, the label passed to
>    aa_put_label() is not properly initialized which can cause
>    problems when the pointer value is non-NULL and AppArmor
>    attempts to drop a reference on the bogus label object."
>
> I've updated the commit in lsm/stable-6.8 and I'll be sending it to
> Linus shortly.
>
> > John, if this commit is problematic please let me know and I'll send a
> > fix or a revert.

I also just realized that both this patch and the SELinux have the
stable kernel marking which shouldn't be necessary as the LSM syscalls
are only present in the v6.8-rcX kernels.  I'm going to drop the
stable tagging, but leave the 'Fixes:' tag of course.

--=20
paul-moore.com
