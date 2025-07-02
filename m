Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCB02BE626
	for <linux-security-module@vger.kernel.org>; Wed,  2 Jul 2025 19:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751484300; cv=none; b=Yx0SRZXZUqR+rLKkShkQybBjhYG2OYLo5uwstWk0VzSql+TNDPMz9UE2yT36ajgiNne6CzrcZEtHhHwf/6ugTZIs/qsDqUYrMILKhgfeC7gpdlxdr81hNQGxSZmElfricBRSKGg31K2meP1nf1MEdygBlkrIcsrogiYpINuIeAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751484300; c=relaxed/simple;
	bh=KK4ynMiBHY0thbjaKNOn/kUYd4MYbYdKNVAr0/lf4n4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ox8mx9ISDUCr+DZG2K3UQBMD9Y8vdcvbClls7/X7oB2G7+PCsQ6wQzX8WQ3W444DtrBrQct8L8TefYrIgdDoGTaXH767GBAVHa+Yf4w3XIQQGAM/5Y8yglDZotx3s7bdehkFB+qPn2fcBd8LFHeMlLuYUPKhhsL/Ua3/m+YyW/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ByItZai0; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ByItZai0"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e740a09eae0so6788979276.1
        for <linux-security-module@vger.kernel.org>; Wed, 02 Jul 2025 12:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1751484297; x=1752089097; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RisGUs6Qykk07nJw80m0Ftg7mf8erIx6Cg/HctC8ynk=;
        b=ByItZai0w8MGT3rkQg9Fse6epWc0z7aza9psyjNIslDY02rb45inRL5w27IE/oJ11f
         toscM2B9hzhUCDHK15bMnsPE/Di2s1Fnzup6bh7976ZiwfV/heNX4UwBgb9ogSoco/OL
         k8ON+PSZdN4V8YpzO6Y9Ggr/S6rKfC40f5GbvphbrqMm9Xzo20823UAr62YyCVa6TdV6
         5kiXFi6zt5BX5S4WFny3X9Qf+qxgCUBdRgJ/F/hF0BTnYamqKTtPEijdzi4/9ClftHUD
         oAJ5qjAaRWbqoSuQSZK8e4mnB9jHFs9k/8Ko8BjapzrR+Z4FqGj85d7nSwCD1SUGYz/q
         GIxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751484297; x=1752089097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RisGUs6Qykk07nJw80m0Ftg7mf8erIx6Cg/HctC8ynk=;
        b=e9NyR2FHcea2AjqsMIDHEhcJgAE+YK8u/rfctJx/xxlT/j+PLs1c32EOuzGI6WC9Al
         lsSLe8iWBzDX8fWQ5e3p05w9vjVM9yZlij1rCEZwHNhQ5GimiGnGJ+1Xn4SKVWtT4a+F
         xU6w+yVWBvjdnQ41GhaVjBSzVixeFCSAmb1pt9rqONCkDpmxtPEckuztOamLPFvXXrHt
         M3SSDZBM8Ho7o0D8v1TunsVA2ck2Yqx3HInFdu4Aguj9XMV6qCAKDcoYWdoGbn1Sw9ZH
         2qXTZ4E77ECa9pXc20ePgR3D5Sh4wtvoRO1YlDr4xlJi9+tDMTb5C37P1mtvvomIGfyY
         3xCg==
X-Forwarded-Encrypted: i=1; AJvYcCWSzBqszK+QpDCvDrGlep+qfXqLgnuB0dTyYtspem3CJ7XV7xIE//MCW6sEdnPS4gcPrpZyzrb7+vHvJRzUh8/pmV1AqL8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0oKk/6RKLNPzD0qHcPNASj+eGiu+F/rQuXd6kmegymTXREa4K
	QcBckHDOL88i8JnY7znLBe/wGxJfwvxTsJU//7JWCzuF9mR6/bwdKm/JncWtCWOiJn2dzggLtSb
	8oFG2TQ58kngBsg2J4DRrKd5tB2+0zOuCc32ku4Q0
X-Gm-Gg: ASbGncsmNWciQQYXWuMUlCJdCrL2eXTyr38LxorK/F6RCOJ2GSgV4MLgW8Ne7l5i+pS
	KOfkgdUyHv638yYdxSC1UdXcD0q8k5Tdizm04xtR21YYB4Npfvl3xqi+Z5gffh9YBJffLdmRGbq
	uCFAeEdEWryXliw9Z64gzRlVN+Wx5M80+OPGnHMCi5dis=
X-Google-Smtp-Source: AGHT+IHvhasAtxRO9RpFu2NYbRrcynF3zeEZltmoq9Luzh1btO4Igu87XYFa3nEiA/TfmY8TNO2agVgG/zRUYfJtTIM=
X-Received: by 2002:a05:690c:6486:b0:70e:185b:356d with SMTP id
 00721157ae682-7164d398834mr54967477b3.14.1751484297140; Wed, 02 Jul 2025
 12:24:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702055820.112190-1-zhaochenguang@kylinos.cn>
In-Reply-To: <20250702055820.112190-1-zhaochenguang@kylinos.cn>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 2 Jul 2025 15:24:46 -0400
X-Gm-Features: Ac12FXyjMghT7240fFXsw7E25qCJfe8hMIplSYH8wjk3i5VEZLbQ2yBp0Z1HQmU
Message-ID: <CAHC9VhTg7cwXu17tHMgSJF3ZRWjA_ozZg3TK3aLJOs2X4QBJ=w@mail.gmail.com>
Subject: Re: [PATCH] net: ipv6: Fix spelling mistake
To: Chenguang Zhao <zhaochenguang@kylinos.cn>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 1:59=E2=80=AFAM Chenguang Zhao <zhaochenguang@kylino=
s.cn> wrote:
>
> change 'Maximium' to 'Maximum'
>
> Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
> ---
>  net/ipv6/calipso.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
