Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA46B3C3458
	for <linux-security-module@vger.kernel.org>; Wed,  9 Sep 2026 19:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788982670; cv=none; b=d8E/qnlLMj9JnmUM6ryp3V0XtvBcNSdP2noLeAkrAd84FQBopdzGPdbTNe0WborcrHHAE72HI/OQQC2EXNL4BbT7vKyTNt9IqSi9/l58plnCF11loX26+7DIuQg61vUeUtcu2gnfsYbux8Y5upFu3/Rddt/5MdCN4vLPP8LqRb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788982670; c=relaxed/simple;
	bh=9ahnDuIzIlnNHViEcr2anfgH+TEO7ySvpOYjKqJILUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mrRsvW27NUpYFhOaI3xDYQjlOT2V/Or9+pBFYcaC7JUN4Tq2TxrBpjeFNEeMFvLQJNZZZZ22pHYVq5/crRAZqcpGg26TJFzV/+n0GDkR3isyv8p3bS1PRel3W60Ux02jHoC671zeA6r67E5R/zADFGtkB7MGHFszAtlXM+6I82Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M2pOVb/r; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2pOVb/r"
Received: by mail-yx2-f12.google.com with SMTP id 00721157ae682-85d46e4cdccso15642927b3.1
        for <linux-security-module@vger.kernel.org>; Wed, 09 Sep 2026 12:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788982667; x=1789587467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zGIeBhiHsvfHjC9J6yImwRdInjaib4hfso2CvsNy6M8=;
        b=M2pOVb/rAfpf8c9Bwl119L9N7ddnxvT5Lbk9i6+QWTaEubnmJWawrFUNA50Uo7qUPV
         /aIeqtSlCiMonnO5wF9h7AWiL9dEk7o3Y5Y8rRbdoQxxavkeE5CGX5k+ttq3Q/CGH+SV
         Ku1ktKHEp7r1wvAJ+K++lW3QeNhT2WaEQ5bk4KOuPpNbq3GvWbN41+M4rkBjEYwZEWkJ
         0UVumj99TnBBTgLSYkD/6RiJEMew+Lr2sRmDSQZl/8SVJmqfD67f0b6BOiyfgfCyHFwu
         p93lA954WmeNCqAVjLy4zJI0iEnJ2xpIq6gSEVw4v2G3Zj/r1IwR2+FEw+FRjFsRIM/y
         9mNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788982667; x=1789587467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zGIeBhiHsvfHjC9J6yImwRdInjaib4hfso2CvsNy6M8=;
        b=BDhulia3JKBw/AVR2tUZ78dQJCBlo5wzEHKwuyIUl9f9S0iXXknC+c/NQLM8XexyCx
         bH5E0uWr0mNn5Z7Eem+uC2/x8ZGt/4rIYF+9OmzGOZUF78y4BzfZUiYtHtusxaFAuWgw
         1B7YExnGBDNXqefGS9Mie0ARFZ7G8J7NIrroDQt1/0YIGhOR+JIfxHMM+YQoqizJhZ/9
         r2lU7U4h4c0ZLClaS0wMaaABlzGg9gDqyWk09lna1gm8kDliU3yDCZCcLciZ/PfYirLr
         NnCa/YRcv2IptMEupktYteQ8Ojpw6M+aBLUSQ1e4s+JcC1tRQtONRnvMul0TjsFr4ojt
         zYSg==
X-Forwarded-Encrypted: i=1; AKwUvBzGZxz2nLXI7U8gViH1B8e4YxrCrWbjTywvFJESRb0ac0DDSSkVCbRUgcG2Set7+5NDbcn8Si7XniNRqeR5T8jmk68bw/g=@vger.kernel.org
X-Gm-Message-State: AFuF++mimwzcHp3UyKRo3Tx5UeS4W7DuiydhQmokSsuRGteEwL9PMoI2
	cpNddrnFjpIqdff1u94swjO/yk7/FSM0lOBCJfD8rqQoepUNM+EplsjV
