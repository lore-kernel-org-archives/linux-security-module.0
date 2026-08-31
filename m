Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F07397338
	for <linux-security-module@vger.kernel.org>; Mon, 31 Aug 2026 21:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788211594; cv=pass; b=bDlBQvPYTOVBE1YFyjtxBrSvCbottddWkrZtmDH/ObCRqc5ItslxRNjjnUtIQmjP708zFbfII2HlJQvin20BoxOkTLw9/Q/N7G6hBatjRl0kfuqVVhVYVJcyOcuPHpXV/y4ep7scz9qSLSKeKM2gXg2V6xWc6jGmg+sK8o21wZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788211594; c=relaxed/simple;
	bh=SNlsz2MPRq4levA4MX+yohL5QexaYB539yJgxQLixV8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CL8lr2k5pdXjZIo1NMVK4q9CnnZzzlVcdLL43uzGOwClSIKCuMJx8Mxl2v3Qv0FhqetneIRXOYL1DoOhbAcpStb07wx/DCzH0+Ch4J0nOgDKhlAbeu99tBOET0AKqCGd65AKfYcrQjlNYImrZDLmKLzae7onNKkXLzkEIH5pG5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=PQIMo9RI; arc=pass smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="PQIMo9RI"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-85377c8bc96so3740579b3a.3
        for <linux-security-module@vger.kernel.org>; Mon, 31 Aug 2026 14:26:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788211592; cv=none;
        d=google.com; s=arc-20260327;
        b=GBYhX39Y1LgGpiDY2yRISJJBjOVIdVlUWMstdLwpctrXsEuSHkSsx3MaLd31C1Qr+/
         NglbDWAAPMJ1oAcr9M8tbaLCT0hf4KTjfpl9BoAqd6yRJ2P7S46qShKBhJGcj5FHtAem
         jbaL9QwdeEmWV8KBCzedcPm0hJwaRNQ/0v92TSI3+9EeuAgmw7D5A26KJzKgbnn8W1wr
         O7Tto4ci7cQ3yVAgFobnNwX+8DyflLi6ExU8GRwTNFo1wz1mhO4LRlKvMgGvYMJF5zZL
         G/a4BaMjh9GN3qAnYxNbGaxC/2veBw5u0uX+3ef//XU7KIjOw9BVI3wW+ANkfBOmSIym
         Kodw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=B0t0GoOAIGAPmJB6jitdBOXKLd7x+wtGWWpKwR8Li5c=;
        fh=+AVUhNCXZUlAK4mOTFvhl25jXZ1/SXnewLwy17V1SIk=;
        b=DnfirX4FfCI/ROe9Zgs7cmEwyJZM/jl8EVEkS97N2dOUnvunTH/L+rITWjCpT2SEzk
         IG60rZuhgQ5eJQkxB9PGGE7ZVXQNFiPxU5wbYi5rEjpiCOSOhIefHHsu3tVEn2IAwExA
         bcyo2sEYY6M6cLEW8sXlN38BUN1EsbtaDFS14CwdFMqo49QU0vio5pEkxs2FFD6fwVFF
         l5q1azBjoj9K8QA33I3fOAFRJY1gqYN678OxTB58P2z6ibZvhLEC3Av9dGgxBnM7fngq
         2tt5jQsTrwTBVSv3jJH9mpb2nvynR3XSKuy4bZGcNG4gn4UA9AuFvnX2LdyFI2pixvjk
         3RnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1788211592; x=1788816392; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=B0t0GoOAIGAPmJB6jitdBOXKLd7x+wtGWWpKwR8Li5c=;
        b=PQIMo9RIZT6w7HmQKV2ItxMWnQ7jJyw4LDw3Sxt1Fq1/4DVLN4pgtpgAvRvhz211bU
         VtUJrxLCUImzY8K22youYRZ9bk6Nm7/vW4fFHUnZKcGluCpZ7aubtE3U4Wfm+/FjntTu
         z/6V+7VDf4SX6e5HWf2GnV73XK/HpkYoauBpjntBsyCzEe98qCEvMXE0T04Fjzp+uIqr
         NP7VE2I18KgJEnAOlaxy1kTaJoDjqkjzc4ZJlPlVyp+sfH0OZiSEBnIEY1UqMzyxCIQ+
         IyNCIsKsFVEzVH+jz5prz8x4Ga138WHh9chWvYOO7xHD3+OomyDnNBDb7Gsf/iU9LFu2
         GW5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788211592; x=1788816392;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B0t0GoOAIGAPmJB6jitdBOXKLd7x+wtGWWpKwR8Li5c=;
        b=UcKFm4lvjJipX0OSfSf0SQjm2A6B5aoYM1FVIOAMqhLNkPKhnt2bOsPP1InaNYv6Dw
         XaSAhAYdQekiMML4lLyZZwS0nD1Io5eyKOnTEmsRmbUSq6nm9dTdaJZcoR+YrqNpndsi
         C12zI9zi3pek6dC5VcqqWyYxiix+/qoiAiATwqn/YEvmnS2CU5Yw4v08mcfjIBrIMBQ3
         7EeWD2l5GLBPBvzSK2TyahCzuvQ+5tYYInkhCi+b/cFWQnz4gKHBNAV+9s5zoBcKs1rC
         BMBVf1OtyAoz5TXhU4czpOjh2F5h+mJnC4Qw2Wy97JwB2dGLU6G76och4vwrtC3lH1mG
         BTBg==
