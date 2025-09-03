Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8E93054FC
	for <linux-security-module@vger.kernel.org>; Wed,  3 Sep 2025 20:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756932207; cv=none; b=XF9NacIKGw/GvhW/BInulu07svv0nwNngGbCBJBCVYWVVOMMIgZrp9npiasQDiQkvYuPSvS6i9zHuIkcRS05eo3iP2j2NuTfF4YPIrx7iapxw+iuWcNpYM2WWRzzZq9qx+OeDJWqKSgnP2bRt8b+56lVaZzefwFdQCb0h/KC6/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756932207; c=relaxed/simple;
	bh=27og5+fwLnrq84zqJxNwPwieJR4goIKuoY55Yt2xb6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cquin5qa1KVUJC95RVHEERMlRy1X+yW3cU4cIMPB+/YaeQuucNSDZl1hv+ZdQf4/hDZQyyJg8W/IbdVkXkOxZN/XU8CdWkgyqMqTRB8+HpvxjslsunKYGfPgLRExXEDRSyaJ+iTqlCLILBA+lbehaZqt/dvY5IYf5Nul6fbmAyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=cH97UslS; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="cH97UslS"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-32b02d88d80so240380a91.0
        for <linux-security-module@vger.kernel.org>; Wed, 03 Sep 2025 13:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1756932205; x=1757537005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4J5ZAyPuJAqt+B4efQjYgrP2z9OquwHDAuNUGWfku9Y=;
        b=cH97UslScOfryM/kMlZ5wsLXstKkAQGi+JRvHcA4eVQ7QlaEol3FbJ6SKzShOH4uq5
         X99tkyDv8wzgXvFCLXDirm2/Ne8Cd2AtlRaq8x/AEIryR4FbCxaWpcfhcFIyxYoK5j4c
         gduSY/BpKZ8uZf50Wn8575y811S/NnT2fQLvfQc30KLOS/mRk5I8MnMq7dQj67Esm31z
         EWH7ZbCwHIuJYLrvZZKwW6Q2y5H6CFtqNFqqVdugbeVoAzmv2dOvieiT7X3FoHKwId05
         fDfcF+8fUInA01ftYDism6bskgoVjZGFrHhXbFnjSkJgzMJBQb2QJjbSlinUMJfJ7BE0
         oN/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756932205; x=1757537005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4J5ZAyPuJAqt+B4efQjYgrP2z9OquwHDAuNUGWfku9Y=;
        b=Iky4nZTs0/Q4GyymMPL50hEiharyfPB+/SmBjg16DRvxfCSLCiT6s6IJidPGNfkbF1
         D/gtDUdtyGqBvWDCBuE3zY9weMEbTsMYYWCS0fOx/d5BP0tSNXMyK1knv6sWbDYT9L+s
         fQsTXCoVJy+3n55etbQl9bTM0Ip9z0o6sPNsvSM8glSDQk9uU72FgA0hQncx4h0p7z6j
         l+e560zS7wD/ufEGjfyWNZATW2H6HSedMP1WU9VdaNqjColisj9TsFuiwMhyZciGEnFB
         16BWkm86g0CMua+vsu2aPEMTAn0zZ4DyIYcs2uEy/+h6yKKaWyEvuN+qgHkNqzzo+TL5
         4O8A==
X-Forwarded-Encrypted: i=1; AJvYcCVOlmqLnbZ1ChqSJiXO82kiii/3qBF1NPLRJi+fLZydrhS8TFr2Fg6MhZJMvogSlnWVubz5Ptg7G0DN32ZR3k2c5qXmaB8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yysxjm7GsZgysZaoeUbugGJ8ws7y9eWnCtnUkfowXjlaWWVpX3A
	4McjeRF0Ri6OAjmVp2tHtcRBqyzv7p6KkJY6zgWuxVq+gS00tzDOLPFUYbJw5OxjBLebYe5Ko55
	hu6g00ZeWFXtmczXBXn6t83RqUZfJu6mQtJTS1V5VGSQ+6Ne5pRU=
