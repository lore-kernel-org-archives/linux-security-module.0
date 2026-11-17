Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.157.188.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794910337;
	b=JI6Ky4Qm5RzZrJ13tPU+W/k/Wp6NyD2tPRmJU0ThFH1TSLQ64ryQvjD9fJ4BI3NL33+W
	 C82Zbu928Jw6PmyLDST1Qe3wFrc5jv9oTuP1xvIvU/0TYPmbz2WWuGLWY6sJ3+lMwTFW8
	 N0QeQ06TAr+22h1wnKIJdtYqwj7pa1FimT9A9DzE++gsZgBMef9IgMmhFWem1Uk00e285
	 ykiq4cA2O+MkWPT8NuxfiFFMGaW6uJaEM8bftXOXfejnRRLt0hiE4k2k/891Ih5RG5Hc8
	 wj0XP8du81jfsHDkq/I16kquM42PT4R0REgAlQhND0TVBgOVEoQbepvMJWLGP2FQ6yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794910337;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Infomaniak-Routing;
	bh=gyRxjx+N08McOgkiPKprbmzlzILJehlh93QhGWzUcJ0=;
	b=X4yyrhD7sHm5LhGlcRSMSAy8okN0CNkpaDtQoVLsrCtsR+Itvu6nJamIg7FUU/9aDQY6
	 K35zpX7CHoQ0j+MBUCSXc1vAh88tgLmt2eiVSvrBqAL0ZXX779N7Lo3jcpF0R1+FXHtV/
	 an+D9rLvgmfS8SUO4c3c5L0osvDv2671WeN+fRMXrX1Bg2NcOWT120hmn0zaMJKm1/qFP
	 zIpYxh+vfBfRuJ6XxOP4Yuqqo6DIkItd/raW0LjceF7AF9JjiEYfm+rwXflBowc4IkUQN
	 6I+gJRa5wCdh0mzqeaiHSzhgz2BrCsim4sYQGcNffctg9WVtbEtmc5fAdIA/Kr1sS2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=digikod.net;
	spf=pass smtp.mailfrom=digikod.net;
	dkim=pass header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=nHhOxJr+;
	arc=none smtp.remote-ip=45.157.188.9
Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch [45.157.188.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D41606A32A
	for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 10:12:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9D41606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=nHhOxJr+
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jTLBG5SKlzNTN;
	Tue, 17 Nov 2026 11:12:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1794910326;
	bh=gyRxjx+N08McOgkiPKprbmzlzILJehlh93QhGWzUcJ0=;
	h=From:To:Cc:Subject:Date:From;
	b=nHhOxJr+GK/f4yDEX29tGjMPr8epPdaAJcBdA0eBWY8l6HqTeVxNg536PZQNw+tqT
	 cxZ64jOrhq2RI5RKKqaSoeNTpcX9bw7JvOnsnXP+Y5Itu6V8/f+egqCFI50qk5btHp
	 RG3GAU7M2M6nknjCtYHdm5BFUmxDEprBZDRFJbvk=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4jTLBD5vtcz999;
	Tue, 17 Nov 2026 11:12:04 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Ada Smith <adasmithgt@gmail.com>,
	Hungyu Lin <dennylin0707@gmail.com>,
	James Morris <jmorris@namei.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Paul Moore <paul@paul-moore.com>,
	Serge Hallyn <serge@hallyn.com>,
	Serge Hallyn <sergeh@kernel.org>,
	kernel-team@cloudflare.com,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v2 0/6] Fix Landlock mediation of commoncap's capability checks
Date: Tue, 17 Nov 2026 11:11:50 +0100
Message-ID: <20261117101157.2520463-1-mic@digikod.net>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Hi,

This is series 1 of 3:

* 1. fix Landlock mediation of commoncap's capability checks;
  2. fix PR_SET_SECUREBITS mediation and add focused Landlock tests;
  3. fix Landlock mediation of capabilities guarding LSM policies.

LANDLOCK_PERMISSION_CAPABILITY_USE, merged for v7.4, denies capabilities
through the LSM capable hook, but commoncap's mmap_addr, capset and
vm_enough_memory hooks call cap_capable() directly.  A domain that
denies a capability can therefore still:

- map memory below vm.mmap_min_addr (CAP_SYS_RAWIO), which defeats a
  mitigation for kernel NULL pointer dereferences;
- add inheritable capabilities outside of its permitted set
  (CAP_SETPCAP), which lets a privileged sandbox without no_new_privs
  gain capabilities through execve(), although the domain still
  restricts their use;
- use the admin memory reserve with vm.overcommit_memory=2
  (CAP_SYS_ADMIN).

As SELinux does, patches 2 to 4 add Landlock's own check to these hooks,
with commoncap's conditions, so they only deny what commoncap granted
because of the capability.  Patch 1 factors out the shared check.  Patch
5 adds tests, including audit tests, that fail without the mmap_addr and
capset fixes; testing the admin reserve would require changing
system-wide overcommit settings.  Patch 6 fixes the documentation, which
overstated what the permission restricts and how its denials show.

Two other direct capability-set checks are fixed separately:

- PSI triggers (CAP_SYS_RESOURCE):
  https://patch.msgid.link/20261106120004.90041-1-dennylin0707@gmail.com
- user namespace uid 0 mapping (CAP_SETFCAP):
  https://patch.msgid.link/20261110144205.2404088-1-mic@digikod.net

Changes since v1:
https://patch.msgid.link/20261110202436.2408244-1-mic@digikod.net
- Replace the admin reserve test, which changed system-wide overcommit
  settings and was racy, with a comment, and fix the mmap_addr tests on
  32-bit ARM (reported by Sashiko).
- Add Serge Hallyn's Acked-by.

Regards,

Mickaël Salaün (6):
  landlock: Factor out capability denial checks
  landlock: Mediate CAP_SYS_RAWIO for mappings below mmap_min_addr
  landlock: Mediate CAP_SETPCAP for inheritable capabilities
  landlock: Mediate CAP_SYS_ADMIN for the admin memory reserve
  selftests/landlock: Test capability checks outside the capable hook
  landlock: Fix capability restriction documentation

 Documentation/security/landlock.rst         |   8 +-
 Documentation/userspace-api/landlock.rst    |   8 +-
 include/uapi/linux/landlock.h               |   6 +-
 security/landlock/cap.c                     | 110 ++++++-
 tools/testing/selftests/landlock/cap_test.c | 336 ++++++++++++++++++++
 tools/testing/selftests/landlock/common.h   |   4 +-
 6 files changed, 451 insertions(+), 21 deletions(-)


base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
-- 
2.56.0

