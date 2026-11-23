Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795463738;
	b=b4Y3V5dpPqMv/kJaDnxF6eE3WLvHHR9ms1qZ6DZ4YpLnuyyzq96JyWxz84SoUrz8Ctty
	 LKjtDKMVQcTR0QQNIGR1b0j0txLvrgTDB7dGA4dPb3XudHnucBDgcR/ti8cqnclwlPQ92
	 Qi5ItsjUtKWekDlgVES0dZL+w5nFZw2tSQ2E6Hi/eKI5Wv803f9Va+9aZghA+pEB8MguE
	 v6DlWtxTF4Wh97JlkT2y3mlwUgk69iNzdwiBXRFJpYLb+e8cPm4adOH/3HzPzlNAg2J+r
	 oXG6yE4/YOm+F5VuxDLicAwx+ngT3tfixmNavSgIsRv6NpAYXoKXJ9N5MyyxskQb3qA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795463738;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Gd5vkS8rekRzrNw14AZBHfRH+N9fBKRzF69D+TwAlOc=;
	b=yzHrWcCkrHlh+uc2ZYyFMOmAFzUpx/cNFKz/wHxOwlMIbOO27Rplip8nn4YTjvKZ0N+X
	 5uosIJvndR70yqDqhou15EsndB8tNz6jVTdzJJUS5xjyKHJl703+C4YtB9/9T7YM0dnf3
	 JnagMX8QdfY8Fc6sJa7V/9SW7FlNj9qjDhHPxkSXjNKH9Izz4+aReO3ZGh4eePEcH2Se1
	 au5jJEc8djBLuwra1sQgiOvyASanbgXNjXRxvfj3Tk7ZGSWu0QGwmR2EU/QuEsc0kyf3n
	 3yWeqpwdpcB4I0tJQ3ztKxScl5RHeeWRB0Acb3IwsaiQPhyBd5qPcx6rIfeAH9o+wXg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=klX4BZ2S;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6012A606A31E
	for <linux-security-module@vger.kernel.org>; Mon, 23 Nov 2026 19:55:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6012A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=klX4BZ2S
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4a358881793so1903716f8f.0
        for <linux-security-module@vger.kernel.org>; Mon, 23 Nov 2026 11:55:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795463737; cv=none;
        d=google.com; s=arc-20260327;
        b=SWrqyWAAv6Y9M3pECbaCVFQTR2FM6bh6xGsbgahVE/TVK+ylh6hoWXlR9n6W4NLsI7
         EqW4Dhf6JDzv/EAV4nvjqE+QEVnhkhemIfY9WSTnKz3BYm5UOwisnA2veKyMUE5u4yoW
         TQ7njGzrv7HikJLKILsd1WCkj95o1B7QJNdnwzYd/+SNfnk1lui3sXgBUOce+cg1ejSv
         cERcjrpKPN/Imx3hBadLrhzh9mymKJI+i4qfHKobibciGaej2n0/vWdXT8FJJ1nOPhCb
         3roy/sl7eryuzRJrB9PEXmSwWUBJuO9r65tHXl0TwF5JgPieKsypAZQKg1dHUl/7eH6a
         I4jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Gd5vkS8rekRzrNw14AZBHfRH+N9fBKRzF69D+TwAlOc=;
        fh=QJP/LpyOUpQHM/T1FXtAHmUOleIzj5bMhWTc3urGSiA=;
        b=X8rDONSdwnLaJb/ug+yy/NOltiR0ij2KwbKfgN/e1YrkAYtaPx2wwqqsVNHllL++cJ
         WNTi69+/6dmnbyOrRygf2ZNUvYODCsNiKYe4CbO4/ch2zbN1cv3ZL3HAVZrCAOMob0s5
         Bl/gHYQNTiVItT0tFAtFKVphv4o9cLgdOHbJEDBu0fLV9eJDm/ZUy8jUAE1HWIZnEHXi
         3MwNRyD4T75eJ3JKaYiauVGB6ztbAWvf6wjLuDtfT+jTsLLopoHbc944Y4pnkCKGb9ts
         B3FVDuGwE4VGpHwKGJf8ODXGUT2DciGOZYeO9NdcUhX4zrtTmKMRvlAZlRXtE3Q+05pd
         cAFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795463737; x=1796068537; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Gd5vkS8rekRzrNw14AZBHfRH+N9fBKRzF69D+TwAlOc=;
        b=klX4BZ2SJNTMSrywDGSIV/16noC15wpAvjoBOkCL6VprZy61rDcD9QTHuztfR9Tuzg
         ya2nK4c06Oxw/VjQ01rYZooWGjRYhIlcehQDLDYYHAihJcTUhaX+DcZEH7BVZC7b8DdI
         3VE9xpA6SNF0jRhObUVsSkdyTgO/dD9XZSshAODtcgr/63eyBQDMfk2w21S/AWnlOAmx
         C6Nxy8ygfimfdk7a67J7QXglsWVIVZ87KpZL0j3iWCA02hOY1H6mCULb6CwOnFGgqsaJ
         Z1GsKqUmNaVZa85kFWwKTasKVepJYI+oWjQPr8BOLjrBomj0HKFEKJN0TbNA9qYZJyZo
         rGiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795463737; x=1796068537;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gd5vkS8rekRzrNw14AZBHfRH+N9fBKRzF69D+TwAlOc=;
        b=ZsI88Owtpcn5QvvUznF0c6g1uOaMoEJBfElxco0kgefFeBHKelXDyn5CUktpxrAI5y
         ub/yuNqDagTI0zBhRJJSQVlbhJjf4Q2ACcq0J3jP2dIsp2OwRaQduMOhfBdh7V5H1UYZ
         fgKfc5TPJRy00qX9p/VsVcEWlsP7udmFRDRPqN47CLjSyZHN4o+x0KxHrRSoQpFUvWkE
         2I6Q8+lujq9Zvwyb218KKj2+mlxBoiLXpjDkGMoN6y6zHb1tSO3FYqQ7BtBimv7kjg4H
         A9gqhKvEIGxOQgDBtaxCd0z3fxQvJ4ZkBdKeIaAE1MrtKqL9OAWf+sapcmVFgmAY7Drz
         rBdA==
