Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A467D3FD4
	for <linux-security-module@vger.kernel.org>; Wed, 23 Oct 2024 00:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729642088; cv=none; b=At/Cb1fXJ4qMImpRLtM0rZp7LEs91UFu1WHUGI/W8s5bXb833o9ZWjEnUQgZ4+efVnyhBELgnumY0/yxRPqTOJMFxaCpH/Guz0iECgMUj7OpdvXEA43PucVcZqU6TPi9q0Odk7Obdw0xMhQrtNnlNd8xqRJye0cVM1trkMCM2DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729642088; c=relaxed/simple;
	bh=L9wuywf5/cbaM5/uK1OhLnWZI2jluA+vbm9p8zFAP3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GXb1NPuPbhRopekTO11dEkF2UBWSW3Uaazh/fzQXwJor9jBlvJLi3YAUSRgl1j7zB24V/5TgDS0heXJDtEVKmW+YXOU89xYXcPApvBE+DAHDuwrmeok+NhoLACbCnxsNq6PWL7Uf43c6RuR7zOwzNU4JjIICxy6llbnHnNfR3xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CpnSwByV; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CpnSwByV"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6e5fadb5e23so28268427b3.3
        for <linux-security-module@vger.kernel.org>; Tue, 22 Oct 2024 17:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1729642085; x=1730246885; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=57Fj8gLod8rIEZZw/4UIvzCnaCOQol0AMMxxaOEWmfc=;
        b=CpnSwByVMmecKruLhu/w+5LXjkJOV73mQH9i3X0hCTApDTl13C0h3mbRHMmVyfFxEk
         HYTXA+Tbub0IS1hu0+szclE9FSRC2q++XVK1kYPedqsKv/LpVywznPtjss6ijuPQiiLR
         KUbmsS8rXJyDtGvPf4t4xYKtjhxAb9NGzixDGJPmyNPCpefxXtf3ty1ZgxhFDmG+ogR6
         YVXHCMLDMhDeSxf7Oo/a3f3TRK6MQRKJLs1bEQ6LxYNqhtdvwyWpo3qCDoXtEQf2v2Cq
         TZOD5dmBIaEEKu4t3JU3lLO8syhKJSmYHMmH7kqCw9vNcga7fnv6p9BuRpAYHWQtcFPd
         c8ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729642085; x=1730246885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=57Fj8gLod8rIEZZw/4UIvzCnaCOQol0AMMxxaOEWmfc=;
        b=iW3O8nUrRMBCXNM51K2G/vexrpzzBsj4E+WrB60KFLCa0WTsvRSA3gp3y2ZyphDApo
         dI5t3H3PaSD3YPBI/BsLVXJzREqJxXqqsU4jwZBEsLhYLUMdZCf6oIB/X0VKj2r3MzJv
         GVKxVtueWgI2akRDe19TFrsr8wU3vaLSHovHjQcBiTBZAaxPSpUfTlCT3PYXJB+oUxVH
         Izu758YuL/BH5JULwPWBLzPFrOJ29iETMlNpUrAHN/Jtq6BikFGTAFJ1P1glmJQMmP5D
         N0Fac/9EJ55aEoyrIXTmT7jH98PR7N2+LIue/tNvQsUHBgnBznvQzemsHFKfybcapjoC
         NXBA==
X-Forwarded-Encrypted: i=1; AJvYcCUuTST0JyXu+2zK2Hm2+zWWQ9bM12HFIbw+Zsn/qpCJ9Tww/+T4+6QxwalHxdJ6fxHAj2q3UFsprRt/peqv6w7/cYZWWCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ2I3E/c5UxJ1C8mkVU0gtqMkIkUlq3uc6alVqIYYcFPhgCueK
	P5Z0kwm5Fez/qRddJgjfQbMfY7vqEkQ2w4NWiBGFVeiHuQJoFDWh9MvPJ+fU5A6UbIbdlImSzmx
	k1WMnKRLTKrrp9IFLQRN3PXne017rny6Aibcz
X-Google-Smtp-Source: AGHT+IHbuDmIRR/TLOrqFnG0inIcjWy4wLhddUf2dm3fEuDr1h8EDF1PeHoMyPzTrVGW9ITR2voHEzHCgq/TwyIeZDs=
X-Received: by 2002:a05:690c:61c4:b0:6e3:2c7c:3739 with SMTP id
 00721157ae682-6e7f0e32236mr9195097b3.18.1729642084739; Tue, 22 Oct 2024
 17:08:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022161009.982584-1-mic@digikod.net> <20241022161009.982584-3-mic@digikod.net>
In-Reply-To: <20241022161009.982584-3-mic@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 22 Oct 2024 20:07:54 -0400
Message-ID: <CAHC9VhRZ6Ug7ACLDgAiqQC3LPRPNM=Q5NX8TYxo-fcPA5XBEoQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 02/14] lsm: Add audit_log_lsm_data() helper
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Eric Paris <eparis@redhat.com>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Ben Scarlato <akhna@google.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Charles Zaffery <czaffery@roblox.com>, 
	James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@google.com>, Kees Cook <kees@kernel.org>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	Praveen K Paladugu <prapal@linux.microsoft.com>, Robert Salvet <robert.salvet@roblox.com>, 
	Shervin Oloumi <enlightened@google.com>, Song Liu <song@kernel.org>, 
	Tahera Fahimi <fahimitahera@gmail.com>, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 12:10=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digi=
kod.net> wrote:
>
> Extract code from dump_common_audit_data() into the audit_log_lsm_data()
> helper. This helps reuse common LSM audit data while not abusing
> AUDIT_AVC records because of the common_lsm_audit() helper.
>
> Cc: Casey Schaufler <casey@schaufler-ca.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Serge E. Hallyn <serge@hallyn.com>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> Link: https://lore.kernel.org/r/20241022161009.982584-3-mic@digikod.net
> ---
>
> Changes since v1:
> * Fix commit message (spotted by Paul).
> * Constify dump_common_audit_data()'s and audit_log_lsm_data()'s "a"
>   argument.
> * Fix build without CONFIG_NET: see previous patch.
> ---
>  include/linux/lsm_audit.h |  8 ++++++++
>  security/lsm_audit.c      | 27 ++++++++++++++++++---------
>  2 files changed, 26 insertions(+), 9 deletions(-)

While not a fix like 1/14, reducing AUDIT_AVC reuse is a reasonable
goal.  Merged into lsm/dev, thanks!

--=20
paul-moore.com
