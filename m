Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7B822D9E3
	for <linux-security-module@vger.kernel.org>; Fri,  9 May 2025 06:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746771349; cv=none; b=Ij81cVql76Oe9nu6J1tPltH217fhV+arnhZR9zC6NEz+pjTye5zVhseIZsid4PI4xO9tqLlmoSZZzi2ek8dsOSCz3oPTqK1467gAX8ujKCXfhhRy+5slWPceSLgeWuKfWUCyIPbZP7686c7r6bB4nv9zmDJc3noef89CjNRN6xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746771349; c=relaxed/simple;
	bh=PAlJ1N0OBElbwoLPQZepjOk7fuV1wlJc+kcVBuypzLQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gae7Iw3qsWbbVywhuHW0tC9sWf0ao556phje/h8JBh2L6KCejpGukN4DPZ4Euk+ZO8QpMlJsZjfLAGWfY+ij5re5Lz7SL/8s8ABQT7EgWJU+e8kLzujs105IEp+ihBT8KK+4xRGNFis8grySf4jvZOw96D2BsjqyzUPflVqTt6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=O2HyWG8S; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="O2HyWG8S"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5fbf52aad74so4396132a12.1
        for <linux-security-module@vger.kernel.org>; Thu, 08 May 2025 23:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1746771345; x=1747376145; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PAlJ1N0OBElbwoLPQZepjOk7fuV1wlJc+kcVBuypzLQ=;
        b=O2HyWG8SRdQH/kQUJgYpI416OkBkmkGch1UGYTPtJlD6WM1Q4Jq4AOJEew++EUiztx
         S7cSb1rkjJzNoir3djYzt/QAroREVr2gobQjISsThNeftkWrtORtIMdrEb+fKSKgofJ9
         GueUlJ8FllRoxRi/BCvMUgG/LJhT9xKW0bmlwpRqvU3BlENRy+dzVcTUwahv+ZNihb8l
         7cPHDmPSH9klMa4p0ejMnJKN4X0W6CTUoGJFN2C+um9I5j3D0u75pbOrVZIC2kmIjBVE
         RqgOnOnWxMuZZLgwDtLXXw2bM6g2zCfpn9USxeQ9kRp0+G8deuJRDe3JqSnDixJSomTy
         M2qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746771345; x=1747376145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PAlJ1N0OBElbwoLPQZepjOk7fuV1wlJc+kcVBuypzLQ=;
        b=tQH99hXDJw5LWsxt/G7XFe8IYzVZzzjr7UA2JyoB5gDBG+j1w2LFfMJrcqaO0pUXV7
         X2BnbQFkghc7qUDmvOidWNkqkEjIw1DePZwuLJqQ4jIhBVuht+JhaOJudtIhoPGY3l7F
         wcCeW9khRVt/IBw5qwvPAunEVQrEAk9U1RrTQm2tWSPO+4Hsn7Cv1sjJvAQyvlNlWgf2
         aqBkxoNXW/txfAI1+Z/JXT38/3DoLUeH8blII547tAi+0ZZkSX7QHMmB9FFaGaxeBkEg
         gkwfeW/oezFy+FQeOLB3vvFwkrFtekvS/funAC0Ev9yPX3oczF1XxfXs8+fsnPnPTbvA
         SZJg==
X-Forwarded-Encrypted: i=1; AJvYcCUh7QpM06qUgfGMiAaDfp9dZBBr/BC5W0J0S9VjNQLHdVB2kNURTh2aFqb+jAej5ylYm5a7+SrcmeXWHdNdBZoArbomst0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAHcgdhCi1VbxgvpTBRdbnSg7KGiCtFLSkxeo/y4gItjypjgk3
	3FWSOd5Xrz3mTcXu0RhkRZQY87/bFVLghc8OVhbJQmNGN6vWqW2VLGv2m4DzSEImCmzOWO7Uh/2
	Z9DeTb1qvTSs/OdeXyZJ04rMs0nNU0BjORqq7RQ==
X-Gm-Gg: ASbGncvn1RMiLGOWeFMkyFkwx8yECNjTAyfCsJwY9grm/C5mT2ZZc3e+Tew+3XgddN8
	KOtsCp2bnRQNOgQ6Zmd1jbW5c0XCSOFzQOAUwYreOiURKL9FNyS0eZdOmkmpe7bn7qlWt5JlEF+
	HhRPUyR+/6im0PrL3/RHFWU81lWuptlM5TLjYr+sawu+MKELEpPk4=
X-Google-Smtp-Source: AGHT+IF0CBsOt7Qgqj1ORjsMePCn8z/Lp6AtC3pVYi28IKbuhseZj7dfMYhwnXl5elvyVwpXTWGA6njyn3NSQjMbJi4=
X-Received: by 2002:a17:907:b11:b0:ad2:242e:fe9d with SMTP id
 a640c23a62f3a-ad2242f01e9mr35364666b.10.1746771345067; Thu, 08 May 2025
 23:15:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306082615.174777-1-max.kellermann@ionos.com>
 <20250309151907.GA178120@mail.hallyn.com> <CAKPOu+_vTuZqsBLfRH+kyphiWAtRfWq=nKAcAYu=Wn2JBAkkYg@mail.gmail.com>
 <20250506132158.GA682102@mail.hallyn.com> <CAKPOu+9JCLVpJ-g_0WwLm5oy=9sq=c9rmoAJD6kNatpMZbbw9w@mail.gmail.com>
 <aB0sVcjFZaCVEirH@lei>
In-Reply-To: <aB0sVcjFZaCVEirH@lei>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Fri, 9 May 2025 08:15:33 +0200
X-Gm-Features: ATxdqUErNzFir_a_9Z4P_nbDzGXuxiEZBA8G10NYVaeJMVl3oDEmeduioWXwZGM
Message-ID: <CAKPOu+89=+SFk1hKGLheMtPq+K47E9FRCo1DBQo9zGMwW=Tr2w@mail.gmail.com>
Subject: Re: [PATCH] security/commoncap: don't assume "setid" if all ids are identical
To: sergeh@kernel.org
Cc: "Serge E. Hallyn" <serge@hallyn.com>, Andy Lutomirski <luto@kernel.org>, paul@paul-moore.com, 
	jmorris@namei.org, kees@kernel.org, morgan@kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Eric Biederman <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 9, 2025 at 12:12=E2=80=AFAM <sergeh@kernel.org> wrote:
> ABI stability is about the most important thing to Linus, so yes, if
> documentation and code disagree, then we should fix the documentation,
> except in the case where the current behavior just really is wrong
> or insecure.

It is insecure indeed (can be abused for LD_PRELOAD
attacks):https://lore.kernel.org/lkml/CAKPOu+8+1uVrDJHwmHJd2d46-N6AwjR4_bbt=
oSJS+sx6J=3Drkjg@mail.gmail.com/
