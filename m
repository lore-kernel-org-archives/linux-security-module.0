Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44E3748F
	for <linux-security-module@vger.kernel.org>; Thu,  4 Jul 2024 09:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720084359; cv=none; b=s2KBNfE5eZMN12VbD2CPDfBafRudR62L/epym3ON1luDI5QDB9zovifr24OJzDR0fH2v2/HmkMomnmQbuHdzB9ZPMKAq6Te/5qQWASDqvN5jfjaLpuu0yHUZAAu/50pK8s/I6Dz/UNKcY5KfHzypsn8b8YQUOvWaxqf4Tas2Lt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720084359; c=relaxed/simple;
	bh=4Zy3A/R03Ea9KVeiTELXbEtMjlgFd5QKpAtjvYV8Ihs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LPIIiCT7ETt1i2paeO+hHdtlr+OGYhOWFJ27uc+PKoLZ6FWRU1PI8p3B+zPgeHOhGyVzuG4m7TFe6nAj/HPTe+q/MLFDMNXRrl+b5Tsd2mEMiWxZZ+DT1AtWhZWU3pmdOHrIkiNkzsZxA5w0EncLXXNhoEWvgwwx3FEgo/RoX/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GoRZSkbc; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GoRZSkbc"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e036d1ce4f7so328038276.0
        for <linux-security-module@vger.kernel.org>; Thu, 04 Jul 2024 02:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720084357; x=1720689157; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cViqdyaOCwn+ROKlv4dtSt/nqrwCEFM0XP/6otHc2rI=;
        b=GoRZSkbcFxFvrio4Y5zb/mXr304EaQTb6Wai3j7SOIeaINL0J6mp0J6HzS7pky0mJJ
         Og4Z1xN7z6h+hZCLWaJj/EuASvDpZU/Zu9vpzI36PiLtwgyZo32Y8fmHn5/K+SBOK1GN
         QRMJbPXlPo/9uwZq4nlY8M9J8fPEeYVNkX5hK4hvnhXIdTSPu38bXT5fdlSdtkezhPF8
         B4ZBhwOgB96G49TDCBfkoGEqgCwTd0vMy/ER6w6AxIBUZQ6g3XxJkO8GWy13oLmVxlav
         q+JXCTiedOwh0O15ZMDuCB8/VyNsgpExIn2b22YTxw8f4n84yR+QVDcGlw6SWXE2YOoj
         WDnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720084357; x=1720689157;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cViqdyaOCwn+ROKlv4dtSt/nqrwCEFM0XP/6otHc2rI=;
        b=YQ2Y6WAkqiXswjnssEeYqM5o8JUK9dBbWoJ1c1BBYoTmGdc3Z9kSX8ZvqYTjOL3vtN
         8Rjy1up6fSZpnp6qIC1f80reec91tQOSqW1zZBJuSJJZ0+wSk76Hs5V/rFNkNiVX0Xbd
         v9zN2CTxUwSMnGJ5UmKGha6VBhvNPLkmJFUhzUhSNBXQ7QmPaswwah/A13KyxkiFV81W
         krlqeQSEAobaokSK6ADscq7oizbWJZ3jHS5+uCZNvooaUCAvCfqelG1wPMyoJMxKbley
         bzbduE0qUkzCreYOMqwzySl+CMzjFq5MPjhqVg04GDZSuiEeaLtDuBNNBKjo/ogTMmP9
         U3mA==
X-Forwarded-Encrypted: i=1; AJvYcCWhu98dGIVY19UsaRuTtV71JHmzvBPuJAjVwwsdOgYF9Qb8dVS5wopGJUs/5SE7S0tOB1S7ncEYS72TAaAnQxCgY6rpOeb+V3vMQOSiWIIs6Iz2e1eB
X-Gm-Message-State: AOJu0YxS7Ljr6E8xlQoFoMODmB7kByzCWNjH24H5c5CJ7EoVMQNDv1ZZ
	5TqV5S6Ln2D9PR8duCGo7Ui9IqtPaUZ5MwJt3Tc4fIBaKR8Ny8o6RJOzQgI/d1SsHpoF3w9k0Ha
	dI1U+MCUoqmuZTEJc6k468b1vxOMk64Q1
X-Google-Smtp-Source: AGHT+IGK9cO/Y3Kx7AjnAWYe8aljVXMGzquzBsbgTcYH0VQHl/lZ4BXdt1YQTy3egddkXiJCHNq1qxeGr6bUrWVKjfk=
X-Received: by 2002:a5b:b05:0:b0:e03:61d1:2b88 with SMTP id
 3f1490d57ef6-e03c2a17390mr488544276.15.1720084356615; Thu, 04 Jul 2024
 02:12:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617220037.594792-1-luca.boccassi@gmail.com>
