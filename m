Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802315;
	b=t9YvvpTfAyJH1h8uhz8wOl5+LA1FcJwtcVIvOqTtBFf5RMODXcaR76Es/HY89QD18xfu
	 xlmUzTn6p4sa0JTxSbvq80w+IxGR3/TLFNfJSGJ+JTL9ZASNbWl3psHdpJuwwHnga0Rga
	 K41VFqBlkLo6cSniiuDedWIHRV7uKYcmkXBnS0n4rPJTwot5Ri9b3OtAHEHF8NXA97XoZ
	 9kDdZPCE70sloQp3PZj/WkMRDGyiVi1Nbh74EUO+crUOPkXPA4yrV0cIaFR20VGaaQtXs
	 Nysyvld/FcY8D0YXPVw0MMZ5Qi0GOTHxiPaNhg4CPBjd/lTMwuMLMTtmC4kLtvLWp8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802315;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=8SqVqOor5x0swrcQlWs1oXfTolSQ94eqY4/417d2g/c=;
	b=x8Hd7SJ5ZHtqRHM/+Rnw+iXsQJSIfzwSx92sWPovZ4O714OjR2RcAwuc/ZGrNjkns7fu
	 sn+qo7NtYqwVoxV8XzAR9PaylAFA4yBIIsnX/crgc7UlZo8kw4m9f6hYc4X2rjk/5yTiD
	 zU+dh3+4rYlhfcBOCIra/N0246Hcpyou++5Laz/wI5CGEF3putNwJ/Ptd7iMKifb+fsud
	 pwj8xehVgC8C/PBcGbDytMBXFtsV2jO+7OkVawtjASAlQZ3y6+i0/u5s3O2ydu9z8lxOh
	 bL5ZccweRTt7+5Hd1vNF4C+lLsFD18AzBo+9EoAk9nCu2Dj8bqWJLaIxx8CQWapvw0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=TIBS42R6;
	arc=none smtp.remote-ip=209.85.222.178
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2220606A326
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 14:25:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2220606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=TIBS42R6
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-93e64d52949so69868085a.1
        for <linux-security-module@vger.kernel.org>; Wed, 04 Nov 2026 06:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793802314; x=1794407114; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8SqVqOor5x0swrcQlWs1oXfTolSQ94eqY4/417d2g/c=;
        b=TIBS42R6gagObM3Y6q6MqKNHybNEVYTgSyBBZ65hsLXrQW7m17/l1FXh0IIMSaRa9l
         2HGpeP60Qr2rWKIaivxQnGpJ2JsFRfb8oplb+qL1Bok3a9S46wuu0sB0ajj8Ukged+Jd
         pb3jkmdT76RsMMoxdonkRO5TInvbhhS03LbId8qazKg9pgvhGuH/Fbdpc5fOMQ0g4TtD
         Ms5zGTB4+J6EFElTLuVGl2rID9ixM4XTaCljd2CBc8cfVmmZHHHtmz635XElcGJVAwN1
         7Q/a+LL0kxDgaUSgcLMEiGvh9cvtdtl0UdXCcut04sGDifS9aZCL9SpIo8BCiykFGyIV
         V31A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793802314; x=1794407114;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8SqVqOor5x0swrcQlWs1oXfTolSQ94eqY4/417d2g/c=;
        b=ifX6Rz78PDKetEo97/FhailaABiDWwwFygjRiEo8dFv0jf16u344M8IY4fDM/Ba5ZT
         YD7B9a9FEOP+5qC7oX3c6D19tK0aUAdfBC5/+/C10d8wmKqbJxFWMNYwNsALfVVJi/XR
         kwFU2TXOITBNrDR4lSnw+751JC+nhgx27fCLkQTtldXmUePtRZnzDcLHz2toHcqUL0KT
         4AcNDkZDf2JZAsCANsrLJ1P5OSqH8mOwy2j1d838Jc3/+IRE9UkLRJ4u+4YGA+5Q5id/
         tu8K1x9mrC6/M/iRiRRGoGwnGrAS6jBgTRA+4eoRY1NvepeV0KUuea5A0GG7T7afJd/X
         cPjQ==
X-Forwarded-Encrypted: i=1; AKwUvBxNFr/YRhOyYy/DEot+fKZAd+qa3jLbImg8u7qq0ITBOV5tzNUirfJ8/TOIHZWnwlIGD9i3WoXhi2FtNqeMUpnpwCYczVM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8tGVdoGUwuhouq4/iAR6oI1hJGzktXPBAZmUCxIo76pVHic8Zb
	l73jwJT0Uws3SKFotQqVbRuXDP5bYOwzp0lVTBGRltZNK0JwWrj3C/SjpSVYXV1uyak6pEmU9N0
	AmaiA+GNEhA==
