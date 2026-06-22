Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9D23CAE74
	for <linux-security-module@vger.kernel.org>; Mon, 22 Jun 2026 16:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.125.188.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782144106; cv=pass; b=WA9q6I8io+cXFCZ89WA3b0tfwCpIjXggEseCmHgXBfq6O7lQDXmuzmLRPtYRgtr+V7v+9B+ptf1rLutxMX0AZ4N5UOvTBmj7OMY0xxWAo6NrF1Bji/bVqhIomxqAyyw4pNC09DI7d2mdW04kzyU5OEfgmrVXWU0Dt+Hrscjj4B0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782144106; c=relaxed/simple;
	bh=rWkvd+EMjIgnvfIzdDWmMWyKR8/5ZcQUEU9ymOufTME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o5OBX34fCXDHHn0RrJvpgJZtnqGRNGJ/lWUdHpJBbUDXJdm+dW54mkX5yuuNmSoXiHdETlfKYmL9y6aBe3KT9pnOtji0P2IPu0raoU6mzj4cLM2zT6z8hFfauWypRmzNPDSATtvJYQAz0DABuvjCLZy//37xRDPh8rkhur/io5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=Lmf6gMR+; arc=pass smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="Lmf6gMR+"
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com [74.125.224.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id CAB593F2C5
	for <linux-security-module@vger.kernel.org>; Mon, 22 Jun 2026 16:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1782144101;
	bh=GNnUNGcYlXek1bndNKg8h/XCXP07hZRUxLwxIa672vQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=Lmf6gMR+ZbN19UD8rSvppcXnu/wjU7DxSOeDHs0y172SRfQk7t5oTcrSZVTtY4PWG
	 P+AgYrOWav8TIB8Z6ReJ8Nx+MZ+OpBom4/d8NCcDh+KitsgOVS8JPdnj57HavJ7I7c
	 CCqH09ucaFFLzLIbPy/O/1VAMHBkEMehH8RiEix5NJEnNgDs5eg0uTlI+u1hTqcj9d
	 wBSLhVS0GcE6ZJpqdQK1ZWkDCuiIkUkqVI3vT+5SglGid7pBO1yhGHiZ0KkhNzsGnI
	 iwmzlvFawwUbBB+QIoDmvwFh+9lrc6gUT4M3+lN1zjvzf4u5hYC71LXkRVweYFZHKw
	 kzJPCZvq/awLDh8gNWJ7hu4Dg/+p2AlcomRsp1PcoPem5g9ZO3W2mft+59TSqBndcg
	 ewsPDNrQXBDWYPqNDWTXVMfsyTQSseNI9e7zjDa9QRFoU4xqfOV2lGZkx0i901INRM
	 fMBTnsKdygC61rgVqcCuec6b05+MeLloUF7SekxrQR31SRgdPIGnjqG/gr7Pu5b64t
	 kragVRRzym2AnUFzQiV19VM/8uM4f4ZPQ3SXRRETUccl/Y+jHbaZDsQK6Hp2lDV8xJ
	 JoZi5/bLj9eCi+++OyfVOZyzus17KuG/FH3k4rnSKsXJR6KL6pGkFWd4k1BuK6hGqI
	 THxqx2RgUdmBq7yrxjKCdVqM=
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-662d529d315so5774893d50.0
        for <linux-security-module@vger.kernel.org>; Mon, 22 Jun 2026 09:01:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782144101; cv=none;
        d=google.com; s=arc-20240605;
        b=hUYlOQCwk4rqrJW86rRt17cR/izd2U+6iwONui0h5VGg9/uRk4WY3VL7CrgKtWfJzt
         sD4eE6JkOQ9AUxMfZDzjDRoM/dp2aKCpLi9rgKjnRkCQcGHU2ZO2+sp7Y4xp770FJFI/
         xESqXQMDjdz1RoDIL4e2WMDrfR6rQ8YJ+hznB3FgG9YTRHHR4abANCSulDgVSHKZJIdW
         iD+xkEHTIeh0WN6yiU5pCYNjQU6F15jXwVOESZMrXkayk7lDiMwzj+12MZmMO9z8Wzl6
         0kuJKdwInF134PwhnOT/vTt0T1lXk8cie+wcZNfAyWdxtYAVg3J6OZx+arNV8b6Uk/pI
         qufA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=GNnUNGcYlXek1bndNKg8h/XCXP07hZRUxLwxIa672vQ=;
        fh=cydRAoMwR5mX37yF1IeMbS5+jVfhIazePT6W7uaZ/3Q=;
        b=b6s7Kvp+8LMfX/Syfo/tec36bu3O6Hrir8P5wqqNBp9tez4e3wrgvKITXSB1C8qo0l
         F70mVdcVuXVvCpRNY/hCux61EkSXXb9Y6LAqETHa+M3JQ9Twx6wpmwBS542gMZ48t4hr
         uxE7RQ5W04CTfkNhh3M2zC+jxuQWrBdX94Q7BUkAc1o0bkbSuYhzuzDL83Lvz4GrYnTf
         7d1QSLva3tl9chDn5BItK2vkkGW1cETmcomPTx+spzyWB7q9rKruhu6w5+6JPtPGV6cM
         RTerqzefMhptMqAMcBy8CAtlgCDKmn6JoKKuKDXRAbDBlzS0YcCA4Ppi8HuZhxYXiTdf
         HHTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782144101; x=1782748901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GNnUNGcYlXek1bndNKg8h/XCXP07hZRUxLwxIa672vQ=;
        b=rjg5IFAn/kwALU6DnvK5WAGn7FTebNCXkJ1ZheK/GYgmf1ObYGYqiwwmrhLO4hbn36
         C5jXOdb/YeBbkqhlMmsfN2Qn+r8PQIGMoDAXe9JQwdOKOs1vg5t+/btRz0BGmvW5rXRB
         y0mxWONQMDBrJ+Z9Nn2l9f0creFyW8PbubEM2lbirUmGE1obKaEx3ecv8ma046B27RKV
         6vAd/piWKVs34SgR3rCkYTfEAuQDB3l2vIJyAH2oLWNcM4tADenXfanKRv/yUuQEpm8Y
         VpOxznIGq6bIWdETSJlzBFLY8lrKBNft/mQSy3JvRGq5XDEq1kItE6yDFZ9SoNmUlnWv
         x2lA==
X-Forwarded-Encrypted: i=1; AHgh+Rr8WOX8lMBRcTCQMXDGG9Cz9+rKxix6JwYuvoRkYD3yykHEFJ6qntnUV4ZgCr+aiQEiqw2OvjkXaW11j/PY4Oqa1pk9Oe0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnWxN4SQMyunYqr+CtIg/pkdp5wHOXqWTP39fv0j73B/clpoTM
	G4RgwmmeGyMVXHCw9RB5Jw+ysT0SQYPd6auYRD+20lk1Vo8Z9nIOjt5B/vStOBjI9CiQnEvpaln
	SSUsT0chD/uKA6I8iEGsA/ql/sRN747fNt6p+yWT5US0VnQlOs40gkbGzPypgAwSy0XrZVzonQ9
	qdFQ/fuFkIDoeZAOeNtmgcDVtHhQnPwWJmDYs5/hQ9B9F5FzJO4ZIV8QAtK5t03rsNUy8b
X-Gm-Gg: AfdE7cl8N1wt5r1+pWSaw6cLL4V5V3QBURactJJPJyvDGtZ4erlsC6TvRbsI0tVrS7Q
	DwWgq/7mgxTNedw+rdwNvSSReUyGSITBfrsIZ/IcDyvByWHy3q9ZL2A1Gvl/hvan6E50RxZ9Oev
	zYDQB1HrckyX9kEzsLsWLMMAnVu5/buiC2NMKlVgQpakAR+7mhSbagkgIOFIhy1FJYUw01I7imz
	PhrACQlZ1aDeaaw9JmJw972Fz3yyLtXZb+ooI/p8q+kWQCbYZfclFBG
X-Received: by 2002:a05:690e:130c:b0:660:6a0c:c734 with SMTP id 956f58d0204a3-66312db92d3mr9612966d50.17.1782144099205;
        Mon, 22 Jun 2026 09:01:39 -0700 (PDT)
X-Received: by 2002:a05:690e:130c:b0:660:6a0c:c734 with SMTP id
 956f58d0204a3-66312db92d3mr9612779d50.17.1782144097184; Mon, 22 Jun 2026
 09:01:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260619011138.264578-1-hexlabsecurity@proton.me>
In-Reply-To: <20260619011138.264578-1-hexlabsecurity@proton.me>
From: Ryan Lee <ryan.lee@canonical.com>
Date: Mon, 22 Jun 2026 09:01:25 -0700
X-Gm-Features: AVVi8CehioJRX4sF0fHaXxWwQZ817Vualcvqp9lWndWRp8Tl9cr736Ah3GtggiA
Message-ID: <CAKCV-6vvVcVNL0EDGss7jMUV8nqM8nNWrbCZ5Teq7u3jSM3JvQ@mail.gmail.com>
Subject: Re: AppArmor: TCP Fast Open bypasses connect mediation (last
 unaddressed LSM)
To: Bryam Vargas <hexlabsecurity@proton.me>
Cc: John Johansen <john.johansen@canonical.com>, linux-security-module@vger.kernel.org, 
	apparmor@lists.ubuntu.com, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, Mickael Salaun <mic@digikod.net>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Matthieu Buffet <matthieu@buffet.re>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2026 at 6:12=E2=80=AFPM Bryam Vargas <hexlabsecurity@proton=
.me> wrote:
>
> Hello John, and LSM folks,
>
> I have been working on the Landlock TCP Fast Open connect bypass [1]. Ste=
phen
> Smalley's SELinux fix for the same issue [3] -- "Similar to Landlock, SEL=
inux was
> not updated when TCP Fast Open support was introduced ..." -- made me go =
back and
> check the rest of the connect-mediating LSMs, since I had only been looki=
ng at
> Landlock. With Landlock [2], SELinux [3], and now TOMOYO [4] all getting =
fixes,
> AppArmor is the last one with the same gap and no fix yet.
>
> Root cause (shared with the others)
> -----------------------------------
> security_socket_connect() has a single call site, net/socket.c (the conne=
ct(2)
> syscall). TCP Fast Open performs an implicit connect inside sendmsg:
>
>   tcp_sendmsg -> tcp_sendmsg_fastopen -> __inet_stream_connect(..., is_se=
ndmsg=3D1)
>               -> sk->sk_prot->connect()                 net/ipv4/{tcp.c,a=
f_inet.c}
>
> This never calls security_socket_connect(); the only LSM hook on the path=
 is
> security_socket_sendmsg(). mptcp_sendmsg_fastopen reaches the same code a=
nd is a
> second producer.
>
> AppArmor
> --------
> apparmor_socket_connect() requests AA_MAY_CONNECT; apparmor_socket_sendms=
g() (via
> aa_sock_msg_perm) requests AA_MAY_SEND. These are distinct bits, and appa=
rmor_parser
> compiles them independently: "network send inet stream," yields accept ma=
sk 0x02
> while "network connect inet stream," yields 0x40. So an egress-restrictio=
n profile
> that grants send but not connect is bypassed by MSG_FASTOPEN.
>
> Reproduced on 6.12.88 with apparmor active. Under a profile granting the =
inet/inet6
> stream lifecycle except connect:
>
>   aa-exec -p egress_restricted -- ./probe
>   [TCP ] connect(2)=3DEACCES(blocked)  sendto(MSG_FASTOPEN)=3DOK(reached)=
  =3D> connection established
>   [TCP6] connect(2)=3DEACCES(blocked)  sendto(MSG_FASTOPEN)=3DOK(reached)=
  =3D> connection established
>
> (The coarse "network inet stream," idiom grants connect anyway, so this o=
nly bites the
> fine-grained "allow send, deny connect" policy that the asymmetry is mean=
t to serve.)
>
> Fix
> ---
> Same shape as the TOMOYO [4] and SELinux [3] fixes: in apparmor_socket_se=
ndmsg (or
> aa_sock_msg_perm), when MSG_FASTOPEN is set and msg_name carries a destin=
ation on a
> not-yet-connected stream socket, additionally require aa_sk_perm(OP_CONNE=
CT,
> AA_MAY_CONNECT, sk). I am happy to send that patch and the reproducer.

We would appreciate having the patch and the reproducer to look over.
Ideally, the reproducer could be integrated as a regression test into
the upstream repo at
https://gitlab.com/apparmor/apparmor/-/tree/master/tests/regression/apparmo=
r?ref_type=3Dheads,
but we can also assist with that step.
>
> (A single core check in __inet_stream_connect(), gated on is_sendmsg, wou=
ld have
> covered all five LSMs and both the TCP and MPTCP producers in one place -=
- the kernel
> already mediates the analogous implicit-connect-on-send for AF_UNIX via
> security_unix_may_send and for SCTP via security_sctp_bind_connect. But s=
ince the
> other four LSMs are taking per-hook fixes, AppArmor matching them is the =
consistent
> move; mentioning the core option only in case it is preferred.)
>
> [1] Landlock: LANDLOCK_ACCESS_NET_CONNECT_TCP bypass via TCP Fast Open (r=
eport)
>     https://lore.kernel.org/r/20260616201615.275032-1-hexlabsecurity@prot=
on.me
> [2] landlock: fix TCP Fast Open connection bypass (Matthieu Buffet)
>     https://lore.kernel.org/r/20260617180526.15627-2-matthieu@buffet.re
> [3] selinux: check connect-related permissions on TCP Fast Open (Stephen =
Smalley)
>     https://lore.kernel.org/r/20260618175513.112443-2-stephen.smalley.wor=
k@gmail.com
> [4] tomoyo: Enforce connect policy in TCP Fast Open (Matthieu Buffet)
>     https://lore.kernel.org/r/20260619002207.61104-1-matthieu@buffet.re
>
> Thanks,
> Bryam Vargas
>
>
