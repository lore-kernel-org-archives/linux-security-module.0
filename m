Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793197578;
	b=4lSP+Vf5/Ynktnh4Cv9yqMYJq6w3ay6u2q40l6MpeEHT+jhsXJ/SJevCdliwhcY7e9+w
	 9d6UTSKBRO76tNtjFdRyNfKMR5BqnukjDVsQ/18Zuk7zWgehV+Wydn3Wt5dN8aI5cj14z
	 fUCXe1dTG7vYB3KorzGMmHBLlaTtbLJFjIYp37uwSZkMqqRgMjaphIp2SsUnc14yQlO6c
	 I/Up2/fNJH76ty1zwD1df5OSSUwl/IxXMl771eP4cXwyfBP0UNHU9TQr7qBn6lwqW40sS
	 ybKtk7YmNCJWxWCsST2nPwFh3TSYl4wNzsLp6/9hbxtR1u2lifsNFoYXecmodgaGUPg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793197578;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=6CnDrX+La+2Fu6jP7wM+lot0uCoQlPoWp1MsRc4XNYs=;
	b=3lqQSeVv0GP4scWQyV1y+6kVauTuyChygn5OHtzTbpcaZpjv5B/TuKSaZXz/jDcrpvLU
	 v0zl3/XxISw1VTGgvsxnr9QWruKJv5efJE22OaQnoyAWKZ5vRoBCg538GBxP3VbJXuIH1
	 fFuLL2ui45KP4Os2T2j5KizggsChdE5LYcmbMXCbSzN0hHcmKQjQyoUetIjBlvJBHMCn+
	 gERNP8fWIKGJXhzftfgFfJzhunNcdqqLaC6qInbTOi3CGLiiZVK8+8niuNhUEtqGZpAAS
	 0ubPaiVR0W/LYQ6JhnXglreIk7x2H49iQTZXei9UN92+4M10Hpn4ZFbyrt8XPbMcJ3A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DfRFAWrm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.175
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E48606A31C
	for <linux-security-module@vger.kernel.org>; Wed, 28 Oct 2026 14:26:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8E48606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DfRFAWrm
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-8b10ac6ab7bso9093897b3.1
        for <linux-security-module@vger.kernel.org>; Wed, 28 Oct 2026 07:26:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793197577; cv=none;
        d=google.com; s=arc-20260327;
        b=VcyKeumiHqY0fO3DotprXEHTNLV0TNw63J9jWkHEIEW9MBtf0WLvhfeO/ntTB9er46
         N5vkgmmbwoDqmDey6+oDMs/CBkI8xFFthaRDwuPCFNjQNpy/5kGcgDyrmZfRiEifabs+
         BIuq7Xn8Y5qj/aA80glBVx1a1eaJt2397r7/1VGnQIjQusuGgdvBqc0/ejnqbI4bNcik
         A5rRXLHu5BXT1CfxvSTyM5F3NvLPREqdIydEcPN6Tesz5dRjeerdH9ADjD9s1PvwhqJ2
         fsLiIpIfpmUWN0qvEfhgSiYcJtv15XKExvVfiuw01s8MKHEbmHSzaqzITIe/PctEAl7I
         Ypjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=6CnDrX+La+2Fu6jP7wM+lot0uCoQlPoWp1MsRc4XNYs=;
        fh=vW/G7+Z5RmwSy1Bjiy1ourOD5NJp6rYB98XcRGID9XI=;
        b=leCOx+1RZauVty3O5oRwTd1imIQTFFgf3M7DNuGoPXr2tVtDG8gLXczF5n94B41v6m
         uDvKzTHyuxUplW/wasSEPb1k/82w9xI1QBoppcEsBlHMNnPqTXjaTuWII5rsRf/dthhI
         k/zcqRSIP1eWcfRIPD0zaAzJQYrPeCAC/AM6M0F7PaWaI1RBJpRbgiS225q0RqD2sXn5
         jk0BW3S+DdRg1dPT1nGLwAyL3x1sJpeefnU8cCZ7SQkTs7pXiXVSpo8uAPfEW/+IvhCv
         DTB/4seyLVFNnwvP+hwCydDafmc0BCNg9xs+wkgdZYaj8N9DQjQd5vN6+flVaWDCiicR
         dNug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793197577; x=1793802377; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6CnDrX+La+2Fu6jP7wM+lot0uCoQlPoWp1MsRc4XNYs=;
        b=DfRFAWrmO+/Bj131K7+MGGvRusTiq7Cc5X579DXdy+WsyQOlHXS84rhXCmVmsKOZC1
         jfuHEhsyE6S5Hv/g/4Ce6BjpcZobIYAK7e7SRGOKE2sQnrptMyZ/rcfRlucg4dR4ESXM
         2gkEM+ETeUkrfFJD5xphI1XdRbsTnl/m+NHm4YrmXbfagBxPULfxYRHU88tAoNYxU0fD
         Sk8MihQlJ6G7wkMm9i9Z8l/r1iyrvuPMo1oPpQz0ZlNwKWJeP4IMCT2IjKSoAP5RqzaI
         HDHSC06lEs0YPSK/mdKu+B4W4LgKQdZyBezNe4ZWTbOgw79zb6SISHpGLp8kXM1lynRT
         +z9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793197577; x=1793802377;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6CnDrX+La+2Fu6jP7wM+lot0uCoQlPoWp1MsRc4XNYs=;
        b=B3w+L9CzIqsqCKINDW/W2DP2IeOPVOzge1eQ/19XuhIS8/TkNWPHhP87jFPEuQkynf
         fpvjh81B0ZtIhsbT89e0iLRgLwxZFG1nKzzltQzmPl4GcLibDxvvCOqIpTYTe2JfZsCG
         Vo1s27nzgkYx3S6DFHmivcuFiCMGfb98JUvM9IQXkLg9niTuq1UWpDaTbEoC6KxUeL3x
         cviIzf/1nZdpXY2Md3saMehbeNtEaLnavUywqd+iFQuHfX87V7vUoKilMD+aOgWYQSZv
         ciyW1zvtmW9u7kfnFeI0C4ktqRevCDYDSTFFqRPuJzu5EaL2/CqLpZfP1uVqKcLvOm6p
         CsQA==
