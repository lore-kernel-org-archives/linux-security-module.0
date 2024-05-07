Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD0B16D9CA
	for <linux-security-module@vger.kernel.org>; Tue,  7 May 2024 19:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715109483; cv=none; b=tMbiUkOdkM55y8qmjbOttHtcDHrcAlHRQ4VE2hXaATKFdbIwHFiq/qNx6SgBkkeUCHCfwPRbcBcOB4sul0huIo3YHYMV6rp2hQAMhF7IL6u5ll35KM7634j1vLL9I62BYeuasx8FXgew9rDBwoGpYkQdDqj+AbtUvMJRJXTGnCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715109483; c=relaxed/simple;
	bh=gJG2RhP5yjo+VUpaj6pMQlkab5QI2HJRpPvMeNdy28c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NVgBKpbzLbEX/qSUpdya39aeBXO+brHLutS02ct0ImWG02+3YLuo3RfZ042B7d2IvRQMhHn74Iba3muvXwMYNdo0ZzYli1AorOn7OxKLXrNd4JbOzercNRRnDJgIf5zMqrAvvYNWABxsZ9L/LyFlxNNOqHsb5gIRKRYsPwIp5bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=bUCJ2sIU; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="bUCJ2sIU"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-61bed738438so37979147b3.2
        for <linux-security-module@vger.kernel.org>; Tue, 07 May 2024 12:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1715109480; x=1715714280; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RkUnJY0EFDu9PZambZs1IeCNxuSIB/aK1oktUOoldtY=;
        b=bUCJ2sIUiNaWigwdUVTOmpH5p7brYDKQmax8OPLuBgx256LQr9kpl/c+WaND+L+kLC
         GXf7aVlYDkZLXHI4ZWDfIszdBOg3Sc97ng3xKLhRPvPDT+geLQgiI2CrHlYynGRQOUtb
         XBgBB9X+dL5NQE9QS9S2UWdFk96DFoqBGn0J/jLgqJZVhVUVeadPTbHKrgmaL3w2AJKz
         v/kjeLqf3m2bjWmgDJp8xXWQAaY/YRcgyo77MX//OjRH2fAtfYjRTcitt+bmHKBL6d9/
         2awKbvwKksINC4R2c1Nr96ZyE8tLoSkOyn/pUo3ReIXXdCOXXnXNhKl4RUerwzCvnYnQ
         sSBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715109480; x=1715714280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RkUnJY0EFDu9PZambZs1IeCNxuSIB/aK1oktUOoldtY=;
        b=JKNhKzI2AI7+X/z2sI5Q88kzsco+jYMIZDXqxPcq1HYjT/Q+ONFevCBDJPH3MM0IPn
         +Fvw1ybChKIqKzReZ9rWAvl8xcRqnIDNufakKU5D2MYuwfkTXeTttFPBZKBNFTLDWAMU
         GyUBtddTGEmz3Sc2IA4n8Z9ozgsJKIfKDpYZShPfNJADPMr6phr8/G1P6iUHCCgcdxyf
         vs7D3xu+m4FL/IIfbv5xVHP9SzHtKxpxhV2ZCGCpJOqZ0uEjLBd6r5JAdYxCpfKD+R0I
         0CxXUgOXfH+LCpluqzwgblbpcVmhtyZxfRk8nyVtoS3b8NV1u57jAnL2A0oD4zpPMwFD
         LGag==
X-Forwarded-Encrypted: i=1; AJvYcCUKz3gj8cP0Amaco9rsOU0f7rzswsK8g9SWJ8vGj0B2kLpZx/tXMHwkK/txW5JuvvuawXVqBchNnhiPzovanKzW+nbrX/hlZm3CqJhsxXKTnEsBGroZ
X-Gm-Message-State: AOJu0Yz3iwCt8LtU5Y/Nt9nOG+oVv5gmijDScnLOkXtzug1MNtadrzAv
	sZ4IHo0KSXxPED4i35caGH5m+uhnT5L1IxPK9hClecoWkd/CX9tk+RkyUahPxldupo3fV1mzQy4
	5XwXnpoiMa/Rf0DViTGA59ZQfxhhp8KMOmmst
X-Google-Smtp-Source: AGHT+IHFh6fuPBDaALHcRGT86x6XUd5Gly/WjOFrrTl9D0oTiWSCEWhjSAxd+tkJ7qiDY205bvSs1K21OSV+FoXwzUQ=
X-Received: by 2002:a0d:c803:0:b0:610:cd34:439e with SMTP id
 00721157ae682-620862f530dmr6343667b3.49.1715109480658; Tue, 07 May 2024
 12:18:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503005850.466144-2-paul@paul-moore.com> <06dc0e21-f44b-48c0-8552-9840147facfc@schaufler-ca.com>
 <CAHC9VhQUW42aicyiMAVaSEsCR-G8E+uVZJVCXodDv8obC3V0VA@mail.gmail.com>
 <18c63d96-d574-4ce2-8fd3-7755d2da6c74@schaufler-ca.com> <CAHC9VhQcUrxxejcJP9m5SwyN8D=Y0rOiF7=w6SQR4=fF=nBNDw@mail.gmail.com>
 <CAHC9VhRdwgorXdBt7jUuQ7tLNbtCggGrbrhxw-Um7aCmk0JgmQ@mail.gmail.com>
In-Reply-To: <CAHC9VhRdwgorXdBt7jUuQ7tLNbtCggGrbrhxw-Um7aCmk0JgmQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 7 May 2024 15:17:49 -0400
Message-ID: <CAHC9VhQUi8vo+gZ0OXYXGSbLpuSaCaNx+7CzXw0eAJyQ48X80w@mail.gmail.com>
Subject: Re: [RFC PATCH] lsm: fixup the inode xattr capability handling
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Ondrej Mosnacek <omosnace@redhat.com>, Felix Fu <fuzhen5@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 4:51=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Fri, May 3, 2024 at 12:26=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > I also need to track down the appropriate commits for the 'Fixes:'
> > tag(s); I'm not entirely convinced that some of the other patches were
> > targeting the proper commit ...
>
> Looking at this again, I'm not sure we can easily narrow this down to
> one or two commits as the current flawed situation is really the
> result of a lot of things.  If I had to pick two may be the addition
> of the BPF LSM and the introduction of the LSM hook macros?  I think
> this patch may just get a stable tag without an explicit set of
> 'Fixes', which should be okay.

I merged this patch, with Casey's ACK and a stable tag, into
lsm/dev-staging.  Assuming no issues are uncovered during testing, or
mentioned on-list, I'll plan to merge this into lsm/dev after the
upcoming merge window closes; I'll send another note when that
happens.

--=20
paul-moore.com
