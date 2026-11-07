Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047159;
	b=yvm4NUN7f/OlEDCjL63drYwDNo9mjtI8DLtHaM9nwIeZiu3m9vwZZwmDLn6Mbi8zVyw4
	 IunscHTCA7pb3MHGYNaJ646KPATVh2Of/IeyBIoNiPo57xnJzOp7xEzj+u3oBQiOSGEQd
	 MajHr6Pwomns6WqYIM+MXEDpr8wy7DfAlL2xQnWVU+ay8RUhYawl3VrDP1bmW0f68LdUr
	 srbHLpx0LjCrdr1441HBS8FfjR0K/x5bADRQ4fDWUwoZnHRnvLJhSmyDcLOMb+Xdk+rfp
	 mLsP/IXhWOl2WIQjUbbvoaLsXQcN1haH6V46LUqTphRcTXqZGfrp1E4ES32PwsZCb2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047159;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=/H39EACLDPLlWZGOOszNpCzWihvn5UTbcxV45W+rw24=;
	b=ZeBXgIv8fbO8DG9sQMonXrWTN4LZXdhcrqqM3dtZUhA01r+Tn5F3JMBmtpEscXyTrylY
	 iuTH6TFVcQeVXY6Qw2HffzrnryMbqSD0mF6mlW9sSI0ZnMKRXfwj1ODj7UXsol02VQJpf
	 fopfXgGvrdkZi8jCcRyD2NlL4wDcHeiw64/NOv4/9L9/HivFNTLVin+iK4XrF3wRVptrT
	 3fYwC+rO5HosZ1NySMYIAaCT9yNLb0wB6j1yVdNPfKc8tzPDxR2HYOFnkIX3wDxSFWcgv
	 /+3X/72mQDh65nQLhyBZrbcOP2bHqOjcvPKotBmP02qci6xcdW6aJO9+eEpIzMbtg5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uBdh8iPP;
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3553606A32C
	for <linux-security-module@vger.kernel.org>; Sat,  7 Nov 2026 10:25:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3553606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uBdh8iPP
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cd3310348d2so150129a12.1
        for <linux-security-module@vger.kernel.org>; Sat, 07 Nov 2026 02:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794047158; x=1794651958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/H39EACLDPLlWZGOOszNpCzWihvn5UTbcxV45W+rw24=;
        b=uBdh8iPPxh7WomiEfzTY2osL0T+VlcuAAKoibyb5LRkVlhERGFHzSR2+04VBWRR3Lv
         ISdrSLOiy/SVIRDzf9L9csYQh4Xxj9l3qdogTSrrMZ8CJaKLYHMSiQhpVOzMgo3nvxky
         UW7CHI49A1zzcz8AUGGVlpcuPO/LbVCgUPMZbC2eXW99RtNRwabBp/wz4KGhyRz/EGwX
         2UmVnevy8paOcXpZ3stRsCsu6NQGYnJCeJgvoQqIi9FdEHFSrnH/PuU8Bi24rPVxb3c8
         gD6fdhk1W1/JzOgKxVj4GJ2YJGZ9lWkrQsDNALhzVKmZMe3Rwdm95o9QnRCUr3dT41RK
         Z/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794047158; x=1794651958;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/H39EACLDPLlWZGOOszNpCzWihvn5UTbcxV45W+rw24=;
        b=K8ymrAeYl3g5tAZPmsTvv7gRpwj8Bz8dpjsiem58RK9m83Ht6jrmzymEtmFvrifiOZ
         xkhbfKfhUAUVXAFfmerBP229WwoMp9SjqJOmLC/EkhI7YUZslCtjZ1/jkRLvDFyE4xpk
         hgXyiooD9szCExQqgvLi/utilOMwILW+Cadba1RetJTYDzFte/eGZkhHJ9aLrN1rgS16
         lF89gJkfpDSwWCKru4CMpzfjtzvxHXtsxlc1AGurxdt05V7uoRIkLO12gFgpGUzubFBw
         0KeqwlrISndeillVQcEPInSj4WluFUicKk961oHbb7E750aIzXT5e7+LsMvLOfGCopsf
         6iNg==
X-Gm-Message-State: APuU4Z8A8t6mpdBChpRCT+be50Btw4cTvu3iSdX4SZ1ke4JcPOUoJrjS
	e2WppchUFuQC8y0n4Ct0ylYMLIPQOeuP+OFX9jh9pnDrNVHKflHSqK0+
