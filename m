Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF0133E37C
	for <linux-security-module@vger.kernel.org>; Tue,  2 Jun 2026 20:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780431824; cv=none; b=Q2rSen3d8n6mspfHP+PD5EQBLy26yeba56TW3r9MZYvpLbdllTTCeNRWc8GxEiaJjTlgU3UJ0V8kdMnV6Txz+pz4GHSSxGJGzRH3H5bwmerqAkFsHSnKEXu9NeGB2TL8da3YxJzw7CNegppA+jjHJsxWHNVAYIXB+sasiZeamz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780431824; c=relaxed/simple;
	bh=wEoo7myzJcpfoEbauBmLowgwhWmu4TyWNYvtwephyFE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Hg/SMEofGeaA0RG8ZlziBuZVlH4Pbizz7BoysrNTKpvgtbI7EGAMDnjnt1Y/44+5V5FheIsRi85h2BwIyuxCC9Zwf/Bquy47At1TdRNzOTfqk/uZN5tny2H/iIbNaV8+kGZ+Rjd8fwjmkeGkzNTGPLSdXd7gTDdlrcVlqRzBrtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=rcwxJy/C; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="rcwxJy/C"
Received: from narnia.corp.microsoft.com (unknown [40.78.13.173])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6BACC20B7167;
	Tue,  2 Jun 2026 13:23:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6BACC20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1780431808;
	bh=mKXXgx5bBTRAtngg47MmJYiZa+98A702lGaVz/cyVjM=;
	h=From:To:Subject:Date:From;
	b=rcwxJy/CsEBzRo1D39vZxClX4hrI7ugaTHlRAApLWO2phVmbWZBDj0eN02odCNkTB
	 iVOU6s8Fhdgi1cHuzdnf0ve7cW/FAnvEi7IY6DgWRkKoyPYyvy6lbNCSub5EgHP6fH
	 +Qlw+VqrqI8N4ujF6c5l3avgpmIvYtgc0cO/k+u0=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: "Paul Moore" <paul@paul-moore.com>,
	"Fan Wu" <wufan@kernel.org>,
	"Blaise Boscaccy" <bboscaccy@linux.microsoft.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH 0/3]  hornet: post-TOCTOU-fix cleanup and observability
Date: Tue,  2 Jun 2026 13:23:19 -0700
Message-ID: <20260602202336.3579863-1-bboscaccy@linux.microsoft.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a small follow-up series tying up loose ends from
commit cf5d6b993a43 ("hornet: fix TOCTOU in signed program
verification").

Patch 1 adds a pr_notice() when hornet_check_prog_maps()
rejects a load due to a map hash mismatch. The denial path
was previously silent; this makes policy denials observable
in the kernel log without changing enforcement behavior.

Patch 2 removes LSM_INT_VERDICT_UNEXPECTED from the
lsm_integrity_verdict enum and from IPE's bpf_signature
property. The TOCTOU fix collapsed the "unexpected map hash"
case into the existing BADSIG path, so UNEXPECTED is no
longer produced by any LSM. Removing the orphan enum value
and its IPE plumbing (audit string, property enum entry,
policy parser token, evaluator case, documentation) keeps
the verdict surface consistent with what providers actually
emit.

Patch 3 updates the signing-workflow documentation in
Documentation/admin-guide/LSM/Hornet.rst. gen_sig no longer
takes per-map indices after the TOCTOU fix, so the example
invocation is corrected to drop the ":0" suffix on --add.

No functional change to enforcement; observability +
cleanup only.

Blaise Boscaccy (3):
  hornet: log map hash check failures in prog map validation
  security, ipe: Remove LSM_INT_VERDICT_UNEXPECTED support
  hornet: update signing workflow documentation

 Documentation/admin-guide/LSM/Hornet.rst | 5 +----
 Documentation/admin-guide/LSM/ipe.rst    | 6 +-----
 Documentation/security/ipe.rst           | 3 +--
 include/linux/security.h                 | 1 -
 security/hornet/hornet_lsm.c             | 1 +
 security/ipe/audit.c                     | 1 -
 security/ipe/eval.c                      | 2 --
 security/ipe/policy.h                    | 1 -
 security/ipe/policy_parser.c             | 2 --
 9 files changed, 4 insertions(+), 18 deletions(-)

--
2.53.0

