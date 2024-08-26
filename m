Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D15E18D639
	for <linux-security-module@vger.kernel.org>; Mon, 26 Aug 2024 23:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724713584; cv=none; b=qeTVeIqA2HvBSnlr/DVQYpEbn3uGKL+Dv1rhw3ya/vatartQ0g+g9Hu30UdfQ0o+ly4xtpDZ5UJ1+K4SFEBqRWlzDHRk+5/V47sW0P1IjyQ0fe2QLmN8Qq0OOIAowNL4Vhee67T/XA/TBSCbd0CoJzPGcTfpENEOsBoakvHmfYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724713584; c=relaxed/simple;
	bh=d9S85ohx5ny7nNbg6X+5K7Z0juMf0UlifZjOOeXbTCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ECkJpg73rLfdzxS+bl5RBrWTqKvmqyJomwCjW4LsCnl/2DOsUds9IZvQ/9HPA49/3lkwWbVgBnUL+oHpera6gkWP1HWgQ0roUkpNZDoVjmfbAtiMF/C8xptyDlonjrTZhcH5IhOVUbkcbpBVL1509A0z0fNe3Bbq+Quufi/z7WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=G+Q6I8h+; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="G+Q6I8h+"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6c0e22218d0so51418387b3.0
        for <linux-security-module@vger.kernel.org>; Mon, 26 Aug 2024 16:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1724713582; x=1725318382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hh2ar4uglkkgeuPUdjdGtFExJoVMowRYF4n6qQO8I+w=;
        b=G+Q6I8h+0xIaONtq+/XitE0zXBdj0lOpBcPg+6LU/n7j3bLve79P59TlhsiqvuG9uF
         qebDMAeOmzTqk+G5zVrCehAodUKQTLd0s4P5llIwIE+LUNvgsZKbxPSgIk/nHwbNo89e
         41blJzopZOB4t596el5abfDSxKH/7AzOHdX9+5ANhrde2wFnt7o2Wa7tnUwYKuOOWGeR
         tKJdIdngUHPNCA/8kVd2dQpUYfEW1SEMY0NYdMXF4/wXQOKf+c8T1t7JvgKtQRwa5MaP
         G+yJiaqmSQODzGmlh4yHLmaEPfXoNwUzPeRDx1mr9yzYaUuVqiIEiXiNHtKKLhYw99i0
         8moA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724713582; x=1725318382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hh2ar4uglkkgeuPUdjdGtFExJoVMowRYF4n6qQO8I+w=;
        b=bzdI3duEkT1km1FweBeqEInE5rI3uQTctt5L62WfqkdPOduWAZA4pr7PhlZBz0m1dt
         /xLfqcnfSvjFoWF4hotwfgnZ87n5dhoB5E9/hGFTpSGjgC7JqcQso7cQCXRcVmwQIGQ1
         LK43sDaPB8B6/LCrC0rqAPAOUpHq1Pd6aYKvgQgRS7FSNMlVS/8ESJrsZbnwqS3llDl0
         SqF6avsZ5z1MrYPuUW3RwAR1LLu2vtQ7LOy9GHxTWmZV5Z9uILrNJL6o4fLxwANxF3NB
         LmZsvB3AdHDak6LUhKjTzFshODWS73S/B7bWk1dgY0wQQDWSrlMn01YBZkIVY5WSX5hh
         ATKw==
X-Gm-Message-State: AOJu0YwEeJCh0NqAUoN+hrv0iT1TqJczyUbfH3EFKw6WGOOxqM5toUK7
	uSsr/FxrJ6Ua23DcPGiwepAVkskO8qKLiySQJ1DCbDbjCpCOARE+E071HuG0ZYCh3LdpB7Oq4f7
	4lXhGZV3uhneTdEZegeNbRcsuC1ft647OwCArbHaQGQLq6bM=
X-Google-Smtp-Source: AGHT+IE+9WBxOgFl716axCN+GtBTbN9VDOPPWQkdIf0hRHuTi7qjDhQqO2xNAJ8xCfTePNjpe5UgEmPQFkL4EsWFZoE=
X-Received: by 2002:a05:690c:380b:b0:6c1:2b6d:1964 with SMTP id
 00721157ae682-6c62906557cmr140540627b3.38.1724713582022; Mon, 26 Aug 2024
 16:06:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <678aa43f-28b6-410d-8890-b8d4e3261807@I-love.SAKURA.ne.jp>
In-Reply-To: <678aa43f-28b6-410d-8890-b8d4e3261807@I-love.SAKURA.ne.jp>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 26 Aug 2024 19:06:11 -0400
Message-ID: <CAHC9VhQsRzHaWUrfA6dsYNpxWQ5JpKvFcUmefJktqxJEFeWbxg@mail.gmail.com>
Subject: Re: [RFC PATCH] lsm: make SECURITY_PATH always enabled
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 25, 2024 at 8:50=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> Only TOMOYO needed CONFIG_SECURITY_PATH when it was introduced. But now,
> AppArmor, EVM, IMA and LandLock also need it. And kernels are likely buil=
t
> with at least one of these enabled if CONFIG_SECURITY is enabled. Let's
> simplify the dependency.
>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  arch/mips/configs/loongson2k_defconfig |  1 -
>  arch/mips/configs/loongson3_defconfig  |  1 -
>  include/linux/lsm_hook_defs.h          |  2 -
>  include/linux/security.h               | 70 --------------------------
>  kernel/bpf/bpf_lsm.c                   |  2 -
>  kernel/trace/bpf_trace.c               |  2 -
>  security/Kconfig                       |  9 ----
>  security/apparmor/Kconfig              |  1 -
>  security/integrity/evm/Kconfig         |  1 -
>  security/integrity/ima/Kconfig         |  1 -
>  security/landlock/Kconfig              |  1 -
>  security/security.c                    |  2 -
>  security/tomoyo/Kconfig                |  1 -
>  13 files changed, 94 deletions(-)

If a Kconfig option is only needed by a subset of LSMs, which is the
case for CONFIG_SECURITY_PATH, it should remain a build-time option.

--=20
paul-moore.com