X-Gm-Gg: AYBFou0vEVgkZpEQjsOvyTtORRhgDEu5ey+fgj1u9dfu3h+dAZ3pxyyUlVKxCdci/PF
	rjlDgfch9tXHJyD8oTPaQGH+/fMVG1WO8Ja5M4B6ogNTqIxIXaDTzc3RqxEOe2LvGGKlnvOUNIx
	UzhK9TZbxclid6vO8Ha17wVtl6nZ2gauH2Fiqm+YJmoDWiI35chz7fQqaUfqzcEzH/BJ6I6atdd
	4piXvo4go3mOCCSMbeYf7cody4X8PpsL2QxNybl3rxJKTQv0tAx2Z8v1rZ6wmsX8wfTL8uMIrj/
	Aaq4oo0kZjqWho5u1Kx04MMCmU4nqyyFSIzTPus5AHpSBnStQcoujqqYsR4uIHT1U91QFdyqwbH
	M/Zr0KMYYNPqyv8Lty3V+8oWNxOcB2w7ezwGUe/yfIBmwH1+AXZlK2ww9WrHrtqyFf5DIh7Ea0A
	4lNPW9cfm7LQqeXcwNMR9+YE4d6G9PRkgzmWmHrIoexP1K9EOccFCKmVeQdPCl3Qi8HJW3PGZY9
	sjYu6PZOz2ELnpEQ6cmcqG9GX4UfhxX
X-Received: by 2002:a05:690c:7091:b0:872:1e2e:b496 with SMTP id 00721157ae682-87f29821932mr39000317b3.31.1788982667401;
        Wed, 09 Sep 2026 12:37:47 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:bae:bfc2:7e96:e5c8])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-871493155d3sm115277577b3.16.2026.09.09.12.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 12:37:47 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kpsingh@kernel.org,
	matt@bobrowski.net,
	paul@paul-moore.com,
	mic@digikod.net,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	kees@kernel.org
Cc: casey@schaufler-ca.com,
	gnoack@google.com,
	jack@suse.cz,
	song@kernel.org,
	yonghong.song@linux.dev,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	jolsa@kernel.org,
	m@maowtm.org,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH bpf-next v3 03/15] lsm: Move the lsm_for_each_hook() macro to security/lsm.h
Date: Wed,  9 Sep 2026 15:37:06 -0400
Message-ID: <20260909193719.518517-4-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909193719.518517-1-utilityemal77@gmail.com>
References: <20260909193719.518517-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the lsm_for_each_hook() iterator from security/security.c to
security/lsm.h, verbatim: a following commit adds a user outside
security.c, the file implementing the LSM policy object kfuncs.
No functional change.

Cc: Paul Moore <paul@paul-moore.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---

Notes:
    v2->v3:
        - No change.

 security/lsm.h      | 6 ++++++
 security/security.c | 5 -----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/security/lsm.h b/security/lsm.h
index 32f808ad4335..264ae63290a8 100644
--- a/security/lsm.h
+++ b/security/lsm.h
@@ -24,6 +24,12 @@ extern bool lsm_debug;
 extern unsigned int lsm_active_cnt;
 extern const struct lsm_id *lsm_idlist[];
 
+/* Iterate over the active implementations of a given hook */
+#define lsm_for_each_hook(scall, NAME)					\
+	for (scall = static_calls_table.NAME;				\
+	     scall - static_calls_table.NAME < MAX_LSM_COUNT; scall++)  \
+		if (static_key_enabled(&scall->active->key))
+
 /* LSM blob configuration */
 extern struct lsm_blob_sizes blob_sizes;
 
diff --git a/security/security.c b/security/security.c
index 2ee276ab15c5..74f98ef8025e 100644
--- a/security/security.c
+++ b/security/security.c
@@ -495,11 +495,6 @@ OUT:									\
 	RC;								\
 })
 
-#define lsm_for_each_hook(scall, NAME)					\
-	for (scall = static_calls_table.NAME;				\
-	     scall - static_calls_table.NAME < MAX_LSM_COUNT; scall++)  \
-		if (static_key_enabled(&scall->active->key))
-
 /* Security operations */
 
 /**
-- 
2.55.0

