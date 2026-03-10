Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F84D3EE1FD
	for <linux-security-module@vger.kernel.org>; Tue, 10 Mar 2026 21:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773178817; cv=pass; b=TX3D/J20CcCo0aAS5MLo6HAQzKDLdY62Nu1pCtSCBoHSjL6/aRQkr0+PAQHIj2wrOiAJCzMjxmYT874v86LgEBvVPRnQxHyrKdOXf4mGW/0BnGfiAQi7H22hs5zyBydPF9t8wc+UtwmcPgPY5qVOyitIpJ+0PUIapAqKQlnSFyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773178817; c=relaxed/simple;
	bh=Ur/oOiJioVSUtc+YFvCGlJNcWs35D1mOgLE4Auf4bWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cumJPJW6j6QYItuQUFLaL5FMOKs0W+6Tls2K8T3ul/ICltt8JI5d/dGo0ccEdWoBmgz5BeX1B1x7cgSkcCsZU6EYS3J6Tw3uwh5ji8oc6O9HzkO8yUGV5JF77B7R7+xnEsB+pi7RPgslmct2X4+gMZogiR5SrcBuUNJhUWRbdhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VbAb/1gi; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VbAb/1gi"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ae43042ea7so110725635ad.0
        for <linux-security-module@vger.kernel.org>; Tue, 10 Mar 2026 14:40:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773178814; cv=none;
        d=google.com; s=arc-20240605;
        b=a/Ilh6AEtEqhkxjcNqHaO6bjHOJvxu0kp7P+roxBNwdiwOm3cF5yr0lxpgvF8wTlGh
         x0MCkle6gLFmEzI03EgJzckUG3HAHYXxKELyPElH1vzc+OWIjbI7WrcZtqwlt2kIXPGJ
         raFB1GfFf7JuBOt7Lcd+cFD/Dnk90ee5/8yvLpExYmSnjxFvRVZZCeyL6ffOma++REnS
         j33/d93lYXSHGWSN9c0TgmVGo8cHW6MbPQwJKNUHtXe6AYdkMFf+Q6+k72s1mbG0d7w4
         MOg9+IQ3vXckPNfsbcZDGzmxFlWoGCWdxAh/7uEorDsKyVE6mNsfm4q6ntIl/ku10i32
         q1dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LwDQFIDEcznEldWRxVlmfk0rWnU3Lda6oDe6A/JW9p0=;
        fh=NAfw3vciMUF8QC1nfMsCr7Gp9gCEpjR1MdYlKbNijtQ=;
        b=kK3Zb3r7t27EJgli6ETDtA4G48qoKbnQqY2S84Vyu+KuO6GdEBQKiVVNngzygbWrla
         Mqu1/Nl82Uz1N85wT7MNh8C1NRCevxMHMh+J4g2dDPy56++ZmMTnU5fZWZ+JuA5RrdUR
         qhLdShdFmccvLPT7NPD4RiW7tnoJkKWYnYdhV8vBuAfjH/evPxNGhQq+en45ZfKbu6CL
         jcv3vsGMTcni7myy5J249G3QAHIoHibt0EbEFz/RZvdg0R+DoO/4aR8X7wvclhKKC8kA
         5xyIFG6XDbns2sjjdTKvPDwDo7EA0lPp/C8+J/E1xIM5QXTjmV4Z33FLZXgD4fDQQPHm
         rN8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1773178814; x=1773783614; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LwDQFIDEcznEldWRxVlmfk0rWnU3Lda6oDe6A/JW9p0=;
        b=VbAb/1giZ1Kb1MUa6LJQWR1x6G0ArCojcycKHC7cZhMhmOzOXK7xuBr22hLEmksXsb
         oQ5HOj0KEFa1tQfI4vASn+/IRY0tbss4/Tlpll2gfVNPP+lAgeuAHxaSCUAmpbev3Fqm
         jpE8EniFp2wCtJa7rBfI59kxvLBb1ZWipDlj2/yi2XOTPss409Cv8WzMFam3eyVdUOXQ
         sKiL6cdrPzRzQWVO+RjJrUyim9A91fodCM3hLHQDkI3YqXqr4K6Q3BcK6p/CfwVWzPdy
         Ge/wHwm5nckQzBcP11UsNF55C3PcJCHSg3wv+TneLOyMM7EHU9PKPa5k2THHacztve4i
         k31A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773178814; x=1773783614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LwDQFIDEcznEldWRxVlmfk0rWnU3Lda6oDe6A/JW9p0=;
        b=NQIwns6Aql+n9Wd6LbLXX612G16oyjPayTExRtOiW3gXL6AiuZHbZffce9gSe4Z+LD
         Va0AZqgeHGys2LOoM315trHmeHPXYzNza9JoWuA8mmaQ4k03toJX9D1lnh/Pd8P52F4F
         fS8fNJ2EJ0Ryb4z3XiLJuv+t0uWCqwKfPBazOfYiwb5IavT/LDd8H1B1ITOsF3yV2hXm
         54kjFNXGAvndtz7XM+yqMupaw4Ze/BDGvs4WQGCDpyIw49kk9zU9H6Mzf6bO/Sxg2DKt
         /xXe4SDTwZ7T+QgjN5tmGt8YjCO8sKS+neD7HDuFBUeXaWc7c5B3hp9V6rh3pQq6ReF0
         NFtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWevbLnG+n/uyDor4/uwtzHFnSvTP9i8HaS0rLmc4C0YFEezUOuIPigxipShaNpsKAmVeoHOe1FwxJbqnH5nxngllzx8to=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP8ZZhEQ5Y0iOk8YTpvQ2jFdWP/EMGpzGRpz4iJKbj8+qp6fbL
	Tt154HtFwIl1AGXXMaK7L68tlvLNKdEFmWjTfcKU20hLVqR2IxXCSZ6dmplgoihGAefvibUeFkU
	ulCYEk6H6odEOgemCsFVQGEaAHYHNEtkz/upck0id
