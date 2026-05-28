Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F6D1DE3DC
	for <linux-security-module@vger.kernel.org>; Thu, 28 May 2026 03:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779937769; cv=none; b=SCHsIMYLQoxYpGEgAFfUFQ3QfDeSxezi48Q45ei13cf08UCtACSd2dvttqSJeEIUW0/AlGPMb2YH1obMaolkiBoEzQyl8Vt67P8dTm20fAhxWGvqyYfI6xzYddLVbtkZwIO6IYGCEBD5mHo0k+wsyIhkdO2TQhEP36CvwOD0n2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779937769; c=relaxed/simple;
	bh=WK4+3KCn4Vh9YzJinK4scBz33DK1YCO+/GoEgzuuZtA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qm9FSh+stgKitQEjeRNUh3whtUEjOF8CccbDPmZ8vH0mBGYd6dT/J1rAZAjx5gf+JYRuPo9BvK4T4Z9I4GeX9qAgPipiHmoVBj6E2z/+yrwCh50svrF5x2j21V4nbRjGGy1MEkpL5DfmGtQMwqseOilkic2JRvAb+FjdEa9O9IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=VUiGUUl/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="VUiGUUl/"
Received: from narnia.corp.microsoft.com (unknown [40.78.13.147])
	by linux.microsoft.com (Postfix) with ESMTPSA id 54E1E20B7167;
	Wed, 27 May 2026 20:09:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 54E1E20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779937752;
	bh=D6CNSALyPv7xmr6yrBr28CsTLCUjCoExXbaNWGGToTE=;
	h=From:To:Subject:Date:From;
	b=VUiGUUl/NQ7cAA5kl75iYu0Qp/Jp83XxPAOvoefyE9l+qoMgM3k6oKMm4mzFowASJ
	 gNsa03jL/TVn4xhAbIRqCdMjct3Kx7KkiWmDNwT2ETK7LKlhS78CEI4Cm5cN0heHby
	 da+J38lUnR+dxz04IQtXHp4MaAcvV2tySf0f285A=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: "Jonathan Corbet" <corbet@lwn.net>,
	"Shuah Khan" <skhan@linuxfoundation.org>,
	"Paul Moore" <paul@paul-moore.com>,
	"James Morris" <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"Eric Biggers" <ebiggers@kernel.org>,
	"Fan Wu" <wufan@kernel.org>,
	James.Bottomley@HansenPartnership.com,
	"Blaise Boscaccy" <bboscaccy@linux.microsoft.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH 00/11] hornet: security, tooling and selftest fixes
Date: Wed, 27 May 2026 20:08:09 -0700
Message-ID: <20260528030915.2654994-1-bboscaccy@linux.microsoft.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Patch 1 closes a TOCTOU race in signature verification. Map
contents were hashed at the program-load hook and re-hashed at
the program-run hook, leaving a window in which a sufficiently
privileged attacker could mutate a map between the two checks
and run a program whose maps no longer matched what was signed.
The fix records the verified hashes on the prog at load time
and, in security_bpf_prog, checks them against
prog->aux->used_maps — the same map set the verifier and
runtime resolve against — so the verified and executed sets
cannot diverge. The per-map index in the signature format is no
longer needed and is dropped; the check becomes a subset test.
Reported by Eric Biggers.

Patches 2-3 fix two counting bugs in the same area: duplicate maps
could satisfy the required hash count, and an off-by-one capped
accepted maps at MAX_USED_MAPS.

Patches 4-11 are in response to sashiko feedback found here:
https://sashiko.dev/#/patchset/20260507191416.2984054-1-bboscaccy%40linux.microsoft.com

They provide some correctness fixes in the hornet tooling along with
making the selftest behave under cross-compilation and skip cleanly
when signing keys / bpftool / vmlinux BTF are unavailable, instead of
breaking the global selftest build.


Blaise Boscaccy (11):
  hornet: fix TOCTOU in signed program verification
  hornet: invert map set check logic
  hornet: fix off-by-one bug in max used maps check
  selftests: hornet: handle cross compilation and test skipping
  hornet: gen_sig: fix off-by-one check for used maps
  hornet: gen_sig: fix error string allocations
  hornet: gen_sig: check for bad allocations
  hornet: gen_sig: fix missing command line switches
  hornet: scripts: set a non-zero error code for usage
  hornet: scripts: harden scripts to handle trailing whitespace
  hornet: scripts: Improve argument handling and error messages

 Documentation/admin-guide/LSM/Hornet.rst |  39 +++---
 scripts/hornet/extract-insn.sh           |  24 ++--
 scripts/hornet/extract-map.sh            |  25 ++--
 scripts/hornet/extract-skel.sh           |  35 ++++--
 scripts/hornet/gen_sig.c                 |  61 ++++++----
 scripts/hornet/write-sig.sh              |  10 +-
 security/hornet/hornet.asn1              |   1 -
 security/hornet/hornet_lsm.c             | 148 ++++-------------------
 tools/testing/selftests/hornet/Makefile  | 114 +++++++++++++----
 9 files changed, 235 insertions(+), 222 deletions(-)

-- 
2.53.0

