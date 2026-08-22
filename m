Received: from mailgate-1.ZDV.Net (mailgate-1.zdv.net [134.93.178.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53752EEE63;
	Sat, 22 Aug 2026 19:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.93.178.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787427660; cv=none; b=BbVnP7DT1BRUqtqYef32TxNxkTEoZtcZx4/adN2P1ak0EszKDp3P6zeAwVo6aWpmuf0qsLocv/GZh03w+iZnNAWJFUkY6B3OJf/OruekPP7XU6+YDOOQlLqSxJB0pm+COCfTy8XrJPvUkobOJACyiiS++GbCzeUJMjyC+lO6Hf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787427660; c=relaxed/simple;
	bh=fwsVXQZ3ULdCXhYHkYBwxm7CBAUndzfhBAphwewhc7g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZJvz0jIEwjZF1cihlb30FvlFfidz7hNHO5d3Gyr+MyZim2oTTSccoCcgyvWtgZRknsIcft9lBWA5te1EhQWxW4Nb0lnqBIdZq7Os8gHAun32dEquTa6A2mkNBhWELhVF42iVTYHH8TuCrI7KGbUyttD8hNaeGYRD5iYuj6hK4k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hs-mainz.de; spf=pass smtp.mailfrom=hs-mainz.de; arc=none smtp.client-ip=134.93.178.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hs-mainz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hs-mainz.de
X-CSE-ConnectionGUID: 4m3G/fNGSWCFEKoj6KJPQQ==
X-CSE-MsgGUID: 7hoMtr9MQb6zBAAbJz78OA==
X-IPAS-Result: =?us-ascii?q?A2C0CAA4+olq/z72XgpSCB0BAQEBCQESAQUFAYIQAoIWg?=
 =?us-ascii?q?TNagRAdli0DkUqOTw8BAQEOAT0UBAEBhQUCjW0nOBMBAgQDAgMBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEKAQEBBQEBAQEBAQYEAYEhhglGDUkBEAGGAAEEATIBRgULCxI0SA4GD?=
 =?us-ascii?q?oIvWAGCTScUxCSBAd5HgWwGCQELgTiFcYJtAYUCgTqEODaBVUSBFYMrPoQch?=
 =?us-ascii?q?mwEgg0VgQyCcIFUjxNICnh4LAFVEw0KCwcFgSNDAzUSKhUjSwUtHYEjIR0XF?=
 =?us-ascii?q?x5YGwYFEiAqQUQjAz6BGUECgXU/Ixk2eoEJXoErKWABAhAXRi4VggcCglqBJ?=
 =?us-ascii?q?14CAUlDDgdIIgsYDUgRLDcUGQQ+bgeOXh+BWgEtPgYBFgsQDFEGFhCBEQcXF?=
 =?us-ascii?q?AIIEQIjBAwZESEBFgWWFAGvbjQHgjmBaIFgBgyKMI40hwZNhFGlBIEXkk6GO?=
 =?us-ascii?q?o4KlTQ/AwqFDgIEAgQFAhiBf4F+MxokT4JoUhcCD1aKcoJlFog4x0N5OwIHA?=
 =?us-ascii?q?gcOAwuHXIpsAT1gAQE?=
IronPort-Data: A9a23:hCJQdqMq16AnmcfvrR3Fl8FynXyQoLVcMsEvi/4bfWQNrUp00jIFx
 jZNWz+Da/uMZmrxfN13PIvl9E9XscfRztNrSQZtpSBmQlt08seUXt7xwmXYZHrOc5KZHCqLz
 O1HMoWQcZ9qFhcwgj/3b9ANeFEljfngqoLUUbCCZ2YpA1A0EE/NsDo788YhmIlknNOlNA2Ev
 NL2sqX3NUSss9JOGjt8B5mr9lU14ZwehBtC5gZgPaAR5geH/5UoJMt3yZ+ZfiaQrrZ8RoZWd
 86bpJml82XQ+QsaC9/Nut7Tbk0QT7fOChOFg3xQVrLKqkAqSvsai/tT2FI0MC+7uh3R9zxD4
 IwlWa+YEG/FCpbxdNE1CHG0Jc3c0Zpuo9crKVDn2SCaItavn3HEm52CB2luVWEUF3oe7Wxmr
 ZQlxD4xgh+r2+ft7/W1bMZXue8NAersPt08mElZ9GSMZRomacirr6Ti99NGmTogjcALR7DsS
 /RfTzdzBPjCS0QXfAZLTshiwqH23BETcBUBwL6Rjaw26G/XxQ0306XrLMjYUtyRAMBcn0CK4
 G7Ll4j8Kk1Kb4HBmGLVmp6qrrDPmgbnQtM3Lbfm5NRDqVex1DNDLzRDADNXptH80CZSQel3L
 00S5zprrK4u+UOxT8XsdwO3rWTCvRMGXddUVeog52ml6KPR7h3fLG8YUjlEbNE3nM8/Qycn0
 EeAhc/vCCZ0sLyND3ma89+8vzSyMDI9KW4EeD9CTAEApdLkpekblBXFQ8x/F+iuh8buBBnw3
 jmVoSl4jLIW5eYH0qSn50GBgDu3r4TKTwgd6QDeX2bj5QR8DKaofY2jr0Pd6ulKIZyWZl6bt
 XMAlo6V6+VmJYmEiSilWOwQGPSs4PGfPXvXhlsHN5sk8C63+mWLe4lV7TA4I11mWu4fdCXmb
 WfTsAdV9ZkVN3yvBYdzYoSsG4ExwKP9D9X5R7XRadZTZpVZagCK5mdtaFSW0mSrl1Ij+Yk7O
 JGGYYOvAGwcBKBP0jW7XaEe3KUtyyR4wnncLa0X1Dy13aTbaW6eSfJfdkmCcKY/4b/sTBjpz
 uuz/vCik313ONASqAGNmWLPBTjm9UQGOK0=
IronPort-HdrOrdr: A9a23:KqW3QKDomZIq07PlHemd55DYdb4zR+YMi2TC1yhKJSC9Ffbo8/
 xG/c5rsiMc5wx+ZJhNo7q90ey7MBDhHP1OkOws1NWZPTUO0VHAROpfBMnZsl/d8kXFh4hgPM
 xbHJSWZuecMbAs5vyKmDVQa+xB/DDRytHQudvj
X-Talos-CUID: =?us-ascii?q?9a23=3A5GuWWWhVk4vdRkzjn+fiOFpRSDJuLniG4zDeBWC?=
 =?us-ascii?q?DNk1HZZ6SSwGz2ptdqp87?=
X-Talos-MUID: 9a23:6Te5XQX1FryghnHq/GDsgxR+LpZN2q7wGmokuJ8kqZbUEgUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,237,1779141600"; 
   d="scan'208";a="48356908"
Received: from zdv-exch-2.zdv.net ([10.94.246.62])
  by mailgate-1.ZDV.Net with ESMTP/TLS/ECDHE-ECDSA-AES256-GCM-SHA384; 22 Aug 2026 21:39:42 +0200
Received: from MacBookPro.fritz.box (91.37.89.206) by zdv-exch-2.ZDV.Net
 (fd42:4323:8cdd:70e:9a03:9bff:fe77:8f92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sat, 22 Aug 2026 21:39:41 +0200
From: Nicolai Kuntze <nicolai.kuntze@hs-mainz.de>
To: <linux-integrity@vger.kernel.org>
CC: James Bottomley <James.Bottomley@HansenPartnership.com>, Mimi Zohar
	<zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, Dmitry
 Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg
	<eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, James Morris
	<jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
	<linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] IMA: periodic runtime re-measurement of process .text/GOT
Date: Sat, 22 Aug 2026 21:38:33 +0200
Message-ID: <20260822193833.98211-1-nicolai.kuntze@hs-mainz.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <a5efe5059cd261c19496e602459fb37e3159817d.camel@linux.ibm.com> <b13a1741eceeba4d4ec50e1c898e011ea81a178b.camel@HansenPartnership.com>
References: <20260817102323.35950-1-nicolai.kuntze@hs-mainz.de> <a5efe5059cd261c19496e602459fb37e3159817d.camel@linux.ibm.com> <b13a1741eceeba4d4ec50e1c898e011ea81a178b.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: zdv-exchfe-2.ZDV.Net (2001:4c80:40:70f:21d:d8ff:feb7:30e2)
 To zdv-exch-2.ZDV.Net (fd42:4323:8cdd:70e:9a03:9bff:fe77:8f92)

James, Mimi -- thank you both, these landed on real gaps, not just
missing explanation. Replies inline.

@James (Bottomley):

> A processes text segment is mapped ro and cannot change... if
> you're looking to fix something like the copy fail cache
> corruption, then a strengthened ROX mechanism would be way better

Agreed without reservation for the case ROX/W^X actually cover: any
tampering that goes through the normal page-table-enforced write
path with the page's permission bits left alone. Prevention beats
bounded-delay detection there every time, and this proposal isn't
meant to compete with it.

> The GOT ... are also often constructed lazily ... practically every
> measurement will be different

You're right, and this exposed a genuine bug rather than a
misunderstanding on your end. The reference implementation's kernel
side has always recorded each GOT slot's access permissions
specifically to distinguish "still being lazily populated" (rw-)
from "RELRO-locked, safe to compare" (r--) -- but the userspace
verifier was silently dropping that field and comparing every slot
regardless. Fixed: a slot is now only checked against its predicted
value once measured r--; a slot still rw- is reported separately
("unlocked") rather than flagged tampered. This doesn't require
BIND_NOW/non-lazy linking -- a binary that never RELRO-locks its GOT
simply never gets that slot verified, rather than false-flagged.

> ptrace()/kernel exploit through /proc/pid/mem are privileged
> operations, so what is the threat model?

The primary case is more mundane than either of us initially framed
it: an attacker who already has ordinary code execution inside the
process can call mprotect() on their own mapping to make a page
writable-then-executable, entirely through the kernel's normal,
page-table-consistent path -- no privilege escalation, no hardware
access needed. Plain W^X doesn't prevent that by itself (it's a
load-time property, not a runtime invariant); only additional
hardening most systems don't run (PaX MPROTECT, SELinux execmem, a
seccomp filter on mprotect()'s flags) closes it. This is exactly why
the design already includes an mprotect()-triggered re-scan alongside
the periodic one -- that's the case being targeted, not an exotic
bypass. A stronger, much rarer case -- an attacker who can write
physical memory or rewrite page tables directly -- also exists and is
covered the same way (this mechanism never consults permission bits,
only resident content), but it's a secondary point, not the main one.
For a deployment whose threat model stops at ordinary privileged code
execution with no mprotect()-hardening gap and no physical-memory
access, dm-verity + a hardened mprotect() policy may well already be
the complete, cheaper answer -- this isn't proposed as a universal
replacement for that.

@Mimi:

> Systems that aren't rebooted frequently ... periodically clearing
> the iint cached info ... good first kernel project

Agreed this is worth doing on its own merits, and I'd support it --
but want to flag it's solving an adjacent problem, not this one:
clearing iint forces a stale file to be re-measured on its next
open()/exec(), which does nothing for a process that's already open,
already measured, and whose live memory has diverged with no new
event to hook. Complementary, not a substitute.

> This feature is continuous/periodic ... a different execution
> model, not an incremental addition to a hook-based architecture.
> The reference implementation ... bypasses IMA's measurement list
> and dedup entirely

This was the strongest objection, and rather than argue it away I
went back and changed the design -- v2 patches attached/linked below,
not just a response in prose. You were right that a self-scheduling
timer inside ima_main.c's dispatch is a materially different execution
model, not an incremental addition to a hook-based one; the fix wasn't
to defend the timer, it was to notice the actual requirement was never
"recheck on a schedule," it was "answer a verifier's request," the
same shape a TPM Quote already has. So v2 drops the timer and
`interval=` entirely: RUNTIME_TEXT_CHECK/RUNTIME_GOT_CHECK/
KERNEL_TEXT_CHECK are now dispatched from a one-shot trigger, a new
write-only securityfs file (`/sys/kernel/security/ima/runtime_measure`,
CAP_SYS_ADMIN-gated), the same event-triggered shape every other IMA
hook already has -- the event is just "a verifier asked" instead of
"a file was opened." Boot-tested under QEMU/KVM: a 5-second idle
window with no write to `runtime_measure` produces zero measurement
log lines; one write produces exactly one correctly-scoped batch;
a further idle wait leaves the count unchanged, confirming it's
genuinely one-shot and not a disguised timer restart.

The measurement-list/dedup bypass you also flagged is a separate
point from the execution-model one, and v2 does *not* change it: it's
still deliberate, for the reason given in the original RFC -- an
external verifier replaying the full PCR-extend chain needs every
extend the TPM actually performed, including repeats of unchanged
content, which is exactly what IMA's own digest-based dedup would
throw away. v1's dedicated per-mapping dedup table (built to bound log
growth from timer ticks nobody asked for) is dropped in v2 for the
same reason it's no longer needed: growth is now bounded by how often
a verifier actually requests a measurement, not by an on-device clock.
It stays available, unchanged, for anyone who still wants periodic
mode -- v1 is kept as sent-and-tested history, not deleted, just not
the default.

Does this address the concern, or is there a reason a request-driven
hook still doesn't belong in ima_main.c's dispatch at all? Genuinely
asking, not rhetorically -- if the list still prefers the
separate-mechanism route (kthread/LSM-adjacent/eBPF, reusing IMA's
measurement list and PCR extend chain as a pure data sink without
adopting its hook model), I'd rather hear that now than after more
patches build on the current shape.

> W^X, hardware CFI, and page-fault-based monitoring all fully
> prevent ... DRIVE ... only bounded-time detection ... The RFC
> should be explicit about that distinction

Agreed, and the corrected version of what I said to James above is
exactly that distinction, made explicit rather than left implicit as
it was in the original RFC.

Thanks again, both -- v2 (0001-v2 through 0004-v2, replacing the
attached v1 series and now also covering RUNTIME_GOT_CHECK dispatch,
which v1 left grammar-only) is up at the same repo if you want to look
before replying: <https://gitlab.rlp.net/nicolai.kuntze/memory_attestation>.
Holding off on submitting any of this for formal review until I hear
whether v2 actually resolves the execution-model question for you,
since a "no, still the wrong shape" answer would change more than a
patch series built on the current shape would survive.

Nicolai (with a lot of help of AI for a swift answer)
