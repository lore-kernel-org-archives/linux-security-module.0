Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE47F2D7D2F
	for <linux-security-module@vger.kernel.org>; Tue, 27 Jan 2026 14:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769523859; cv=pass; b=kbxPkf+DbfFWUhQJpZHjqIZCAVxHiARZxZYYjapcJdWWAX6C1vk1/KA4P+qnSqcwjwDMJuPPiAyypI5k31RUIjwSBhYNWhW0i9OedHIK7fyLkJXGQKYh2FYCSthqGmySrI59hIJtmLUz1OTC/TDijAWkz/rIU70eC21nJxN/9R0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769523859; c=relaxed/simple;
	bh=8wGhZ57QYRdVwdwGXh3v1vTEUMwIfmYPnQ8VICDIueg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pl3RA9Q6OXIcDlt1gZN+jcUxY5Es7bc4fiyM59xUjHWYfwjKWxOcU4LUaTspOu3lMl63pnP/xdrMw6+9yx1/OehY6JIgQX/cTr8Z+ebwcUoi1r6ScMRLfiwyxhspLmiiu1o5qHgA661mvXqyi+aIhEjG/3Koa0CAY3uCKCpM/cM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=i42ENrUD; arc=pass smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="i42ENrUD"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c46d68f2b4eso3652765a12.2
        for <linux-security-module@vger.kernel.org>; Tue, 27 Jan 2026 06:24:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769523857; cv=none;
        d=google.com; s=arc-20240605;
        b=eYHIUN/ZlSp7vKpqFzXdgczLnSdKd/VOWMO4UbPwdxbhKy3OJ4jqZ2UcfKKj42OvfO
         GLG86fgOMHsA8dinkid25O926I6VMKmlIjlEuCgZBwPBK22DRbguIxitjJQ2mQm558gu
         y3yjBypCnKxQgAIkzwYpcpckxgsAHdcxMpl5ayagu4RyB2gtJYkKLBcUSHZMkPuzAzXh
         4E5CDS9TyEhFuL+2hANIUiOEDP/AwuG18MqHxU3lSlBBsmGnMZpade46yt1Y9zVzlpD3
         uccX1rY25x/KL3mFNx821sg5ePFRSvayhIv5AKlztEcmMx+5ERw85NtwhCnp3WBbfX1q
         loaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=g8tcvewIRp4nWFWaAt8GaNWTar5d4nYaZWbJiaHU2o0=;
        fh=Oo3y2lqrLBM/i9Bnmy0sysHRju6yC+8yPIXPMYVy1wQ=;
        b=GkkdEfmkQAw1y2rgqXiNbt19gS9imjz9SMwrL/OIigFXd/cGDYo5J86noSHhCnISGO
         Hv8MddYvaZIj26fRzgFW0nZCgpUbpPlxZnpjegl2kXgCHUl0Ic/C1gm9YKE1WhDE17Mq
         UzQKV6lZ+6fm77g3/eTWH4Rj5YmFKXT36AXTTAYbr0nfYzfHGMxbRvYGC9e5+3IiVitS
         pLvEUiBSvUZcQ+19hLYjp2K1Wo1IJjmzEqVSGOcqpp7tUAj1LkGGhyRJhdkk/7yICu9S
         jIGpevNZqHgcyaEcoFk5djIG+0UzsQ7OnB+xS3tHoMdzvyiCYeKPqPXalj/dNvr9y4L8
         /gvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1769523857; x=1770128657; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g8tcvewIRp4nWFWaAt8GaNWTar5d4nYaZWbJiaHU2o0=;
        b=i42ENrUDMUDCGjKkz9nFFlAcDg0PNwtBaKNF3qlouMLTpEnprDZZNW0YCfwyCBpoY1
         nhs0ID4Y0piH5123jsmUq6CAgDP7LC3u9xWeOsF+2cNmlEbhEUtQLshFfBZB6I6lNMZ+
         XUVyVWK05w118524yXjGwJ1RTctZckUMr002cp5LGGiqiguZFM1FgniqI4CSYFl0NJiy
         0PtJlTBfnJDKMIINLIiu8tvVi+ifJeuXTiKLfbr4EwmtvHL41ExgoA6eghpPDcoSiZs6
         lkJP0BBGkJSi/aEyCmWcsXwN8WU6sNJU/Ek/Ij6/KVNdjiy2qE7poBuJj9hGwLUH+Rke
         3Fcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769523857; x=1770128657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g8tcvewIRp4nWFWaAt8GaNWTar5d4nYaZWbJiaHU2o0=;
        b=u0rtE6USv8BznSWPPr7ycjCYAMiVxR+88Z6uVgADq8/R691PH1NR6FqPBjCl5nlICY
         oKqnLWrbyikh6t23Vgo/2Umlb7hl16PlVQ9f16nqJfL/ZPLGrEd3f46maAM1KtjWCjid
         T0J84Hr6zLPEpPRgHNVIpJgCourwbVLoHdqdDnsGZn3lYBUWQPQV6tyVwUzu6T8rpgUA
         TGrO/BI9LSO4KQPghzYrgnNp3pP5K0+ysXrYSH+CVDVhjMA5d+4TvQisWLpWv6d6zRGs
         1dpzRyExyFoeDfutnQxS4LdFbGJb52teult0IAywIthi3oNoeIqx5Yadr32bBI8x+9tg
         VejQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkWL2PMLh5HAsWGdilhUOVs5CKuRoDosbdTkJ0rViVUaRr1nwjvdD+vKYMMbGVzhaHMXPfxp7hwFJz0YtSiXV2yJMFBms=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6DwJxhMiGcS8BRwQ07wKqFRf2hNKrTGtjju2cRxSA6OpdMCZ8
	IYvTUqE4n1dnljsnXhrw7J5SaTI5gqQOXdg5yluXkL6QzMuFhKv/ML7Hfc+b238/h9+oYhWLyZo
	psKh1zB1Dijq1Sf+7uN05W9dTk2mgpqrcr1ZN4PBQ
