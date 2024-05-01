Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82A9748D
	for <linux-security-module@vger.kernel.org>; Wed,  1 May 2024 17:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714586237; cv=none; b=NQKCn2DWln1Pz/t+yhLxf1JCsXIvwOoIBLD0MFAdxSzC5XvsWPo5lIQqeFMYLwdgwH63cJDdqIOaNcrbuWr1kReKqlT+35b1rnTeoykdDgWwkHTvQ+f91vBbQT6Tld6usgmc2sZtn11oZhrIHvGnWPJW78V0fG9wq1qVDTpS+cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714586237; c=relaxed/simple;
	bh=GJ3wnLrdW1PPsQa2n6bMRg0TH4dYEyNGYzugogJTMpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=HgQwSYAnqldxMeBaU9O8ylh57t3TbrpPDKOeAFLfBeKHwZ78BIEOPMtQNCQE80F3+m3SNSFdPaXclAvV1m1H4PIcswjYKkfxSt4q8doUhR0sn4tivn65xqIWg+c8ALlpavx20K0tbe+kAq9+gAbKB5r5r4zBc3ifRa2uKu+wHHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=I8Z07CpA; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="I8Z07CpA"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-61b92a83216so80455677b3.2
        for <linux-security-module@vger.kernel.org>; Wed, 01 May 2024 10:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1714586234; x=1715191034; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ayrzPULUNcYQbUaZ9Uy7uz1oK8GZadM3WPqUA5kKMXQ=;
        b=I8Z07CpAgS9z+saAc5fKDrFhw87AKd/mM3U66HhkOGjBhu2ZBk+mwUI+3x+nj6eTMW
         vU1saYAuGklR3RvlQo6UHVc3+ByfwwCyemARj8zPEhfthztxyMr1HJVubgHXBvaRskwT
         UPDlZSROO683XhTs5atqaKp049/0qiGJ3+lQd4kljOWzY0R08JBCePmsSuGydkJnrdAE
         5S7T2IR/txH8dS7KxZ48Ye+ABL6agWzHQbfdl6x0dUyff4R7FCgve1ozzup8F5iezROR
         NkkPSnEMgAS+21oAUnw62tztW7ZiYHZNfCoOeNoWEWCTKYMhdqlDMGKDe+w02cm+81zL
         Xtqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714586234; x=1715191034;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ayrzPULUNcYQbUaZ9Uy7uz1oK8GZadM3WPqUA5kKMXQ=;
        b=s09HJcfLEj7QMNhRnYXTlD7vnoWiFU+dJuq8m8JwiNZEc/ZPgiSVAcUYmU5u2Iwt6g
         T5kaNWReZlILkMUAi5giUWGLLWrNE6/+t1K7UGMk9GAuFsgoGW9fa/y0FfIe9pkRGgVC
         PIqrSOjS/M6Q7mcy60ynUVknUgmAi9vAFQRlMOS7VusZMj8FvwTyjXR3n4ILXBm2R9Et
         EQuy97HKR34QkPABoZbD+c8/EyCqawoScaBuTaTmEIi3phK6TaXdUBQdr3MIAOlnwtzg
         U+Lq2Pl9J6r9FIbbSUcvhQmy9k4cgAF+hATk6zT3TXirMFPLTTmbFMrLLDiq/93O5Y4d
         ZP4A==
X-Gm-Message-State: AOJu0YyYfolP+o9tRMh+BGKsg+YxExOjG9jutjJXL2rUXbaT7iqHAb5w
	6KKQOxZep8ZMaiQL9UxwzSXJPYQiwcatUeykzK1t+nwQ5TQz2JJp1/zTUFSNHo13CBzx8PumHWy
	gaRXWC28ezI9QefCQskKs9Ty8bawOFsrKlLToazvnYp7X+yI=
X-Google-Smtp-Source: AGHT+IFy+rjHbzSm8+fTOVxoDC6dk9IIh9wp7D7nIvnzonYw3UbZPvc8C5W+i4XjnZnu5TMHma/lIA0b4jflpqqaFJg=
X-Received: by 2002:a05:690c:6184:b0:618:95a3:70b9 with SMTP id
 hj4-20020a05690c618400b0061895a370b9mr3268265ywb.36.1714586234503; Wed, 01
 May 2024 10:57:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240501160725.12027-2-paul@paul-moore.com>
In-Reply-To: <20240501160725.12027-2-paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 1 May 2024 13:57:03 -0400
Message-ID: <CAHC9VhSvU_B+nQBBWC556=uvLUGUHTu9nXFzZiE4jxJvfd6Vow@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: update the LSM file list
To: linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 1, 2024 at 12:07=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> The LSM entry was missing a number of files under include/.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  MAINTAINERS | 3 +++
>  1 file changed, 3 insertions(+)

Merged into lsm/dev.

--=20
paul-moore.com
