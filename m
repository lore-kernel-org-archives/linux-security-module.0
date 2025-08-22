Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8A9286D53
	for <linux-security-module@vger.kernel.org>; Fri, 22 Aug 2025 20:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755894995; cv=none; b=gU535tngNn9pJmNfPntgi+L3T6m/EWfeAI9Jo6iWW/VsEWUDRKVq1Z5TmSpMBxDf7FWr4NkSbx84rc5TZYFTP6WLBBVbsWNToUQHX9QRSDWf+lfiCvTFX7r4VFV0k3eGyyF23DFZebrWUCxWalNR7jkZkFGE4CfglO6bauZ10GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755894995; c=relaxed/simple;
	bh=h0ZVMZe1qO46b0+FRFlstU+V/qioRFVqZx3CIYXUOPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=pP8naEn70+PNTzpDWnFJ0E/ewcmxoJNv3wxjoEv72ECmBQON+L7E+4EP6QzV5SjdjUX5EZqXDjP37pzRs7D3RmOxQO7KRafz9osOaHL1bP9gK8+srejzfHqwe7ZgA6IHpNFGc8QAPwyxs9KNdSHL96M4lkJfOTNkPiLr4iWHkmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=OfWO4JVW; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="OfWO4JVW"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-324eb9cc40aso1893832a91.0
        for <linux-security-module@vger.kernel.org>; Fri, 22 Aug 2025 13:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755894991; x=1756499791; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AvHw748wFarUnnLh1kaFyb8NXkrU7YbIjRL/JuKz/Uc=;
        b=OfWO4JVW4zugkqL5Ov7dunLjbCl4tRty+l7xervziv7M0wNKtyCmkn7X2RT7ew7m2S
         edj9DD7RzevVB1Q60Ym/JafepMpJgyhV2x2zZtOnGh4SHvdacKHJc0MW7XPsNVVHpNLt
         CD8s0E3nS1w+IzD8vxS+au/uB1Mk/Ppo0rtky3syr1cASJeUjCfYikrmg6P461F8AhVE
         s4zrW2U6+c4RJCw/y/A+toPN6t+4lsQb++TNbxy+GUmhpK3SWyVsjB8Z664qkYQXGxxS
         qMu8uu8LA/guPO9o+wlu8aOJjb9ySuoaegKZhxG7ZaUcEvIZHFbClvdgHF+HWW0UNoRq
         sYpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755894991; x=1756499791;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AvHw748wFarUnnLh1kaFyb8NXkrU7YbIjRL/JuKz/Uc=;
        b=sXtu94NtVCoQKVkvogor1+InUwVPiUIP6ZjbdkcJFt6f8Pc5aZ4G2BJWqvGv5v1Tnx
         tpPJBFZ7fvDKR9JIsJP7sLTmh5Nzp2nJOFtriYgZ8aYKYmEsB/Fi9jKbjMvSdftX7qPH
         kMkEugkdjZednpcGJYnUUl0X5jGLlDm4xI66N7o1SQ0dehpLRUxcodfXg6XgU8/UE6Tk
         ks5hu9xzbGrkwgRwfj2ZiQNVHsyKFw8oE5T5QhIw/Cr33QevZi6NJ3wwc8FYsRnt3Pe/
         DMH1dKeWuKmh7wO/7GB+HzCsH4j9f6C4V/F2v02SCOrdfSyB9VOzKULKzApja7xZeLpI
         NsQA==
X-Gm-Message-State: AOJu0Yxd2yeslzvJBG6c56/gFqmKfdtkyRvM+O71HZGeDBnxCVGTBlBf
	zCOTnVkhC8C5ZCKUmm6H6M9vnqDy3jmQopL7SAdW3JUEKjb5RLVuTDDl+k96MQASBHsoPnJ5yAB
	WFO5Cjzligi79MVRxBQBrmmPqXJNelFoWdxDD1fZPNsF6N4y7T80=
X-Gm-Gg: ASbGncuF4jMSA9d1DOIJWAG2vbXf1HgvH5Gp+I9k6pqvtcRaV28o1pBd+iAczIZVeMD
	zqAGJJLozAM0+jI303RPAiR2868EEzEy7EENbYT6oYuPvtOrbToJtgBYwmqvaGq7OfzypfBwLpn
	VKvMfyR6p/J9nKpgATCyfP8tq0B3Umo/py2m5ssr1muu0GZmppLczSgaATm98L6n3p7lWk6fcER
	sXyIIA=
X-Google-Smtp-Source: AGHT+IEqdBTzIkxBsonzdubPzHUzLXF7csUGeyV5HR0TeNq0f3fCP8vPVePD1TR5jsfM5sbVh7ZV9EIwuLcedE43JGo=
X-Received: by 2002:a17:90b:384c:b0:31f:14b:f397 with SMTP id
 98e67ed59e1d1-3251d474294mr5612988a91.1.1755894991286; Fri, 22 Aug 2025
 13:36:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819195841.238246-2-paul@paul-moore.com>
In-Reply-To: <20250819195841.238246-2-paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 22 Aug 2025 16:36:20 -0400
X-Gm-Features: Ac12FXzuEipZKRQOHBk7GlYyH24kilSe3Hwh09kdTIJPq6O-im9uQzHLj3FUMKM
Message-ID: <CAHC9VhTv0gwaY7CRRzLi68DdqrEXiMSOpAUo5yx1XXad81OwrQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add the associated Rust helper to the
 CREDENTIALS section
To: linux-security-module@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 3:58=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)

Merged into lsm/dev.

> diff --git a/MAINTAINERS b/MAINTAINERS
> index d61f7246e5bf..0ee0098f2df8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6484,6 +6484,7 @@ S:        Supported
>  T:     git https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.g=
it
>  F:     include/linux/cred.h
>  F:     kernel/cred.c
> +F:     rust/kernel/cred.rs
>  F:     Documentation/security/credentials.rst
>
>  INTEL CRPS COMMON REDUNDANT PSU DRIVER
> --
> 2.50.1

--=20
paul-moore.com