X-Gm-Gg: AYBFou0Spdd/HxII6YuMZG/vBjP1qJAcv7f2Y+u/JY8X1rGqY/j2wbu5mqNS+jWK/qn
	nwb364KUSiHav2dyfzQqIxegcMmlLZc9qyFHYWxTxwUxpGpCrGUDpteUi0DNZDSIee2u8FOZQyJ
	E2wv1XIUjU9xisiAgFQD8yuh7uNU5jnoVSqCxOMcYavwBK9XmjVITm/aRl1iEovz9h/R0sl724X
	t1xR1AkT1oa2SWj0+NjWheAYmxCOhDDV755PqYeSwHT6TlYcwydWhx5p6y0bx7OlgoMLma/Bc8Y
	MImOUCD2tKcjm3ZQ75mb+uL5N1lJ4sRTem55rmYBAJA+S6vtm1Dr97yN54KSjxrySxqRjenzo2W
	DURifskfuGLNIEiv2N4Noji9pFD//WrtBYzgYJNF1BGyDgCO6xfTCPMF6SQ6ne0KiCoO9qxz3O7
	A14OHdI3H6oNfgqgZ4JfVRkTnOO7Y5Me7yA/AJfnvnYol8vfQ0f5ebo6UfvL1RyVz3Vmj4FCrKw
	omQ+nabPuXScIwnwoVUmzPa0BdUwm/UAFu8nOkiGHanbtzAimzbo6enYp5iiIbqUgPKNSq7Mndx
	H4vM4Qv5xyCJ1lLgWWoX7DuZNjAm7Vm+GHXxyeuFp2HliQ==
X-Received: by 2002:a05:620a:272a:b0:93e:c35b:2332 with SMTP id af79cd13be357-9442184e908mr2661347985a.73.1793802314009;
        Wed, 04 Nov 2026 06:25:14 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.242])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d4898a06sm209917385a.42.2026.11.04.06.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 06:25:12 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 04 Nov 2026 14:24:39 +0000
Subject: [PATCH v2 12/13] ptrace: use cred_ids_allow_control()
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-b4-cred-ids-v2-12-956213608f16@toxicpanda.com>
References: <20261104-b4-cred-ids-v2-0-956213608f16@toxicpanda.com>
In-Reply-To: <20261104-b4-cred-ids-v2-0-956213608f16@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>, 
 Paul Moore <paul@paul-moore.com>
Cc: Serge Hallyn <sergeh@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793802280; l=2045;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=9DmbRYL9nHbIrwEdqslR1HfoLxxnNGAAY3s4ZuSx70k=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QCPouo4xXV/GVLy1uelleQqnw8GVnO0OfsD+sD2IlkuRSz25DloSK9u/PQ7MJcxM5iQ+V8UcwcQ
 YmSXy3QPcJAk=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

__ptrace_may_access() picks the filesystem or the real uid and gid of the
caller by its mode and wants them to be all three of the uids and gids of
the target. Say which ids it is and use the library.

No functional change.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel/ptrace.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 3f2fe68ccb14..8024d80f82e3 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -305,8 +305,7 @@ static bool task_still_dumpable(struct task_struct *task, unsigned int mode)
 static int __ptrace_may_access(struct task_struct *task, unsigned int mode)
 {
 	const struct cred *cred = current_cred(), *tcred;
-	kuid_t caller_uid;
-	kgid_t caller_gid;
+	enum cred_ids caller_ids;
 
 	if (!(mode & PTRACE_MODE_FSCREDS) == !(mode & PTRACE_MODE_REALCREDS)) {
 		WARN(1, "denying ptrace access check without PTRACE_MODE_*CREDS\n");
@@ -327,8 +326,7 @@ static int __ptrace_may_access(struct task_struct *task, unsigned int mode)
 		return 0;
 	rcu_read_lock();
 	if (mode & PTRACE_MODE_FSCREDS) {
-		caller_uid = cred->fsuid;
-		caller_gid = cred->fsgid;
+		caller_ids = CRED_IDS_FS;
 	} else {
 		/*
 		 * Using the euid would make more sense here, but something
@@ -338,16 +336,10 @@ static int __ptrace_may_access(struct task_struct *task, unsigned int mode)
 		 * used a syscall that requests access to another process
 		 * (and not a filesystem syscall to procfs).
 		 */
-		caller_uid = cred->uid;
-		caller_gid = cred->gid;
+		caller_ids = CRED_IDS_REAL;
 	}
 	tcred = __task_cred(task);
-	if (uid_eq(caller_uid, tcred->euid) &&
-	    uid_eq(caller_uid, tcred->suid) &&
-	    uid_eq(caller_uid, tcred->uid)  &&
-	    gid_eq(caller_gid, tcred->egid) &&
-	    gid_eq(caller_gid, tcred->sgid) &&
-	    gid_eq(caller_gid, tcred->gid))
+	if (cred_ids_allow_control(cred, caller_ids, tcred))
 		goto ok;
 	if (ptrace_has_cap(tcred->user_ns, mode))
 		goto ok;

-- 
2.55.0

