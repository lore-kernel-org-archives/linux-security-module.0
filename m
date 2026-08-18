Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3226234B669
	for <linux-security-module@vger.kernel.org>; Tue, 18 Aug 2026 20:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787085228; cv=pass; b=JkPcPBg5HKjpb3mur2b0x9qHufcIOQiQ3ji2Np9DO81pQQa2faVtxbHDhIbIBLnAG1xxKUMpDZ6oqSD29+ZebmqrtXRcFgbTpqWhWPGU7VYs1VLYojDG2EzW7c5VWmp83oo/A/gviajETMatXIi++tpzUeJC9q6n5git+n6rT1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787085228; c=relaxed/simple;
	bh=ahO/hxkyhcx9MbLYLXI4ZZtDhucoaenUkK08RmlXrNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NuemsA1Irc+42Qw+5vUqUQM9liMOsVhMMM5HubuwPke/oYRdVzyRk/lYlFyVJvPJc+ljI3DzjDO4BzKm2K9SVDZooFaa/17owVQOccZqwfCBmKIOYjra2PSRh3n14hC/pPOFhcn4Oz2QG2xMgVzC+hN8BijIyKNPUf+IVt6xxUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=U0SG09IW; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="U0SG09IW"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cf52d15d88so2017725ad.2
        for <linux-security-module@vger.kernel.org>; Tue, 18 Aug 2026 13:33:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787085227; cv=none;
        d=google.com; s=arc-20260327;
        b=AOgi0a1Mbu3CjqvYHxmGCiNaujkGZ438dXRgshfDPS+LhP1FTHT/ihUfBFaIDm+lzH
         F0aB2/IBeQg+KoEVsfnMzbscVxYeL8jmxNQ22wxa7fvZo/tZKUXpxkvxQ0jayDcABYvr
         J9NtquqqN1eHA2JykKTYQi+GXQaXppqLjaGaQR3hqWn5VPtJRGkGZyEFbu/Rk8O3D6+3
         beP+DVN4WpVMJWoUim2i5UBNTNqIX10sjIp/gVLz3fghNzAHJZWFFE3f255OEq8ehj4u
         1oNOU0MYkK73XDgmLr9zby4JX/BH9Dw7DgozIb0r2GMq5foqALtnxSZIPRc6+VZkJ6yW
         ohng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6uraYBbE+DhlvGLckM6pckva7CYGVZJMunUUEGFglIc=;
        fh=5eV3GC1zYaF/Y7ijqc/WWHUENmdBkoFMa2IA/Syml7A=;
        b=e2C7w45/Xc8qVmpqX+l82aun1azQ0iSR7lbChUq8FAhwN1P3A0hGZ4IlDmWCsRwtZX
         uv2NyRZDJlDi5UCDPyS8+y7oTJGR3y1kjpDZ7F9b5RJCrlGsJ6b2YV0jbcnUz+/yB3Zp
         WFkhXV3nku1gzT5Ip2nyrXv56ve3+bW9vJ0qXR4hp/20CW7DxkjAhxcIR8+vp8/lJIav
         vdM/OyM8+c57AH292sWha0bhG368NvF7PU9Eb/Ni5fpNZz28s68blYstyx+Fbpw7dKzZ
         Is6dOo+6lZvnqOVzYIuqnu6tlQN01pHT+aPl2cI3FI+Gnan47jUqdOKoZTGwTxy4Wm7d
         UC4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1787085227; x=1787690027; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6uraYBbE+DhlvGLckM6pckva7CYGVZJMunUUEGFglIc=;
        b=U0SG09IWHqhU/pES+NAk1gt9dcgHDM/IVYrMDb9RFqdBnxUoPX3HtkcJhnS31DLi2Q
         Zy7XGUWLROcmKf30P35I3ENOlGPwpszjPA9b1n9QGtzW5fkOl9Q+H6oYBB3zjVdhZ6oj
         EgIxh025LXfSWym+DlkLtrZv1OjC2eiusV785VcKfFjd4RfVIYVEVBo4ejAnO3i0F62H
         Isn51v2oHR59pJQDxLwXhojEBVzwOAcEl7eUGmsZx5s2cBscDaFbEKSvt0csr4dXJJEk
         xFy6dacSITG2A+t+PvN8THQlByQYiGaSCeeeImYMI/N4pQdFN+qZ4l6PCxt295LFoxRu
         YHhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787085227; x=1787690027;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6uraYBbE+DhlvGLckM6pckva7CYGVZJMunUUEGFglIc=;
        b=GSj772MlQ/f4B5AoltzyO0kJvUO3hcbOexaVOJm9fjcXxHiTcbIXgYMRVPpzhhhhkR
         +//Gxts/QTlyaPdEPO8u5M9ShiYJk80Wgn6JXJz7tVtEij0a2MfKd6Q2LZ3gaOsuskld
         0yQv2r4Lybn326lVqP3/uw28IaPYvhr9q8LOjLXScN4G0yubqntzCFDqDI4gKExhnDJU
         Ge85bocvtu21r6Uc82XYkKrKdrE9FI2kxJustWflFrj0I0I7UNGTMpPKFW+VA8VwO64P
         JAtY37msPNiVPU4uiO5LJ3DP6rMDZRcv3g0EhIGD9AToed//q+Zca9E4np7SljV+E6U1
         tQ5Q==
