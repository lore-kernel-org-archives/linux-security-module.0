Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8F83DE441
	for <linux-security-module@vger.kernel.org>; Mon, 23 Mar 2026 20:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774297622; cv=pass; b=DvYs1avGsoKM4YR5oLuljtRhA/xhcc1rRN2OJIUOAZ9nndnfjLLseIkbLjO1XczbhkWadxp66o1zJ5ddXBy3X9LphO/U0kfSq5GEVfABh5IBIExW/eyq/1roNNsKthkBHjRnTznVvqkqFvjsLbPY0S651V6U5Un1QTkggSHZo/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774297622; c=relaxed/simple;
	bh=UHRNSR/Znkl84N7M/0cd+OulIZWBWecvpme/oncGlAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RkxkaMMS7JO6Lb3Arz9MLW03lsnx6UiVrbSqkEbthR7ZB/TgRxeNgxHm9Z8zWXHk2/3QsIjWbgCEqT9ZXd72M2JhI5kZ+0Cbb5w3Gw9wldswPpRjc9x1Q0CrVMVbTLCfXeOrU4bu3zMmTV6U8gOwIwS5JIP/qV98AQwdTcXaJeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ai8JpGUz; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ai8JpGUz"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2b05761bec1so25418005ad.1
        for <linux-security-module@vger.kernel.org>; Mon, 23 Mar 2026 13:27:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774297621; cv=none;
        d=google.com; s=arc-20240605;
        b=lOOkcHOnTSal5sMf3eFm+MK1T3qv6z0qPjfLr95zoFmg0OxICEQZPf0Ovk34BDO3xu
         KhQSnyOXB9Xtgn34zzrMSkqA7/JRnad8EwKserozZIH0PzrRc37//5qXCgDL3d4hvBCB
         KFfgw0X6W6ouWCiFkabSx6iWkyERtbHMSKQRKg89bJ+QOn5qdme71Bx7RP1XKRMmiTc2
         MLe0YqOqA86/21NmUNF3Wcc8UARnFvmgqF11IS2Egr+n/FGmIV1MLA1XNer1vhPUdqp1
         8nOyz9h9RZOrf+j0YYB9ma3mbTdv3BXim3Z1abxoJ+i//G8RRsQ1GR7Z03aZCXUZmwPR
         u7Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZnSiO6nUBeAvL7zsJIx3NN22KTDnl+zg3ihQoV58SNo=;
        fh=lWf45icr0s8Gd8vShaZm5/eoWpMHTtFMUHnDtGGRcnk=;
        b=NliHRFR/v8zVSJWfePTIA1M4bGa+TywsAgG8r9WYM+mufFyeueqHyXgjsbFSIFebw7
         ASLnrx7whKUR1mrCWiK5C3pVr35VaDaL3iGNuhI0m4xUU/r58Zh0wwosYYn2AbntsHvh
         czZRXitqmTj0hozSWRYH4X0DwAyj18ail1m5F9wh4AcMVADgB09P83mpNLZeTI/o5ZaV
         uTnmF7Svgm3m2I+KOw8sw+A7ArNuMgCP1CSXpcuvkN1Gg2bslzIrhVtvGPqzkcsFawc5
         vOwhH+3rj3OeM1vPjNFgWbA/UZgsktxBetHNxS/7+2fWdqz2rhEhOMDzFugM/cCCgSUK
         YaQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1774297621; x=1774902421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZnSiO6nUBeAvL7zsJIx3NN22KTDnl+zg3ihQoV58SNo=;
        b=ai8JpGUzDh4wEN97Rwn2orkMMxRddfpLxwlV6T46cC027BBLYwBQPiDJCy2qdbDVGy
         cJ0P2zTk+ShP39YJOJ9FH9s6/oZVuRZPARnM+aXU2TXXACT2r3y8UoUbNyHa3u8HSUlQ
         aKqqfsHoNKqIhI7LLQU7pDtWu75QMmDLv12EI55sNWktKDOAWmp49IbhgeBJCfz9eghD
         65zpBbaHMvV5dnO4pKkCh/a1l7cNNMIpAP/yYg1eXcyJVmkAefdR7w5JiAOB1NLh6Gd8
         3jqVoiq8oaJUd9DCM9oCOOPNfAo58HloHZVZRqKI3YfSV1agt/j9GGKVmJutXp7ye7tm
         qOgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774297621; x=1774902421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZnSiO6nUBeAvL7zsJIx3NN22KTDnl+zg3ihQoV58SNo=;
        b=YmorDrpJDI97GvWioIKlbDgQZts+wNAXG/+me0xoawLCVUURLEuy+0a7e0VVTEIq2y
         pH+LIDdjT4CODi4Gl0Ib2YvWiCk1dwOqwc7L9LjSPen+a1y1A8WthBus1TPQIZ2fwofg
         +kHNCtrVoMVq/b4mouACVCn1FWmaCdo4mYiswgyMUbVurrc6ALrkg2I5bLmXZQ78+Jof
         bpGB4G3oKyLGTw+5C15tfkknU2dNofIOK6IkUMq9yyzIAXL5OaljDrqqmLz18vNiOHPj
         Pvz8RR7juv+H9/q5P0HrxIOyu1IkYge35f+Vko4g38jqwQ4QdI2FYfFa3OddRrnq4f+h
         S1Nw==
