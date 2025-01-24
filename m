Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73C61DB13B
	for <linux-security-module@vger.kernel.org>; Fri, 24 Jan 2025 09:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737710678; cv=none; b=Ua1RmxTLmB8Tg7JFxWLcRjBxiVwZPu0itNN8VNMOGtny8LAXd7JlNABs9HUTMcPHXVJQeIoS9F1A4eTuJCSLqe+zowyTRn+apMynZY57/oBQECsh2sKJ+6wmEPUJ4YH4Vkj0eiQ5tRYfDI+jjWD8NKZbywnf7ftBJQLhofriIn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737710678; c=relaxed/simple;
	bh=OFlCvag1dCMWxCbQJF9vTIHIYpXQds68VWnbaoEmzps=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Rm9vFibs5E4zrUJ46hNcC3geAvRp8Ls9a7zYcJDbE5z8gwtAZ7eRuV46Gd49dtEAjQ1vsep6UwfyHYjrMj4dOpJpX2iQu4zSjDo/ladQK073CZqeJjwiMcx0En+WZdTzJPgrynkEdzFOcLTfo3hM+Jp+u3cb0A5YLLWOwey7Pwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GCFywpgO; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GCFywpgO"
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-5d3d9d6293fso1888398a12.0
        for <linux-security-module@vger.kernel.org>; Fri, 24 Jan 2025 01:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737710674; x=1738315474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r4qUWQfGYfCur4iR04Gogqvnq5G2P8cLb5tgTIutD9c=;
        b=GCFywpgO6mJ6dKthtV1VZaRE7OH5tsptRUzI1aGKCKkEF8lRyyftq3cgHtccIHVTQQ
         za95g6wybwk3OdfdmcjAX2nHuuHcBqzetz1obPQCFd8Bp6QLsVCPOgrwfjzC91ydLAXD
         lJ/uuZSVjOvNAmmL7lkPQu/BGRRrCNJ4AqYpZceW+92PNzWgnQYnh6tjPn4cmvdwOLj9
         09YflXlw1UrCZ6RSM8uBxLwvUj20VXG/u6UVHW6G3E2cJI6IGTruudE0ulWtaroBrglh
         ANGT85Wfe22qY9BpAXtgPi0qanmX7pXaighmrBqfk9Fe/iM9IvDQTs7rDEswR+UdaBC4
         mI6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737710674; x=1738315474;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=r4qUWQfGYfCur4iR04Gogqvnq5G2P8cLb5tgTIutD9c=;
        b=DdRPOnWUR1EBK4vSUE+KP5GoUUvFtE4RCUHcFgh9EllVIfAYuvLCTTPEwXmSJ5HrM9
         W9+nm/TUefol+Aos/eHTf/yfHBnaUt/up9N01GnuS/9eZsZ/XfhrqyKeU5M6V6w7nTlf
         2O7j3dSMkgooR12BNxMZfljk6QTcno4eP2AhDDHUU+ARE73c6nnVWspCYvaVkTpNghY7
         kTD/YDawmxFJxmihZ0k13k319RmF2WBnQ+7TvyXlmtPmAo4TXBwm/nYBB0akpsmTAzOg
         yR3+9H0Tfb3bYK1+4WdbpOO8OpLe20i3eKChztqoVJq7hrt8eVpC0vTdFqJvchkxQF8X
         CDBA==
X-Forwarded-Encrypted: i=1; AJvYcCU4Lydkd3AOuyeY/DsmW50TPbvjzYg4XnHgDiHJE52k5yX/Z5IarhroWhTYjMT5BdVO0ktettOXLL6Q1p44+ml/5CWUmzY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfxAnx/+EZCI4OvwM5NXTNSHtkdbedxu2cpJIil7fNDaIqShF8
	5Hu3aiMyjNNMaO6xxoQufBWd/5GjuH9bxVz981tJHwNth5Lndd3Vi1EWJ1Pf7GC5OMN8yavkuum
	wpg==
X-Google-Smtp-Source: AGHT+IEyLOTvh3qO2R3zKQwDU3mM0N68wG3/2dAq6sVpthSi5GIlcCrKg2utWHsF1089JWIBT3RJ8EQvj2c=
X-Received: from edbij8.prod.google.com ([2002:a05:6402:1588:b0:5cf:f391:7e9d])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:51ce:b0:5d0:8197:7ab3
 with SMTP id 4fb4d7f45d1cf-5db7d2e913amr22662796a12.3.1737710674232; Fri, 24
 Jan 2025 01:24:34 -0800 (PST)
Date: Fri, 24 Jan 2025 10:24:31 +0100
In-Reply-To: <20250123194208.2660-1-tanyaagarwal25699@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250123194208.2660-1-tanyaagarwal25699@gmail.com>
Message-ID: <Z5NcT4Z3Fo5RrB9s@google.com>
Subject: Re: [PATCH] landlock: fix grammar and spelling error
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: Tanya Agarwal <tanyaagarwal25699@gmail.com>
Cc: zohar@linux.ibm.com, mic@digikod.net, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
	anupnewsmail@gmail.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2025 at 01:12:10AM +0530, Tanya Agarwal wrote:
> From: Tanya Agarwal <tanyaagarwal25699@gmail.com>
>=20
> Fix grammar and spelling error in landlock module comments that were
> identified using the codespell tool.
> No functional changes - documentation only.
>=20
> Signed-off-by: Tanya Agarwal <tanyaagarwal25699@gmail.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
> Original discussion:
> https://lore.kernel.org/all/20250112072925.1774-1-tanyaagarwal25699@gmail=
.com
>=20
> This patch set is split into individual patches for each LSM
> to facilitate easier review by respective maintainers.
>=20
>  security/landlock/ruleset.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
> index a93bdbf52fff..c464d1f84792 100644
> --- a/security/landlock/ruleset.c
> +++ b/security/landlock/ruleset.c
> @@ -121,7 +121,7 @@ create_rule(const struct landlock_id id,
>  		return ERR_PTR(-ENOMEM);
>  	RB_CLEAR_NODE(&new_rule->node);
>  	if (is_object_pointer(id.type)) {
> -		/* This should be catched by insert_rule(). */
> +		/* This should have been caught by insert_rule(). */
>  		WARN_ON_ONCE(!id.key.object);
>  		landlock_get_object(id.key.object);
>  	}
> --=20
> 2.39.5
>=20

Reviewed-by: G=C3=BCnther Noack <gnoack@google.com>

Thanks!

=E2=80=94G=C3=BCnther