X-Gm-Gg: ATEYQzwk+hpvNeksxqBqa3oVX32m+daXtenI2ufoWGXsEOKOzam6+PM81EG8tPH9JG3
	fkU0vX/0Ayjg0RkZZ3dUWejW02KsWZI5tkW38TrVsVX41jYFgR+vVZMAhHs0Auh1UqTU3THCz+G
	r+0F/ca8V7d0uiknhEpfjmNXYMm8FRah0hOU1x+OfnPXezucUCNJNySSWUHkDaXpHAysp9rmKxd
	2CsIOfHiRx6qx70piVLEHY8l5XRDOb8qLBQ5N/r+Mit/4HT/AMyqTqrOg40dvoQX/FkY2r2cP/L
	JV+AZe8=
X-Received: by 2002:a17:902:cec1:b0:2ae:5426:da3f with SMTP id
 d9443c01a7336-2aeae8588demr2810015ad.28.1773178814554; Tue, 10 Mar 2026
 14:40:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309-fw-lsm-hook-v1-0-4a6422e63725@nvidia.com>
 <CAHC9VhTR9CsBgxRCAHXm5T2NZ5tr+XfmA--zkt=udmk9hPRuZQ@mail.gmail.com>
 <20260309193743.GZ12611@unreal> <CAHC9VhSRt_QEJKJFBDBySNQCiPpcawd5A76xmoRNtppRKGaCog@mail.gmail.com>
 <20260310090733.GA12611@unreal> <CAHC9VhTKsOYrs8Wh-O548=2gE7N_gkBy+q05+atcR=D+30uQ=w@mail.gmail.com>
 <20260310193000.GM12611@unreal>
In-Reply-To: <20260310193000.GM12611@unreal>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 10 Mar 2026 17:40:02 -0400
X-Gm-Features: AaiRm52Jj19K4Bao4t5KT5PLu-pdK7gUrebczrdDo6_ONMvwkckflBrJZIIsFNk
Message-ID: <CAHC9VhSh8A+yGHT_+BqFGaLNqsZDcaz_cuqf9A+neRQQ3PMY4A@mail.gmail.com>
Subject: Re: [PATCH 0/3] Firmware LSM hook
To: Leon Romanovsky <leon@kernel.org>
Cc: James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Saeed Mahameed <saeedm@nvidia.com>, Itay Avraham <itayavr@nvidia.com>, 
	Dave Jiang <dave.jiang@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, Chiara Meiohas <cmeiohas@nvidia.com>, 
	Maher Sanalla <msanalla@nvidia.com>, Edward Srouji <edwards@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 3:30=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