X-Forwarded-Encrypted: i=1; AL+hErEpIGamtd4kt3mRw8VHXK2EVcuTHgDp5E9LBefW6u7uOsr62j7b777bH8uyluUnulL0BPPXcWMkPmrBnpvY5jw6FdH4vT8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/glS7iiHsrOBqwI/d4nP11P5Kuuepnb3YW2L4YfGxcX+iXlUq1
	FoRRZwQ2GNBK+42cL6eQuQdNx3KttUom64ejCP6kIxJVkN8t0Q2aJxsTcuM723ynQh6+Kl4FNmt
	znQyMGB9o4RInnYdE5IRnVMq408K22vI=
X-Gm-Gg: AZFdTZcCh1RM9LyGr6oU+8F+Nv9kfszlhG/xmmiXSBb5i3NRpDt03lB8p1u255JGVK/
	i4gW84jQcBYD3yWrq07ysfgnl/MUr0+hingdfWleLNMY01/Q0g8Dbxbd4Ttr8I/bdgMRYSEz4CT
	g7u+WYo5/PdICWVr0bCQbGHhk+V3BvIjAC4k6Sc5ewpCO4cp8cdFPP2sezk8skDh3TlgqDYF8Yi
	GwHs9qJd6QQpFukSLBFN3Mvu+jixPl9kRCj9M5BQ3XRC/TTz7tcTaVem4+zxKBs8bxQ1bvGD/vi
	hociNwvFbAiZqc+dj91QamQjO9jG9i5fQIvZukWyaWzKwQrm2VJ3padY28QdLm18KfDgkYY7hqK
	gW2MOkwn5Pw61LNkq7IjzNOOR6z6txlqAJbMsV7ZVtfdYET16nokMbzDOE94RCzN4n9ZmZPPqS5
	Uuh4BlpV5eMCgAmtx/i3XGI9OtgSQtSYPgdw==