X-Forwarded-Encrypted: i=1; AJvYcCWMbeLIYPJsZZA3x1YqVDlAiS4Cyt/nLuigPqLHk9yQEiGRsT46lMkWGp//1QF4TF7QPGQaAxd7vfkYq7IQ/UZXUav+K1o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx041kgKkSDTHYPWFMpWjng7lZSISfkuZ3hdstXVed4r8eHpcnH
	GB2+LsTaLAkAwYw+yNlX8EueTF8sCmcF4yxb1uHPvFL8fXH837bTsGkMVmwubG3LpxuSleOITN1
	PVzB48Lg3fwbQw0/QU+Ud6qtD/XRMJ1V0DlX/JWoi
X-Gm-Gg: ATEYQzzLFt0tn++dQkMJhw9qKZtv8KK2QM1PN1CA1E3SGzEGzBYMWJiYObQ8iAaE4Lq
	3AKCnCU/HlMFi4c4B97KmXEfSJXm/k8wOjfKZ8qHQ5HoRtRj8xd2tu+bJWm3+xqa8UKif1RjBCb
	sSRS+9JWedgWqdD81YqzYwKHiuJXdVnS7ha2qwMs1tbY0tKuAYaRE977LOIeXonAvrfdSOUvlaE
	XEbFfgfS6TlLfCSZePMzEtWVrK51/d9Nf8MIDZkM5eX3tk3g6yt2hPWNHS2rSD+u57mV0sz3dRQ
	i8O+ELk=
X-Received: by 2002:a17:903:22c9:b0:2b0:6488:4957 with SMTP id
 d9443c01a7336-2b0a4e6de6emr6779955ad.30.1774297620908; Mon, 23 Mar 2026
 13:27:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323165654.193957-1-gnoack3000@gmail.com> <20260323165654.193957-2-gnoack3000@gmail.com>
In-Reply-To: <20260323165654.193957-2-gnoack3000@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 23 Mar 2026 16:26:49 -0400
X-Gm-Features: AaiRm51p_92OOnZQnlg3seLDMJD1HFGdB1xy5D_9YA69tuaEOd66nQudPa_lIxQ
Message-ID: <CAHC9VhSovqp5wkB0Lkj14kR_WB2PhBNN4h4jXwXZ9=eCDSrNNQ@mail.gmail.com>
Subject: Re: [PATCH v7 01/11] lsm: Add LSM hook security_unix_find
To: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	John Johansen <john.johansen@canonical.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Tingmao Wang <m@maowtm.org>, Justin Suess <utilityemal77@gmail.com>, 
	linux-security-module@vger.kernel.org, 
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>, Matthieu Buffet <matthieu@buffet.re>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, konstantin.meskhidze@huawei.com, 
	Demi Marie Obenour <demiobenour@gmail.com>, Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>, 
	Tahera Fahimi <fahimitahera@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 12:58=E2=80=AFPM G=C3=BCnther Noack <gnoack3000@gma=
il.com> wrote:
>
> From: Justin Suess <utilityemal77@gmail.com>
>
> Add an LSM hook security_unix_find.
>
> This hook is called to check the path of a named UNIX socket before a
> connection is initiated. The peer socket may be inspected as well.
>
> Why existing hooks are unsuitable:
>
> Existing socket hooks, security_unix_stream_connect(),
> security_unix_may_send(), and security_socket_connect() don't provide
> TOCTOU-free / namespace independent access to the paths of sockets.
>
> (1) We cannot resolve the path from the struct sockaddr in existing hooks=
.
> This requires another path lookup. A change in the path between the
> two lookups will cause a TOCTOU bug.
>
> (2) We cannot use the struct path from the listening socket, because it
> may be bound to a path in a different namespace than the caller,
> resulting in a path that cannot be referenced at policy creation time.
>
> Consumers of the hook wishing to reference @other are responsible
> for acquiring the unix_state_lock and checking for the SOCK_DEAD flag
> therein, ensuring the socket hasn't died since lookup.
>
> Cc: G=C3=BCnther Noack <gnoack3000@gmail.com>
> Cc: Tingmao Wang <m@maowtm.org>
> Cc: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> Cc: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> Signed-off-by: G=C3=BCnther Noack <gnoack3000@gmail.com>
> ---
>  include/linux/lsm_hook_defs.h |  5 +++++
>  include/linux/security.h      | 11 +++++++++++
>  net/unix/af_unix.c            | 10 +++++++---
>  security/security.c           | 20 ++++++++++++++++++++
>  4 files changed, 43 insertions(+), 3 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
