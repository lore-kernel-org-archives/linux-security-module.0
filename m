Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch [79.135.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCF123395D
	for <linux-security-module@vger.kernel.org>; Thu, 18 Jun 2026 01:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781745954; cv=none; b=u+sjzHHuQA0aX3b4XoYT5MVfhHp4QE0j0jtP1B7nB30bJ5wXPKqnVk5A0rQr6XjO7u79UIePZODX/LAJhtvsbd72s6eno/i/kFyNNor6kXKugF3VptNNe1Ul8f9IkdsEuuougjhS8H/rpKj6bwfTn+sQ6bXOo6oEO7gKx8IhfN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781745954; c=relaxed/simple;
	bh=O7p1A7X5x41GXGfzPlhDFe+3UIbQXqLuJwmu7r/FXcw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A7MNF0DDVA6sxZfXqW613bqK43VBmrk94zDg4UC8OeRqUVf2JudlVA1yTeevTHlML5a0bXyRU5zBX+zgjnM+i2e8rq92VZO9mQrodErDF8No6YuSb61CicSwh373FdoMvwgWL8M2fKuAdT6PiDczHhQ4nCksyx0dj910Rrg/Chg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=YeUMjgq5; arc=none smtp.client-ip=79.135.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="YeUMjgq5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=edji6ohfindvvaar3ohyzfy2dy.protonmail; t=1781745941; x=1782005141;
	bh=O7p1A7X5x41GXGfzPlhDFe+3UIbQXqLuJwmu7r/FXcw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=YeUMjgq5RCVdTetuI5yb34xTm4SMkHOuDClbFAfs5Ia6sDybWU4ryD+E3fJfzyyzs
	 IvMClPTp/YWHfFU5HTpTVf/3jQKYWRwaiTLsEBdmZW7B/UVqm44mJLznK4LqYm5wLm
	 KTq3KpaOk1F2d5bHhXZBzowUcbN1XKo1k4YsZqFvyD+Nm+QtXsG8E6NvbBnRiG79WL
	 AgvC8HDQa8bbquptr+yIj7f4RWbjWioZg/Kdi2L2ZA+o+G5736Ee6iCGRKO8s2iKQ4
	 TIxSV2Mv7SU6q59mBtbNbA0PLtJJCZgsRBW/tSW6Y0yjIUSFSKmcMbanyyJeM8xWk3
	 lQ3cFAKuVSKtw==
Date: Thu, 18 Jun 2026 01:25:33 +0000
To: Matthieu Buffet <matthieu@buffet.re>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, =?utf-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Paul Moore <paul@paul-moore.com>, Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, linux-security-module@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] landlock: fix TCP Fast Open connection bypass
Message-ID: <20260618012527.34964-1-hexlabsecurity@proton.me>
In-Reply-To: <20260617180526.15627-2-matthieu@buffet.re>
References: <20260617.eemahv8ui7Ee@digikod.net> <20260617180526.15627-1-matthieu@buffet.re> <20260617180526.15627-2-matthieu@buffet.re>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: 578dcb4dea7ac936c800840fb4f141f9fbb80230
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thanks Matthieu, your #41, so no competing patch from me. I built your v0
(Landlock + MPTCP) and ran an A/B: without it, a confined task with CONNECT=
_TCP
denied still reaches the port via sendto(MSG_FASTOPEN); with it, that path =
is now
denied too, on IPv4 and IPv6.

Tested-by: Bryam Vargas <hexlabsecurity@proton.me>

One scope note, since you mention MPTCP: an MPTCP socket isn't covered.
sk_is_tcp() is false for the mptcp parent (sk_protocol is IPPROTO_MPTCP), s=
o
neither the new sendmsg hook nor the existing socket_connect one mediates i=
t. On
the patched kernel my MPTCP arm still reaches the blocked port via both con=
nect()
and MSG_FASTOPEN. If MPTCP is meant to be in scope for CONNECT_TCP, the gua=
rd
wants `|| sk->sk_protocol =3D=3D IPPROTO_MPTCP` (not sk_is_mptcp(), which i=
s the
subflow flag).

Bryam

