Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95FE1FA8DD
	for <linux-security-module@vger.kernel.org>; Tue, 17 Dec 2024 22:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734472806; cv=none; b=POj7mnr25XPt6J/mH8CRB9A+zPUvcXvJ4N1OAw7DFu4ZhehxsM+uQyO1GCAV3FXKfHcQCqQlQWu1Sgbu+zB7Ru+T99vGOKNDyFrdiawHGXFn0m7xY7UabT44MMvvn+Jtm7DyLhMNV/uPtzwY8Jea1j7Y8q7GiWepwpE2Uoo5ATk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734472806; c=relaxed/simple;
	bh=RX/zhaiq0L9l8ly9a3z2OFOaSe+5bBHH/nUVnvYlvXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fm+Q1HSCsvIT3mPs+kvA2aSu53pgYvq7+bqdcxNsduHiAMoJ9BkVRcLQYuNUuXiK2ksNndV7174bmwTxe98lj+2+8x9oqwQErW4DX3r/9o0jqsxrtI2ofp9rG/vHeN9QMf+IwRmXajJybKFK3vGt9He/sW8qYW5VsqGzBTpQNoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Dt3B9Gv7; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Dt3B9Gv7"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e3983f8ff40so3552390276.1
        for <linux-security-module@vger.kernel.org>; Tue, 17 Dec 2024 14:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1734472802; x=1735077602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ftdzShgtX/tEAx6aAhp++i3l0eubtYOM8tBAmWgBMfE=;
        b=Dt3B9Gv7TgfxnTpwvvWDpvMtVKgCNSQXIdGn2cDp+WAZiKRU1+Sl/btlbAFtGJkDUO
         7ftqo0GX7GV56dIB5CAnJpTKDklKfL+QMPnD9LTGlnSegpXwB/SCiJTFFrGEfBUV40Z7
         DdaTSkT0YtYdhuzZrNmdGfw5C+JSoxdJNeaXdP/Et2vZENVZBahV+7cllhWFoupSHCPn
         aibJhEsPsPcWRs4yMiS060XWLD25cfNreE9Y4eU46v9cCgKS1inNqsjwXYkSIrMrCUt7
         TFOzRLfz5qVudqD4DUme7zAI96PPs1eTO5ZFOn/mwyaUzitABONMhcZyvqkOt4A4SEvP
         afBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734472802; x=1735077602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ftdzShgtX/tEAx6aAhp++i3l0eubtYOM8tBAmWgBMfE=;
        b=RKB/7KQli9IJNQW+u7jkqSmU5r94mY0Fyn4tnCZbn3o4sTk3a8B9MWU5wKScn/bgFt
         R89KhJdVcagRhyc2+EFLta2dStkOjeyTvMGz11AV/nTwuOVme3lDion3YdhOz/Fj8k1M
         tQ7mW+0IXAA/MRb6sPF7lfzN0JljbwlOuywipQnXnPI3G7rrxjjQZXHGLr+asS/AqibA
         U7C0wyRmyNXO6OTLbvuTJEcPWL4E20GsxZKbAmp4NigGzTMaQNColl1vGDzcl6IiZyuW
         KHHG4sMLZBlJc54y+y4RYfyARP71/wT4Un5/9mxxxgtXgdRUBPhr7YB0g/3LUgR6F0Mj
         34Qw==
X-Forwarded-Encrypted: i=1; AJvYcCW/JvL4sfXFy9GaNDuKcC08QnTnMTJQegqN/dGXsaT+7jjUYgpB8yHITs2L3ZSb0twFTvt5riqhgbz07o9R7l1yGjekM5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+8YGDQlv0P1xZuF6xrl+CshFowGP9nTUMZ0SujlLrjivMGhxF
	fMtJYFfePnyl001TgGMJpuZyNfR2DNIYXMUIeBmvU2+IxG7sAQDNQKDKn8Y+e0lKze5wV+iOqKE
	66kSYynPKclf/0bEdHYDbm9gOX5KtwZWLtffo
X-Gm-Gg: ASbGncuJ8cBg/6668mdl8hWyDCym/jVtz2Hhygj6HBvC8u7ap8ANUjjYdCOHiVC5DIV
	d3UtUrUzZ1aNDsvGab7ks3dLTmfclLVtH0EbS
X-Google-Smtp-Source: AGHT+IEU7ZqkpQLdLUs+NmpFyHzcV/krv50XAmUj5bf5ADbtRq+UVr88p+tUmkW66IRG+xuXXznG0o19SeGqPqHFkkQ=
X-Received: by 2002:a05:6902:2204:b0:e2e:440e:d29f with SMTP id
 3f1490d57ef6-e5362122e49mr679348276.20.1734472802619; Tue, 17 Dec 2024
 14:00:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217202525.1802109-1-song@kernel.org> <fc60313a-67b3-4889-b1a6-ba2673b1a67d@schaufler-ca.com>
In-Reply-To: <fc60313a-67b3-4889-b1a6-ba2673b1a67d@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 17 Dec 2024 16:59:51 -0500
Message-ID: <CAHC9VhTAJQJ1zh0EZY6aj2Pv=eMWJgTHm20sh_j9Z4NkX_ga=g@mail.gmail.com>
Subject: Re: [RFC 0/2] ima: evm: Add kernel cmdline options to disable IMA/EVM
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Song Liu <song@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, roberto.sassu@huawei.com, 
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, jmorris@namei.org, 
	serge@hallyn.com, kernel-team@meta.com, brauner@kernel.org, jack@suse.cz, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 4:29=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
> On 12/17/2024 12:25 PM, Song Liu wrote:
> > While reading and testing LSM code, I found IMA/EVM consume per inode
> > storage even when they are not in use. Add options to diable them in
> > kernel command line. The logic and syntax is mostly borrowed from an
> > old serious [1].
>
> Why not omit ima and evm from the lsm=3D parameter?

Exactly.  Here is a link to the kernel documentation if anyone is
interested (search for "lsm"):

https://docs.kernel.org/admin-guide/kernel-parameters.html

It is worth mentioning that this works for all the LSMs.

> > [1] https://lore.kernel.org/lkml/cover.1398259638.git.d.kasatkin@samsun=
g.com/
> >
> > Song Liu (2):
> >   ima: Add kernel parameter to disable IMA
> >   evm: Add kernel parameter to disable EVM
> >
> >  security/integrity/evm/evm.h       |  6 ++++++
> >  security/integrity/evm/evm_main.c  | 22 ++++++++++++++--------
> >  security/integrity/evm/evm_secfs.c |  3 ++-
> >  security/integrity/ima/ima_main.c  | 13 +++++++++++++
> >  4 files changed, 35 insertions(+), 9 deletions(-)
> >
> > --
> > 2.43.5

--=20
paul-moore.com
