Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7041C5F1B
	for <linux-security-module@vger.kernel.org>; Thu, 30 Apr 2026 00:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777509431; cv=pass; b=psTvqKxaIchJCMze6yBHEk6PIhT+RjGeIPaDJ7kx40xxJQ2CWCoWnYIaxX7YJek3qF3TY2i+Jdvf1PoeI3ck/VpAAABcMQrhehHkhmIMiCvgN49z8BzzNeEYjNYItTtNgwJMNjGRLmMbceAb7YRiJd7tSYI5xmqB/mqLoLMc/HE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777509431; c=relaxed/simple;
	bh=jxwagxkzPi78qwqEQPmxVQVl+/Y1Vrryfq7+F8b392M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qC1pwVtsZBQEZU5rVvwUr1mAtsnd3Qoa51bmQqUig2W0WC+y0fvJKJDTXCm1q05v6y2zDQeQv0Rw1LKgjFncbPs60XeFNxkca2HT2SHuIYsqUWVI746U/G4WmjcKXyC44LIT9f3sSkKfV0stJYBZrpX2Md+Giyen/eQKXoJQ5ok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=eS/db0qW; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="eS/db0qW"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ab232cc803so1424665ad.3
        for <linux-security-module@vger.kernel.org>; Wed, 29 Apr 2026 17:37:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777509429; cv=none;
        d=google.com; s=arc-20240605;
        b=cWgF6JG5CxZTkcNtcpqwXB8tsUYI+rkj6Zy76kyYcKf31vTemRG1qxPce4e0LHqVpL
         0DfhxvsUloS4ro5W7qgokNJT26BhJG2/JHx5TgTWoQaAVECEyvTqUiMeM/A/tXfXPSb+
         VqSonPJPTGx4fyWCJvavoLjeJ/yQLUC3mv9z+zcrvIl0SOrrGyJwaAh5KSjRY8ORC8Bo
         5B7JkwenBOhttFMy/z6nrJE8EsmBxzS2DAeeghZJVznr8RyCKWa2c249yi50eny0hNMZ
         tiRpF5RZPgTVYJKHZz2A3MQIu8Tlc8RNJ9hNSOwHhjw9drO7mWKzdaZRhgQE/MPs8Owz
         VhEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XxIaGXcpSE5LxIReZcGgBcZB3ReO4RJbfPvanWg+Ksw=;
        fh=YtbI1kPmbvau0ylZyXIZkCUQtNl+9bY4teEmGCH00tk=;
        b=dKjPev9eD+3eLghnDwTGqyWtjqFECKeOLVweAel8shw2l1vXtiQlz4Exe3Ccd2Tz0G
         d/h1ukVzn5w0cD9vutfwWztr8rB7saQLrNDPgFYJTAtmxjx40b6es5gtQAdxD5BzKNNy
         igypqfHJrHZp5g365Ml3Kh9kksMzMLxTRZUue/lMKSjw2Gbi6TIjJ/1/qNeCy3YRCVS4
         xdu2BvI0xepYwKGTy7bg88UB0uB3zjfC56lfeiWbmj8MLUP1o8Fz4ZfHfv9+V92kLDM9
         L8azfyNABppX7p7ePrpK1X/LjMNvNPJzzCRgMaQoZgx+m6Vvz4mSlcuZf2mJbCOCDZ9C
         zc7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1777509429; x=1778114229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XxIaGXcpSE5LxIReZcGgBcZB3ReO4RJbfPvanWg+Ksw=;
        b=eS/db0qW6OCfyvEl1tGX/aAPfKh+98ODtSsABKaEG3/UKblugEP7KMa8bHupkzvAOu
         SzAj8yIWyxKw6LStzCvSMYwpWihSuXetB1fONwuIlrT4faYy4WrEWvzyhDM/89PFev6/
         vXkL1vxrIoICucEKwE6Uzr/TZEzQKhzn8JZ2+AA8Kc4i2dK7HKxzqPj4+ansFuLu9uol
         ad1PeIEIvAVuSSH/amy6Uemdlm6eopaS98KIz2IDMAdNRugx+EXEvbk7Clrqaj7b2xQy
         EhA2pG9/V7rS0wt30efh6ZvmKlOgWx3HVH3ikBepIBKB3pK12NJYYirtKMBRIzyJ8jz6
         N05g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777509429; x=1778114229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XxIaGXcpSE5LxIReZcGgBcZB3ReO4RJbfPvanWg+Ksw=;
        b=K8Ot9UlZ3a5qXLPmu9xYOek2s3AWWdsn6P3Oxe34WqnQPzMc8NcIcB2OVRwnnZEgUM
         3hFwH3+Ug4m3PizFWEbPdzx11XTm2TGcwliAYGkuTJPnOp7rJ42xd9XX8+m42Vfc2wLy
         pxDrLllnpFJNpiMuR5dbdLJbvz4A/JxJ5xyXkgYijIy9b/lGSVCp1mQL8Bj+d79WV4yU
         BN2Zer3DprnV8h29BuNa45msokQogRkGITLTJxewXqhOoAAA7ZmfoIaM9LjFEVLMo8mF
         XX9FfBRMd1Sj/o+rBbh4RF/cdSxHuma/8YGhRrcfcbLFbJK00t1t6yFZRxtMO9fT4DDv
         Gk6A==
X-Forwarded-Encrypted: i=1; AFNElJ/jSgMVxmI0IevqUXuePgZmG00qBx8Ltk/ujkAnrAGcfwiSHHS2jrcf8v7G+r8W5M5i99l9gBK7yBkqOnNj5a3ezNn8P6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMj/Bmopl9h2j0tqQU5U+xrhZz5sTAINvKuX/+5xFGIHO/yD9S
	Qx7Ke0FHDdCwxIMwLIxXRSYR1do4LrGXkKKc4JHigEwY4whUgJpkWOR8CtWn319epDCvQqZNjqV
	izt27C2k81HqSvpvLIp2Il24cVrhsudx/G9cfu/NI