X-Gm-Gg: AZuq6aJAktRd2cOdpaXrtRwAfqs4Mxy+1PL6LPDW089WGYyaqfgqethuWu7bh4GgV8d
	P0ao0rUX8Mg1vdkUM9F/Wd/R/ni/hOco4bVb6dCJoFBtbfsdwOdD5y8jj2Uc5RNf65IUbtu9IKX
	1F1SM6nauxBSphMsr+GdaDId6lQdKRU/RURhE8hfH2taqKuGmi2KnbGF7zs/SlHBnjj2aY1T4Wg
	WavyKvWUies9VphJHVaRaUd75pafZlE+a1vIp8EeZcDHZp6yv/1NASPOe3X2J2qkLXKFmGXucrE
	/2PsEhEZnfhe3ZbHQ0mEb35bjj8dis7RAoOCgyamkjDYJ7fH/Ya2lmsfRsmSclTC8RylsTJazWW
	fnF1n0jl1lQ==
X-Received: by 2002:a17:902:ebc3:b0:2a7:683c:afc6 with SMTP id
 d9443c01a7336-2a870dbc9acmr21001815ad.39.1769523857061; Tue, 27 Jan 2026
 06:24:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127-ima-oob-v2-1-f38a18c850cf@arista.com>
In-Reply-To: <20260127-ima-oob-v2-1-f38a18c850cf@arista.com>
From: Dmitry Safonov <dima@arista.com>
Date: Tue, 27 Jan 2026 14:24:05 +0000
X-Gm-Features: AZwV_QgkM7RdmAG2bnPSNf7d7wiBR9A44kYI2A7GzBO9Yj2LAjFQ-cNjrOT6bes
Message-ID: <CAGrbwDStoDBMTB2f-F1jSeak6mqmHvq-ZjpkRNmExeX024=TVA@mail.gmail.com>
Subject: Re: [PATCH v2] ima_fs: Avoid creating measurement lists for
 unsupported hash algos
To: dima@arista.com
Cc: Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Silvia Sisinni <silvia.sisinni@polito.it>, 
	Enrico Bravi <enrico.bravi@polito.it>, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2026 at 2:18=E2=80=AFPM Dmitry Safonov via B4 Relay
<devnull+dima.arista.com@kernel.org> wrote:
>
> From: Dmitry Safonov <dima@arista.com>
>
> ima_init_crypto() skips initializing ima_algo_array[i] if the alogorithm

Managed to forget correcting the spelling here ^
Please, ignore v2, version 3 is here:
https://lore.kernel.org/lkml/20260127-ima-oob-v3-1-1dd09f4c2a6a@arista.com/

Excuses for the noise,
           Dmitry
