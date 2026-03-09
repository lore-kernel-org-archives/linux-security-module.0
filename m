Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6592D0C9C
	for <linux-security-module@vger.kernel.org>; Mon,  9 Mar 2026 23:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773097840; cv=pass; b=ZZOuQUag+RcFo90ba+8cYKpaERRBhORxWjUMik3BaFCIDqKDUg9cWERPsHmnH+Y1FNRPqMexaqw28i2TcRjOQjwowvkTR//s7b+dvSdbv5POuEWkMuMBIWYxFg8sNhpI/jp+gEd3FpaRpEt6uBAciAijSRnpNIBcOvjSDhvm4A0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773097840; c=relaxed/simple;
	bh=guYTRTIV07tIVXdrecWKFPe8mBR75tmplTw1gLdq8E0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kVrBG2QEkL+FWsWR1lyEn/ryq6gtlaUJJj3ZoctlT2qpZadUPqap88YpjOnJ50L42gK6WjCbVJt7+vveKF7kZMYBwS97frB1LmiAJbJCnFg8vSiNYnWpYXbQtl+QFIPvB8ZmpND+xqxizYNBr3y6nj8qMl20BKu61bZlbocjyEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Di2XWOaz; arc=pass smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Di2XWOaz"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c737d3a51bdso2236172a12.3
        for <linux-security-module@vger.kernel.org>; Mon, 09 Mar 2026 16:10:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773097838; cv=none;
        d=google.com; s=arc-20240605;
        b=gYdKofK8shFkjEKvora6/8jQo9/Bloc3180rtp1s4TSY8LcLx8AhnVcIl45iNrX30o
         cYInH4Spf067RjEV0m7WBaJkCVMe8cUTu5y0AiAwVbZ2GBdhQBpAbX0sgEcuNjzKLmgr
         KHqBoKQZEvaaUJWzGbuzP2KtpQDKuNOWX/Uljq/aEa2YZ8A0EzNJkArifNhtmRUK3hjQ
         EiE6vMQqKzfR0OLKHmH951Pdbp8kMVTD+CDDdv9pIHR37oPg4v0WhnSVlp0r4vYy9UMe
         UXBoa1SWPfg5hb/lWe7entLYFI1vlurzRgv6PE2m1TIbn1SRPag/tKn8SYDquHth2EOQ
         /fZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ganXn/aKh/jYswvsKTbptfBmhWROPWX8eZLsZsMWaX4=;
        fh=RTRxkRgrze+56+GPABKPX4czYsVSjCR/3vDj006H2tw=;
        b=KbjiNFGtjLc9IAHnbSCF/mhwuAr6lrLZzADO+SLDTuhqoo899kTW7Eefnxmze2KnwK
         O/G68ZkG/xJcUWjoRI810Xox5/ZhOIEHYC8Zc3W/tTBcAXS/Xue3sjCpxtVovmyVKg6Q
         nI9eZt8sdZoNuLpvsV4cIjqhB9Mj6GHJ5ppQWDGAMRPBx7x+q5IQQV7yC8h4CDWG+6GH
         O3ufP98iWnM30h5wlgbEcbug96gTqyE+FVXS4YBwHt3898RznRaFpIysUWDe5tblbs7S
         0Q4j+Y3C6bONA08Ly2N2I0+9IfOHMujKPjmPkSv7K3LDX2UYPpMlUhS/EsadSjK/oCh3
         XGdw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1773097838; x=1773702638; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ganXn/aKh/jYswvsKTbptfBmhWROPWX8eZLsZsMWaX4=;
        b=Di2XWOaz1EvLd+vI95sTWqA8i42y6DJh0I11hubVjLTwKyi4WUCDEkjjx041RCILc9
         pawx47A0jN2Mbf6aKeFytXlgPt6PUXMO7HeRHmfJRVoesArSNPUoQXbV7gPXWuH9Rzrf
         DAOfoxz6NxlCvpIIDQhA7OZ56CbcYamlnOy2uNCnsd/pDBi8B9ODUdvejT2tueGE/G+p
         c+Ll0H1CpM+pZS5hRtQnRZAQSmgt6HNEUMp9m6oPdceP2mekpMrzgpLblEtdMYR8bdBT
         15hVO+ULHsYDb4MiMPtisCM+HZyHNBO9qint1CRcSao2OGIlUi0Z/p9F4xn6ij+6buWt
         kTrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773097838; x=1773702638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ganXn/aKh/jYswvsKTbptfBmhWROPWX8eZLsZsMWaX4=;
        b=OgHNDqe6Mc3SJ/hb96kB7wYSKpCamE0jkE5mZI4LzxjAnyVQYfXZf7rwEzgJlilG5f
         5x723dYsUu62Isd77gvXPVn2JKge5UIu2vORPZ8O2wWOso8LM4c8g37qT0GwIVIF9kCB
         iZpwOd+9eSZhygvdg12EGnCuHb3vIoJ9s9UfEAazjeQ1e7Mj8boPbsrNx3jDunm95gGF
         PkQJ+sP1OSpME5JuEOp6jwEuiyTBOTNmgWwrWkVPin4Vn50OQZqpTORc7EkQhxGWJJq6
         +V8o5Tls8szT/tHCsAzmsnNtcpZSuSYcKwxnxv2zDDFl3U7tI0v9GACjY8SnXnil8hrJ
         IiXw==
