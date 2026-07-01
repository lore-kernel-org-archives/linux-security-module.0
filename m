Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BEF330D35
	for <linux-security-module@vger.kernel.org>; Wed,  1 Jul 2026 18:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782930821; cv=pass; b=Hw6zCRuDhyn2MTlIIFxr56YkWeGa7c3jgjteoQM39JsECydQW5gU91/uvlqzF2/2CfBsT8OtG9o6DxTcwL4f796K1bGS6AVDTpWkjhd8i4ToqJ8okakzpb6UWXmdJAzFEwFDPuDyktRKv62u88PO92G6FUrmcsakM8B4xF6NizA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782930821; c=relaxed/simple;
	bh=NHi5bXagq2PW7+7GUvb45PHMMKBGFsAVR5cwXQ4fOCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EFHpnO6eKjqMAcllVAbgPhrGrbk4IetqPyAZqfoaxg/w1HnKLOFGqnptzwD9W//otJDsyx9Uqs8IX5ZJ7O9PiC87qUQgWIZStiO1cYhf6maUl4FI+sN/ey1TbOQNx/7Ua0wO4gdVa3lnca7xTiAikwOCtwgBj6V8YyZhA7f4htk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=bqebpa1m; arc=pass smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="bqebpa1m"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-845b6d9bf39so658442b3a.1
        for <linux-security-module@vger.kernel.org>; Wed, 01 Jul 2026 11:33:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782930818; cv=none;
        d=google.com; s=arc-20260327;
        b=so67/cvQzCyLMWifybt8vR5vyWke20TWZNGHx98PxauNX1kgdQe9zcrfOhYJYwSwhE
         BDpaFkn2LpzE8TfP1nVR/6aXqbVNrgWaijhMnJ+h7TtGLe0b74vwtgmh2Kn4AtGX+ltg
         9eyhYOktuSfP1bogEawr8moxFiJdAXSRx+Dt58cVfsxTFfzP2AiJfq2CQUw3wdTTYy4h
         o5lKg9vVyPjC4jfayT6glCOIqQyVK4aXIAIMkob+SvLRoLI1FUVStSTrPvQI1XKyGPvD
         WPDzZUjSl+7Acid+aYY5w6fjQir/fauoYdzIgGK66dkFRpRO5Z8Wv76szIQiSq90/Xkm
         sFIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rnl3zqI1JA5b/M0bVVPPEG7QizZgQWNx2m7hgpcgEjI=;
        fh=0BE1XeajuqeYNHMDJFWXrCgpjTVhj6Oi4LBBBhd8Y5Y=;
        b=n3fu7/eV0DOaLje1eRc0aTInEsHxmO8tTx0By32Py2Ce+/vLYKH32HsEcGk/Bmei5X
         2BmHkGGLeu7bBQgjUvpckCK2LcKf3HinyJ8hNjgPn6deVVz34x3xQMVI9FBn4sguwuUS
         gsRcnPQ42drQArSXtQfdZMBkVJoC1r/O1EW+MqKW2ipexXHd5dBZTTtoHeVbfVe21x/f
         VFS9d29XfVAhiW9W/CnhZ8E+WzsPSEVPFCsw7/0wR/9ESFqYnCFe7XUrrgS+5Tm2ytu4
         bSxytr3VnTNkZSi89ja+CNBH8TcYstdQffZ17ccQqWwn4yUeuz9dTct2N2GGxoAnFR+7
         EaZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1782930818; x=1783535618; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rnl3zqI1JA5b/M0bVVPPEG7QizZgQWNx2m7hgpcgEjI=;
        b=bqebpa1mIbXWBS5CLw+k2UQhZPv/hVZphiqKb6GAl88kUJyeljtIBDo+z/gnKEbaKm
         nEp97Pm03i2ePlNUn5AlBrpCOiafCTcx7Hs53mUV0vLTu0TfHJqBgX5rhdscrAu+UJQu
         c94AnAq8q74qmU0Gi0Cm+f/DeYUhkIXH2p3wcEJ2F5Hv9nA06Z+a6Jc9vEh15ZuHr+0B
         o7xQ+t1Mvq6NzwWKhh1PFkijeyk+V6wTnmruRTkTPHtVmxXL2IMQrYAyuK/XP0Tgxu5k
         Yt86oT6dHkTPU6TZ1s2+X8UEADvJe5ltR7zY/XdKjeLGvsZXRFA8hvRoRQAfh+mxKdUS
         Ur9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782930818; x=1783535618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rnl3zqI1JA5b/M0bVVPPEG7QizZgQWNx2m7hgpcgEjI=;
        b=O6ROPTvTPQ7qwAahoFR8jlDbf6Jj/vhoG/Lc1GfIvX0m5SkmipudASghb1z7SYTEp0
         oyCIqBpeonCCbmCwpuLtF0ZASiVDWzQVapuOyU6bIfWB0clnq09iakIWvg0e9ORdNoeK
         CuGAHLMjKXQDkyQcHRq9Hn0luVFf2LJ81CD7SUuFgR43XejDXFPZubU4rChenhi5Y2BI
         fpqta2eaqo+Oe3Ns/AM+MBpm5X5spQ8mVnafqyoD/xpjQNsaQ7RixJOLwuMulmcnu2Ru
         KBTxTD43QmuIVGDboPyKPxRFenVqzeUmUW0B/9YTqWZsLFAVKwUMINZWRc51oXk/dzdF
         fY5g==
