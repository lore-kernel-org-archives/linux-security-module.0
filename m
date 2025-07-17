Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76582BEC28
	for <linux-security-module@vger.kernel.org>; Thu, 17 Jul 2025 18:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752776538; cv=none; b=Jumi9X108zEveYwPUbPEPW/uycei9nv6a8mFa0VPDAdOdC5dNR04JSa/HAPDGUuSRAtTXk2vo8BN8/QyTOuuV7WUMo62SmePs3cCFyf/1ujvcDbS/cw2pMgebSWUCGG8glxjlQDVPfyfEphW0miELAxrkSVISGPjb7LyrOnIYMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752776538; c=relaxed/simple;
	bh=G3jL+wG+8NOo0C9q/J7PTimEdtDkh4rD9YQDFto56U4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gJIbPrLFePZViPLcOe+GisCUm68kwCqX9+vKQF0yXsMejscvuTWDtmLqcztoS1mmMl9S4l/NC7jWJCiUcviAhQdnKZz2KXQd3xL3PEJsHDQXh+8MnfDTPdByTc8s4koVXX/YU3YTrLp10neYVwj+OeOyHrkKaoERxNoGy3NUhU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=N21Wm9PT; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="N21Wm9PT"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e8bcbe46cf1so1284575276.2
        for <linux-security-module@vger.kernel.org>; Thu, 17 Jul 2025 11:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1752776536; x=1753381336; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dj/cZu4K955u3WxbJO5Yyn51Gj07gNitENbpCqXBrlg=;
        b=N21Wm9PT616dOulvzkGsVasCVbVeqicWkekZa2o7Jwi6tNsB9ScbQOk2uCWrJ4BSgQ
         byQZpN5CcZQqZCfF6dv1uY3Y10LswZOOjDIh7iNF585cz8MaPb+VK4T1ZxOpP5MeBpdF
         gE8tnyZnY+O1DwXMOndAnND4Sam1fGlvwXn9rMcnKlOuJocT7ZCh9vFGp7nirLEIMhLx
         iHSpY8YCtdmbAOVhEznjsbwFgHt3ukCVD1+uCud1upaeTJhzmYtfasW7Foewh5npChNE
         mUiIpQEOfvtHtLkXVJ/bLu0e4cgf382HGv00YzcVAm7HMwyOG8NZRa3Oi/lH1JQby+0S
         y7aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752776536; x=1753381336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dj/cZu4K955u3WxbJO5Yyn51Gj07gNitENbpCqXBrlg=;
        b=aeGhCKkE80bhTeb7Eql/FLaSeLHqnAvVFvZkV5DRD0kzDAW+Dfoo9I9/fX8qRhpBOs
         XEmZmStvmtWT1NYWH99Ruhc78zBjqITeKG9/INyS8PsWCCo8vJmnvA84F9YQ/KJGYlo5
         vXm5lMa9ykogsGexO7I8VK8t9FuCU0ZnjTVOY6CT+AFrw4zIypbGORjMJWbCWHdMNzC4
         xGr/yL/eJTsRLh+Ff9xK5dQgLnbEmqFyCKcvweQk6Kd8yATyl3mRW0Xthmtef6aEp+0C
         f3ND5l34ENuC1F69zmrKem8JKmrdD7V16H2bj4fzyLRIinTdA7yTQrBgsKgEdl14lPWC
         t0jw==
X-Forwarded-Encrypted: i=1; AJvYcCWazajqsptDCv304h2NzjsmDhu63zCRNS6SaIlTJSfY1KV2GZekc3X0CQUsSIriyOe9rGdair8pCkyEDcG0y+PMwhcIL+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOxiZH4EE67emZMxA8d1f+wqZruZ9oG0Tb9eSX5Cq2MhcDpmsX
	fuGSQDcIcZHwKFnpbsdqkkt7S9AO8Twkx9cze9JOWo2iNR6hoJ/E4e4bSYo3GmJtuGogpgs4Sfr
	xhpt9j8VvzYAqIVYHuxVbP3tNwUuP0LVDtugM732UZkOgI2FlLcAIGA==
X-Gm-Gg: ASbGnctVso1w0o7yq/1ucxieSuPM5gsH6+flnctZkIGuvQ0bpQ+yc95y/L86jQ7mYDT
	EjIHZu5pr/ghYhK+8bJf/OWSZ9Ga85J2zCd4f00Ll7WDVJlBXyISLGAqkEdNb06J6pn+cyA12G4
	u37l8vkwMkMhm3iP6r7vsTXySyyD3OMUNCTfXVqqJrHX2RnXluvwRQG9+WbZnfu0ET81mXJzdRh
	IR+eiYgh2SA7PZScw==
X-Google-Smtp-Source: AGHT+IFl6UDPpr/oWWaFnlHMWZyVT1LMOLcL/IIjAuyhHi/01vC0aMu35s2078tcgwodJEbgmu0BPGrHYuDoxJtxfp0=
X-Received: by 2002:a05:6902:248d:b0:e82:1f55:effd with SMTP id
 3f1490d57ef6-e8bc269ebadmr9165657276.5.1752776535732; Thu, 17 Jul 2025
 11:22:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1750975839-32463-1-git-send-email-hamzamahfooz@linux.microsoft.com>
 <20250716212925.GA14322@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To: <20250716212925.GA14322@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 17 Jul 2025 14:22:04 -0400
X-Gm-Features: Ac12FXxe4T_hN6jEbI53FNZzZFqap9jNRjhELwIEMsW3hFfT4g6e4hyRn79zWz0
Message-ID: <CAHC9VhS3qY=+DVYqzkgbHLETUo4KgQ17qr_BC3pn9TeG+cr8Mg@mail.gmail.com>
Subject: Re: [PATCH 0/2] Secure Boot lock down
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Xiu Jianfeng <xiujianfeng@huawei.com>
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Yue Haibing <yuehaibing@huawei.com>, Tanya Agarwal <tanyaagarwal25699@gmail.com>, 
	Kees Cook <kees@kernel.org>, linux-efi@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 5:29=E2=80=AFPM Hamza Mahfooz
<hamzamahfooz@linux.microsoft.com> wrote:
>
> Ping?

Adding the new Lockdown maintainers to the To/CC line for review in
case they missed it earlier.  For reference, the patchset can be found
at the lore link below:

https://lore.kernel.org/linux-security-module/1750975839-32463-1-git-send-e=
mail-hamzamahfooz@linux.microsoft.com/

> On Thu, Jun 26, 2025 at 03:10:37PM -0700, Hamza Mahfooz wrote:
> > All major distros have had carried a version of this patch-set
> > out of tree for sometime now, but with a bunch of magic (typically
> > sprinkled in setup_arch()). Though we can avoid those architecture
> > specific quirks if we call efi_get_secureboot_mode() from
> > efisubsys_init() and that allows us to have a generic solution.
> >
> > Hamza Mahfooz (2):
> >   security: introduce security_lock_kernel_down()
> >   efi: introduce EFI_KERNEL_LOCK_DOWN_IN_SECURE_BOOT
> >
> >  drivers/firmware/efi/Kconfig  | 10 ++++++++++
> >  drivers/firmware/efi/efi.c    |  9 +++++++++
> >  include/linux/lsm_hook_defs.h |  1 +
> >  include/linux/security.h      |  8 ++++++++
> >  security/lockdown/lockdown.c  |  1 +
> >  security/security.c           | 15 +++++++++++++++
> >  6 files changed, 44 insertions(+)

--=20
paul-moore.com
