Received: from mail-106119.protonmail.ch (mail-106119.protonmail.ch [79.135.106.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376A72D5408
	for <linux-security-module@vger.kernel.org>; Fri, 19 Jun 2026 01:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781831523; cv=none; b=QdvMBv/HX1aJolXezxDdl/4MhXSLgxd10BX4SsOFvNaUmGWvFXTnOZU9IAUEmnEvt4uqkyuSi4wgVrg1x2Binvg6fVWWyTMpFQ6dtqa//W5wDtk39Y6Hf6LpgjKhU/J1nvK+murjyBAvOFmCBbByN2ZMe56IhyYgHPZgIDTJiUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781831523; c=relaxed/simple;
	bh=UeM6pamAl4ywOpSLza3EOHnSPwbVt5s2v3DCHEFSi0k=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=dQc/Kdf8SFbvlZ8trAJcxBFFRs8+nLoM3utwV8cgQwWhlCEZyRyb0ieNU/c4R8osJLKCHrC3CdZ/6SZZxCX1OoUtj/BGrznqRYWVUJVbNWDw5YAyhik+aVZiuIDp392/G3xNgwFL0zo8lxnzs3FpqY22QU/jMDmNry8XdEn4V4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=bKmSPQh3; arc=none smtp.client-ip=79.135.106.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="bKmSPQh3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1781831517; x=1782090717;
	bh=2XNCRhy4uaOiOmuU4tNaw0+tI3srLdlDb52wwhIwtyE=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=bKmSPQh3YFC7+VcvZjA1WkrEP+cR0Qm/TV9Bs+WD4GbfYmkUJesx9dQbpOxNCy6qG
	 +FqeB/5z4MC9TJ+7vL1XLbL81Ky0dk9Y33nEnI4CdXtdfkItJBkD9AyopX26NOh00v
	 1cHwDWnseWc6LA54CuAAh5CwTSd+7Zcb3+D/bwMAreJgPxsAQIlkRgXSmNSWtFKSQ8
	 njnrng9zuSAAtG6tnCve30Djm9TnsRjyQNllQEJNa7SmhzxqfEP273HBcJdkj3pJem
	 7M6v/wjaze6mAUG/Ny+Rk7X+4ciucPGNxhBd2sDjlf8WCguFpSuUad3cKhrADGi7Wk
	 9W3pLKG4bhKSw==
Date: Fri, 19 Jun 2026 01:11:45 +0000
To: John Johansen <john.johansen@canonical.com>, linux-security-module@vger.kernel.org, apparmor@lists.ubuntu.com
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, Mickael Salaun <mic@digikod.net>, Stephen Smalley <stephen.smalley.work@gmail.com>, Matthieu Buffet <matthieu@buffet.re>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: AppArmor: TCP Fast Open bypasses connect mediation (last unaddressed LSM)
Message-ID: <20260619011138.264578-1-hexlabsecurity@proton.me>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: 07f0b31b3d290527fbe6492402348c1c56250175
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello John, and LSM folks,

I have been working on the Landlock TCP Fast Open connect bypass [1]. Steph=
en
Smalley's SELinux fix for the same issue [3] -- "Similar to Landlock, SELin=
ux was
not updated when TCP Fast Open support was introduced ..." -- made me go ba=
ck and
check the rest of the connect-mediating LSMs, since I had only been looking=
 at
Landlock. With Landlock [2], SELinux [3], and now TOMOYO [4] all getting fi=
xes,
AppArmor is the last one with the same gap and no fix yet.

Root cause (shared with the others)
-----------------------------------
security_socket_connect() has a single call site, net/socket.c (the connect=
(2)
syscall). TCP Fast Open performs an implicit connect inside sendmsg:

  tcp_sendmsg -> tcp_sendmsg_fastopen -> __inet_stream_connect(..., is_send=
msg=3D1)
              -> sk->sk_prot->connect()                 net/ipv4/{tcp.c,af_=
inet.c}

This never calls security_socket_connect(); the only LSM hook on the path i=
s
security_socket_sendmsg(). mptcp_sendmsg_fastopen reaches the same code and=
 is a
second producer.

AppArmor
--------
apparmor_socket_connect() requests AA_MAY_CONNECT; apparmor_socket_sendmsg(=
) (via
aa_sock_msg_perm) requests AA_MAY_SEND. These are distinct bits, and apparm=
or_parser
compiles them independently: "network send inet stream," yields accept mask=
 0x02
while "network connect inet stream," yields 0x40. So an egress-restriction =
profile
that grants send but not connect is bypassed by MSG_FASTOPEN.

Reproduced on 6.12.88 with apparmor active. Under a profile granting the in=
et/inet6
stream lifecycle except connect:

  aa-exec -p egress_restricted -- ./probe
  [TCP ] connect(2)=3DEACCES(blocked)  sendto(MSG_FASTOPEN)=3DOK(reached)  =
=3D> connection established
  [TCP6] connect(2)=3DEACCES(blocked)  sendto(MSG_FASTOPEN)=3DOK(reached)  =
=3D> connection established

(The coarse "network inet stream," idiom grants connect anyway, so this onl=
y bites the
fine-grained "allow send, deny connect" policy that the asymmetry is meant =
to serve.)

Fix
---
Same shape as the TOMOYO [4] and SELinux [3] fixes: in apparmor_socket_send=
msg (or
aa_sock_msg_perm), when MSG_FASTOPEN is set and msg_name carries a destinat=
ion on a
not-yet-connected stream socket, additionally require aa_sk_perm(OP_CONNECT=
,
AA_MAY_CONNECT, sk). I am happy to send that patch and the reproducer.

(A single core check in __inet_stream_connect(), gated on is_sendmsg, would=
 have
covered all five LSMs and both the TCP and MPTCP producers in one place -- =
the kernel
already mediates the analogous implicit-connect-on-send for AF_UNIX via
security_unix_may_send and for SCTP via security_sctp_bind_connect. But sin=
ce the
other four LSMs are taking per-hook fixes, AppArmor matching them is the co=
nsistent
move; mentioning the core option only in case it is preferred.)

[1] Landlock: LANDLOCK_ACCESS_NET_CONNECT_TCP bypass via TCP Fast Open (rep=
ort)
    https://lore.kernel.org/r/20260616201615.275032-1-hexlabsecurity@proton=
.me
[2] landlock: fix TCP Fast Open connection bypass (Matthieu Buffet)
    https://lore.kernel.org/r/20260617180526.15627-2-matthieu@buffet.re
[3] selinux: check connect-related permissions on TCP Fast Open (Stephen Sm=
alley)
    https://lore.kernel.org/r/20260618175513.112443-2-stephen.smalley.work@=
gmail.com
[4] tomoyo: Enforce connect policy in TCP Fast Open (Matthieu Buffet)
    https://lore.kernel.org/r/20260619002207.61104-1-matthieu@buffet.re

Thanks,
Bryam Vargas

