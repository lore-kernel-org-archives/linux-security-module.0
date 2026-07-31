Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5565C3101D8
	for <linux-security-module@vger.kernel.org>; Fri, 31 Jul 2026 02:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785464479; cv=none; b=jgZIoM24frCJyeMGhSTW3JqZpuBE3ye6gjRpHFJu9/lzp3l0+NanHJrt45bPhHUML+HsfsoS9SL04L/FYfrXCbDlk6Ec6FXIGInROi3MvhfttI2sD20QGgG9inejz3BO+Mdc7Yx1xrcV251ndov6npnKVriqqZ1aFmH6XDCFnKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785464479; c=relaxed/simple;
	bh=Eb0i9E1Gj/ePAHcgoR0E+HEHOHcL5jShkypGqqir1ck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YVq17fqUfFR2+kFw7OzBXGUW/p9lpj13VrjC6zpmoYZ1BWVoLbXSVbucvhLbbZWQWFAYObqMQdCfS8+32WA8iX0z1LugMlHPrS3NNPlpmefQvOJQr/P21lPtyq/Jf2a2juqvSCljmIePBaiX1ipTqBY5BWJ9YhsU5Bddp4ReA54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BJxwxulJ; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJxwxulJ"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-81fc442789cso7352587b3.3
        for <linux-security-module@vger.kernel.org>; Thu, 30 Jul 2026 19:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785464475; x=1786069275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x5Hdd2d+rIeKOx6QkydL222RNNm3Nsb20BqP+/GgTXI=;
        b=BJxwxulJGiu8pnn2NjZ51oNybQpxsSLHfraJNiYIN5Pog1iJ41uon7qfTFXLmmhhwM
         DPGrlM6rOK68sPT0KTry+I+0He3WbcyZAwyrqKR54PYqpo6Ltb5PIBfRIa5Ly1QtXPwj
         QHZvdf7Knk4cI4u7g6MHun4qc/mt8bPnwfUAjApf0iwtQwf3k2h9hv5tGQAnf+e5OztB
         XAf8HmtkoJAhNoF8PZhzPG6ZlPjmbwkR62ywTzBHdZW88ZD6JtIJ+UsMlTpfZGpKdpQo
         +Khw4xap3TR2Sv4A6PYBQxJdU/p/Nhov8Dh2Xqz7Q1adTVoh3yDX+PTEn9iocwNEY4Sw
         5iIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785464475; x=1786069275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=x5Hdd2d+rIeKOx6QkydL222RNNm3Nsb20BqP+/GgTXI=;
        b=tBff6UjE/mwFprOxtpSamfLmn8zPWIihw1zese3SlSFvl5HS2RRUa/97U6S4MSNKYP
         GOTaoMtmUVxznEtaqLgvFuOPvdKVa7ugshhTmNeD8m2rHljNNi/PBqJ6lhpWJquVoc6r
         siTCw21kJSEJlIczxgT8s5pOgt9BLnrdQbdL5/H+um0ee3InO9u/0mDIQQ3CTaQR7Fa9
         oCXUYaJGqdhexEXJzNQ76eD4SHPZB6L6geFQ4o2EldvxONjo9nw7MAfo11hhhHA+DJt1
         UQ2miwC9HFypmsQOMvETy0ER6g+vtLyaCvkchx1KaFV/545UXDr5FotSEEYdqcXgjzrn
         ZCDg==
X-Forwarded-Encrypted: i=1; AHgh+Rp6B2aFDRrdnm84ioVhaEPFcd7IUyW4Qny2d2PpF9yQph5aQySDTzkqtKxhvYd7ewxNdj64r2lJhkpChPknkvgyGAJhQ40=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLxY54fa4xr14SYV0Ug0KCWc6Qv4JSUWUBdKmHCOQ0y6c5pFwR
	HgA4OqHzK8a6HeJUwjrjMDVTR6plFrE9oUL+xEJvR7vkI1eeFdocnS/U
X-Gm-Gg: AR+sD10tDaAUK1bsWmua5qNEUOCHymQHxnZbkE9IkEXyvPIkv+Sf6QquxWgWk04soc/
	UGyOXu0eDSvcVhSLYR4UaMkUWBgm1Hbydtd7IJVREzj0avuLAf6/xgpzN1NOaEccQQOyAWqEZ1u
	ti1f5XiJXeAdn7J/A00KKBQWB1XiQFj4TtfYjUqQRzqjHNPMkkqIfgLrJ/HxpD6X5O6IZtAN8XY
	AxE3S/6K4HJwMsUNjEX60TLuiQ4FhvPIKHlIArmzkbsfA5NvAF+lATo5WSYQO5aSq1OcAvNBQUB
	fl75gIgbO+4CLXakd9K3dxjaSknHz5wgoY7KsgcvyBhBSiHB8YeEdyvL/OybvuMyuYhXfB1hOnm
	Bp9wkitdz38PN16pkuD9EhgQetmOru2IUSJ4UFw3VOxMQ2cj4gwCTtk3qPcOiIRHZjHU8JDgySi
	BC2Wu4V+SYXgKdS6BBelPkQ8ULzdNt24AoG09mvkGF9izWCn+eVNu08BYPyG4dvHGrxl5xWwXUd
	myd1WTx8knfogX1Rex6PA==
X-Received: by 2002:a05:690c:4d09:b0:81f:3b6d:a0c2 with SMTP id 00721157ae682-81fcbbb0bd4mr506707b3.42.1785464474838;
        Thu, 30 Jul 2026 19:21:14 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:e94:8a83:feea:6720])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fb8b26e8bsm20519047b3.47.2026.07.30.19.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 19:21:14 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kpsingh@kernel.org,
	paul@paul-moore.com,
	mic@digikod.net,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	kees@kernel.org
