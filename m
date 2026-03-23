Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589733ACF03
	for <linux-security-module@vger.kernel.org>; Mon, 23 Mar 2026 14:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774276641; cv=none; b=khLMdgvdJUNRpOxvVJVWsfh9E9GPxldB2eZf6LjnZ/GrWX1SUmA32qB2Yg0hDOwCVkWVHqV66mIStbIQJKUYpJ95vBuHguM9twTODyPvZg5Ck2RnnW6cJ1/ECl7PTYvTXd+p9UpdKv3wnD9RIEoiUYuEQszaw4VL1kGMoWqz/xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774276641; c=relaxed/simple;
	bh=DMbXMglMLqexRK4r59KM1pp/3lF7vZDIbIOMtAtTbgE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NCg1hTHmafjWDlBLAxz3L+jHLPguZtXjacePuEpPkRqe4MX1X8zAGv8U/cF9s59p4OdTZARKltHAL3zpi2eEWh+mLxn4pUzZ/kY1qgm+aWOIfIx/nkAyS2hIz7JnfWlTu//QGOXZHkZNazRWKOFTogrURG2GEtXUHTw3mrMJAGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=l22AxLEr; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="l22AxLEr"
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C7F1D3F99B
	for <linux-security-module@vger.kernel.org>; Mon, 23 Mar 2026 14:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1774276637;
	bh=r6tGJUi7Q/sk2IlSUmmfPbgFRMDmCLVna/XK1xDxun4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version;
	b=l22AxLErkOBlJXTzaCNohkYAAmjM3ri214Ld7Nx888alsBq8rgKspgmhIJ8mIAq6V
	 jevWFABxX42KOOxoI+A5uSs9fCxL0P6DpwQdeQilzg77n6qlfV9lqNcmfWi8GhFGkT
	 AWb0NFd2MKLf82/wudfYQbNdhU1PyrZkUlNzSuuVZiY0/RXxxcEyVFWsjqVD3fWsf7
	 lBMF3LfEJsiT1WdtwrVA/ld0gsKXX2ggIywbXcXfjr3e/0uA5mMn4Di+BFVP8M7prv
	 IHTLN7n1Ucf92S4Cm3egrM//rqtf7s/chAmiVex/MvhTN3+dq+SsmIQkEKqmMtZAEy
	 3X0LWkiexr2x15loq4dlkWMtOojfcWfcP8417UQNNMYt3h+9U7R78FWr4atV3Tbsyz
	 yofqHUW2/yA51V/2OX2YNR7l8zZeyPTqoAibIuiqsKp8GgaS1EylgvMPTzBCiMTM7E
	 xGLgApyTOZI3RaLBT3BabsMPEeDQYiU9J6d0cLswFVbx48LrPsffEuBP+9RQ7MyRkc
	 GwVtDGiSOXKPeQMkEt4CaoLxS48Hfw+mZGkv7hN0B6VXZAMQI/UJnm0EvovqES2RZg
	 Ar6vQdAiTaHyySpouFX+6qIts4uHWac2U/Ot66qjNNPzmiXvmRHYIFCa5ENn+xio5i
	 rb/pn0WNt67P2qT4WwtdgWuo=
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-12711ec96fbso2487170c88.0
        for <linux-security-module@vger.kernel.org>; Mon, 23 Mar 2026 07:37:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774276636; x=1774881436;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r6tGJUi7Q/sk2IlSUmmfPbgFRMDmCLVna/XK1xDxun4=;
        b=MO8S7erhdQu3vzUPtgPvwMhmkssWTu//sP5ZFswficErYEzrSg7Jgbo+4Whx7Eh1YT
         IQZc4kOnR9HgTpdd8oAB0BqAxmb4J9EuUG4yXTogm7FpGDMKmM/wvy063paZGomzMAU0
         7EmCREcpxTBt56+sGT0+Kc8H7wt9wy18T57dDvysUleFEPplVzFomKRRDg+j+b4gE/h2
         IPSmE78WFSzU5xa8ma76mRXgDfHS3kH8XzS2/2IbBld1tcwqkhu1YX+aaC5Ygc4o4i82
         s4BhE5+puGF6miUYuGwLd6PU+FDh5NjRacsvd/5cqof80NIKRxcSqx/ZmcZdE6rnrXf9
         BKnw==
X-Forwarded-Encrypted: i=1; AJvYcCWgmKh+OcP1y+rP2UIM1srmc5MpUzolt9nc3xP0Rzp3J0/aZeJuY5zJvIHh/bYHr65tWs890smfbOK2YJTAZ1U8/XHLd9A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1mLnOVRxtX9B4PievuPoLFtrnCsysaRJX41fcicVokpCp44e4
	wAT2R36TSZPXTMtnUT+piv8mPaE9RT/rsoX3Ss4uXn/qLR3q8mDOk125D2yFY1tgX+WuCJxCjl1
	98ldenug5FGhslDblKFdya7h2GyAbwRWwboxwrOl4/AS0l0G4s25zkrHuHzl+9vu8YOlND0Cga8
	P1wbVcSAZTLyBI57JM/A==
