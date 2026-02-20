Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3978831AA95
	for <linux-security-module@vger.kernel.org>; Fri, 20 Feb 2026 09:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771579187; cv=none; b=fb5LOkbBAESQTYDA0EQO1snrigUjLya0G5IA16HTiqtv3Tb5DkRvB+E69ldRhlBfJEm2GhZp5Z5kVSFLskwdyJgcpadX5hdHzoyCmxaT7WuyXSTSpFywMZsUtVs+r/Py2+fzIgDR3ezQ1Iqq5mVoDylY72/KXY2k01S/ZgqPUog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771579187; c=relaxed/simple;
	bh=RzVAsmgCX+eNpk235zObjm0hV3fCfptaf/FTUdQJ9Vs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=mUM9ywwyfZ/8lG3pkny/4h/rIPC07JnZB/bBPi+OghJkxrYAHzL6EPhnWR8TP3YHmFhxHEv7LF5gUGqGqs4FMAa9AeYUrdbpRLmid3qyxOWGTwSywXPZY8wfSIIsqUTsph76EQahoKRNVYYhyiEmB3Lhabgs64d/VH+1bKGIZH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zT5BGU2L; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zT5BGU2L"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4837cee2e9bso14546245e9.3
        for <linux-security-module@vger.kernel.org>; Fri, 20 Feb 2026 01:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771579184; x=1772183984; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gprspD6DwdfqC1wGIsWpNbG9c6i9DJdCUwDwX2fyK2k=;
        b=zT5BGU2LnopXgvvhUXgO1jkKOjePPIQcvIO8YUQCMF1JJTPs/KpHWQRC4eLdEWjYRJ
         bqlIx4xFtNOKODafRsRhZOJH4V6ri8yZtRvw44ZTeGUQeVJyn5QeWf56PLBsW6Y6IkQZ
         XtVpKWRSgZv+SnVlGqNeKkUP1pjH3h6WtM8nEaVHVsLlHdjYft+acXaZcrURgbKt6zNZ
         wTXdaccTQAFSPIudSkSRiHUB/PpoI4SiioXsJZhWI0XKr/nUrby0kIGf5pXXoxiIoFuT
         7nqHZr8PHEsZFrAk2wATioN+8uq5LNFrLLyn8XOSNbyKy5Y0ycQC7aO4kNHcDxTnZ5Qe
         6zRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771579184; x=1772183984;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gprspD6DwdfqC1wGIsWpNbG9c6i9DJdCUwDwX2fyK2k=;
        b=W3Ix534c/7aK7DdqEbUNtFJHDzH/DSuMVTJsmLwlHZVa+3tBiDoHkCRBXJW86p6esr
         hGVKFvwhE6Wte6nGpAh2n2nwyzX4pYwAcezlH8DoWWsz4jVDug9TbA+4oNBzSWh/k3+i
         Um72wbdZ45Wdg7ugn7KXDpyBRqEIwznJYF7SF6MK6eM9Qd+yztnlcRT8jsGr+hkYPAMK
         d6ss/QiS3Ppwd9a4eDbmp3v2T2FS39BesmzdsBUULIdQNmw/6PMLe5uITdJ24vgiKD9F
         CecMyOP2uhuIkJiIaDIxKrhjb+VHW2nn1msdcQVFGbwAwRphG9+yqhZpBwwrtSZibgx2
         WBWw==
X-Gm-Message-State: AOJu0YyUjkP7iXvHlxj3OPfTMxGq+gJohjmow/7MrdnyjM+JJm85c/7r
	vnLMqNciYeWxlAR+PtG/iRTqVJJxdQo1ySPtvMu/+Tt47I7b82ABfHkdhRxYVVwRyOFTx/90kcT
	Mv/ZENOH6VfkClMTcQQ==
X-Received: from wmos16.prod.google.com ([2002:a05:600c:45d0:b0:477:a181:1922])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:6389:b0:477:7af8:c8ad with SMTP id 5b1f17b1804b1-48379c1f4d3mr395686105e9.31.1771579184414;
 Fri, 20 Feb 2026 01:19:44 -0800 (PST)
