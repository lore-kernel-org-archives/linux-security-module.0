Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9744034888F
	for <linux-security-module@vger.kernel.org>; Fri, 24 Apr 2026 21:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777064946; cv=pass; b=DTDo0bXJCveE2rNsubhN3IQCUvKHKkpbR1L3k2VSmPA8yRSQSCq2B3wlL3X1anTPfASll67D9d2lTnOEeSZmTCESw5K1Y9KbHpFdhXcKbSjSHX8iAWFiUIYCjv4Hb7inNoDIHCvvV2GCltRhOpCznonsBCuQElOUPdLYimAdZ/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777064946; c=relaxed/simple;
	bh=zeoP/9P2pLhahz91nxn+4EYf85rGHyQaiFHaei/lRpY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PQPM6z/PE26vlsgijDwIWQVAa6mAxg4wpjkVLHuxqWuIfusOKOlMGBX5kg3uoFWMbhvC0/sfQsAVwZXAIZ+KMuFkzfhSWcvuggTNPp+ZwfyL5U6W7t6CCzPiyNbffi7GzvWT1MDOU7hAuR8olOhnv1Au24CEcWscanwJ6+wUks0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=N2LJTSm/; arc=pass smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="N2LJTSm/"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-82fbdd60b64so4107853b3a.3
        for <linux-security-module@vger.kernel.org>; Fri, 24 Apr 2026 14:09:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777064944; cv=none;
        d=google.com; s=arc-20240605;
        b=LLLGdV9tpUrj1pE4q6DiMjRgqyawSS4vLHISzyGZuQKtPmhSnmL7R7mOPo5Gvl/xyp
         tUHCDiock+e77ygGEIxd48jsogulsyksmza42iLXz5u613ULG8R1XQJHrRE9svCzJZsp
         GM7DpEF1eqqSX+2HZ/5BTBZtyMIHkDw0/mjPRJBh6pjr/czrMu0DHYcaw3AmDrR6WcDB
         CiNn+4qsPRH++6n+oENqoVO/q0FGJrF0qg6xYLtCR30Zds49F8rNC2eswSHBpOgvrIdk
         cc7aWpZlGT2uAS6zX0K2OUDlp1SBMAziS6cRrvGHnTpWED4TNyoup/Dj6w07GSiYmUZ2
         lFlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n1d+xjduzAM/MSTs6YplaFj6vz27O1vUoV9FGHND4Bg=;
        fh=fdze5GW5pTpDp/FzPs1LRY2g2c9rNFevRnffazAvqRo=;
        b=Y7Ohf5bShsKrcjpl4sGpFIVm6BT9Vpp/Z8xA/v2/wC0RQvfjHuvzo4PCfw8XNXPofQ
         R+tkSyp0HWnHSM+mKCAoFbBjKX6wprhPKAmilXqgt2410mjs0iSChssvP9T5jpB9vtYJ
         0rqIp3/VsSr1ThT0fE8aUuummLBH1Tg2uVgI0SEv2WT/VMBZVdJr3HuDO0/N7eMlbvHr
         yth+7TB1pZBli5RKbThSgSMXS5XmgA7PfflRfAC5mPs1+PuvZ0bCvEhKzpSgVPnKx5S1
         5OwWOAoyOlyWNRVxwfvXub81VctWAkjeAUkvoDx17GE80JNPFq8knB4QCjxXsjRyp35k
         OQuw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1777064944; x=1777669744; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n1d+xjduzAM/MSTs6YplaFj6vz27O1vUoV9FGHND4Bg=;
        b=N2LJTSm/KHpJhLjpXOk5CUvaf8N9Z2lWvCSN4T+aN8J024Tmi1rxa7XFbAn6SQoNVV
         GUH3RsEkkUcLb2mEil8n2lWVSgsqUHWzopkEn5SZOLtscsK58OJnlzSEIBtyUNQUYdvH
         +byH8FgfLqfo8JyqoDDaX13/nD89RlBBLIHlEC7StSUNl6H3Vy+2ru/vr7Pyh6KiTO77
         Ktu7kfiDHpGgJAO3HpK3SHkufojtSfEknYyaEYMPN2CzO2fOMf6IPeE80U1zOvPoPnRF
         YKVO3FZw3ZPo6kT4V9n3eWHRgTMdy32T8LzXSNotCcCqFEr1uCowrPfhLnDz66W+1ZwM
         dHFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777064944; x=1777669744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n1d+xjduzAM/MSTs6YplaFj6vz27O1vUoV9FGHND4Bg=;
        b=NI65Ra2dfPrO/VXgAQGEO9VMO0jeQb21FsVk+qlVoFk5h0It0173gzZhGmIDXvTRDg
         sUtJdDYoyIMXXc64vgSFKwnPSy1yHx1wE0NCdX0HUqHXr7r27YWMeev160nVj1+LQza6
         Z7rFVGkL3p//mUufr6ipETVoCp9ZrS/RrRAeubZWpjk4Vd0O4dZMazNmMY6vc2zUZRba
         qhjMKJF98V8i7kgFsA3aRJ2I/cqdFVjhHd5lUVcO/8mIU2XzfcKuKuYFMLRomRs4tLoS
         zAgj5YE5tcDhGC2qyGD8FbamdA3XfeODd+ZAjBEMHnRozdt1ZYKZfDX0KoGdX++G+5l3
         j6Lg==