X-Gm-Gg: AYBFou0xgkg1NsX++B4hrgL1RNVOcg+vv0jgAhjo2TWVuHBWsjZBSdqCjiHUJV3cunV
	CKMClmd78XIjlwvGs1Hx4L4t5gW/4iscg+r8WFXQXeOXQYsiRh7wAjqYyfVECSgA5MP0cRVQMR/
	PNupCuEIR22cT0GG8LEkODSblVyKwCTCKYQoBs4TAbFvr9aIIWZvrSmwOSMtjkYbRU+jlDsh8eN
	vpT3m1JIL7mJ2Pe7kOosOvX1LPcVOM2VqxlC8Wr+KjU6Ttt0Z1SVvVnWd9fWxolvLT22GtnQJxe
	FnB+Y7eAxXr2L9g36CO2Z1sVKAAPGnylibSRtnA12Q2e7V1czG1Qf4+0mFgbc3ISONXUrjajxub
	NxizT61zCSlX8qOAK0IvNnQMCVPzYTb/H1C2tnuf1GAaw2Q77aO3YT8f0zdcGXWwMyjnTeWeJFE
	PoTE6V085xufKB+6/8JJJLzfhsIZN4ZTtL0DmN0wJZP+UUdFzQfiFUhfIfkQBlsKtP8wTCXSXsq
	zK0UH7jU/JjEKXzU3OFt6/BaRyQMaUjoZi9i/MawtVB1/vKjB2OBlyKVBNyaSdA6/X0ICKELEki
	gg22f8xB7Ma+kweDZqXPjN0/DWW1iiaQFhJvlKYVlR9QlVebSAM2AR2MktQpeWfnLM4/wdt7uTx
	Muw==
X-Received: by 2002:a17:90b:3cc6:b0:3a8:786a:cfed with SMTP id 98e67ed59e1d1-3b10659feaemr1154902a91.37.1794047158052;
        Sat, 07 Nov 2026 02:25:58 -0800 (PST)
Received: from Terra.tail0ac356.ts.net ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1152fa888sm207764a91.9.2026.11.07.02.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 02:25:57 -0800 (PST)
From: Weiming Shi <bestswngs@gmail.com>
To: John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	stable@vger.kernel.org,
	co+c85e76ce40a43b9b@bugs.sh
Subject: [PATCH] apparmor: safely acquire the cached label in aa_file_perm()
Date: Sat,  7 Nov 2026 02:25:35 -0800
Message-ID: <20261107102534.816756-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

aa_file_perm() passes an unreferenced RCU snapshot of fctx->label to
aa_get_newest_label(). Its non-stale branch uses a plain kref_get(). Policy
replacement can drop the proxy reference after the stale test while
update_file_ctx() drops the cached reference, so pread64() can increment
the label's refcount from zero.

Acquire the RCU-published label with kref_get_unless_zero before testing it
for staleness, keeping the label alive while resolving its replacement.

refcount_t: addition on 0; use-after-free.
WARNING: lib/refcount.c:25 at refcount_warn_saturate+0x111/0x130, CPU#1: AAVICTIM/5091
RIP: refcount_warn_saturate (lib/refcount.c:25)
Call Trace:
 aa_file_perm (security/apparmor/file.c:657)
 common_file_perm (security/apparmor/lsm.c:529)
 security_file_permission (security/security.c:2392)
 rw_verify_area (fs/read_write.c:476)
 vfs_read (fs/read_write.c:566)
 __x64_sys_pread64 (fs/read_write.c:770)
 do_syscall_64 (arch/x86/entry/syscall_64.c:94)
 entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)

Fixes: bce4e7e9c45e ("apparmor: reduce rcu_read_lock scope for aa_file_perm mediation")
Cc: stable@vger.kernel.org
Reported-by: <co+c85e76ce40a43b9b@bugs.sh>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 security/apparmor/file.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/security/apparmor/file.c b/security/apparmor/file.c
index 694e157149e85e..59c27b9c5a8d15 100644
--- a/security/apparmor/file.c
+++ b/security/apparmor/file.c
@@ -621,7 +621,7 @@ int aa_file_perm(const char *op, const struct cred *subj_cred,
 		 u32 request, bool in_atomic)
 {
 	struct aa_file_ctx *fctx;
-	struct aa_label *flabel;
+	struct aa_label *flabel, *tmp;
 	u32 denied;
 	int error = 0;
 
@@ -654,7 +654,12 @@ int aa_file_perm(const char *op, const struct cred *subj_cred,
 	}
 
 	/* slow path - revalidate access */
-	flabel  = aa_get_newest_label(flabel);
+	flabel = aa_get_label_rcu(&fctx->label);
+	if (label_is_stale(flabel)) {
+		tmp = flabel;
+		flabel = aa_get_newest_label(tmp);
+		aa_put_label(tmp);
+	}
 	rcu_read_unlock();
 
 	if (path_mediated_fs(file->f_path.dentry))
-- 
2.56.0

