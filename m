Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5EA1E764A
	for <linux-security-module@vger.kernel.org>; Mon, 13 Jan 2025 22:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736805997; cv=none; b=QTcEgffZexuZjZfdijDLBObvj8s5PQ3YC1u1LzUTEv8UgbcFTT/w6HvOSb/t/rkbCoDM36+GfugF0Owac3ttGGH7PnxR6gl3iULPGErb8lFi6LwX9HuH3XuWUV8Vj2V0Ozk1gF7yXa6t8jXlIEiXI8tpfvfBg2iSiuyHJ/uC7oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736805997; c=relaxed/simple;
	bh=ti0EijE/8TJGFq9uN4RpN6pMVvXddS0yA2im7aoPSCQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qbVN3br938OJRTKYIqilU9jDyMPvTTELeHoW02hBr2RszKDgkKKd+nxWrOUhArFNKtpas66Ybih7YMO4gkS7LCdnNqoldmNFq2cIMVfzjM2MXLwu5GnzcTNMFs1Z0+wEbULNjwKDhf+MOc2N4rmXCunESWZfLtFBzcfb2Y9/goU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pkCSrpQn; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pkCSrpQn"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-5d3fe75a9f0so4335895a12.3
        for <linux-security-module@vger.kernel.org>; Mon, 13 Jan 2025 14:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736805994; x=1737410794; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DCWnemB5aE300uaRMu2u9vJAHtH56D5RmhhGVOpFGy4=;
        b=pkCSrpQnf/dT4veVTfVwMv9qqBaHNHF43xJ9jqPdaPf6PU5WftScyhboGSbDODubq0
         liTRsy9AHQ3dgAaw/HPa34qc1VM97bx4tvuCVLOhJnJ2SKp8hsKqG2Gz7zv+kfx8MTO+
         WAZYDSVqavDitm331FwH2B2S8p2Hm67XtvOWV+HqPSGcIs0Hg9GYBJZAOWvPr0PC1mBm
         Fn7GbpCLtATIR2tfYiX8Wfh65UFn8023W6Zny7YZn1e4+6CgDIqjNPKh0DAQMNp3c75a
         jFKwoE1WpLz1gBps2CYS2EXw+3bVlogwwYaAH02Rnirz1FtVqujWrhF2WGXAklO+5CO4
         vKzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736805994; x=1737410794;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DCWnemB5aE300uaRMu2u9vJAHtH56D5RmhhGVOpFGy4=;
        b=aayFz6mFIiy9jSTRCGGal0/1qciLRJ4H3GQcKrj5/ywl1iEvrOFZLQZ/6irEHrLIIc
         FbwhV6NIeTavOw5DX7mjL3nIeGJ0nFcyJuQZXO//ZQrckrgJ07kY0SIL/SF0gbNr8eO6
         ZIXdL7b2oMC60w91LdgC6cVFLurhttDV0m8WNEqyJqTlX4QkQgvijzjMT7jYyHhGXC68
         nazEjWCZqn3BFkSF5+U5PYcCTNcLpC3pOUJdcf7ULzr67eeEB/G9hmLYyiCFK2OBd6KP
         hqV0ThT/cvQGA3JIVuVvDp6Hc13IR5z8OyBYqPK1oQuvwWj/Lncpqy5EwXfx5m7vnsjS
         E/uA==
X-Forwarded-Encrypted: i=1; AJvYcCUAlYz4/akBhoyJBNb1phVUsh86WovfErF3wGq5YA7VelaL9gP7SfV2bcIdkkeRZS0AVS70DTTzZhrIoot5TcH8QPN5sd0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuDv64nrpUc9vz+6zPyuWbDGVl/Lm9VgAah2fvtSiWq2ZyOfOD
	cuHaH5u6Pou0SIfIO9g9e57ow8J9ft9wc7R6xprziPlnik+dRPtAc4oFKdQOec1AFP5wguIebGD
	jpQ==
X-Google-Smtp-Source: AGHT+IG5JvV6SazojT6g+coksh99/zAT9hJ5kGSRDqFMubgseMAUPW2JQacMz4QWAckhBR+P0QXAkcC9pqw=
X-Received: from edpg20.prod.google.com ([2002:aa7:d1d4:0:b0:5d0:e889:c403])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:2348:b0:5d0:d183:cc05
 with SMTP id 4fb4d7f45d1cf-5d972dfbc14mr18335294a12.5.1736805994007; Mon, 13
 Jan 2025 14:06:34 -0800 (PST)
Date: Mon, 13 Jan 2025 23:06:31 +0100
In-Reply-To: <20250113161112.452505-3-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250113161112.452505-1-mic@digikod.net> <20250113161112.452505-3-mic@digikod.net>
Message-ID: <Z4WOZ_yqVbgoHBlB@google.com>
Subject: Re: [PATCH v1 2/4] landlock: Use scoped guards for ruleset in landlock_add_rule()
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: "=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>
Cc: Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@redhat.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matthieu Buffet <matthieu@buffet.re>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Peter Zijlstra <peterz@infradead.org>, 
	Shervin Oloumi <enlightened@chromium.org>, Waiman Long <longman@redhat.com>, 
	Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2025 at 05:11:10PM +0100, Micka=C3=ABl Sala=C3=BCn wrote:
> Simplify error handling by replacing goto statements with automatic
> calls to landlock_put_ruleset() when going out of scope.
>=20
> This change depends on the TCP support.
>=20
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
> Cc: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> Link: https://lore.kernel.org/r/20250113161112.452505-3-mic@digikod.net
> ---
>  security/landlock/syscalls.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
>=20
> diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
> index 5a7f1f77292e..a9760d252fc2 100644
> --- a/security/landlock/syscalls.c
> +++ b/security/landlock/syscalls.c
> @@ -399,8 +399,7 @@ SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset=
_fd,
>  		const enum landlock_rule_type, rule_type,
>  		const void __user *const, rule_attr, const __u32, flags)
>  {
> -	struct landlock_ruleset *ruleset;
> -	int err;
> +	struct landlock_ruleset *ruleset __free(landlock_put_ruleset) =3D NULL;
> =20
>  	if (!is_initialized())
>  		return -EOPNOTSUPP;
> @@ -416,17 +415,12 @@ SYSCALL_DEFINE4(landlock_add_rule, const int, rules=
et_fd,
> =20
>  	switch (rule_type) {
>  	case LANDLOCK_RULE_PATH_BENEATH:
> -		err =3D add_rule_path_beneath(ruleset, rule_attr);
> -		break;
> +		return add_rule_path_beneath(ruleset, rule_attr);
>  	case LANDLOCK_RULE_NET_PORT:
> -		err =3D add_rule_net_port(ruleset, rule_attr);
> -		break;
> +		return add_rule_net_port(ruleset, rule_attr);
>  	default:
> -		err =3D -EINVAL;
> -		break;
> +		return -EINVAL;
>  	}
> -	landlock_put_ruleset(ruleset);
> -	return err;
>  }
> =20
>  /* Enforcement */
> --=20
> 2.47.1
>=20

Reviewed-by: G=C3=BCnther Noack <gnoack@google.com>