X-Forwarded-Encrypted: i=1; AKwUvBwn0U9y1M5/VeYOwKnkTH+RDnx9cbkntAXdINGKS7EnmCE8FM4XPasFqpKAGMDjZzJf7q5ijSJkDansTFFEgvy8s0QQ0lI=@vger.kernel.org
X-Gm-Message-State: AFq9FYI+ahAGeGkW094wnczOZAgNYY8QgT6gHcapzvOpGS0a7GDJhats
	MuIvEluIrHnc6w3oOBFETPqRR3BoayLJnXPTocQJ6AAcvvvZg3R9nWDw6xT58aFvtJdhEk6Io8b
	tZqznrFCPrT4Bv2gRjZLYVjy4uz+no7k=
X-Gm-Gg: AYBFou3a9+6Vju2Buv5yEi+WXBSmJccsUeNCBuCrboD+y6x/Y1/81nBzD/4EuAwahkB
	icWDVX9eRyDp1jNMgTdQapbCmM0u9MJnpgdA0/KcXu/kVhs+f7+IPpIh5xaYYWJp5tS2xDoivbe
	9GiH3Qqj+Xz94Rjol9o9JlVz3YkkxYbj/nKAn1PqNlSsKZfll0rTjqViU8jHuXEZLfiQFm+DutH
	NykqizM97RgIfc3HJYGn6fjNLwNYZE0qUpUTazBlAxqQY2ry1kSYA9soxdbGg/t07ngetZluGYE
	loZ69DN3kEcwsj0T1H5kmHIM8qlKcQML3vvRKY1oomcR4SHAaqRsrn2ay2biN4lMn9BwP3HlqOP
	iPlLKGRNGs++sbAG6jJ97k3PcZg3VnohvPaPxG1WSfQMz3BOHMS71h7EMUsjF8wQTv1guW8o=
X-Received: by 2002:a05:690c:e90d:b0:8b0:d42c:54e9 with SMTP id
 00721157ae682-8b1b5c9953bmr12024777b3.34.1793197576747; Wed, 28 Oct 2026
 07:26:16 -0700 (PDT)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019-b4-ipe-keyring-rfc-v1-0-156f0b93e843@nvidia.com>
 <20261019-b4-ipe-keyring-rfc-v1-1-156f0b93e843@nvidia.com>
 <702ade20-a2f3-4919-97e6-c72faa89399a@kernel.org> <20261021-groll-donnerstag-erfuhren-ce34a0ed4e97@brauner>
 <CAHC9VhTHUU0h9k74CMT6wYhMwyY3YhbSSFwJoDTvoFRyTFVZwg@mail.gmail.com>
 <20261022-hausbank-dozent-hurtig-9443f3777475@brauner> <CAHC9VhQ4sdCRvJ+YPZoiQzR_hgQN6-=84qvnTDDGPf=7=L9-jA@mail.gmail.com>
 <5143896100674c9fd744c4d7d6ce12232910e789.camel@gmail.com>
 <CAMw=ZnR54hMBwGTps23t9Mm_VO1bAvmeX8uTf_VJ0rJsFNMLuw@mail.gmail.com> <37b653494cf282c6e428e2ae8fd781a0ea69bf3f.camel@HansenPartnership.com>