Cc: gnoack@google.com,
	jack@suse.cz,
	song@kernel.org,
	yonghong.song@linux.dev,
	martin.lau@linux.dev,
	m@maowtm.org,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>,
	Casey Schaufler <casey@schaufler-ca.com>
Subject: [PATCH bpf-next 02/13] lsm: Add LSM hook security_policy_kptr_put
Date: Thu, 30 Jul 2026 22:20:35 -0400
Message-ID: <20260731022047.189137-3-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260731022047.189137-1-utilityemal77@gmail.com>
References: <20260731022047.189137-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the generic LSM hook releasing a reference obtained through
security_policy_kptr_from_fd():

  security_policy_kptr_put(lsmid, &policy)

The shim uses the same targeted dispatch by @lsmid as the get hook:
only the implementation registered by the matching LSM is called, and
it only ever reads its own member of union lsm_policy_kptr, so a
policy object only ever travels back to the LSM that produced it.
The hook is void: releasing a reference cannot fail.  A reference can
only come from the matching LSM's policy_kptr_from_fd hook, so a
dispatch miss means a caller passed the wrong lsmid or an LSM
implemented the get hook without the put hook; the shim warns instead
of silently leaking the reference.

An implementation must support being called from a context that cannot
sleep: the release of BPF managed references may be driven from object
destructors.

Like the get hook, this hook is excluded from the "bpf" LSM's
attachment points, as the targeted dispatch makes an attachment there
unreachable.

Cc: Paul Moore <paul@paul-moore.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 include/linux/lsm_hook_defs.h |  1 +
 include/linux/security.h      |  6 ++++++
 kernel/bpf/bpf_lsm.c          |  1 +
 security/security.c           | 27 +++++++++++++++++++++++++++
 4 files changed, 35 insertions(+)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index afd5b3f932a9..0800622e317f 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -454,6 +454,7 @@ LSM_HOOK(int, 0, bpf_token_cmd, const struct bpf_token *token, enum bpf_cmd cmd)
 LSM_HOOK(int, 0, bpf_token_capable, const struct bpf_token *token, int cap)
 LSM_HOOK(int, -EOPNOTSUPP, policy_kptr_from_fd, int fd,
 	 union lsm_policy_kptr *policy)
+LSM_HOOK(void, LSM_RET_VOID, policy_kptr_put, union lsm_policy_kptr *policy)
 #endif /* CONFIG_BPF_SYSCALL */
 
 LSM_HOOK(int, 0, locked_down, enum lockdown_reason what)
diff --git a/include/linux/security.h b/include/linux/security.h
index db807e61d310..5017a335918c 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -2331,6 +2331,7 @@ extern int security_bpf_token_cmd(const struct bpf_token *token, enum bpf_cmd cm
 extern int security_bpf_token_capable(const struct bpf_token *token, int cap);
 extern int security_policy_kptr_from_fd(u64 lsmid, int fd,
 					union lsm_policy_kptr *policy);
+extern void security_policy_kptr_put(u64 lsmid, union lsm_policy_kptr *policy);
 #else
 static inline int security_bpf(int cmd, union bpf_attr *attr,
 			       unsigned int size, bool kernel)
@@ -2390,6 +2391,11 @@ static inline int security_policy_kptr_from_fd(u64 lsmid, int fd,
 {
 	return -EOPNOTSUPP;
 }
+
+static inline void security_policy_kptr_put(u64 lsmid,
+					    union lsm_policy_kptr *policy)
+{
+}
 #endif /* CONFIG_SECURITY */
 #endif /* CONFIG_BPF_SYSCALL */
 
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 9fa514204fb5..e9059d43e92c 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -57,6 +57,7 @@ BTF_ID(func, bpf_lsm_xfrm_decode_session)
 BTF_ID(func, bpf_lsm_ismaclabel)
 BTF_ID(func, bpf_lsm_file_alloc_security)
 BTF_ID(func, bpf_lsm_policy_kptr_from_fd)
+BTF_ID(func, bpf_lsm_policy_kptr_put)
 BTF_SET_END(bpf_lsm_disabled_hooks)
 
 /* List of LSM hooks that should operate on 'current' cgroup regardless
diff --git a/security/security.c b/security/security.c
index 14fd8b878cd0..fd535bd00c24 100644
--- a/security/security.c
+++ b/security/security.c
@@ -5479,6 +5479,33 @@ int security_policy_kptr_from_fd(u64 lsmid, int fd,
 	return LSM_RET_DEFAULT(policy_kptr_from_fd);
 }
 
+/**
+ * security_policy_kptr_put() - Put a reference on an LSM policy object
+ * @lsmid: LSM_ID_* value of the LSM owning @policy
+ * @policy: the policy object, in the member of the LSM identified by
+ *          @lsmid
+ *
+ * Release a reference previously obtained with
+ * security_policy_kptr_from_fd().  Only the hook implementation
+ * of the LSM identified by @lsmid is called, and @policy must have
+ * been obtained from that same LSM.  An implementation must support
+ * being called from a context that cannot sleep: the release of BPF
+ * managed references may be driven from object destructors.
+ */
+void security_policy_kptr_put(u64 lsmid, union lsm_policy_kptr *policy)
+{
+	struct lsm_static_call *scall;
+
+	lsm_for_each_hook(scall, policy_kptr_put) {
+		if (scall->hl->lsmid->id != lsmid)
+			continue;
+		scall->hl->hook.policy_kptr_put(policy);
+		return;
+	}
+	/* A held reference implies the matching LSM implements the hook. */
+	WARN_ON_ONCE(1);
+}
+
 /**
  * security_bpf_map_free() - Free a bpf map's LSM blob
  * @map: bpf map
-- 
2.54.0

