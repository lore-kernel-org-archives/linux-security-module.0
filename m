Received: from mail-06.mail-europe.com (mail-06.mail-europe.com [85.9.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74263F54C5
	for <linux-security-module@vger.kernel.org>; Wed,  8 Jul 2026 12:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783512610; cv=none; b=WqRcIz7cY5CqaJMuLkPU5UFktFRaXpPg7W+Ijd7/YjtySukbjtafqsZrsP+tEQ1SBqaOJ1B8SwQw9LEmU+4xiAWm38VZizJ4hYvZ9tjLygO4YFrtalDfAmuwrCOr7B77oCs3O/zrU1YzxGHGwMlIPjdqW2aWvYfNNg02ZQeT128=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783512610; c=relaxed/simple;
	bh=q7pq4RkyXliE5Piwh20/AqpvrmpVs1qnGP8atekwzHY=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=m7y6WIwRPjHxRb+/twc7PRtDoiivjd3Ow3Nh4FSI+mxfHFLkMehrmPmJTBVQF+rFc4fWOnPs9X+bjz0neD9TxnLMF3NgceXW8DyhbSOofGg5HV04eYvEGnL0V0H9azfWRLxnuRG2P2EVyYcEqlpxpMS8drXXJdeW96fYlaLfbE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=YD9yfCLz; arc=none smtp.client-ip=85.9.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="YD9yfCLz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1783512596; x=1783771796;
	bh=q7pq4RkyXliE5Piwh20/AqpvrmpVs1qnGP8atekwzHY=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=YD9yfCLzoIFry2/9wAWOPUe1DhmxUilPdLJvtKYgtJat9bErrH05KsicV7g6g0hiC
	 PvHUO4gUm5h+UaLkJ1NxZFlJj9fFdKyecBOP4lU3pTFvDT/n7Ei0U4f7YRCJUun8aQ
	 Z3PTwM6UlcNq+0W2VMUyxf4v9aiuooBRq6ehhGZW4MrXZ5/rLNQhgd7AqD82wUZtzw
	 5AQ4D8J5xyS3QioetrO6DO+tWlgQUxjJKqsOaeQX7MEWOa2ErqCmwBDzghopSY5YWe
	 i3gZ2qVHVrOzs71UD19MHs1vh3+QPJa+PqDgx6FVAXWMFgadMFYlca48qK/jToZrXw
	 PKzXX6xIVJVlA==
Date: Wed, 08 Jul 2026 12:09:51 +0000
To: "rppt@kernel.org" <rppt@kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>
From: BoxStrikesTeam <BoxStrikesTeam@proton.me>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, "paul@paul-moore.com" <paul@paul-moore.com>, "jmorris@namei.org" <jmorris@namei.org>, "serge@hallyn.com" <serge@hallyn.com>
Subject: [RFC/discuss] memfd_secret(): opt-in visibility for security monitoring (eBPF/audit)
Message-ID: <umQp9Qs18vw53oZDFIgYE4MyUWNemeNL8-Vbs-BOYEvQByiyPSZ3RrEvOpmdWUZ1YtjEHpjlgZnMo5DkJuJziwrKWTYS_A0QF_B3ixToMBY=@proton.me>
Feedback-ID: 205449183:user:proton
X-Pm-Message-ID: 117239aa9462dde2ee42b831599a3a00f881cf9c
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



Hi,

While experimenting with mseal() and memfd_secret() together on a
recent kernel, I ran into what looks like a gap worth discussing:
content placed in memfd_secret()-backed memory is invisible not just
to other processes, but also to in-kernel tracing/observability
mechanisms such as eBPF's bpf_probe_read_user() (EFAULT, as expected,
since the region is removed from the direct map and kernel page
tables entirely).

That's working as designed for the threat model memfd_secret targets
(protect secrets even from a compromised kernel / ROP-based
exfiltration). But it does mean a local, unprivileged process can
now allocate memory that:

=C2=A01. Is invisible to kernel-side introspection (eBPF tracing,
=C2=A0/proc/<pid>/mem, ptrace-based tooling) once populated via
=C2=A0memfd_secret(), and
=C2=A02. Can additionally be sealed against mprotect()/munmap()/mremap()
=C2=A0via mseal() so its protection bits can't be relaxed either.

Neither primitive alone is new or alarming - mseal() protects mapping
metadata, not confidentiality, and memfd_secret() is explicitly
opt-in and disabled by default. But combined, they let a process
carve out a region that a host-based EDR relying on eBPF
tracing/probe_read helpers cannot inspect, and cannot force back into
an inspectable state either. For userland security tooling that
assumes 'anything a tracing eBPF program can attach to, it can read',
this is a small blind spot.

I want to be clear I'm not suggesting memfd_secret()'s core guarantee
should be weakened - the ability to keep data hidden from a
compromised kernel is the entire point, and forcibly exposing content
to tracing programs would undermine that model and create a new
attack surface via the eBPF verifier/helper path itself.

What I'd like to raise for discussion instead is something closer to
what was already anticipated in the original series - Mike, your
commit message for memfd_secret() mentions: 'Once there will be a use
case that will require exposing secretmem to the kernel it will be an
opt-in request in the system call flags.' Two lighter-weight
directions that stay consistent with that opt-in philosophy:

=C2=A0a) An LSM hook / audit event at memfd_secret() call time (this
=C2=A0echoes Christian Gottsche's 2022 RFC to label secretmem inodes
=C2=A0via inode_init_security_anon for SELinux). Even without content
=C2=A0visibility, logging 'process X created a N-byte kernel-invisible
=C2=A0mapping' gives EDR/audit systems a behavioral signal to alert on,
=C2=A0without touching the confidentiality guarantee at all.

=C2=A0b) A distinct opt-in flag (as foreshadowed in the original commit)
=C2=A0that a process could set to allow a CAP_BPF/CAP_SYS_ADMIN-gated
=C2=A0tracing context to read the region for legitimate
=C2=A0monitoring/debugging - fully opt-in, off by default, and never
=C2=A0implicitly available to unprivileged tracers.

Is (a) something that's been considered further since the 2022
secretmem-inode-labeling thread? And is there any existing tracking
issue for the kind of opt-in-visibility idea in (b), or was it
dropped as not worth the complexity?

Happy to help test/write a small selftest if there's interest in
pursuing either direction.

Thanks,
BoxStrike Team.
Researcher:Eneshan Erdo=C4=9Fan Karaca, Other ananymous


Researcher emails:cyberblackk@proton.me