X-Gm-Gg: AeBDietfZTjMwrBntsk0RP2BX6jl4H7vyldSToABUOiuPiNpiuPdfgSW/K3wu8EzH1F
	vwYn50g7XOHExieN/ttm5qVMZixAfr4LQbcNX9tMhD9KSUSAM1oIktlMAvItz435t+1Vm58PQh3
	Hm+HArtdf1sFCI4p4cUoEYmOy0JSLCtTm+EY6TNkXBAPB4QtBNzPxk2W+ohrk/FiNHe2nUY+0QI
	rVGhJ1aqvSScaIDK5IIwyf3FHGUtsHGz2T247WMGXImQT7CSs5o6oMG3AkNIxaga4OkDg2iVwHf
	BlsPjxZhu30ZeFEPxA==
X-Received: by 2002:a17:903:3644:b0:2b2:5314:e96a with SMTP id
 d9443c01a7336-2b9a2523582mr3745025ad.34.1777509429231; Wed, 29 Apr 2026
 17:37:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aephL3MzYoqFGaT5@e129823.arm.com> <CAHC9VhRQWHEWQ5NzOPiu8jtYv6UsRm8WVS4fd74AbkOcAd4y_g@mail.gmail.com>
 <aesGU8a3mbVzvteH@e129823.arm.com> <CAHC9VhSaT_quKYnpFjAfqvL07JNbWMgM6c4pB9F46NHawX3DCA@mail.gmail.com>
 <014cf39aa8d6a0bcfa1a95c069675977ac67b843.camel@linux.ibm.com>
 <CAHC9VhTW3=RJ8L91RWXYYA9tFjfSXGN-DMEEwdiD6big9H57Ew@mail.gmail.com>
 <1f78fc75b2e95239973612a4b6c4cc782960b7ac.camel@linux.ibm.com>
 <CAHC9VhS4JmPmCJrYTdbjxb3TO-uK6cB3Zij-ef=wswGce2BGzg@mail.gmail.com>
 <1e51c2fd090e5ceb07b1d09e50650c70fd3ccdb1.camel@linux.ibm.com>
 <CAHC9VhS_WgwhW_NDO91LoTeSzdieGqbwqnwPq8KpavH1_Lwi7g@mail.gmail.com> <afC0UPfGhNTsXnyi@e129823.arm.com>
In-Reply-To: <afC0UPfGhNTsXnyi@e129823.arm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 29 Apr 2026 20:36:57 -0400
X-Gm-Features: AVHnY4L0F5CYsArVv0_Aux1I2flm7srRsxc7thS9QtQpbPKd3nDtBwoWwNOL0u8
Message-ID: <CAHC9VhR8Qc42xnoNHW+CEKGEAeupET-BFdYuHLuM3ZGzfDmEYQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/4] security: ima: call ima_init() again at
 late_initcall_sync for defered TPM
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, roberto.sassu@huawei.com, 
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

On Tue, Apr 28, 2026 at 9:21=E2=80=AFAM Yeoreum Yun <yeoreum.yun@arm.com> w=
rote:
> > On Fri, Apr 24, 2026 at 6:49=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com=
> wrote:
> > > On Fri, 2026-04-24 at 18:10 -0400, Paul Moore wrote:
> > > > (I'm assuming you meant initcall and not syscall above, but if you'=
re
> > > > talking about something else, please let me know.)
> > > >
> > > > Saying that you aren't comfortable moving IMA initialization to
> > > > late-sync is inconsistent with allowing IMA initialization to be
> > > > deferred to late-sync.  Either it is okay to initialize IMA in
> > > > late-sync or it isn't.  You must pick one.
> > >
> > > Yes, we're discussing late_initcall and late_initcall_sync.
> > >
> > > I prefer to look at it as being pragmatic. I'd rather err on the side=
 of caution
> > > and not move the syscall to late_initcall_sync, than move it.
> >
> > If you were truly erring on the side of caution you wouldn't allow
> > late-sync initialization without knowing if it was safe or not.
> > Determine whether IMA initialization is safe at late-sync.  If it is
> > safe, move the init to late-sync; if not, keep it at late and figure
> > out another mechanism to sync with the TPM availability.  If needed,
> > you could probably use the LSM notifier to enable the TPM driver to
> > signal when it is up and running.
>
> I don't think LSM notifier wouldn't be good since it a one time
> notification for initailisation and it wouldn't tell properly
> whehter TPM isn't present in system or present unless functions
> ima_init() are rewritten to discern the "TPM deferred" and
> "TPM doesn't exist" in the system (e.x) boot-aggregate log creation.

Yes, some work would needed to differentiate between TPM present and
TPM absent, the notifier would simply be a mechanism for the TPM
driver layer to signal to IMA (and potentially other LSMs if needed?)
that the TPM device was initialized and ready.

> One question, though.
> In the end, for systems where the TPM has already been probed by late_ini=
tcall(),
> init_ima() continues to be called at late_initcall(), while the above app=
roach
> is introduced for systems where the TPM is not properly initialized by th=
at point.
>
> If init_ima(), which used to be called at late_initcall(),
> were instead called at late_initcall_sync(), could this break system inte=
gration?
> In my view, both late_initcall and late_initcall_sync run during the do_b=
asic_setup() phase,
> so it doesn=E2=80=99t seem like this would cause tampering or affect thin=
gs like the creation of the boot-aggregate log.
>
> Is there any particular reason why init_ima() must be called specifically=
 at late_initcall()?

That is something that you, and the IMA devs need to answer.

--=20
paul-moore.com
