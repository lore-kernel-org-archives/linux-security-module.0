Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6B0233723;
	Thu, 16 Apr 2026 17:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776360916; cv=none; b=jmc+nRdJnB16EQp58QekG+Z1NJjnnj3qsNRg+9t1z8O+AKYBmpY0vYVGTzjRZ2Ah/bakaF1PRHnCO6Bt+u8HHkQIlwP0wbv1Xuk5DDxv2DbJC+1ZXm90h4IRXLP3IfkPeDw8MzqgYU6jLwY7h2pfAwiykDb7suqTEqVhYclP0Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776360916; c=relaxed/simple;
	bh=kqha0qiMM4Du35H8cIJF7rKdngSpdJtw9bX8eipCtqw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sWFv9V0snKIbghZ5BMXKFcQoygHxijpwipacPMLwadbXC0mmZ6zUKjLxCt7iLwcCKcYof+XmKy0ZQvfTJGy0kfBvFY3LCA4vEmz9vJKVZSVbLfEvo/S8c9e06deTekRxBWtbm++D48B9rY5MrPZJWX37BFmpllbp4EwrOB/YMJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=NMwTvvtg; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="NMwTvvtg"
Received: from narnia.corp.microsoft.com (unknown [40.78.12.246])
	by linux.microsoft.com (Postfix) with ESMTPSA id CD5EA20B7128;
	Thu, 16 Apr 2026 10:35:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CD5EA20B7128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776360910;
	bh=DZKm0Alwrv4Z1eZ0BB8iScYAw3YwStuCulMKFBkNkcw=;
	h=From:To:Subject:Date:From;
	b=NMwTvvtg59odIXENYx3Fqr80Jup+isq9y1mcPM3kf1FWP0HFOT5A6GdpXFmpfRC9H
	 dSlOpPEF+rewBNvkni/5gPEB6uUxLtCNxOs7M4iGrmZvqd652ZsYwmvdkThCtfyb5r
	 oJrBudSRMsuhJS9lvfDiE5I9/VOnE3/Hqihvq6cE=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	James.Bottomley@HansenPartnership.com,
	dhowells@redhat.com,
	Fan Wu <wufan@kernel.org>,
	Ryan Foster <foster.ryan.r@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-security-module@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Song Liu <song@kernel.org>
Subject: [PATCH v4 00/10] Reintroduce Hornet LSM
Date: Thu, 16 Apr 2026 10:33:21 -0700
Message-ID: <20260416173500.176716-1-bboscaccy@linux.microsoft.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch series introduces the next iteration of the Hornet LSM.
Hornet’s goal is to provide a secure and extensible in-kernel
signature verification mechanism for eBPF programs.

Hornet addresses concerns from users who require strict audit trails and
verification guarantees for eBPF programs, especially in
security-sensitive environments. Many production systems need assurance
that only authorized, unmodified eBPF programs are loaded into the
kernel. Hornet provides this assurance through cryptographic signature
verification.

The currently accepted loader-plus-map signature verification scheme,
mandated by Alexei and KP, is simple to implement and generally
acceptable if users and administrators are satisfied with it. However,
verifying both the loader and the maps offers additional benefits
beyond verifying the loader alone:

1. Security and Audit Integrity

A key advantage is that the LSM hook for authorizing BPF program loads
can operate after signature verification. This ensures:

* Access control decisions are based on verified signature status.
* Accurate system state measurement and logging.
* Log entries claiming a verified signature are truthful, avoiding
  misleading records where only the loader was verified while the actual
  BPF program verification occurs later without logging.

2. TOCTOU Attack Prevention

The current map hash implementation may be vulnerable to a TOCTOU
attack because it allows unfrozen maps to cache a previously
calculated hash. The accepted “trusted loader” scheme cannot detect
this and may permit loading altered maps.

3. Supply Chain Integrity

Verify that eBPF programs and their associated map data have not been
modified since they were built and signed, in the kernel proper, may
aid in protecting against supply chain attacks.

This approach addresses concerns from users who require strict audit
trails and verification guarantees, especially in security-sensitive
environments. Map hashes for extended verification are passed via the
existing PKCS#7 UAPI and verified by the crypto subsystem. Hornet then
calculates the program’s verification state.  Hornet itself does not
enforce a policy on whether unsigned or partially signed programs
should be rejected. It delegates that decision to downstream LSMs
hook, making it a composable building block in a larger security
architecture.

Changes in V4:
- IPE integration
- Arbitrary keyring support

Link to V3: https://lore.kernel.org/linux-security-module/20260326060655.2550595-1-bboscaccy@linux.microsoft.com/