> On Tue, Mar 10, 2026 at 02:24:40PM -0400, Paul Moore wrote:
> > On Tue, Mar 10, 2026 at 5:07=E2=80=AFAM Leon Romanovsky <leon@kernel.or=
g> wrote:
> > > On Mon, Mar 09, 2026 at 07:10:25PM -0400, Paul Moore wrote:
> > > > On Mon, Mar 9, 2026 at 3:37=E2=80=AFPM Leon Romanovsky <leon@kernel=
.org> wrote:
> > > > > On Mon, Mar 09, 2026 at 02:32:39PM -0400, Paul Moore wrote:
> > > > > > On Mon, Mar 9, 2026 at 7:15=E2=80=AFAM Leon Romanovsky <leon@ke=
rnel.org> wrote:
> >
> > ...
> >
> > > > > > Hi Leon,
> > > > > >
> > > > > > At the link below, you'll find guidance on submitting new LSM h=
ooks.
> > > > > > Please take a look and let me know if you have any questions.
> > > > > >
> > > > > > https://github.com/LinuxSecurityModule/kernel/blob/main/README.=
md#new-lsm-hooks
> > > > >
> > > > > I assume that you are referring to this part:
> > > >
> > > > I'm referring to all of the guidance, but yes, at the very least th=
at
> > > > is something that I think we need to see in a future revision of th=
is
> > > > patchset.
> > > >
> > > > >  * New LSM hooks must demonstrate their usefulness by providing a=
 meaningful
> > > > >    implementation for at least one in-kernel LSM. The goal is to =
demonstrate
> > > > >    the purpose and expected semantics of the hooks. Out of tree k=
ernel code,
> > > > >    and pass through implementations, such as the BPF LSM, are not=
 eligible
> > > > >    for LSM hook reference implementations.
> > > > >
> > > > > The point is that we are not inspecting a kernel call, but the FW=
 mailbox,
> > > > > which has very little meaning to the kernel. From the kernel's pe=
rspective,
> > > > > all relevant checks have already been performed, but the existing=
 capability
> > > > > granularity does not allow us to distinguish between FW_CMD1 and =
FW_CMD2.
> > > >
> > > > It might help if you could phrase this differently, as I'm not
> > > > entirely clear on your argument.  LSMs are not limited to enforcing
> > > > access controls on requests the kernel understands (see the SELinux
> > > > userspace object manager concept), and the idea of access controls
> > > > with greater granularity than capabilities is one of the main reaso=
ns
> > > > people look to LSMs for access control (SELinux, AppArmor, Smack,
> > > > etc.).
> > >
> > > I should note that my understanding of LSM is limited, so some parts =
of my
> > > answers may be inaccurate.
> > >
> > > What I am referring to is a different level of granularity =E2=80=94 =
specifically,
> > > the internals of the firmware commands. In the proposed approach, BPF
> > > programs would make decisions based on data passed through the mailbo=
x.
> > > That mailbox format varies across vendors, and may even differ betwee=
n
> > > firmware versions from the same vendor.
> >
> > That helps, thank you.
> >
> > > > > Here we propose a generic interface that can be applied to all FW=
CTL
> > > > > devices without out-of-tree kernel code at all.
> > > >
> > > > I expected to see a patch implementing some meaningful support for
> > > > access controls using these hooks in one of the existing LSMs, I di=
d
> > > > not see that in this patchset.
> > >
> > > In some cases, the mailbox is forwarded from user space unchanged, bu=
t
> > > in others the kernel modifies it before submitting it to the FW.
> >
> > Without a standard format, opcode definitions, etc. I suspect
> > integrating this into an LSM will present a number of challenges.
>
> The opcode is relatively easy to extract from the mailbox and pass to the=
 LSM.
> All drivers implement some variant of mlx5ctl_validate_rpc()/devx_is_gene=
ral_cmd()
> to validate the opcode. The problem is that this check alone is not suffi=
cient.
>
> > Instead of performing an LSM access control check before submitting
> > the firmware command, it might be easier from an LSM perspective to
> > have the firmware call into the kernel/LSM for an access control
> > decision before performing a security-relevant action.
>
> Ultimately, the LSM must make a decision for each executed firmware
> command. This will need to be handled one way or another, and will
> likely require parsing the mailbox again.

As it's unlikely that parsing the mailbox is something that a LSM will
want to handle, my suggestion was to leverage the existing mailbox
parsing in the firmware and require the firmware to call into the LSM
when authorization is needed.

> > This removes the challenge of parsing/interpreting the arbitrary firmwa=
re commands,
> > but it does add some additional complexity of having to generically
> > represent the security relevant actions the firmware might request
>
> The difference here is that the proposed LSM hook is intended to disable
> certain functionality provided by the firmware, effectively depending on
> the operator=E2=80=99s preferences.

My suggestion would also allow a LSM hook to disable certain firmware
functionality; however, the firmware itself would need to call the LSM
to check if the functionality is authorized.

--=20
paul-moore.com