In-Reply-To: <20240617220037.594792-1-luca.boccassi@gmail.com>
From: Luca Boccassi <luca.boccassi@gmail.com>
Date: Thu, 4 Jul 2024 10:12:25 +0100
Message-ID: <CAMw=ZnR9Eqw1Q6CnQhitBKHDGduQStVK7BfSPj-54xJjgSMqcw@mail.gmail.com>
Subject: Re: [PATCH] dm verity: add support for signature verification with
 platform keyring
To: dm-devel@lists.linux.dev, linux-security-module@vger.kernel.org
Cc: snitzer@kernel.org, jmorris@namei.org, paul@paul-moore.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 17 Jun 2024 at 23:00, <luca.boccassi@gmail.com> wrote:
>
> From: Luca Boccassi <bluca@debian.org>
>
> Add a new configuration CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG_PLATFORM_KEYRING
> that enables verifying dm-verity signatures using the platform keyring,
> which is populated using the UEFI DB certificates. This is useful for
> self-enrolled systems that do not use MOK, as the secondary keyring which
> is already used for verification, if the relevant kconfig is enabled, is
> linked to the machine keyring, which gets its certificates loaded from MOK.
> On datacenter/virtual/cloud deployments it is more common to deploy one's
> own certificate chain directly in DB on first boot in unattended mode,
> rather than relying on MOK, as the latter typically requires interactive
> authentication to enroll, and is more suited for personal machines.
>
> Default to the same value as DM_VERITY_VERIFY_ROOTHASH_SIG_SECONDARY_KEYRING
> if not otherwise specified, as it is likely that if one wants to use
> MOK certificates to verify dm-verity volumes, DB certificates are
> going to be used too. Keys in DB are allowed to load a full kernel
> already anyway, so they are already highly privileged.
>
> Signed-off-by: Luca Boccassi <bluca@debian.org>
> ---
>  drivers/md/Kconfig                | 10 ++++++++++
>  drivers/md/dm-verity-verify-sig.c |  7 +++++++
>  2 files changed, 17 insertions(+)
>
> diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
> index 35b1080752cd..1e9db8e4acdf 100644
> --- a/drivers/md/Kconfig
> +++ b/drivers/md/Kconfig
> @@ -540,6 +540,16 @@ config DM_VERITY_VERIFY_ROOTHASH_SIG_SECONDARY_KEYRING
>
>           If unsure, say N.
>
> +config DM_VERITY_VERIFY_ROOTHASH_SIG_PLATFORM_KEYRING
> +       bool "Verity data device root hash signature verification with platform keyring"
> +       default DM_VERITY_VERIFY_ROOTHASH_SIG_SECONDARY_KEYRING
> +       depends on DM_VERITY_VERIFY_ROOTHASH_SIG
> +       depends on INTEGRITY_PLATFORM_KEYRING
> +       help
> +         Rely also on the platform keyring to verify dm-verity signatures.
> +
> +         If unsure, say N.
> +
>  config DM_VERITY_FEC
>         bool "Verity forward error correction support"
>         depends on DM_VERITY
> diff --git a/drivers/md/dm-verity-verify-sig.c b/drivers/md/dm-verity-verify-sig.c
> index 4836508ea50c..d351d7d39c60 100644
> --- a/drivers/md/dm-verity-verify-sig.c
> +++ b/drivers/md/dm-verity-verify-sig.c
> @@ -126,6 +126,13 @@ int verity_verify_root_hash(const void *root_hash, size_t root_hash_len,
>                                 NULL,
>  #endif
>                                 VERIFYING_UNSPECIFIED_SIGNATURE, NULL, NULL);
> +#ifdef CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG_PLATFORM_KEYRING
> +       if (ret == -ENOKEY)
> +               ret = verify_pkcs7_signature(root_hash, root_hash_len, sig_data,
> +                                       sig_len,
> +                                       VERIFY_USE_PLATFORM_KEYRING,
> +                                       VERIFYING_UNSPECIFIED_SIGNATURE, NULL, NULL);
> +#endif
>
>         return ret;
>  }

Gentle ping. Anything I can do to help move this patch forward? It
fixes a gap in our dm-verity story that I'd really like to see sorted
for the next release. We will use this in systemd, among other things.
Thanks!
