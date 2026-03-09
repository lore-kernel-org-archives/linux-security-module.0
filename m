Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044CF33D6DD
	for <linux-security-module@vger.kernel.org>; Mon,  9 Mar 2026 18:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773081173; cv=pass; b=Zo9zFGZlgWrzPgdcIAoepfajH3QIAz/RZMpLx+QfhaZRBhd2xUkin/p7F0hRwsy5NhUz7SNZ5z+9uQ7LyTXzqza3qPzcB+fwl02jqFxLxbycVXkQY3RQbvINy1QEGpatQyHTn5Egdra7w+YnZBZs72uZ/mwmPSCU1NX6Tzz/Kek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773081173; c=relaxed/simple;
	bh=5pfbX7IgfKNQp2WRG7sxyMmlo2J+X5YrF7BKB81kNxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EpPCw/dj3AfwuuRxEup4FMSxTFkTv1mBbdDnO2Y0m0HYGJqXLR7O6YCaC7LD60HeGpAWTuKb7fUrOt0P9xVQ4Re11o+BEDyE005y3lGQbNge9wFr7R/rhRAmZfFzzh5avqPpbWOaf1JezHwKjAsEv1/oH2nnQeVCPeIy+XEF+pI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=OKmBdzXM; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="OKmBdzXM"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ae4d919f9bso51870765ad.0
        for <linux-security-module@vger.kernel.org>; Mon, 09 Mar 2026 11:32:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773081171; cv=none;
        d=google.com; s=arc-20240605;
        b=G+gKT+vA/r0Sd0iSqSjSv85yHgU8Ahe9wZUqu1YUTHWNNFnEEnawRkmD8MgP7n3ohW
         2jPJE7Mcib5OeOFa3UdNXkwXJPc3g9Sl/gaKwtlk+hbclK33WZp1+D6HkF2yKfsDWXbQ
         Wxp4O3acuq4X4KUAvnqKWkdpRM8YL3YMMcoJfyo2jZWEYt06YD+ESzuQ1MACbS1r6xlS
         yJWJ767lXgUkFoeQMFavTWhVYQLE/2hIC0ykotqQJ5O8bymmPwoHpZk6wJnj0A1nTSrm
         TEV14XA8IkGuTFwWX7HaIi2PbjSVJYb/fN6hXS8i7Ox+Z6Gc3ik6N8Zmm9uEi1esWwNL
         FX2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5pfbX7IgfKNQp2WRG7sxyMmlo2J+X5YrF7BKB81kNxE=;
        fh=vD00dgu+cuAZ/FdS+IMaU4c3krlyG8tga6fiPR7X8sg=;
        b=DSzCOErNWO7xY8pSUGz8LBOVHYpJyre0y0aap6Itp/eKJWYT4MpVYA0+l1v3QWb/mn
         FUi1GrW+CIu5Quxx32ONSfpnOHtPQ0V9jlArvXq6Vxm9kuCJPi8kgsQqcc/tRi3rEvza
         ioyeqiN6C/oSfEZjpl7EAiqcj+OpPs0g4vVb7NdMNU6hkkveWFLLurVTuDj2sRTXCUCJ
         w5bIBWWwklgKSPt6s8x1/EYBMyZGlzyq3eCRUhFUWyIop7I03G6a+M3FORVDKstDMe7O
         AEVDJPm+0psBfneVX9gzptxjgoSL8BDt1dHZg2VkBKRuWAjp7yPuw+jkLCCAcn92lhl3
         bJHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1773081171; x=1773685971; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5pfbX7IgfKNQp2WRG7sxyMmlo2J+X5YrF7BKB81kNxE=;
        b=OKmBdzXMZs6SZgPLUjsPOaiO+XmfmTXOFzyKs1YgdM4mgLEF4F+FrC/D/erbDUCir+
         O4L16W2VSgn3XDXFaqnhZAcWQvxI1L3Sy5VnkTi4zVFx2eDN0GfuHDUq4qe8KwcKoJRC
         RObbgArgN6CuQ9LKBsw2x+GQ2mZH9HRMjMHiRYfp7vexmkytgvmMNvnaanWPssC4Ihei
         +LWD/aa6uLA15eFEqMJUKF9CLMsJPydHdahIGPWyq56vsbsXUzcx2EfIDYtCKyt2QD7P
         /aiF/DPKcisdax9mxmZ/iANKtESmGm9u7VjDopZxWaQM7gpsN1kYK2dheUeKb7A9JBLq
         /V0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773081171; x=1773685971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5pfbX7IgfKNQp2WRG7sxyMmlo2J+X5YrF7BKB81kNxE=;
        b=TMjUrubxxLlNvcmMUHjBMPWgzDb9TG0B69Bpl/a30sEPCqbYW3UU7XiMVSKaeBqH1j
         Fvo9ELcm8/LVyyYc6atH5M+gY/1HIiDlFBtWlEg+ENi58SPYBQszS59chBAnPFbPqjoq
         6PzmVmebZW4x3hQFJpFFEmAYtgksmOp1SDt1PoT8KV5SDPxT6eHtePHDatr3qs60Urmo
         zqDjkNU7oPpxNODi97Z+EefrcAF2Y+RXwC3vaI6/Qf3KyHze2UAQ/fUAJHO2XVBMRo82
         TtH2WCATIg4zyrBhZ7F3U5B424oEbbrGM23LVaROgXzGMeNLq9RhwddpSA/nuyuK6DuS
         8Bng==