X-Forwarded-Encrypted: i=1; AHgh+RrR1tby1XNdPflmEuZXNA1gLHCIsOLOltFRYXvzmEPnpJIL9IHQNUdtIvQFjX75C3G2Z3sYW4cPv2JhUL+qJx3m/2sLmAU=@vger.kernel.org
X-Gm-Message-State: AFuF++kFDMBZgLfWcNDk2P8fs6ghGY7YtL5Xj5V2iwk6CEnbaSAZqdAY
	QrW1kfonhN2itUHZhrRJ7KNpU8ByPqG15qVoUULjBZEDEeQzDLmJXQsE1fAxglrIBL5xtxMfUYE
	HAFm3K+3VfmJB/rL7DB2yb7TargXqSt4skmd6YOTG
X-Gm-Gg: AR+sD10NfVFjLHb9JYBBHDrB+qzHeIHiO4Sz1McyPUdN634Oz/FKJl5yHFkEPfbDgp/
	6T8rW6YcwG3AlBbbL3R6kGHJ3diG9DQnD06mdjRn9jPWKJAh10g5bulYSi1pqqgKKXCLIGO98mr
	ciMKQADh8ejwASyE4IaM1Rxof5wdRbnyD93a8p8IohGqbm8CsB7+qhL8YquDXtBP+oqpv6mx95F
	h4FaA1u/RIvik9y6f87wJrYz2DMErqgFYHu+LEu/LhfLqI6pok72/CqhuUuVJGms3Cpes+nZ2to
	NsnW/u0pC70Eb8wg9fEjp46560TKkSCls6DCNxCstBPpYg==
X-Received: by 2002:a05:6a00:2da7:b0:851:bf92:34c9 with SMTP id
 d2e1a72fcca58-8562a8d2cdfmr43570322b3a.9.1788211591833; Mon, 31 Aug 2026
 14:26:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260726161400.3010511-4-mic@digikod.net> <5cabf9b33a20f130cedcc423b8b2d151@paul-moore.com>
In-Reply-To: <5cabf9b33a20f130cedcc423b8b2d151@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 31 Aug 2026 17:26:20 -0400
X-Gm-Features: AcwNN1VcoP3dcmF-y7p30PIUoPvKVk5sVz3Ko6oQrIqfztGFDqzJ9T0P3PiRYsc
Message-ID: <CAHC9VhS_WP-bLgMGiFAfE1MT76iKvVJ-OV5r7xju-KMdrfjssQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/12] security: Add LSM_AUDIT_DATA_NS for namespace
 audit records
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Christian Brauner <brauner@kernel.org>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: Daniel Durning <danieldurning.work@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Justin Suess <utilityemal77@gmail.com>, Lennart Poettering <lennart@poettering.net>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, 
	Shervin Oloumi <enlightened@google.com>, Tingmao Wang <m@maowtm.org>, kernel-team@cloudflare.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 4:16=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Jul 26, 2026 =3D?UTF-8?q?Micka=3DC3=3DABl=3D20Sala=3DC3=3DBCn?=3D <mic=
@digikod.net> wrote:
> >
> > Add a new LSM audit data type LSM_AUDIT_DATA_NS that logs namespace
> > information in audit records.  Two fields are provided:
> >
> > - ns_type: the CLONE_NEW* flag identifying the namespace type, logged
> >   in hexadecimal.
> >
> > - ns_id: the unique 64-bit namespace identifier, retrievable from
> >   userspace via NS_GET_ID or listns(2).  Unlike the proc inode number
> >   (inum), ns_id is never recycled.  For namespace creation denials,
> >   ns_id is 0 because the namespace does not exist yet.
>
> Based on the code in this patch, "ns_type" should be "namespace_type"
> and a similar change needs to be done for "ns_id".  Regardless, the
> first three patches look fine to me (I can fixup the above during a
> merge).
>
> As mentioned previously, I want to merge at least the first three
> patches via the LSM tree since we have multiple LSMs which depend on
> these new hooks.  I'm happy to also merge the remaining Landlock
> patches in this patchset via the LSM tree, or you can manage those
> separately; let me know how you would like to proceed with that.
>
> Since we are at -rc7, this is obviously something for after the
> upcoming merge window so I'm going to merge the first three patches
> into the lsm/dev-staging branch now with the understanding that they
> will move over to the lsm/dev branch after the upcoming merge window
> is finished.  If you want me to merge the Landlock patches too, just
> let me know.

The first three patches are now in lsm/dev, thanks everyone.

Micka=C3=ABl, if you would like me to merge the remaining patches in this
patchset into the lsm/dev branch just let me know.

--=20
paul-moore.com