X-Forwarded-Encrypted: i=1; AFNElJ/DEJIMUA17LoZx8RSn3vta/yTIpF/7sz1b79J2YrJouR6i/EKdQP5HQtAYB9lol5MnQ7xxI/sXuIZwDrHI7+8u1+TW8cc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx3/6dvBHXlp11fKUnGNNxGG/hQuT3twvxnTDCn2qBhcrTslpc
	3/nRKRChLtJ5Rbumc2ZL8uZVbaBY2BftsQ68QhJYcrmwHw8nBXdQanIR39EdUEAEYJ/v/pb8lVX
	stveHctzeYj5e14xVBuDmj/LA1DwOvZa3FFfNZknr
X-Gm-Gg: AfdE7ckg26VJrbY5NsW0YKsNyTrtCfKXi7RCI9HLIExNiAy+TqYIKv/5gRz2BG7ceba
	QO0pwhDWouzdWlkJtfZvYygfwsN+71+0zSbUqyKZBCJD58Do1DVt/RahpAGpxk9VIz//ERDdgt5
	8g0D6UNpQo6t3e3mrwoRQUMqWM5gnfjXFUk3NoC1ZGDToQA9jFaHfajNVjQnl06l/MyrjEwcSe9
	GLWs/a9goIqvharpw/6zWyW/ABF0yeamDLKwuBCL/KU2b+ey47kowoLKlkm8ELpa4nMfoNs
X-Received: by 2002:a05:6a00:22c9:b0:845:3608:90be with SMTP id
 d2e1a72fcca58-847a82d93d0mr6309487b3a.17.1782930818301; Wed, 01 Jul 2026
 11:33:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407200157.3874806-1-utilityemal77@gmail.com>
 <20260407200157.3874806-7-utilityemal77@gmail.com> <20260701.ze4eph1eKo7a@digikod.net>
 <CAHC9VhRfqSoM89WC6TdQHapUVQe8a18rW2c-F7+tu6EjM9EdCA@mail.gmail.com>
 <akUH13qbsEnJLgQu@zenbox> <CAHC9VhSjRcMr9+5dMkep_TPKduYdob-bZ73FLfXd_o2xiWwOSg@mail.gmail.com>
 <akVbLGYyafZq_93v@zenbox>