X-Forwarded-Encrypted: i=1; AJvYcCUHROGweaR6bhdSq/1NBTBCbnAh0uSJIrHG44gcxBizpc0dndgJXEZWXdGK5Fyr5qo+KXuKh29qlIctv31ZgRHNih4Fljk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEwxxsI36sgZOrTZbqA6SMVukERW+sZFBMbdf6deJ8R22qOL40
	lt4dKOjCU4QpeI9L/VMax1wSOiy/RMhkr6irQpVptWrDXioe4o5sCBHwB3lRDhBSnvz2QIdrmYt
	ijaOPf1mT0yRgu3zKFdzhzYDnQ0GpRf3EJ5BizJAy
X-Gm-Gg: ATEYQzyoYyj1FVgrsV51ZM1FBG3soNAuIzeyOEqxcdDErVcmclIJIjgeF/XIfRPfpoe
	QCCksD2rHedEQ7ZrkqBM7KDbnG5zvxVDsRot4Q/LbQHa6Oeyx02xbohZHpv32EV/yt5sLfs9ROy
	e25ss/f8yeux9m8BzeXWojxbZbUA4TmaKmgdS7bg2D2TvqKB46N8xcANz16/zQFNfl4PEHKMDn/
	GIVfRLgxC7SIhOFd2th8GHKtoWqIEo5yJ0fBZ65fIciEUSpeteXtaj0yuAovyx33HDTJBVcvfRV
	NZ7Tjm0=
X-Received: by 2002:a17:903:1988:b0:2ae:5ec4:2f78 with SMTP id
 d9443c01a7336-2ae8242cf9emr130948555ad.33.1773081171206; Mon, 09 Mar 2026
 11:32:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309-fw-lsm-hook-v1-0-4a6422e63725@nvidia.com>
In-Reply-To: <20260309-fw-lsm-hook-v1-0-4a6422e63725@nvidia.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 9 Mar 2026 14:32:39 -0400
X-Gm-Features: AaiRm51Nyf3eubsZF_AS8QuxcFS2-w70i5MYcT-OKhQqne3jHp6zEq8Kbc0-IAo
Message-ID: <CAHC9VhTR9CsBgxRCAHXm5T2NZ5tr+XfmA--zkt=udmk9hPRuZQ@mail.gmail.com>
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

On Mon, Mar 9, 2026 at 7:15=E2=80=AFAM Leon Romanovsky <leon@kernel.org> wr=
ote:
>
> From Chiara:
>
> This patch set introduces a new LSM hook to validate firmware commands
> triggered by userspace before they are submitted to the device. The hook
> runs after the command buffer is constructed, right before it is sent
> to firmware.
>
> The goal is to allow a security module to allow or deny a given command
> before it is submitted to firmware. BPF LSM can attach to this hook
> to implement such policies. This allows fine-grained policies for differe=
nt
> firmware commands.
>
> In this series, the new hook is called from RDMA uverbs and from the fwct=
l
> subsystem. Both the uverbs and fwctl interfaces use ioctl, so an obvious
> candidate would seem to be the file_ioctl hook. However, the userspace
> attributes used to build the firmware command buffer are copied from
> userspace (copy_from_user()) deep in the driver, depending on various
> conditions. As a result, file_ioctl does not have the information require=
d
> to make a policy decision.
>
> This newly introduced hook provides the command buffer together with rele=
vant
> metadata (device, command class, and a class-specific device identifier),=
 so
> security modules can distinguish between different command classes and de=
vices.
>
> The hook can be used by other drivers that submit firmware commands via a=
 command
> buffer.

Hi Leon,

At the link below, you'll find guidance on submitting new LSM hooks.
Please take a look and let me know if you have any questions.

https://github.com/LinuxSecurityModule/kernel/blob/main/README.md#new-lsm-h=
ooks

(If you lose the link, or simply for future reference, you can find it
in the "SECURITY SUBSYSTEM" MAINTAINERS entry.)

--=20
paul-moore.com
