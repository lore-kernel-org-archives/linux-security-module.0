Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2BD3ED136;
	Fri, 27 Feb 2026 23:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772235593; cv=none; b=X2ett2Aly1E6aEijsy3nN67oFHoBmHMdlk5AINSoIaKEFgAoPusMDtXetsdpKCqFrd0FJTLwjf72ImJRoYZV4T/HHReMeyjKksJPYR/peD1qdsEX/uv/LrTDM8dxt4/aUOA+nqc6hNdj18mE328mVBs53QioTY6o03lU1yEePvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772235593; c=relaxed/simple;
	bh=KcCnfgg5ecC2YzqLATrMKcgJK3gVvJSMWX7/uo0T2B4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VNuciO24XRCBKu+y+LaFiaiaHiHdLHV9cF/oYBxVRS2iH5SwvEyrGcbB6TfQyUVbtNbGnCZPLNOSvbGKqR1Lj5gD5ihkC5qJ8awagEHjQD4hfw3HYQZbDeBQlveUU8o2VxU773cmIY+Z8iyy7jCMhsuVtbScEqqZg0fPkmAgP6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=r42pYxoQ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="r42pYxoQ"
Received: from narnia.corp.microsoft.com (unknown [40.86.183.173])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5E00120B6F02;
	Fri, 27 Feb 2026 15:39:40 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5E00120B6F02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1772235582;
	bh=mGqDcC+nxviHSDAD2OTZ9M1DnTHcdp0y9/j6ZnFeKqw=;
	h=From:To:Subject:Date:From;
	b=r42pYxoQxkEB78yU7Izo6mEqiyXPP5CXlhkscwpG0ywKdk0LrxA5YkOhXPyjmsFaX
	 TXB+RRuE9tawXkkV+Q1ARrOFUBvSRE/UGDx84k3J/sTDyt0TIVD6Yh3PWiOvwKDz+b
	 8Qi+9pWHFAPOswFN7uah2nAwrKeNHX4cRlDYvi48=
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
	linux-security-module@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v2 00/10] Reintrodce Hornet LSM
Date: Fri, 27 Feb 2026 15:38:29 -0800
Message-ID: <20260227233930.2418522-1-bboscaccy@linux.microsoft.com>
X-Mailer: git-send-email 2.52.0
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


Changes in V2:
- Addressed possible TocTou races in hash verification
- Improved documentation and tooling
- Added Alexie's nack

Link to RFC: https://lore.kernel.org/linux-security-module/20251211021257.1208712-1-bboscaccy@linux.microsoft.com/


Blaise Boscaccy (4):
  security: Hornet LSM
  hornet: Introduce gen_sig
  hornet: Add a light skeleton data extractor scripts
  selftests/hornet: Add a selftest for the Hornet LSM

James Bottomley (5):
  certs: break out pkcs7 check into its own function
  crypto: pkcs7: add flag for validated trust on a signed info block
  crypto: pkcs7: allow pkcs7_digest() to be called from pkcs7_trust
  crypto: pkcs7: add ability to extract signed attributes by OID
  crypto: pkcs7: add tests for pkcs7_get_authattr

Paul Moore (1):
  lsm: framework for BPF integrity verification

 Documentation/admin-guide/LSM/Hornet.rst     | 310 +++++++++++++++
 Documentation/admin-guide/LSM/index.rst      |   1 +
 MAINTAINERS                                  |   9 +
 certs/system_keyring.c                       |  76 ++--
 crypto/asymmetric_keys/Makefile              |   4 +-
 crypto/asymmetric_keys/pkcs7_aa.asn1         |  18 +
 crypto/asymmetric_keys/pkcs7_key_type.c      |  42 +-
 crypto/asymmetric_keys/pkcs7_parser.c        |  81 ++++
 crypto/asymmetric_keys/pkcs7_parser.h        |   4 +
 crypto/asymmetric_keys/pkcs7_trust.c         |   9 +
 crypto/asymmetric_keys/pkcs7_verify.c        |  13 +-
 include/crypto/pkcs7.h                       |   4 +
 include/linux/lsm_hook_defs.h                |   5 +
 include/linux/oid_registry.h                 |   3 +
 include/linux/security.h                     |  25 ++
 include/linux/verification.h                 |   2 +
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
 security/hornet/hornet_lsm.c                 | 323 +++++++++++++++
 security/security.c                          |  75 +++-
 tools/testing/selftests/Makefile             |   1 +
 tools/testing/selftests/hornet/Makefile      |  63 +++
 tools/testing/selftests/hornet/loader.c      |  21 +
 tools/testing/selftests/hornet/trivial.bpf.c |  33 ++
 35 files changed, 1623 insertions(+), 41 deletions(-)
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
2.52.0