In-Reply-To: <akVbLGYyafZq_93v@zenbox>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 1 Jul 2026 14:33:26 -0400
X-Gm-Features: AVVi8CcSSANgttFtvXFj_mSXCnTrfkayt9zsVvnF80WzPHPaIUdOPirjWkOrJQ8
Message-ID: <CAHC9VhRp6pvQXskNU0FXBkDw=MAF8Ht1Mk7BbUeU8JnEkSk52g@mail.gmail.com>
Subject: Re: [RFC PATCH 06/20] bpf: lsm: Add Landlock kfuncs
To: Justin Suess <utilityemal77@gmail.com>
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, kpsingh@kernel.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, kees@kernel.org, 
	gnoack@google.com, jack@suse.cz, jmorris@namei.org, serge@hallyn.com, 
	song@kernel.org, yonghong.song@linux.dev, martin.lau@linux.dev, m@maowtm.org, 
	eddyz87@gmail.com, john.fastabend@gmail.com, sdf@fomichev.me, 
	skhan@linuxfoundation.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Frederick Lawler <fred@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 1, 2026 at 2:29=E2=80=AFPM Justin Suess <utilityemal77@gmail.co=
m> wrote:
> On Wed, Jul 01, 2026 at 09:28:22AM -0400, Paul Moore wrote:
> > On Wed, Jul 1, 2026 at 8:52=E2=80=AFAM Justin Suess <utilityemal77@gmai=
l.com> wrote:
> > > On Wed, Jul 01, 2026 at 08:12:34AM -0400, Paul Moore wrote:
> > > > On Wed, Jul 1, 2026 at 6:59=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mi=
c@digikod.net> wrote:
> > > > > On Tue, Apr 07, 2026 at 04:01:28PM -0400, Justin Suess wrote:
> > > > > > Create 2 kfuncs exposing control over Landlock functionality to=
 BPF
> > > > > > callers. Export an opaque struct bpf_landlock_ruleset preventin=
g callers
> > > > > > from accessing unstable internal Landlock fields.
> > > >
> > > > Generally speaking we don't want to provide APIs, either in-kernel =
or
> > > > at the userspace/kernel boundary, that are specific to a single LSM=
,
> > > > see the LSM syscalls or the security_current_getlsmprop_subj()
> > > > function as examples.
> > >
> > > I would raise bpf_ima_file_hash, bpf_ima_inode_hash, as examples of
> > > clear precedence for this. (BPF calling into specific LSM)
> >
> > The BPF IMA helpers were merged back in the v5.18 timeframe when IMA
> > was still standalone, it wasn't until v6.9 that IMA and EVM became
> > proper LSMs.
> >
> > > Kfuncs are explicitly marked as not being an ABI, and are more
> > > flexible for later changes / deprecation etc. [1]
> >
> > The issue isn't so much the kfunc itself, it is what the kfunc
> > *calls*.  From what I saw in the proposed patch, the kfunc calls
> > directly into Landlock instead of passing through the LSM framework,
> > e.g. a function wrapper in security/security.c.
> >
> > > LSM framework API can mean a lot of things. I assume you are meaning
> > > like a pseudo-filesystem mounted interface that controls LSM?
> > > Correct me if I'm wrong.
> >
> > My apologies, I should have been more clear.  When I speak about the
> > "LSM framework", I'm talking about the abstraction layer that provides
> > the interface that the kernel and userspace uses to talk to individual
> > LSMs.  The LSM framework is analogous to the VFS layer/framework in
> > that it provides a single API for a variety of underlying subsystems.
> > While not 100% correct, you can think of it the LSM framework as being
> > the functions/hooks defined in security/security.c.
> >
> > Does that help?
>
> That does. security/security.c seems like a good place to enumerate the e=
nabled
> LSMs and to check to make sure that Landlock is actually enabled both in =
the kernel
> build and that the Landlock LSM is up and running.

Yep.

> The above patch only checked if Landlock was compiled, when it should
> actually be checking if Landlock is actively enabled.
>
> So I will probably make a shim for it there that gates calls to
> Landlock.

Please keep in mind that the LSM framework API needs to be reasonably
generic.  We've got some general guidance on adding new LSM hooks at
the link below:

https://github.com/LinuxSecurityModule/kernel/blob/main/README.md#new-lsm-h=
ooks

--=20
paul-moore.com