Date: Fri, 20 Feb 2026 09:19:40 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2483; i=aliceryhl@google.com;
 h=from:subject; bh=RzVAsmgCX+eNpk235zObjm0hV3fCfptaf/FTUdQJ9Vs=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpmCcG2dYFauWFQwfok8OjVnzYeu//VaM+84liw
 zR2AoeZbkuJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaZgnBgAKCRAEWL7uWMY5
 RrHrEACR2OjvRIIbN//bRm/Sq1IOsPBvNbqKAvgjXkAydF1JViFY/R5Ly3aA8ht1NBkzmGA2WFJ
 RxuOLw98H4TKei1QuJ7hXXOb7KijtWM3Rd+5zN8mZr1/AtEaIK2TR1p9JcAiLNIxUDzMVyl8Pfx
 JMJL48Ps5SO9gRBOuExZGVDgL9gnn6D68JijUpe4ahgBDByI560TftG2k3oPh6avxXtulJ2U6Tq
 lwEirut3U+D9yBBVo+w12TmkurNU0jUWDwDqONBR1Gw6NYXApSYO6Eog23vrIRlvWKcfiDJhwHJ
 x+Gj+ONcLZPkMD7o9ECm5fBQXK11+PqjK/G03Z4oRZ2XLVidDcZ2sHlK7OcvyNLnWcq36BrSY2g
 bWCWyvj52cdAW0lMUUUKA0ds525fzke3DdDEWsx06EL2yuC00SldVADVqsxARmbQZJzp9bGjYyl
 aKQHf4C5l1uQvfYugMJpKqm7pOXmSMs8H/mEvIysxN5q8hckyWdFaMBrrymJDuODxqCA0C1jxR8
 viG8KUcrfhUMs2s/axMXUaA1g1LnOWsBFfXn3xic+UKCyk4Rx5UO9t/9+LBlhb24tWAKuhm9hX3
 vq03S0O0ZxAzaZ8OR9wNGf7W17wIXzNQ8YCTrugua2d0WoxIbs/bPRPp0W6MkKgICqsrURmYGoN bL3G6pnj6GL6EBQ==
X-Mailer: git-send-email 2.53.0.345.g96ddfc5eaa-goog
Message-ID: <20260220091941.1520313-1-aliceryhl@google.com>
Subject: [PATCH] cred: clarify usage of get_cred_rcu()
From: Alice Ryhl <aliceryhl@google.com>
To: Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="UTF-8"

After being confused by looking at get_cred() and get_cred_rcu(), I
figured out what's going on. Thus, add some comments to clarify how
get_cred_rcu() works for the benefit of others looking in the future.

Note that in principle we could add an assertion that non_rcu is zero in
the failure path of atomic_long_inc_not_zero().

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 include/linux/cred.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/cred.h b/include/linux/cred.h
index ed1609d78cd7..95dcf5e967c7 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -213,32 +213,50 @@ * get_cred_many - Get references on a set of credentials
 static inline const struct cred *get_cred_many(const struct cred *cred, int nr)
 {
 	struct cred *nonconst_cred = (struct cred *) cred;
 	if (!cred)
 		return cred;
 	nonconst_cred->non_rcu = 0;
 	atomic_long_add(nr, &nonconst_cred->usage);
 	return cred;
 }
 
 /*
  * get_cred - Get a reference on a set of credentials
  * @cred: The credentials to reference
  *
  * Get a reference on the specified set of credentials.  The caller must
  * release the reference.  If %NULL is passed, it is returned with no action.
  *
  * This is used to deal with a committed set of credentials.
  */
 static inline const struct cred *get_cred(const struct cred *cred)
 {
 	return get_cred_many(cred, 1);
 }
 
+/*
+ * get_cred_rcu - Get a reference on a set of credentials under rcu
+ * @cred: The credentials to reference
+ *
+ * Get a reference on the specified set of credentials, or %NULL if the last
+ * refcount has already been put.
+ *
+ * This is used to obtain a reference under an rcu read lock.
+ */
 static inline const struct cred *get_cred_rcu(const struct cred *cred)
 {
 	struct cred *nonconst_cred = (struct cred *) cred;
 	if (!cred)
 		return NULL;
 	if (!atomic_long_inc_not_zero(&nonconst_cred->usage))
 		return NULL;
+	/*
+	 * If non_rcu is not already zero, then this call to get_cred_rcu() is
+	 * probably wrong because if 'usage' goes to zero prior to this call,
+	 * then get_cred_rcu() assumes it is freed with rcu.
+	 *
+	 * However, an exception to this is using get_cred_rcu() in cases where
+	 * get_cred() would have been okay. To support that case, we do not
+	 * check non_rcu and set it to zero regardless.
+	 */
 	nonconst_cred->non_rcu = 0;
 	return cred;
 }
-- 
2.53.0.345.g96ddfc5eaa-goog

