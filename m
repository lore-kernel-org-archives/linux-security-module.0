Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B69145FF7
	for <linux-security-module@vger.kernel.org>; Tue, 27 Feb 2024 16:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709049697; cv=none; b=Cg4pa2hygB5ZqkE0PaB6hn5d8a4eom8ZpbQ6sdKNGuFBdDrqPzQwDQHhTigHLevQhQa41b1gPVZkD4OffF1972Wfsxd2EuCQ3D9UaTqaApCTZjKwzgKZ0kg1SZJbP5t/BidvKMz7FXc1RtZBqDi28/wA1vNosOzNpMNTIY57GHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709049697; c=relaxed/simple;
	bh=YcbXQMW6orIGD2J32M5lewwEx24IkTPl43MiFtSywpA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h5x2Y8Z7i3Q7cIXSK8Siz0lArxz6El1PsPmf1C2spKiJsgbRZ5MycDhH1x4RasT5tbxpGomJRtv2RBU3LLLBP5gDj7oYHzlhQNelsbR4YLrPRAev75P1z2VM4soMuDNfqGEpR7GIpglhvj8ZLbM6qVNbdbzNe1g/GmWpmoyH160=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=I4mwwlWB; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="I4mwwlWB"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3c19e1846ecso1415939b6e.2
        for <linux-security-module@vger.kernel.org>; Tue, 27 Feb 2024 08:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1709049695; x=1709654495; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ac+DW6WihzpCoOAFiLjFcHhP6f2iYTwciWP36cUV4HM=;
        b=I4mwwlWBWiZMVsYyZri+BrABvznzJdfpLDhkf6bWJYaTPX71+h5/owfxnSjWNfpkAY
         nPAdR0wGWT1lxu/+UQb3/bQyhQWeavbcexWPhORfXfQR6jV0GV5VtR3ENgGtuv7WXUCA
         la/fYWCwguC0k9foii7UY+o/2LPWd66tZP2LUIEnpfv1m208fqfjrBKVelMIO4mU9P/G
         2yppWWb5N/tKS4kfxQfQoRWaeK0L5rHiu1aC7I8zhzQ9lE7CNPfetjuk5eVJwmU3KXVB
         IJhTc2PzPUuylsC0lz9KYnBBhdGFEUzrwK+UEKqtz6nVjEvUcwYdMx1OlyaKC1QPOz7S
         Vp7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709049695; x=1709654495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ac+DW6WihzpCoOAFiLjFcHhP6f2iYTwciWP36cUV4HM=;
        b=cDcYFvWKCBu6wKqXS9WXlpXzqDpIhJnvgcMQ6wkhXIQJuO+BG4p7BBdh8Uu3W5qvbM
         QeEvlrWHq49moZhPLkgO0KF01+bs0vPPlTbcvxmitW2pqnqF4gqPRZJ2mHH9mbtmbZky
         lSW4DJ/g5VDv+xJa7kbo3dX3cM9P+LgchCZXDAVPE/d13/TUPaX+22pZOPzz4DHoAG6E
         aAagrJU2MpItSKBR68MmWCAnxTkc3xvnvg6RxsKhsapbXBhA36TEYExXpUw7cfmMQYa3
         RJk56XIjKKlX8weeBr4sRrA/BonG0gYbFLvAwR1YWq6r0kaWFxcN8fIDK0018O+/9kz7
         Aokg==
X-Forwarded-Encrypted: i=1; AJvYcCWG68gB/LInYcyUob6Ro6i/yWUCdV6WUGjz8BKB5f5jvqEORYqiSMgFKggMu6/dYp6s6CBMWcNfPndIxFXrRRAk0/91fW2kno9dzd7BATug7kty5kay
X-Gm-Message-State: AOJu0YyvO/Rg1bh8rV3tdjcM8KWwcSrf/p81pxI8gEZurprx1PxsXeZ9
	kdAoao5de2LJf+qGhfHiMxCDFTzREkIM/GSjeKYq4pB2EI8w0a/apX80K/vzMH0fpY3mnYFDk6h
	fMUFUR10VDzlB03LvYj/Ks2KeBK6hf+/iVMYS5PXHH38WwZM=
X-Google-Smtp-Source: AGHT+IE9MdMFU9x6FoxeTlyyLtbrwrCH54o03/D8XMEA7Si2aBMN5Aya/Dkp9vESrpYl2ue09rzvpreM73e0UemlMqU=
X-Received: by 2002:a05:6358:5e8c:b0:17b:5d21:e86e with SMTP id
 z12-20020a0563585e8c00b0017b5d21e86emr12410573rwn.3.1709049694861; Tue, 27
 Feb 2024 08:01:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223190546.3329966-1-mic@digikod.net> <20240223190546.3329966-2-mic@digikod.net>
 <CAHC9VhQGLmeL4Buh3ZzS3LuZ9Grut9s7KEq2q04DYUMCftrVkg@mail.gmail.com> <CAHC9VhTUux1j9awg8pBhHv_4-ZZH0_txnEp5jQuiRpAcZy79uQ@mail.gmail.com>
In-Reply-To: <CAHC9VhTUux1j9awg8pBhHv_4-ZZH0_txnEp5jQuiRpAcZy79uQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 27 Feb 2024 11:01:24 -0500
Message-ID: <CAHC9VhQHpZZDOoPcCqRQJeDc_DOh8XGvhFF3M2wZse4ygCXZJA@mail.gmail.com>
Subject: Re: [PATCH 2/2] AppArmor: Fix lsm_get_self_attr()
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	John Johansen <john.johansen@canonical.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 2:59=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Fri, Feb 23, 2024 at 4:07=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Fri, Feb 23, 2024 at 2:06=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@d=
igikod.net> wrote:
> > >
> > > aa_getprocattr() may not initialize the value's pointer in some case.
> > > As for proc_pid_attr_read(), initialize this pointer to NULL in
> > > apparmor_getselfattr() to avoid an UAF in the kfree() call.
> > >
> > > Cc: Casey Schaufler <casey@schaufler-ca.com>
> > > Cc: John Johansen <john.johansen@canonical.com>
> > > Cc: Paul Moore <paul@paul-moore.com>
> > > Cc: stable@vger.kernel.org
> > > Fixes: 223981db9baf ("AppArmor: Add selfattr hooks")
> > > Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> > > ---
> > >  security/apparmor/lsm.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > If you like John, I can send this up to Linus with the related SELinux
> > fix, I would just need an ACK from you.
>
> Reviewed-by: Paul Moore <paul@paul-moore.com>
>
> This patch looks good to me, and while we've still got at least two
> (maybe three?) more weeks before v6.8 is tagged, I think it would be
> good to get this up to Linus ASAP.  I'll hold off for another day, but
> if we don't see any comment from John I'll go ahead and merge this and
> send it up to Linus with the SELinux fix; I'm sure John wouldn't be
> happy if v6.8 went out the door without this fix.

I just merged this into lsm/stable-6.8 and once the automated
build/test has done it's thing and come back clean I'll send this,
along with the associated SELinux fix, up to Linus.  Thanks all.

John, if this commit is problematic please let me know and I'll send a
fix or a revert.

--=20
paul-moore.com