X-Gm-Gg: ASbGncu52fzSuG0Pt+ipmllx5UbI0f26ADYwraLXEE0+hun1npRIrHCiIyG2veP6lcL
	m6zkFzGlIoUauOZpnA0+LAAXlKHCKoPMO5RAJejkn1hoZdDvmigvhKWa7ClXj4QcO/QkFtePiJv
	RkTMIHKeYCM31qNPnU/qIbm2gVhgmrGTe9B5u1C6PFB9UNoi1f391R3xUOYB5vRcVq0KhGQZr9M
	/DK3pY=
X-Google-Smtp-Source: AGHT+IEQJCaMMXRQwVvK7h5/Q6b9DGduxYynzANDDzGXPsK+5nl9MJ7jOAJpAhUnmR3pkuQpDg9Pg4o7XueiTWfhdoI=
X-Received: by 2002:a17:90b:2802:b0:32b:9506:1773 with SMTP id
 98e67ed59e1d1-32b950618b8mr55670a91.33.1756932205371; Wed, 03 Sep 2025
 13:43:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9f35539de7188c6b853c55b76958a286131f5928.camel@huaweicloud.com> <20250902125457.2689519-1-roberto.sassu@huaweicloud.com>
In-Reply-To: <20250902125457.2689519-1-roberto.sassu@huaweicloud.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 3 Sep 2025 16:43:13 -0400
X-Gm-Features: Ac12FXxKMPsEzJAGYC2xoOwmRYoQxVIxBe63dOEJDQM6GwZfLYjmyRi68JmcOCk
Message-ID: <CAHC9VhSP=NEDd7nLUxPj95tgaHeERaJHf2KH9PDfpwNNuPRzTQ@mail.gmail.com>
Subject: Re: [PATCH] ima,evm: move initcalls to the LSM framework
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: zohar@linux.ibm.com, roberto.sassu@huawei.com, 
	linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, john.johansen@canonical.com, wufan@kernel.org, 
	mic@digikod.net, kees@kernel.org, mortonm@chromium.org, 
	casey@schaufler-ca.com, penguin-kernel@i-love.sakura.ne.jp, 
	nicolas.bouchinet@oss.cyber.gouv.fr, xiujianfeng@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 8:59=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> From: Paul Moore <paul@paul-moore.com>

We should obviously drop the 'From:' line above ;)

> This patch converts IMA and EVM to use the LSM frameworks's initcall
> mechanism. It moved the integrity_fs_init() call to ima_fs_init() and
> evm_init_secfs(), to work around the fact that there is no "integrity" LS=
M,
> and introduced integrity_fs_fini() to remove the integrity directory, if
> empty. Both integrity_fs_init() and integrity_fs_fini() support the
> scenario of being called by both the IMA and EVM LSMs.
>
> It is worth mentioning that this patch does not touch any of the
> "platform certs" code that lives in the security/integrity/platform_certs
> directory as the IMA/EVM maintainers have assured me that this code is
> unrelated to IMA/EVM, despite the location, and will be moved to a more
> relevant subsystem in the future.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  security/integrity/evm/evm_main.c  |  3 +--
>  security/integrity/evm/evm_secfs.c | 11 +++++++++--
>  security/integrity/iint.c          | 14 ++++++++++++--
>  security/integrity/ima/ima_fs.c    | 11 +++++++++--
>  security/integrity/ima/ima_main.c  |  4 ++--
>  security/integrity/integrity.h     |  2 ++
>  6 files changed, 35 insertions(+), 10 deletions(-)

I'm happy to replace my patch with this one, would you like me to wait
on an ACK from Mimi, or are you okay if I go ahead with this patch?

(As an aside, I'm still not entirely clear if I should wait on ACKs
from both you and Mimi on IMA/EVM changes, or if one of the two of you
is sufficient?  I'm happy to follow whatever approach the two of you
would prefer, but I don't know what that is ;) ... )

--=20
paul-moore.com