In-Reply-To: <37b653494cf282c6e428e2ae8fd781a0ea69bf3f.camel@HansenPartnership.com>
From: Luca Boccassi <luca.boccassi@gmail.com>
Date: Wed, 28 Oct 2026 14:26:05 +0000
X-Gm-Features: AclHuK_2pDead4oUBgww1V4NOQP7FrJJqtxPGmwYbVPNkoSmhvEEW-kSQFaRSpM
Message-ID: <CAMw=ZnQU0PRSn5gh-QNT+GuKroQaRsRUUMDB=rM=LSX+=h-JkQ@mail.gmail.com>
Subject: Re: [PATCH RFC 1/4] ipe: add the .ipe policy keyring
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Paul Moore <paul@paul-moore.com>, Christian Brauner <brauner@kernel.org>, Fan Wu <wufan@kernel.org>, 
	Manuel Huber <manuelh@nvidia.com>, David Howells <dhowells@redhat.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Andrew Halaney <andrew@amutable.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 Oct 2026 at 12:42, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Tue, 2026-10-27 at 11:07 +0000, Luca Boccassi wrote:
> > On Mon, 26 Oct 2026 at 12:57, <luca.boccassi@gmail.com> wrote:
> > > I think there is one issue with the design pattern where keyrings
> > > are set up in userspace, that I have mentioned a few times already
> > > and I got documented in
> > > https://www.freedesktop.org/software/systemd/man/latest/systemd-system.conf.html#RestrictFileSystemAccess=
> > > as well: they are trivially bypassable if the kernel has kexec
> > > enabled and it is signed. The security model relies on the "good"
> > > userspace running first, but if kexec is enabled, there's no
> > > guarantee that will be the case, and as far as I can tell it gives
> > > root trivial capability of overriding it and extending the trust
> > > chain as the attacker wishes.
>
> The attack sounds doable, but it also seems to be exploiting a gap in
> kexec policy: kexec is supposed to behave like a warm reboot so if boot
> policy requires UKI only then so should kexec and that sounds like the
> thing that should be fixed.

I don't think that's the case though, even before KHO/LUO existed,
kexec has never really behaved like a warm reboot, as for example boot
services do not run again, so various chains of trusts are not reset
(eg: a bootloader might now be blocked so warm reboot would not work,
but kexec would). And since KHO now exists, the difference is even
greater, as more and more state is retained across the boundary.

> What's the mechanism boot uses to ensure UKI only? So we can see if it
> can be adopted to kexec.

There isn't one, and I don't think there is correlation, as booting a
UKI is not the only way to boot a system. Eg: this problem applies
just as well to booting an arm system on uboot. So I really would not
tie this to UKI or UEFI specifics, it's more generic.

> > > This is of course not to say this new IPE keyring shouldn't be
> > > added. But perhaps it would be nicer if the default build flag was
> > > mutually exclusive with kexec being enabled? Not sure if that can
> > > be expressed in Kconfig though? default: yes-if-kexec-off, no-if-
> > > kexec-on
>
> I wouldn't do this because a) I don't think it's an IPE problem, I
> think it's a kexec one and b) distros get very tetchy about hard to
> solve feature anti dependencies.

Note that I wasn't suggesting an explicit conflict, but merely to
model the default values of the kconfigs with such a relationship,
allowing manually setting any combination the user wants. But it was
just an idea, maybe it's not worth it, dunno.

> > > At the very least IMHO this relationship should be documented
> > > explicitly in the kconfig blurb, as it seems to me it's a major
> > > footgun to leave laying around, and users might not necessarily be
> > > aware of it.
>
> I'd document the need for trusted userspace on kexec if it was a boot
> requirement, yes.
>
> > KHO/keyring folks, what would you think about preserving sealed
> > keyrings across kexec via KHO so that the chain of trust can't be
> > reset by userspace? Good idea/bad idea/yes send patches/no go
> > away/etc?
>
> Well, yes, we do have a similar problem with the trusted keyrings.
> They're actually initialized from the shim created ..RT variables
> (which are volatile, but don't die on kexec).  On first boot they're
> initialized before user space, so we know they came from shim (or
> another trusted component in the boot chain) but if root uses UEFI RT
> services to add to a ..RT keyring, the added key will appear trusted
> after kexec.

If it is possible to overwrite the RT variables then yeah it sounds
like we want to preserve the machine/platform keyrings too via KHO.
