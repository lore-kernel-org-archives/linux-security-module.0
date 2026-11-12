Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794466783;
	b=H5p2uFrINRpDSco2pywSUszd0Xv6Ikr1q30TN5y87wmkQc0dUUFP7rxXDEqS6RwJs0yE
	 ObFBz4QCB2us/bFxl1sFZwG85Tcb2oprFReMrMOWtl1Vat7b3gzm+MadBN8wdiWTAKTxL
	 OUlSgHylCYMPDivkCJw1RIfOM+AhCc7+ampA7pRYDIEsPAcmUTuDMBhzpXV21mdfgn0aK
	 Rgr+USVO5xWcE28vSs9cYUsCiKPGI1EJUkFhgDy0HQLusqPibalX3bTbehDrulQ59rzbs
	 7VnBC0D8YVduhH2SOBILyqX8gMyRoUC/ZtQrNu3y11Q1n6Zd4vmgSNbsvgb3qTNVmRA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794466783;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=rNduiENQ9vhtrjuPl8puxUBgMaXfaonka9e702B4Qpw=;
	b=fpmFPmhwq/vYbw8XIdBsrhRJdZXv3fzUjLyrz2syvLTrsUQZMoG+M9hkAWLYyTcWJ3IX
	 3MDuv2ajnZrJ8WGq7QC9uNJoiPRODGusb69P/66GrHi6LiR5sX6ncylxgStpVCm/rvdMa
	 hCqtzHjkH7W9S6OaIE/RleOumh72XLM61a+wH3KJPOVdljR9A7j6+Bvd29Mff1YE59lRb
	 Yy1+DMujMA+v2bJsPDzhREtzDwVe/wl3qwEzMjhTK6l7zr7e6xqZ5PVoUFLkmPXMVaeRq
	 W6h8t87rp6/ypF+l52k/cXMkSpWwMOvsYl/FEprX7k1cTfTlOnEosKurgSAqcfEoJ4A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=glabDw3a;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43152606A32A;
	Thu, 12 Nov 2026 06:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=glabDw3a
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794466782;
	b=Ndg9ErfyuhV+WsxKY6JFCyjCM1iaNFs1yK/06QOFiFkuL+A1+LWgj2zvFyq9ScFKL6OZ
	 Y8p8fO0h1ycqkhbGWdx9Y0f3S7M/Xgx9fpD07uhWzqmQBcAvYjTMSlxvjLZZ3O68de7QY
	 Y37iKw0aGd4COxAmkc1usK9BVclxhM9cBA8frmc7qDO7YNd0/gSNT8I+p3/513KXutUf2
	 vqe4ABXlW7eaz2g0X8bYdSIJzCNbWoVm99YIPClkds6GoHt1g2ENMzC/B6H4pvOoAWHQF
	 Kp5dbB9TCvwHXSsbOj2GNo6s2q3JeRE2QT6hSfQJxycUThqRZ7e3QI1xGwy0zQ8o+dw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794466782;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=rNduiENQ9vhtrjuPl8puxUBgMaXfaonka9e702B4Qpw=;
	b=wBlf7YYL1Tap3CY+KvXEEsDsKODnfv0Tkl+hoGct1RdRoBayYVS/AL+D/jdLeLD6KlW0
	 Qskij0o80z6E9+lrDXxbn8+4WU8wrgvUtay4wTzvVnBW7WnF8b6QQPRw4WCDkubxuoMYQ
	 pUzyhEXegn6n61/82PZQ/Dkyx7LBvKEdJoGCFTwdA64pFCQLZdrF0Q2yRlyW65/KXDjTD
	 xhiqQLCa/5BLTWVyeIvorDNN+w72vgnsM1+bUn/NwgRXd4AwX5gXm95J68BCCqJANRj28
	 YJljbkoG6hII1/uOvMcmyjzzDgrPTf6vLJP/c5yhWZWdcGcm5eOs+LnnAlF64j1RzuA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 52CA11F00A05;
	Thu, 12 Nov 2026 06:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794466782;
	bh=rNduiENQ9vhtrjuPl8puxUBgMaXfaonka9e702B4Qpw=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=glabDw3ad+goMtzBkEd9rQmqMIPvUajUtrkvKhLl2oO8khrQI4lZr5HDzbwYd6kKL
	 CoKnm6owDfcS3C8R0ANz/yTPI+sMRblN2muX9WsacN595P/svpWVDJPkjlywGHuxzb
	 iuow6zn+N59w2RsNlpG1wvFDAawb5Z/HZkWZxzH/wG0xylzwZvnPcUejxkJrQB/caD
	 pWbHxCN9Nuoosg9ErNAS1d/CP1E8R3qNTQ0QxNRIUeIeFRpFmfE/uf8I7GnspO7tOh
	 DfvOqTI7r2wq6A3YaBaF6NKM66XBLdSYgSIIdFipTQ/xbG9IBGb/eAkUgWFYO0I0a2
	 LzNg98O6RVsEQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id A3F32492F2;
	Thu, 12 Nov 2026 06:59:41 +0000 (UTC)