X-Forwarded-Encrypted: i=1; AJvYcCX/cUckKWo1UpSAedbwg8In4zkNwD+N2V6f3s1vrgnuF6nTfNn40Rb7ITS4MN94aZOag0UaFmeE1akt5dPotj2h0QL5O4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFXLmSwesfUkvcTzAtLHGnXjWbVty0UGtWZr36rTD59k2rfwFv
	RZkS2FIpEobdP0QyzdKgU8g8MMsWtlyOOluLHeUPhdhFhL6wxe8/PG8av8C4IYqLOWUlJ5bffiD
	xWhaj5HlfEYKMnBD+gFnJRvJVyg9XeND+yVE+IF93
X-Gm-Gg: ATEYQzy234goIOH+kWrGVu1Un3Ev+30otCLIxg3nEbmlQKr6HvD3U308kIJIIUWiicM
	VX7X2DCari0I571sam4m1QhFKMtabJOY7AG0IHbACT89fkjoVKVqTA8UXOSNvMqNIgtaIReKmke
	PYaccbyAeZL4+dxzsnq/sdj4uJJVPFL+vHrux5Whg/wHblS12b3ByCdn2vOQRewPH+LFsx0/4Wn
	O7BjOI7GCtDrXBNHgA/rWV+WFyWkAts7eXsSQoM1vCDH1g3vTK4R3WTgJ7IDfrgewv8OmDAytqE
	ZYlqbbDii8EgBRGnzA==
X-Received: by 2002:a17:902:d2ca:b0:2ae:4445:f39a with SMTP id
 d9443c01a7336-2ae823681demr128912475ad.7.1773097837652; Mon, 09 Mar 2026
 16:10:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309-fw-lsm-hook-v1-0-4a6422e63725@nvidia.com>
 <CAHC9VhTR9CsBgxRCAHXm5T2NZ5tr+XfmA--zkt=udmk9hPRuZQ@mail.gmail.com> <20260309193743.GZ12611@unreal>
In-Reply-To: <20260309193743.GZ12611@unreal>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 9 Mar 2026 19:10:25 -0400
X-Gm-Features: AaiRm535xFpxdgvR-5FzqjZOmCULmHkHTB-IpoDK9Z417AAIc646ZPqFW7lnHx4
Message-ID: <CAHC9VhSRt_QEJKJFBDBySNQCiPpcawd5A76xmoRNtppRKGaCog@mail.gmail.com>
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

On Mon, Mar 9, 2026 at 3:37=E2=80=AFPM Leon Romanovsky <leon@kernel.org> wr=
ote:
> On Mon, Mar 09, 2026 at 02:32:39PM -0400, Paul Moore wrote:
> > On Mon, Mar 9, 2026 at 7:15=E2=80=AFAM Leon Romanovsky <leon@kernel.org=
> wrote:
> > >
> > > From Chiara:
> > >
> > > This patch set introduces a new LSM hook to validate firmware command=
s
> > > triggered by userspace before they are submitted to the device. The h=
ook
> > > runs after the command buffer is constructed, right before it is sent
> > > to firmware.
> > >
> > > The goal is to allow a security module to allow or deny a given comma=
nd
> > > before it is submitted to firmware. BPF LSM can attach to this hook
> > > to implement such policies. This allows fine-grained policies for dif=
ferent
> > > firmware commands.
> > >
> > > In this series, the new hook is called from RDMA uverbs and from the =
fwctl
> > > subsystem. Both the uverbs and fwctl interfaces use ioctl, so an obvi=
ous
> > > candidate would seem to be the file_ioctl hook. However, the userspac=
e
> > > attributes used to build the firmware command buffer are copied from
> > > userspace (copy_from_user()) deep in the driver, depending on various
> > > conditions. As a result, file_ioctl does not have the information req=
uired
> > > to make a policy decision.
> > >
> > > This newly introduced hook provides the command buffer together with =
relevant
> > > metadata (device, command class, and a class-specific device identifi=
er), so
> > > security modules can distinguish between different command classes an=
d devices.
> > >
> > > The hook can be used by other drivers that submit firmware commands v=
ia a command
> > > buffer.
> >
> > Hi Leon,
> >
> > At the link below, you'll find guidance on submitting new LSM hooks.
> > Please take a look and let me know if you have any questions.
> >
> > https://github.com/LinuxSecurityModule/kernel/blob/main/README.md#new-l=
sm-hooks
>
> I assume that you are referring to this part:

I'm referring to all of the guidance, but yes, at the very least that
is something that I think we need to see in a future revision of this
patchset.

>  * New LSM hooks must demonstrate their usefulness by providing a meaning=
ful
>    implementation for at least one in-kernel LSM. The goal is to demonstr=
ate
>    the purpose and expected semantics of the hooks. Out of tree kernel co=
de,
>    and pass through implementations, such as the BPF LSM, are not eligibl=
e
>    for LSM hook reference implementations.
>
> The point is that we are not inspecting a kernel call, but the FW mailbox=
,
> which has very little meaning to the kernel. From the kernel's perspectiv=
e,
> all relevant checks have already been performed, but the existing capabil=
ity
> granularity does not allow us to distinguish between FW_CMD1 and FW_CMD2.

It might help if you could phrase this differently, as I'm not
entirely clear on your argument.  LSMs are not limited to enforcing
access controls on requests the kernel understands (see the SELinux
userspace object manager concept), and the idea of access controls
with greater granularity than capabilities is one of the main reasons
people look to LSMs for access control (SELinux, AppArmor, Smack,
etc.).

> Here we propose a generic interface that can be applied to all FWCTL
> devices without out-of-tree kernel code at all.

I expected to see a patch implementing some meaningful support for
access controls using these hooks in one of the existing LSMs, I did
not see that in this patchset.

--
paul-moore.com
