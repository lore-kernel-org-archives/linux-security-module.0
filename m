Received: from mail-05.mail-europe.com (mail-05.mail-europe.com [85.9.206.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D60537206E
	for <linux-security-module@vger.kernel.org>; Thu,  9 Jul 2026 05:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.206.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783574097; cv=none; b=qaabjFB3MafHvne6FS0uQwt2WfTI7FSVhPcsSJeaPucDR4bovrD9b1B1MdrZ3kXI7Cg6Nc9HvW3tdLa3fF843m3Ny2Af7RMy/an77mIEICKGgDe915WAgFK5oSNtpMoV1/ivBP+iINu12eY89U63b6Nqwbkj74Ch7WjubLNnU7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783574097; c=relaxed/simple;
	bh=//uLA+s6qwaDTgsvTiLRg4jEcoe8gz5B2XgMn4s7FKg=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=HBpXBYb7sJRk6He0cvuHo4RFDHI9kcPyVo2DxBTWUue1Lpi2/K1ee86hWWNB3Nsfn1ar+qBDCjrKO1VPfvl5t+J1VB0cDGV7Afd6rdx+luT1ea/LUJw4dLOzTQNvDfLzIbfq8yQEYOXT0StEQO2Ho2if8hDzVP1jUzIX68AuIQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=FrA8MWgS; arc=none smtp.client-ip=85.9.206.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="FrA8MWgS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1783574082; x=1783833282;
	bh=//uLA+s6qwaDTgsvTiLRg4jEcoe8gz5B2XgMn4s7FKg=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=FrA8MWgSX8EAeMxc/LECNUan0idpSp7JLCWZWnkIGbyCWCjkm3e/QvDYUTqBI1L1W
	 oe++g69ToQ8xlEGGlGGCAtZRdavuYEIhdfxorJ6BatfJ7e2vxQdleKgexLBa7eXTdP
	 HgHjBD4j2zfIl9H+WrGtPwquOPZBYc9HjgokXA3RptdcA8eiTo/W9yMqfHBswecqAy
	 7f18A75Xv4fL3LNO/s+FEljyEH7gnvCM8iko8Y0+6T9TcjqSugIjnZaJsDVWWfKQTQ
	 TtzFRZGnx0L4l3w36ISJxDhvtxNEXPI/JvoeF0a3FT5xjwFgozOAM/TKKpcSVqi9lD
	 bEjwddCq+TarQ==
Date: Thu, 09 Jul 2026 05:14:36 +0000
To: "rppt@kernel.org" <rppt@kernel.org>, "paul@paul-moore.com" <paul@paul-moore.com>
From: BoxStrikesTeam <BoxStrikesTeam@proton.me>
Cc: "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, "jmorris@namei.org" <jmorris@namei.org>, "serge@hallyn.com" <serge@hallyn.com>
Subject: [RESEND][RFC/discuss] memfd_secret(): opt-in visibility for security monitoring (eBPF/audit)
Message-ID: <MZlCECz5s73hPgQxtqWZ2VbXNTCZnItnwMHu2iZQlRC6ba0B9GuqxT2EhvhwQ-uanBDsNn7Bg09nGVynBHdmSsiRjhyI1udkYbqOoPfpe6w=@proton.me>
Feedback-ID: 205449183:user:proton
X-Pm-Message-ID: 10d4677c9e8ac675e6b6709b3446567f78dad599
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Note:Apologies for the HTML format in the previous send; this is a plain-te=
xt resend of the same message.




Paul,

Thanks - I found the Gottsche/inode_init_security_anon() thread and can see=
 it landed. That answers (a) cleanly: labeling exists, policy can be layere=
d on top via SELinux/AppArmor if a site wants alerting on memfd_secret() cr=
eation. Good to have that confirmed as already solved.

On (b), let me push on it a bit further, because I think it's worth spellin=
g out explicitly rather than dropping it.

My concern: as it stands, an unprivileged process can populate a memfd_secr=
et() region and mseal() the mapping, producing memory that is (a) unreadabl=
e by any kernel-side introspection path, including root-owned eBPF tracing =
programs, and (b) can't be coerced back into an inspectable state via mprot=
ect/munmap. From a host-based detection standpoint that's a blind spot an a=
ttacker can use to park a payload where a CAP_BPF-privileged monitoring age=
nt - something that in most other respects can inspect any process on the b=
ox - simply cannot look, no matter what capabilities it holds.

I understand the objection this invites, and I want to address it directly =
rather than pretend it isn't there: the memfd_secret() man page is explicit=
 that its ROP protection rests on the absence of any in-kernel primitive fo=
r reading this memory. If I'm reading that right, the objection to (b) is t=
hat adding any such primitive - however capability-gated - re-creates exact=
ly the artifact a ROP chain would want to call, undermining the "no primiti=
ve exists" property regardless of who's nominally allowed to invoke it.

I don't think that objection is wrong, but I'm not sure it's fully disposit=
ive either, and I'd like to hear the maintainers' take on the tradeoff expl=
icitly:

- The ROP threat model assumes an attacker who already has arbitrary kernel=
 code execution (they're calling kernel functions directly). If they have t=
hat, they can likely already walk page tables and reconstruct the mapping b=
y hand - the primitive removal raises the bar, but per the design's own cav=
eat ("no 100% guarantee"), it was never advertised as absolute.
- The (b) scenario I'm raising is a different actor: a legitimate, privileg=
ed, kernel-mediated monitoring agent (eBPF LSM/tracing program) operating t=
hrough the normal verifier-checked helper path, not an attacker executing a=
rbitrary kernel code via a ROP chain. Conflating "any code path that can re=
ad this memory" with "a gadget a ROP chain can call" may be overly conserva=
tive if the new path is narrowly scoped (e.g., a new bpf_probe_read_secretm=
em() helper, verifier-restricted to CAP_PERFMON|CAP_BPF programs, opt-in pe=
r region via a memfd_secret() flag the owning process must set at creation =
time).

If that distinction doesn't hold up - if any additional kernel-callable rea=
d path is considered equally exploitable regardless of gating - I'd genuine=
ly like to understand why, since it would mean the confidentiality guarante=
e is fundamentally incompatible with any form of authorized introspection, =
which seems worth stating plainly in the documentation for anyone building =
EDR/monitoring tooling around eBPF.



Even if (b) is rejected, I believe explicitly documenting that memfd_secret=
()+mseal() creates an introspection-proof region would be valuable for the =
security community, so EDR vendors can adjust their threat models according=
ly.

Thanks again for engaging with this.



Eneshan Erdo=C4=9Fan Karaca.