X-Forwarded-Encrypted: i=1; AHgh+Rrh3T3sUy8Xa4haD1LgrXChyLYWJv5ESxh1uKF3y3J2RyMBiYB60fb0CGxiGCyY+ELW28uiKfoGis1KhFeq0gjnfOZ7BwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaCe9x8zY8MZ2Ie7lTl319AGAyWIVBFJiWqeEk0UV3T92D4DxG
	JhbuFDnXRPSYwQjB4jUTKyzzMG8fnaHcDyF0zQBGsTXIcja1IxEWQ6AY1o4kj9Wz23YdINNbXGr
	J3Q0LU+k50+1F9xEm5RygvL8pSZ+i5VPRIvLORD3y
X-Gm-Gg: AR+sD11000h0Y5GNt3ruFS1Sx2HoZ/L4kHFosRjkO1ZuU8OA4ys22HDczgr1AOR4RL9
	4JvbXCNyWihHP34RS/q9uuTslIi7Whh6SnwdlBxhIoR2xNdBMzkvRI6lNIgCiWBn0afOnQIaRgx
	cD9LB/SsmThhynhGOsQxc+Ij9uBsHtQ4iV0Wd6qPF1DrS4P0UB+A96GfXEruef7mEgHfMSt7DPv
	TgCqyzwYCjq352gHq3PtYZp+JhdnRQZaJZxsY+/Bc2MWdtjygrPqjZTajjpFzJg4fxlG5CVRI07
	HeDateWqRK2LZ6suXl+qrRHu+LcQFJ84PUnqYS2CXTVR
X-Received: by 2002:a17:902:fc8f:b0:2ca:1b97:70c5 with SMTP id
 d9443c01a7336-2d5f6a6eb9fmr7767355ad.4.1787085226630; Tue, 18 Aug 2026
 13:33:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260815112041.1248855-1-utilityemal77@gmail.com>
 <DKRYZPV04750.1V3UXL56PKB6@gmail.com> <CAEXv5_gT+xcZauKug-VsmqSBtuMPEPtw7hubxn6-0nv=D9aq5A@mail.gmail.com>
 <CAHC9VhSs5noQexa5c5RiP_DEzUgGaZw1hwsP+T-HWRvvymB+3w@mail.gmail.com> <CAEXv5_j0h+qCvj5U_aha_7OUUyuR6FPzufo3zK=Ax67724CPjA@mail.gmail.com>
In-Reply-To: <CAEXv5_j0h+qCvj5U_aha_7OUUyuR6FPzufo3zK=Ax67724CPjA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 18 Aug 2026 16:33:34 -0400
X-Gm-Features: AcwNN1UQuVCsOkhNWUx-tlb4xHAlv8wA6C_NfoDY1rkpQ9dCBetDreSKXv9N6C0
Message-ID: <CAHC9VhRzfOR4-RtPapOC4am8F=sC54VDzr7hAn2UMxNQwp_38A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/2] lsm: give BPF programs a way to query
 locked_down state
To: David Windsor <dwindsor@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Justin Suess <utilityemal77@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Xiu Jianfeng <xiujianfeng@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 4:16=E2=80=AFPM David Windsor <dwindsor@gmail.com> =
wrote:
> On Tue, Aug 18, 2026 at 3:48=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Tue, Aug 18, 2026 at 1:42=E2=80=AFPM David Windsor <dwindsor@gmail.c=
om> wrote:
> > > On Tue, Aug 18, 2026 at 5:43=E2=80=AFAM Kumar Kartikeya Dwivedi
> > > <memxor@gmail.com> wrote:
> > > >
> > > >
> > > > Lastly, given the difficulties we've faced from the LSM maintainers=
, I'm not
> > > > inclined to waste more time in explaining again why this cannot go =
under
> > > > security/.
> > > >
> > >
> > > I'm still going to send v7 of bpf_init_inode_xattr series, even thoug=
h
> > > it's a stalemate. Haven't yet decided where it'll live in v7, I'm
> > > inclined to leave it where it was (in fs/) since one side will NAK it
> > > wherever it lives. We can record NAKs and take it from there.
> >
> > As a FYI, I'm not going to ACK any of the LSM changes with the kfunc
> > in security/bpf_lsm_kfuncs.c.
>
> Hmm, even if it lands in security/ you'd not ACK it?

Bah, a typo on my part, my apologies!  What I had meant to say was
that I'm not going to ACK any of the LSM changes with the kfunc *not*
in security/bpf_lsm_kfuncs.c.  Sorry for the confusion.

--=20
paul-moore.com