X-Received: by 2002:a05:6000:29d2:b0:4aa:831a:d0eb with SMTP id
 ffacd0b85a97d-4abb3c37a50mr16976489f8f.9.1795463736432; Mon, 23 Nov 2026
 11:55:36 -0800 (PST)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <d85ece6e-27f9-4d9f-83af-4101bc76fef6@app.fastmail.com>
 <356db94e-f5d6-4fb2-839a-b97aef72256b@app.fastmail.com> <CAHC9VhR9sjunJRnM9gy-BkBZkapQTrr8a8FtmaK7JkAmUqTrLA@mail.gmail.com>
 <CAEf4BzZKmn6g0SK8OddjKFj_vAmZFvpZv32Hs_S+GHgT7VNfrg@mail.gmail.com>
 <9d6bdc31-e57c-4187-be78-29d82471f710@app.fastmail.com> <9695ec3d-7b81-488d-989f-0bd411d673f2@linux.dev>
 <CAPa8sAh6b5xn4rZzPfM0nZ+_kkywWj22fy8deLq+6qYews0rdQ@mail.gmail.com>
 <MRYP264MB7057096D13282544720793F2E67A2@MRYP264MB7057.FRAP264.PROD.OUTLOOK.COM>
 <CAEf4BzZWEU24+ZC0W_20hc3t+qnEHncQA1ztTF7ZPPOf3DDPVA@mail.gmail.com> <CAHC9VhSFvOiP5Tyt=rOFMwg=Ro1jRw+hfcw4AdCkEyftZJHQCQ@mail.gmail.com>
In-Reply-To: <CAHC9VhSFvOiP5Tyt=rOFMwg=Ro1jRw+hfcw4AdCkEyftZJHQCQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 23 Nov 2026 11:55:24 -0800
X-Gm-Features: Aa3M54rW4zsDQnYRhxM3Ycfdbtgyp7iJNkovd2OcGLgGuI-HlydZfB9BSFPhl3s
Message-ID: <CAEf4BzZqjiWR4EzBFdV-czH-GnxqOeOAsMLgXtQ6TwN2ZiiT8w@mail.gmail.com>
Subject: Re: [BUG] bpf, lsm: new first argument in 7.4 inode hooks silently
 breaks BPF LSMs
To: Paul Moore <paul@paul-moore.com>
Cc: Paul Mabileau <paul.mabileau@harfanglab.fr>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Daan De Meyer <daan@amutable.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, roblabla <linux@roblab.la>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2026 at 11:37=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
>
> On Thu, Nov 19, 2026 at 12:59=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> > On Wed, Nov 18, 2026 at 7:14=E2=80=AFAM Paul Mabileau
> > <paul.mabileau@harfanglab.fr> wrote:
> > >
> > > Hello,
> > >
> > > On our end, we also have already merged code to adapt our eBPFs to th=
e argument order change. However, we would still prefer if this easily-avoi=
dable breakage could be fixed by moving the argument to the end, even if it=
 means having to revert our fix.
> > >
> > > This is motivated by the fact that such a change is not made in place=
 on our end because we ship our software to environments we don't control, =
meaning that any and potentially all versions ranging from 4.11 to the very=
 latest should be supported, so the change is made by compiling and shippin=
g a new variant of the concerned eBPFs for the version interval it is valid=
 for (7.4+ in this case). And that has to be done every time there is an up=
stream change like this, so the total installation size and overall complex=
ity grows accordingly.
> > >
> > > If we could avoid that, especially for such trivial root causes, it w=
ould be nice.
> > >
> >
> > I agree, and that's why I'm asking Paul to accept the patch reordering
> > the newly added argument before 7.4 final is released.
> >
> > I do not think that the maintainer's personal preference for argument
> > ordering beats real user pain.
>
> As stated several times in the past, the problem lies not with the LSM
> framework but with the lack of an abstraction layer in the BPF LSM
> providing a stable API.  As far as I can tell the lack of an

I think the problem lies neither in the LSM framework itself nor in
the BPF LSM in particular. Neither have any abstractions built on top
of LSM hook prototypes to guard against argument reshuffling. And
that's fine and basically inevitable. If you change LSM hook
prototype, you'd need to adjust source code of all LSM frameworks
relying on that LSM hook (which is easy for in-tree source code, of
course). For BPF LSM, if argument is added at the end, that pain can
be avoided completely.

> abstraction layer in the BPF LSM is by design, and while that does
> provide some advantages, one of the notable disadvantages is that the
> API is unstable.  If you want to be upset at anyone, direct your
> frustrations towards the design and current implementation of the BPF
> LSM.

What upsets me is that your personal grudges against BPF community
(or, perhaps, just particular members of it, doesn't matter) gets in
the way of doing the right thing as a maintainer and putting Linux
users' pain above your personal preferences and/or dislikes. And
hiding this behind "I like this specific order of arguments" or "BPF
LSM should have better architecture" is just petty.

>
> --
> paul-moore.com