From: Weidong Wang via B4 Relay <devnull+weidongw.illinois.edu@kernel.org>
Date: Thu, 12 Nov 2026 00:56:11 -0600
Subject: [PATCH] ima: reject duplicate fsname= in a policy rule
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261112-c3-n204-v1-1-dd9400b9ece8@illinois.edu>
X-B4-Tracking: v=1; b=H4sIAAtj9WoC/yXMQQ5AMBCF4avIrDUxQ0pcRSyqBmNR0iIScXfF8
 kv+9y4I7IUD1MkFng8JsrgITBOwk3EjK+mjgTLSiEjK5spRVihTEWNZ6aIrNcR69TzI+T017e+
 wdzPb7Z3DfT+ayAPUawAAAA==
X-Change-ID: 20261112-c3-n204-a82e17864b76
To: Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
 linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijie Zhao <zijie4@illinois.edu>, 
 Weidong Wang <weidongw@illinois.edu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794466781; l=3130;
 i=weidongw@illinois.edu; s=20261108; h=from:subject:message-id;
 bh=YGNbmdIKoUZltwnBYfWkHQKsciAD4PKBCRhCaE1+1UI=;
 b=4mb0v9yD+DWL94QnJHXjVFAc9KVagxK9XVa02IFOvT8sgRKBXYR4REO5WY7iFuUHoGsCpmAz5
 hptdCWvDfCFCRSHcRMOFTmcIViSfxZYjR7/IMQjnieDszYjTMNYCxoR
X-Developer-Key: i=weidongw@illinois.edu; a=ed25519;
 pk=DR2S1xPEa5sELrWPfOpvUphJQ2VHC+MDc/wJavE/ifg=
X-Endpoint-Received: by B4 Relay for weidongw@illinois.edu/20261108 with
 auth_id=1449
X-Original-From: Weidong Wang <weidongw@illinois.edu>
Reply-To: weidongw@illinois.edu
Content-Transfer-Encoding: 7bit

From: Weidong Wang <weidongw@illinois.edu>

ima_parse_rule() stores the fsname= value with kstrdup() but, unlike
fsmagic=, fs_subtype= and the other options, does not check whether the
rule already has one. A rule that names fsname= twice overwrites
entry->fsname and leaks the first string.

Reject the duplicate with -EINVAL, as fs_subtype= does. Such a rule used
to be accepted with the last fsname= taking effect; giving the option
twice was never meaningful, and the other options already reject it.

Writing the policy requires CAP_SYS_ADMIN, so the leak is limited to a
few bytes per malformed rule loaded by a privileged user.

The leak was found by an AI code review agent (an LLM-based bug-finding
tool developed by Zijie Zhao and the submitter) and confirmed on an
unmodified kernel, without error injection, on x86_64 under QEMU with
kmemleak: loading 64 rules with a duplicated fsname= left 64
unreferenced objects allocated by kstrdup() in ima_parse_rule() (inlined
into ima_parse_add_rule()); the same rules with a single fsname= left
none. With this patch the duplicate rules are rejected and kmemleak
reports nothing; rules with a single fsname= are still accepted.

The reproducer, fix and changelog were drafted with AI assistance
(Claude), then reviewed and tested by the submitter.

Fixes: f1b08bbcbdaf ("ima: define a new policy condition based on the filesystem name")
Cc: Zijie Zhao <zijie4@illinois.edu>
Signed-off-by: Weidong Wang <weidongw@illinois.edu>
---
Tested on v7.4-rc1 (05441d697f7f), x86_64, QEMU/KVM, kmemleak, booted
with slab_debug=U. 64 rules written to the IMA policy file at once:

  trigger  "dont_measure fsname=pocfsA<i> fsname=pocfsB<i>"
  control  "dont_measure fsname=pocfsA<i>"

               trigger                         control
  unpatched    accepted; 64 unreferenced       accepted; none
               objects, all "pocfsA<i>"
  patched      write rejected; none            accepted; none

Without slab_debug=U kmemleak reports none of these leaks on this
kernel: stale pointers in the per-CPU slab sheaves keep the leaked
strings "referenced". Writing the policy more than once needs
CONFIG_IMA_WRITE_POLICY=y, which the test kernel has. The code is
unchanged in mainline, linux-next (next-20261111) and next-integrity.

The reproducer is available on request.
---
 security/integrity/ima/ima_policy.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 2dc1d93aa..f08ca00bd 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -1619,6 +1619,11 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 		case Opt_fsname:
 			ima_log_string(ab, "fsname", args[0].from);
 
+			if (entry->fsname) {
+				result = -EINVAL;
+				break;
+			}
+
 			entry->fsname = kstrdup(args[0].from, GFP_KERNEL);
 			if (!entry->fsname) {
 				result = -ENOMEM;

---
base-commit: 05441d697f7f9a927264f4058cbbc6a03dfcac9d
change-id: 20261112-c3-n204-a82e17864b76

Best regards,
--  
Weidong Wang <weidongw@illinois.edu>