X-Forwarded-Encrypted: i=1; AFNElJ+okp/31IZZ2cRl1lgK0xiVm83vT9JIUjI3kUJLj8bgmM/FcMCzjZz2KqWV4C5806PlFxiZHlaOFyjcuTiRwGj41zt1jzU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYsG9QqehgtafHdxlKGXjcOt6jP3DS5aRu6yyi1oIBkd0Ks6HU
	NNkI6IsClbvrpsQmFne1tky8fDrddkMom5wDe2cU8Q4aXYesc/pUO2hUJVsLWhiXOrUAi8uSMnl
	p0k2Atf5MSbYCxBBUdTFBnL0knEnB4hE8ZS8pczyq
X-Gm-Gg: AeBDietAc5XbB9nOTlvNj38nILdicosr0MakxlbDbGkku9+/+cjL9yF53z65GPmt5hl
	ai5QXttbd+jBISi5sfCUOkDENxmd13lZwqUQuMDqiRj3tJyav6gUoorNAuVLQQ4jCaPIiECvS+Z
	L6U6obLYWpGmQoNlDpd4uuucRUld2NzI6KFVEw1FU04WEFy8kZtyBys0ch9+m4mCdHNOt0ga6ng
	YNWlC6N0j19/71FnPultxmjWkSugjqlAvGbmrCPegQu0dRUoWDFDOJzjbekwrOJvf2Ja0w0XZNa
	w3EFlLahUEt52iYfcw==
X-Received: by 2002:a05:6a00:b4b:b0:81f:3f03:6846 with SMTP id
 d2e1a72fcca58-82f8c97b854mr34295308b3a.47.1777064943538; Fri, 24 Apr 2026
 14:09:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aeoAlVEwzRUPrlVe@e129823.arm.com> <aeoRxWPyOHGJd+Jh@e129823.arm.com>
 <aeoWO2Cwo04YYu2l@earth.li> <bd908e28298d968740d03c97bc7e441de188b7b4.camel@linux.ibm.com>
 <aeokwrC86WI7uT+K@e129823.arm.com> <aeomlp3I0eVE5mce@earth.li>
 <aeotq8nPVu4wvEx5@e129823.arm.com> <e4e242ae5533d5762a3647186a178764881bf9ff.camel@linux.ibm.com>
 <aephL3MzYoqFGaT5@e129823.arm.com> <CAHC9VhRQWHEWQ5NzOPiu8jtYv6UsRm8WVS4fd74AbkOcAd4y_g@mail.gmail.com>
 <aesGU8a3mbVzvteH@e129823.arm.com> <CAHC9VhSaT_quKYnpFjAfqvL07JNbWMgM6c4pB9F46NHawX3DCA@mail.gmail.com>
 <014cf39aa8d6a0bcfa1a95c069675977ac67b843.camel@linux.ibm.com>
In-Reply-To: <014cf39aa8d6a0bcfa1a95c069675977ac67b843.camel@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 24 Apr 2026 17:08:51 -0400
X-Gm-Features: AQROBzD9P2TWOpZi4hSjY4N4Nov3CnXh30sPXe4h_cg3LpJPQQpo1U__Q_DVo84
Message-ID: <CAHC9VhTW3=RJ8L91RWXYYA9tFjfSXGN-DMEEwdiD6big9H57Ew@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/4] security: ima: call ima_init() again at
 late_initcall_sync for defered TPM
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, roberto.sassu@huawei.com, 
	Jonathan McDowell <noodles@earth.li>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	jmorris@namei.org, serge@hallyn.com, dmitry.kasatkin@gmail.com, 
	eric.snowberg@oracle.com, jarkko@kernel.org, jgg@ziepe.ca, 
	sudeep.holla@kernel.org, maz@kernel.org, oupton@kernel.org, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	catalin.marinas@arm.com, will@kernel.org, noodles@meta.com, 
	sebastianene@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2026 at 4:58=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> wr=