Changes in V3:
- Updated for signed attribute patch series changes
- Added some new result enum values
- Minor documentation clarification
- Misc style fixes
- Added missing signed-off-by tags

Link to V2: https://lore.kernel.org/linux-security-module/20260227233930.2418522-1-bboscaccy@linux.microsoft.com/

Changes in V2:
- Addressed possible TocTou races in hash verification
- Improved documentation and tooling
- Added Alexie's nack

Link to RFC: https://lore.kernel.org/linux-security-module/20251211021257.1208712-1-bboscaccy@linux.microsoft.com/


Blaise Boscaccy (6):
  lsm: security: Add additional enum values for bpf integrity checks
  security: Hornet LSM
  hornet: Introduce gen_sig
  hornet: Add a light skeleton data extractor scripts
  selftests/hornet: Add a selftest for the Hornet LSM
  ipe: Add BPF program load policy enforcement via Hornet integration

James Bottomley (3):
  crypto: pkcs7: add flag for validated trust on a signed info block
  crypto: pkcs7: add ability to extract signed attributes by OID
  crypto: pkcs7: add tests for pkcs7_get_authattr

Paul Moore (1):
  lsm: framework for BPF integrity verification

 Documentation/admin-guide/LSM/Hornet.rst     | 321 +++++++++++++++
 Documentation/admin-guide/LSM/index.rst      |   1 +
 MAINTAINERS                                  |   9 +
 certs/system_keyring.c                       |   1 +
 crypto/asymmetric_keys/Makefile              |   4 +-
 crypto/asymmetric_keys/pkcs7_aa.asn1         |  18 +
 crypto/asymmetric_keys/pkcs7_key_type.c      |  44 ++-
 crypto/asymmetric_keys/pkcs7_parser.c        |  81 ++++
 crypto/asymmetric_keys/pkcs7_parser.h        |   1 +
 crypto/asymmetric_keys/pkcs7_trust.c         |   1 +
 include/crypto/pkcs7.h                       |   4 +
 include/linux/lsm_hook_defs.h                |   5 +
 include/linux/oid_registry.h                 |   3 +
 include/linux/security.h                     |  28 ++
 include/uapi/linux/lsm.h                     |   1 +
 scripts/Makefile                             |   1 +
 scripts/hornet/Makefile                      |   5 +
 scripts/hornet/extract-insn.sh               |  27 ++
 scripts/hornet/extract-map.sh                |  27 ++
 scripts/hornet/extract-skel.sh               |  27 ++
 scripts/hornet/gen_sig.c                     | 392 +++++++++++++++++++
 scripts/hornet/write-sig.sh                  |  27 ++
 security/Kconfig                             |   3 +-
 security/Makefile                            |   1 +
 security/hornet/Kconfig                      |  11 +
 security/hornet/Makefile                     |   7 +
 security/hornet/hornet.asn1                  |  13 +
 security/hornet/hornet_lsm.c                 | 346 ++++++++++++++++
 security/ipe/Kconfig                         |  14 +
 security/ipe/audit.c                         |  15 +
 security/ipe/eval.c                          |  73 +++-
 security/ipe/eval.h                          |   5 +
 security/ipe/hooks.c                         |  37 ++
 security/ipe/hooks.h                         |  11 +
 security/ipe/ipe.c                           |   3 +
 security/ipe/policy.h                        |  14 +
 security/ipe/policy_parser.c                 |  27 ++
 security/security.c                          |  75 +++-
 tools/testing/selftests/Makefile             |   1 +
 tools/testing/selftests/hornet/Makefile      |  63 +++
 tools/testing/selftests/hornet/loader.c      |  21 +
 tools/testing/selftests/hornet/trivial.bpf.c |  33 ++
 42 files changed, 1794 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/admin-guide/LSM/Hornet.rst
 create mode 100644 crypto/asymmetric_keys/pkcs7_aa.asn1
 create mode 100644 scripts/hornet/Makefile
 create mode 100755 scripts/hornet/extract-insn.sh
 create mode 100755 scripts/hornet/extract-map.sh
 create mode 100755 scripts/hornet/extract-skel.sh
 create mode 100644 scripts/hornet/gen_sig.c
 create mode 100755 scripts/hornet/write-sig.sh
 create mode 100644 security/hornet/Kconfig
 create mode 100644 security/hornet/Makefile
 create mode 100644 security/hornet/hornet.asn1
 create mode 100644 security/hornet/hornet_lsm.c
 create mode 100644 tools/testing/selftests/hornet/Makefile
 create mode 100644 tools/testing/selftests/hornet/loader.c
 create mode 100644 tools/testing/selftests/hornet/trivial.bpf.c

-- 
2.53.0

