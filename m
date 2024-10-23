Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4403E1CBE8C
	for <linux-security-module@vger.kernel.org>; Wed, 23 Oct 2024 14:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729694365; cv=none; b=Lpxo+Vzj4dWz8Mmx6x3hMNN0cAKyKeXPpUUZKwg6TY/ovNrXesi1lx2cPxlejqdhm7BNS4fUI3ocvytWp1IEPGT9JYlnJK7jj+uCw2WKmLyJiO3+tZQDsnz+0nQGvfCZ9tXsbKdHwz0r8TlZPTkj8lfiH+tPuyq9BZHqnZ+CN00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729694365; c=relaxed/simple;
	bh=odby0jjqoFFOhNqsHsqZcbKiEYm2n7Gl+WYrvBNHbTA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=AZ+1tPIoFk5mLpR2o8LmnmodiFZHh5DYe1tlHcn9RjxwPPvL2ZerXr9k4VhJBsZCfWIk3OayFlpGf0OymaOwM9Zpl63h5ieHvt+TUqoAmR1Wgz4XMZAd0oqCsSoi8umkpDdCoUk87XbtQlKh/xqDyUp35N1698xAwoS7fBuj45Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lYnoa+u5; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lYnoa+u5"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-50d55d86f95so2113952e0c.1
        for <linux-security-module@vger.kernel.org>; Wed, 23 Oct 2024 07:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729694363; x=1730299163; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WhPKDbFTUZYFFVIAP/OH1JPHMZdUigC397OHZv1u/EA=;
        b=lYnoa+u5Lmqi5lsIbXLnM5yL6d+4Sm+jl8VQ/2a6esAdI8uIOw+cjvGUJfEkehwWY5
         2Z4qgPxJ1lGd+TKg4LLPnO6s1ycNlRgiExjJXuN1oYs/oTZ9y3huX22LqQKBHd1fRYkt
         udrS1dpnPzpvn+kqjlsRYyh+2hTH/+8KzVvOxFrP8ORAsRGG2kgBW64re++8EKNYhn2a
         bMxpxizFQ9VXKwZyVtDELYNGqKMOp5KqIAGeshmWrMt4OMc+KrriLpF4pyVd5RitLvc4
         vcleEk3o0D3Esmc654hNRlo0YE/vzqitCOa11inE6YG09v+LcywAe/uLN5H3WGIcQMyo
         aUnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729694363; x=1730299163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WhPKDbFTUZYFFVIAP/OH1JPHMZdUigC397OHZv1u/EA=;
        b=uty5l8iV6UVuO8owsZweGC8SsVYh5EVKOtAXGrQITKmZK6gBu00ImeDo6GCT+Cb1QQ
         1JAg0wLuQzEBiLefk/H0ThqqWRx5EqLqd1oBHjhCwZA639lmqqhKqGu9KcHRR7+MMyEW
         7K4v30kJzQunAZg0wGUDOgpHnmGvV4jiDaY/g8iwCuzfyNiv9GKS8AHMiyG29HaXa898
         cQE+OKveqhUg7YWXbStwuFK2H4neCwaQj/jAX/3E/kDQTRHJ54C+oUcRit5f864HaV8A
         mUiyjY+aabSOe89UnIfQ3U8N6RkktL5rqMGcg0gRZwz//Sxn7kY7TktNMJzXbobVFOH7
         1kEw==
X-Forwarded-Encrypted: i=1; AJvYcCX8OtBxyegK7XwprNzz4nRrp4lTbmPHmTrgu429aVr/EaE1k3g8+Zv4TEFhZdescJJgF9xfRLRkh2ighPbpbEWSbsXziyA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8thGYezHAtJ6KMe6+ab90veT4SxL95gK3iCGlaAKdnlgVv60t
	2u9zWwgeee2iTEYbWNRO3BGwavjAD9/b4RWjT09UWu28p/7mZffja4DkzN0WcRBTnKVWZETS4Zr
	eXYE638jxN9+wah0numyg4RkmVn72msu4ILvS3A==
X-Google-Smtp-Source: AGHT+IEGxTvgFJQKGjPndiT4g1UmrIbaruLgKpKg20RzOuGPbLbHepYglwQf3SmW4/COXfCydu/3Ww6v3WefxwQ10jU=
X-Received: by 2002:a05:6122:2a53:b0:50d:60fa:183e with SMTP id
 71dfb90a1353d-50fd037aecemr2859533e0c.11.1729694363103; Wed, 23 Oct 2024
 07:39:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 23 Oct 2024 20:09:11 +0530
Message-ID: <CA+G9fYt19NZ=8wY9aQRdYjtsPgiaywUQ2ff+TGkX-6zLBUGsNA@mail.gmail.com>
Subject: axm55xx_defconfig: ld.lld: error: undefined symbol: lockdown_reasons
To: Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, linux-security-module@vger.kernel.org
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Paul Moore <paul@paul-moore.com>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	"Serge E. Hallyn" <serge@hallyn.com>, James Morris <jmorris@namei.org>, 
	Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The following build regressions are noticed on arm due to following
Warnings and errors with gcc-13, clang-19 and clang-nightly with
axm55xx_defconfig.

Started happening on next-20241023.
Good:  next-20241022
Bad:   next-20241023

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build log:
=E2=80=94-------
ld.lld: error: undefined symbol: lockdown_reasons
>>> referenced by lsm_audit.c:417 (security/lsm_audit.c:417)
>>>               security/lsm_audit.o:(audit_log_lsm_data) in archive vmli=
nux.a
>>> referenced by lsm_audit.c:417 (security/lsm_audit.c:417)
>>>               security/lsm_audit.o:(audit_log_lsm_data) in archive vmli=
nux.a

Links:
=E2=80=94---
Download_url:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2npIko0KV1uYFA7CZM7n=
R9jHBBO/

Metadata:
=E2=80=94----
Git_describe: next-20241023
Git_repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.g=
it
Git_sha: ceab669fdf7b7510b4e4997b33d6f66e433a96db
Build_name: clang-19
Compiler: clang-19 and gcc-13
Config: https://storage.tuxsuite.com/public/linaro/lkft/builds/2npIko0KV1uY=
FA7CZM7nR9jHBBO/config
Download_url:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2npIko0KV1uYFA7CZM7n=
R9jHBBO/
arch: arm
config: axm55xx_defconfig

--
Linaro LKFT
https://lkft.linaro.org
