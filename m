Received: from mail-10697.protonmail.ch (mail-10697.protonmail.ch [79.135.106.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831D63C1974
	for <linux-security-module@vger.kernel.org>; Fri, 10 Jul 2026 13:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783690840; cv=none; b=DkoTLFARNJc3QcL/oBL9kLQViswVCYkjycRhJvzyGVjmrh8BmN/xCT6HAWUQRVIxVX8CkZIhZRFNFZcj+GR9H4kDy50gtFk+xWsSB3VeMROZaAvbiwk1If7kUTAmLz69N0f4c/6+Xcf8kR0DQxq8QNPzarn2ezgpcL2T+zb4Aww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783690840; c=relaxed/simple;
	bh=vIiiJ+cCf8lqAIOs514qP+AoBMOvT7LpG/tOo8gCmII=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fz9WHSO5xN1jDd+h8rKVI3FLCjd3opKB/xWNsVOHuNc8WVTpJ214+1dl73xzpWK+I7evrJGFUcvXFIJ4DLecaBIkyyauJJtDWFbH7eQjv+85jB5RSSpTgR20uoi9IJxFigiPCW60JLUob96cdj0xBh65h1891wUNdACXcLwNrmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=hMk7Alrl; arc=none smtp.client-ip=79.135.106.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="hMk7Alrl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1783690824; x=1783950024;
	bh=vIiiJ+cCf8lqAIOs514qP+AoBMOvT7LpG/tOo8gCmII=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=hMk7Alrlqw7r1hFNUhRlV1qHOjskMYC3pW0uNzpxYGV8k1v3L73TCrSshT9w+bbhD
	 ThbiHw4Dw1y3uFJzlZyYvHiuLmsaSM4ZqL4stx7Sbdg/KxdOFbatEL531tuolLxpU/
	 fXpC7dgE263LggkjoXBG2dDecdbp/q0nbCkQlHekjD/QCkqlTowEjGbQBIvlFNK4Ze
	 gmYaXBVo6e2Ga7sOofmFH1W/3YVyOsr0u7Fs7hm30E1+aXCL5H4nEYfwQWdq2Tt9tH
	 KGpsZQz1VaNYl6mYdxlJ6D59Nt0pKR+/zVwRAV+lZ5klOw9jtU2lsbnj+De7GPBcH+
	 lp6vqOyucVd8g==
Date: Fri, 10 Jul 2026 13:40:17 +0000
To: "paul@paul-moore.com" <paul@paul-moore.com>
From: BoxStrikesTeam <BoxStrikesTeam@proton.me>
Cc: "rppt@kernel.org" <rppt@kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, "jmorris@namei.org" <jmorris@namei.org>, "serge@hallyn.com" <serge@hallyn.com>
Subject: =?utf-8?Q?=C4=B0lt:_Re:_[RFC/discuss]_memfd=5Fsecret():_opt-in_visibility_for_security_monitoring_(eBPF/audit)?=
Message-ID: <pciGBFzXU6ZhxcvS_9tWNr4oA-3uEmqoXh-B63mT0hsw3Deyl5pud2MXgRGQ6lHx59gqVkFekZjMMI3dhlkJemkaY63utKQplAIw1Tj-jS0=@proton.me>
In-Reply-To: <CAHC9VhRCo1nc2qLfq=Fk9Q26vjSOUBgfM8wV6U4S+Hv1KM9LNQ@mail.gmail.com>
References: <umQp9Qs18vw53oZDFIgYE4MyUWNemeNL8-Vbs-BOYEvQByiyPSZ3RrEvOpmdWUZ1YtjEHpjlgZnMo5DkJuJziwrKWTYS_A0QF_B3ixToMBY=@proton.me> <CAHC9VhRCo1nc2qLfq=Fk9Q26vjSOUBgfM8wV6U4S+Hv1KM9LNQ@mail.gmail.com>
Feedback-ID: 205449183:user:proton
X-Pm-Message-ID: 249e68c2716dbae997f0bb878229f5895b302bd6
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Proton Mail g=C3=BCvenli e-posta ile g=C3=B6nderildi.


------- Forwarded Message -------
Kimden: Paul Moore paul@paul-moore.com

Tarih: 9 Temmuz 2026 Per=C5=9Fembe saat 05:21
Konu: Re: [RFC/discuss] memfd_secret(): opt-in visibility for security moni=
toring (eBPF/audit)
Kime: BoxStrikesTeam BoxStrikesTeam@proton.me

CC: rppt@kernel.org rppt@kernel.org, akpm@linux-foundation.org akpm@linux-f=
oundation.org, linux-mm@kvack.org linux-mm@kvack.org, linux-security-module=
@vger.kernel.org linux-security-module@vger.kernel.org, jmorris@namei.org j=
morris@namei.org, serge@hallyn.com serge@hallyn.com



> On Wed, Jul 8, 2026 at 8:09=E2=80=AFAM BoxStrikesTeam BoxStrikesTeam@prot=
on.me wrote:
>=20
> > Hi,
> >=20
> > While experimenting with mseal() and memfd_secret() together on a
> > recent kernel, I ran into what looks like a gap worth discussing:
> > content placed in memfd_secret()-backed memory is invisible not just
> > to other processes, but also to in-kernel tracing/observability
> > mechanisms such as eBPF's bpf_probe_read_user() (EFAULT, as expected,
> > since the region is removed from the direct map and kernel page
> > tables entirely).
> >=20
> > That's working as designed for the threat model memfd_secret targets
> > (protect secrets even from a compromised kernel / ROP-based
> > exfiltration). But it does mean a local, unprivileged process can
> > now allocate memory that:
> >=20
> > 1. Is invisible to kernel-side introspection (eBPF tracing,
> > /proc/<pid>/mem, ptrace-based tooling) once populated via
> > memfd_secret(), and
> > 2. Can additionally be sealed against mprotect()/munmap()/mremap()
> > via mseal() so its protection bits can't be relaxed either.
> >=20
> > Neither primitive alone is new or alarming - mseal() protects mapping
> > metadata, not confidentiality, and memfd_secret() is explicitly
> > opt-in and disabled by default. But combined, they let a process
> > carve out a region that a host-based EDR relying on eBPF
> > tracing/probe_read helpers cannot inspect, and cannot force back into
> > an inspectable state either. For userland security tooling that
> > assumes 'anything a tracing eBPF program can attach to, it can read',
> > this is a small blind spot.
> >=20
> > I want to be clear I'm not suggesting memfd_secret()'s core guarantee
> > should be weakened - the ability to keep data hidden from a
> > compromised kernel is the entire point, and forcibly exposing content
> > to tracing programs would undermine that model and create a new
> > attack surface via the eBPF verifier/helper path itself.
> >=20
> > What I'd like to raise for discussion instead is something closer to
> > what was already anticipated in the original series - Mike, your
> > commit message for memfd_secret() mentions: 'Once there will be a use
> > case that will require exposing secretmem to the kernel it will be an
> > opt-in request in the system call flags.' Two lighter-weight
> > directions that stay consistent with that opt-in philosophy:
> >=20
> > a) An LSM hook / audit event at memfd_secret() call time (this
> > echoes Christian Gottsche's 2022 RFC to label secretmem inodes
> > via inode_init_security_anon for SELinux). Even without content
> > visibility, logging 'process X created a N-byte kernel-invisible
> > mapping' gives EDR/audit systems a behavioral signal to alert on,
> > without touching the confidentiality guarantee at all.
> >=20
> > b) A distinct opt-in flag (as foreshadowed in the original commit)
> > that a process could set to allow a CAP_BPF/CAP_SYS_ADMIN-gated
> > tracing context to read the region for legitimate
> > monitoring/debugging - fully opt-in, off by default, and never
> > implicitly available to unprivileged tracers.
> >=20
> > Is (a) something that's been considered further since the 2022
> > secretmem-inode-labeling thread? And is there any existing tracking
> > issue for the kind of opt-in-visibility idea in (b), or was it
> > dropped as not worth the complexity?
>=20
> Modern kernels do allow LSM labeling of secretmem inodes, see
> secretmem_file_create().
>=20
> --
> paul-moore.com


Hello,

Option B caught my interest. Do you have any updates, disclosures, new idea=
s, or anything new to share?

By the way, I strengthened my finding with a proof of concept and have now =
disclosed it publicly.

Thank you.

https://github.com/BoxStrikesTeam/Counter-Attack-Injection-Method

https://boxstrikesteam.github.io/Bulgular/001/finding-001.html
