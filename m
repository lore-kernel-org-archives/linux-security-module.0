Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B00AEAC7
	for <linux-security-module@vger.kernel.org>; Fri, 12 Jul 2024 13:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720791343; cv=none; b=bm4Ija0DDtl6SfqLuEo9cXEcXBd7rLLsKPS6JqJwTOYSyFBXEFjD2eJY3IFuKJfdgSSvtzwCjgHRk0UrtkrtfC0CUTm4CiDgXeMkmPnHpf0cMmT2Pdl/5AqCxZ/NRW6PNDXZBnP6odXT9H60E9ALPF/HzJFakqj5iW8N9dw1UEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720791343; c=relaxed/simple;
	bh=fss1gxwB4P1lk22zXxnwlw8cYsg4hk0ErlcUO8mh63E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iBGUd9k9mi89+y8PnYbD46XiuePCjeTvf6Q1vIWo3JdYGv+OJirrunraH/OK+gl/VJpMXdvGQhOWE2+xTXusuX/7r+BntG1w2GhbnMA5ch5a730NLgTDOzM/LQItSw4eeDkTj0tXPHFVabOL8Kxqo7a9zIPv2xKrqrKV/L3aBf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eMAvySks; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eMAvySks"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-651a0aa7463so34171737b3.2
        for <linux-security-module@vger.kernel.org>; Fri, 12 Jul 2024 06:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720791340; x=1721396140; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w2HDQ4g5m5MzeG3csQuOLcO9IM+mYhsymW8yy7VBih8=;
        b=eMAvySksFIzM/ocbdht7fh4/XyusiwLVeP+FSMASOTlKTUf5rIcYICCuI2DwMXCRIn
         jwCt8+Ggh1obvITDTvOcL/nU1QiCqWHQu5GUCmnvO6pguW9YrwBETeYLYJgGN01pG/R0
         +PtliZVyLjL2wzZ3M94EExYf0YUsjfo1V34G41xgzsKEJ8IybTxMqz/+ii6XLGlZ9RLI
         qrrTsAfYftpQJ5bjtOK44LrKJxYL/UvumqYKo3WFRdWDNWQuRNCMSzsMg8C94GibP3xi
         8j+nqnXcnBkPof2y/EYSUEqjnVeKjmRlDJy1V0u3/Xo3JhBTf5zYmmPxhqQuDmguYVbh
         aJEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720791340; x=1721396140;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w2HDQ4g5m5MzeG3csQuOLcO9IM+mYhsymW8yy7VBih8=;
        b=w5//OY/ukS03c0/TyfMCN4ygqpDfErUGaYbqCnMSWbXgJ7odKmLVARV8ewc4ndESKq
         Ci13uuilfbBrColb84s8Eh8XPYBh49UDZEQ9fdKYDzZyVjePZuM62TMlT6dEla6DdBW7
         bYROvTIB1bVpwQ8b8vRNU+B7obqJjzv83rkb2wHhVyNyTnTcevuZrjvmkNSRPQcHzh4N
         4T3GRwaG9u43rJ3Zl/Xyx1NcWAA/aKO0A1NQoN8io2Ttrf7Sar522kC6ito2qDsmEFJ3
         NxfnqLCtdBdqxyt9FRlvGLcwSfW8344CAcJn4UGIf7oEpe3RJHMK1ue3Fvi8e9/huUip
         sSog==
X-Forwarded-Encrypted: i=1; AJvYcCXQlmLqozOhBxQrhitBjDPd/ZgSVmS8kUty3Vj/QJlUbtYYkSgMsGpC80QlXVEfRpn7ttCEdTkh6oGqLn9aNThazp9wf23EQmg2/Bhgx48RYHEFbe99
X-Gm-Message-State: AOJu0Yw+5jcEjNzGD/mbgPh3YP35Td+YNt2Qo3gSwL6hGaZiPk9TixtK
	EHVFpVHoGwGr9hl/Ih7T1ICdk1zVbkZxFcIvBfv4Iia37Y9H+y+HbkZLfdhjMlIYH+A4xva3nuj
	W1Q==
X-Google-Smtp-Source: AGHT+IFha/nMDN6S/TwrONeF1FiJuEVfcvQp/s8VTraTpNboGlvtBVgktw3g1ryTJdUuBlyrptoB5xgP7UI=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a05:6902:725:b0:dfa:849d:3a59 with SMTP id
 3f1490d57ef6-e041b143653mr879689276.13.1720791340711; Fri, 12 Jul 2024
 06:35:40 -0700 (PDT)
Date: Fri, 12 Jul 2024 15:35:38 +0200
In-Reply-To: <20240712130904.145010-1-pvorel@suse.cz>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240712130904.145010-1-pvorel@suse.cz>
Message-ID: <ZpExKpaDvxj3tqBN@google.com>
Subject: Re: [PATCH 1/1] landlock: Mention -1 return code on failure
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: Petr Vorel <pvorel@suse.cz>
Cc: linux-man@vger.kernel.org, 
	"=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@linux.microsoft.com>, 
	"=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>, Alejandro Colomar <alx@kernel.org>, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 03:09:04PM +0200, Petr Vorel wrote:
> Mention -1 return code on failure for landlock_add_rule(),
> landlock_create_ruleset() and landlock_restrict_self().
>=20
> Although it's a common rule to return -1 on error, it's better to be
> explicit (as the other man pages are).
>=20
> Fixes: a01d04a69 ("landlock_add_rule.2: Document new syscall")
> Fixes: ca5163697 ("landlock_create_ruleset.2: Document new syscall")
> Fixes: 3f7e4f808 ("landlock_restrict_self.2: Document new syscall")
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> FYI we test return codes in LTP.
>=20
> https://lore.kernel.org/ltp/20240711-landlock-v3-0-c7b0e9edf9b0@suse.com/
> https://lore.kernel.org/ltp/20240711201306.98519-1-pvorel@suse.cz/

Thank you, Petr!  This looks good.
(Please apply Alejandro's rewording suggestion as well.)

Reviewed-by: G=C3=BCnther Noack <gnoack@google.com>

=E2=80=94G=C3=BCnther
