Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1ED224AF0
	for <linux-security-module@vger.kernel.org>; Mon, 28 Jul 2025 21:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753739378; cv=none; b=DabneRj5MWzEhnmEA5zQK8/hJoll946DZ69kM3gWYbasoLLQrhCJUcWZTbxRcuBK0k1F7CZ/nwftHypnVzac8+ulPBjcERJXWl+WTwSrIrvTNwrOt7Y6LPoqd14cg9CK7c5X9XvXH31oV4XJ72QfSTmfFaukgcI537FwiJJvZ4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753739378; c=relaxed/simple;
	bh=tTCJWGUp62X7xORqgRT8/m9obaHcnwzTRIbKZR7RuOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hmTV3EH96ikr2c6gRqtxrLYSn+mkHE7bOED622kZZsWG08Jm9DuVeOsHwmSItTvxJz8S5cD8w6vz3MkIAPaPHZST9AVYwjaybkl9jo1UEp9aX2TNGWAp79QNu2jh/KbyuwE7cJ8LN4y5ItaRiS1GZY7ySqmM+2tlJ5dWdyvbztY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Nh+KwAhg; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Nh+KwAhg"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e8e11af0f54so1162062276.2
        for <linux-security-module@vger.kernel.org>; Mon, 28 Jul 2025 14:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1753739376; x=1754344176; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=poaEelBg7a7OcoaRwgyEnvu3ww/B0f0meFimZvf+Ksc=;
        b=Nh+KwAhg220CV5ri5tPFw7EWzAPu7j3V3OA15Ypm2cfmtWCJMJZwB4uQP5llEDBiUj
         0WMw5a1JT6p1AKSg0PPTclQVO8PXh/xLaBHvROZ+R8XWT5IDqAMozM23xfekNFXtrv7Y
         yMwNWnGjUlXJI7RK/ZrbojjGkDLpnwj/Wems67wS9YR2OQERVE9VHF5x/vBvrsw1uP22
         jjuBdb3nJLh511EJvJHtLnUH4TAM+HfZv+5C74Z3DMtrDdVR7se/NalkW0GD6u1Vx4M3
         2Q64lV9GbNNNuui/PlCznV3zYeXxzIks9ASQGBVG/0r3JtxkTCIoWz+xRnt6bdDuR7fL
         IG/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753739376; x=1754344176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=poaEelBg7a7OcoaRwgyEnvu3ww/B0f0meFimZvf+Ksc=;
        b=KeWR2U+gkT/ZJFJUUa1rFv6eQv1Y6gmc3W6sBW5G8hlt5bTuwb0LNote3vb7CGmcs2
         NOixMgGaEkRvbIoJ4KegWqi6kbOLOL+XxJW5ZgNoOsQio+/xlfIGCO4WCIQvAK8apDlu
         R2fmnciOL0CGQrbeebqUQoVGG/NCEKyAVoC6Afl0KPzCRL32dtGaqU7Sg6lXIswgHGtJ
         yNIvKR5mx8RmCb0geWikY72BP8x0IRdcJv+pegMLsPQE/EyvloSiM9kFZl/vnIqSOsPM
         dvZiQILj51O8a0TaZ1SmWpaOeLTqsVeY4Z0BKahRkWRx8vvYnoh1w42gAH7eEcj6ukmb
         7F8w==
X-Gm-Message-State: AOJu0YwIc8UlcIlCqOcZko21ROrkCWDi/Xx/AR1/zT1rgiad2NzOLYLE
	JfzZRjl3CLTVvpOn5B6iWMGv3Pgvd8t97S/oIeCq4Fjn0rIV0fwoGAScrSR9ScLgdkg09WqvGJ7
	UPaZfaz1fArsFNhJElVnhjpp5TVxP2q7XG4S/f/G0
X-Gm-Gg: ASbGncvjtCzxup8ElB52lYMI2cylyU56B+q9LvAjXvEKZTJXQQDBirp3Icrp2JepH7b
	Ff1erFyUjDreQK/hlYzEAWUDwy56UuzsxHaxwG5e6UNo4B8xfA9AK1btB9iKdYIAq32kgIMCeID
	z5N1GaplYlMFqPf/IkLqLUZ64FN7Ob7ZClwVO42OQm8z9t5p3nEcahlRlLZG8l/ckltmbUhZxis
	chjwLMkAumhpRY94Q==
X-Google-Smtp-Source: AGHT+IGDWEdUVk8nOAd3eyXAgRoqbzWehDC/nmyeD5iRJSvY5Vw/y940r4iuZWMM9Zl9+esWYILkX9fMDQfg5o7B9Hc=
X-Received: by 2002:a05:6902:1501:b0:e8e:25db:be33 with SMTP id
 3f1490d57ef6-e8e25dbc361mr1013358276.28.1753739375979; Mon, 28 Jul 2025
 14:49:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721232142.77224-36-paul@paul-moore.com> <20250721232142.77224-66-paul@paul-moore.com>
 <3101077d-a5e2-d08b-03c2-2ed064a35b54@huaweicloud.com> <CAHC9VhR_24Zv7u0Btz8pSk420Totnx2uRyVdoHU1tXevWKw5mA@mail.gmail.com>
 <68025cd0-e55a-066e-954e-a398feedc34b@huawei.com>
In-Reply-To: <68025cd0-e55a-066e-954e-a398feedc34b@huawei.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 28 Jul 2025 17:49:25 -0400
X-Gm-Features: Ac12FXyHnpkhjuUV-tiMUv0zwfhXi7dvEqfqeEj1riNPGNByZhk8N5Ld8lteEnw
Message-ID: <CAHC9VhSp0cfSf1aeuWU3ZGt45v-vyoR9L2LtAMLpE+yB39ThPw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 30/34] lockdown: move initcalls to the LSM framework
To: xiujianfeng <xiujianfeng@huawei.com>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, John Johansen <john.johansen@canonical.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Fan Wu <wufan@kernel.org>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 26, 2025 at 5:38=E2=80=AFAM xiujianfeng <xiujianfeng@huawei.com=
> wrote:
> On 2025/7/26 0:51, Paul Moore wrote:
> > On Fri, Jul 25, 2025 at 4:12=E2=80=AFAM Xiu Jianfeng
> > <xiujianfeng@huaweicloud.com> wrote:
> >> On 2025/7/22 7:21, Paul Moore wrote:
> >>> Reviewed-by: Kees Cook <kees@kernel.org>
> >>> Signed-off-by: Paul Moore <paul@paul-moore.com>
> >>
> >> Reviewed-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> >
> > Thank you for reviewing this patch.  As you are a Lockdown maintainer,
> > can I change your reviewed-by into an acked-by tag?
>
> Yes, absolutely! Thanks for checking!

Done, thanks!

--=20
paul-moore.com