X-Gm-Gg: ATEYQzweYIybyDZ+h7JJxny3wSUs18ZzON7hy+LwyOJF2+G/MwY9BiCrxxVIYR7d+3M
	po/CPIDqJSASm9gQMq9f0wIPTQu0TX5+mk+Bj5DmSpWkBP6T6vjn5wsbVRjT30m+zc3I79H2tHz
	NrEfcVg8o/0K6Abap3CqiisUrnceGCju3rS1L1WWhiZUYPk2rQ6UNQNzCGhf9AjhsfLOBBs1Avx
	LNCzsrqobKHFikQxM1JoG11RhjCA9r7YbEIzxKH7H6huQdU670mlwFpenLM5h/U3MznrPfs/XMV
	tjFZBfJIORPwAwXkS86BZILZslwIDoQTFjwLHVHpa34xjxuGtpSCiBDB+aqDOnpelXRv6L2+heM
	IrOqF7DqjZWNv/iO6ZTMG2een8d2Z8ntUDwT7t/VnSa3mqnDKzXQavTNNJKlxKOSFc84cIA==
X-Received: by 2002:a05:7300:2382:b0:2c0:d04c:a6a7 with SMTP id 5a478bee46e88-2c1097c0a34mr6039342eec.28.1774276635950;
        Mon, 23 Mar 2026 07:37:15 -0700 (PDT)
X-Received: by 2002:a05:7300:2382:b0:2c0:d04c:a6a7 with SMTP id 5a478bee46e88-2c1097c0a34mr6039319eec.28.1774276635388;
        Mon, 23 Mar 2026 07:37:15 -0700 (PDT)
Received: from [192.168.0.106] ([187.95.108.133])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b29d28csm15436900eec.19.2026.03.23.07.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 07:37:14 -0700 (PDT)
Message-ID: <c3fccd822db5fc76b7fab00a9515eb276a71b421.camel@canonical.com>
Subject: Re: [PATCH v6 1/9] lsm: Add LSM hook security_unix_find
From: Georgia Garcia <georgia.garcia@canonical.com>
To: =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>, John Johansen
	 <john.johansen@canonical.com>
Cc: Paul Moore <paul@paul-moore.com>, =?ISO-8859-1?Q?G=FCnther?= Noack
 <gnoack3000@gmail.com>, James Morris <jmorris@namei.org>, "Serge E .
 Hallyn" <serge@hallyn.com>, Tingmao Wang <m@maowtm.org>, Justin Suess
 <utilityemal77@gmail.com>, linux-security-module@vger.kernel.org, Samasth
 Norway Ananda <samasth.norway.ananda@oracle.com>, Matthieu Buffet
 <matthieu@buffet.re>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
 konstantin.meskhidze@huawei.com, Demi Marie Obenour
 <demiobenour@gmail.com>, Alyssa Ross <hi@alyssa.is>, Jann Horn
 <jannh@google.com>, Tahera Fahimi <fahimitahera@gmail.com>, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>,  Kuniyuki Iwashima
 <kuniyu@google.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org,  Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>
Date: Mon, 23 Mar 2026 11:37:07 -0300
In-Reply-To: <20260318.In1aekohyivu@digikod.net>
References: <20260315222150.121952-2-gnoack3000@gmail.com>
	 <2697b9f672967b1318630f2ffa21914f@paul-moore.com>
	 <20260318.In1aekohyivu@digikod.net>
Organization: Canonical
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello,

On Wed, 2026-03-18 at 09:48 +0100, Micka=C3=ABl Sala=C3=BCn wrote:
> On Tue, Mar 17, 2026 at 05:34:57PM -0400, Paul Moore wrote:
> > On Mar 15, 2026 =3D?UTF-8?q?G=3DC3=3DBCnther=3D20Noack?=3D <gnoack3000@=
gmail.com> wrote:
> > >=20
> > > Add a LSM hook security_unix_find.
> > >=20
> > > This hook is called to check the path of a named unix socket before a
> > > connection is initiated. The peer socket may be inspected as well.
> > >=20
> > > Why existing hooks are unsuitable:
> > >=20
> > > Existing socket hooks, security_unix_stream_connect(),
> > > security_unix_may_send(), and security_socket_connect() don't provide
> > > TOCTOU-free / namespace independent access to the paths of sockets.
> > >=20
> > > (1) We cannot resolve the path from the struct sockaddr in existing h=
ooks.
> > > This requires another path lookup. A change in the path between the
> > > two lookups will cause a TOCTOU bug.
> > >=20
> > > (2) We cannot use the struct path from the listening socket, because =
it
> > > may be bound to a path in a different namespace than the caller,
> > > resulting in a path that cannot be referenced at policy creation time=
.
> > >=20
> > > Cc: G=C3=BCnther Noack <gnoack3000@gmail.com>
> > > Cc: Tingmao Wang <m@maowtm.org>
> > > Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> > > ---
> > >  include/linux/lsm_hook_defs.h |  5 +++++
> > >  include/linux/security.h      | 11 +++++++++++
> > >  net/unix/af_unix.c            | 13 ++++++++++---
> > >  security/security.c           | 20 ++++++++++++++++++++
> > >  4 files changed, 46 insertions(+), 3 deletions(-)
> >=20
> > Some really minor nitpicky things (below), but nothing critical.
> > However, as we discussed, I would like to see the AppArmor folks commen=
t
> > on the new hook before we merge anything as I know they have an interes=
t
> > here.
>=20
> John, Georgia, we've been discussing this new hook for a few months now
> but didn't hear from you yet.  We plan to merge this patch series with
> the 7.1 merge window (in a few weeks), so before that I'd like to merge
> it in -next in a few days to get a broader coverage.  I'm pretty sure
> this hook will work well with AppArmor too, but could you please take
> look to confirm?

Apologies for the long delay replying. I have looked it over and I have
no objections on the hook, it looks good to me. I would prefer if we
got a reply from John as well since I'm not 100% confident but he
should be out this week. In any case,

Reviewed-by: Georgia Garcia <georgia.garcia@canonical.com>

Thanks and sorry again for the long time to reply.