ote:
> On Fri, 2026-04-24 at 16:15 -0400, Paul Moore wrote:
> > On Fri, Apr 24, 2026 at 1:57=E2=80=AFAM Yeoreum Yun <yeoreum.yun@arm.co=
m> wrote:
> > > > On Thu, Apr 23, 2026 at 2:13=E2=80=AFPM Yeoreum Yun <yeoreum.yun@ar=
m.com> wrote:
> > > > >
> > > > > Sounds good. Once the patch is posted, I=E2=80=99ll review it as =
well.
> > > > > Sorry again for the noise, and thanks for your patience ;)
> > > >
> > > > My apologies for not getting a chance to look at this patchset soon=
er.
> > > >
> > > > This seems like an obvious, perhaps even stupid, question, but I ha=
ve
> > > > to ask: if IMA can be properly initialized via late_initcall_sync()=
,
> > > > why not simply do the initialization in late_initcall_sync() and dr=
op
> > > > the late_initcall() initialization?
> > > >
> > > > Does any IMA functionality suffer if initialization waits until
> > > > late_initcall_sync()?  If so, it seems non-critical if waiting unti=
l
> > > > _sync() is acceptable, as it appears in these patches/comments.
> > >
> > > This is the way first patch did, and here is some discussion for this
> > > (Might you have seen, but in case of you missed):
> > >   - https://lore.kernel.org/all/a6a0e15286c983d720de227c6827adbe976c5=
b9b.camel@linux.ibm.com/
> >
> > Thanks for the pointer.
> >
> > Unfortunately, my concern remains the same: it's either "safe" to
> > initialize IMA at late_initcall_sync() or it isn't.  Attempting to
> > initialize IMA twice seems both odd and wrong.
>
> Agreed.  However, IMA should be initialized as soon as the TPM becomes
> available, not delayed.
>
> In patch 2/4 patch description, Jonathan describes the reasoning:
>
> Unfortunately some TPM drivers (such as Arm FF-A, or SPI attached TPM
> devices) are not reliably available during the initcall_late stage,
> resulting in a log error:
>
>   ima: No TPM chip found, activating TPM-bypass!
>
> and no measurements into the TPM by IMA. We can avoid this by doing IMA
> init in the initcall_late_sync stage, after the drivers have completed
> their init + registration.
>
> Rather than do this everywhere, and needlessly delay the initialisation
> of IMA when there is no need to do so, we continue to try to initialise
> at the earlier stage, only deferring to the later point if the TPM is
> not available yet.

Once again, that heavily implies that it is safe to initialize IMA in late-=
sync.

Put another way, what breaks if IMA's initialization is delayed to
late-sync?  If the answer is nothing, just move the initialization to
late-sync.  However, if something *is* broken and we are just doing
this because of TPM delays at boot, this patchset just creates
additional problems and we need a different solution.  I can't
envision a scenario where it makes sense to attempt initialization
twice.

> > I understand the need to ensure that the TPM is available, but if it
> > isn't safe to wait to initialize IMA at late_initcall_sync() then it
> > would seem like this is a bad option and we need another mechanism to
> > synchronize IMA with TPM devices.  If it is safe to initalize IMA in
> > late_initcall_sync(), just do that and be done with it.
>
> Within the same initcall level there is no way of ordering the initializa=
tion.
> Yeorum attempted to address the ordering issue in commit 0e0546eabcd6
> ("firmware: arm_ffa: Change initcall level of ffa_init() to rootfs_initca=
ll"),
> which is being reverted in this patch set.
>
> Ordering within an initcall level needs to be fixed, but for now retrying=
 at
> late_initcall_sync works for some, hopefully most, cases.

That's not a good answer.  Ignoring the TPM issue for a moment, can
you confirm that moving IMA's initialization to late-sync is safe?  If
not, why is this approach being considered?

--=20
paul-moore.com
