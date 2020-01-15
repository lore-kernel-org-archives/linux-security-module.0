Return-Path: <SRS0=2BO2=3E=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B2B7C47409
	for <linux-security-module@archiver.kernel.org>; Wed, 15 Jan 2020 17:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52B7E24656
	for <linux-security-module@archiver.kernel.org>; Wed, 15 Jan 2020 17:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gZOvsoWn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbgAORN2 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 15 Jan 2020 12:13:28 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41526 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729169AbgAORN2 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 15 Jan 2020 12:13:28 -0500
Received: by mail-wr1-f68.google.com with SMTP id c9so16529056wrw.8
        for <linux-security-module@vger.kernel.org>; Wed, 15 Jan 2020 09:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b3NJ2CZ8kBjGjnKwLifa2Rd0VYqXxRjZEy90LqHwLt4=;
        b=gZOvsoWniHlHh9h21Kxu4FD8G1kLvd5AkOP1w+Fz6LnT80ZgROGkilczKCyE38xgkJ
         XXhRGIWXyL3OagMSvBfHaI8clTj/ouKIxzFCMBJyQD+eJqVb0Scj6I6C4JK+jKL7fdaT
         tqyTFAfDLsPunlujzvO6ku+GDMtqs5nhOnocA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b3NJ2CZ8kBjGjnKwLifa2Rd0VYqXxRjZEy90LqHwLt4=;
        b=TwKZHd7ZEYMQ8d1i/9NcRdmSoLkiaC83TYyapSupzSSjzwzBVf4i0suk4vzzuSvZpR
         ySUZcMxcoCh/CaT/5x4AVioX5JQWUg6k6N9lUJvVzQwOzDp83xWFqfAK3BZunSHjajrn
         n7UYHPBm0BTPhGcdKEaZ1+6pEKkRTkFM/+OOGOG9ii82qTko9OgEJRSs/hBjoqRH4Y/1
         2Ek0XT7tBwlV5JZH9zTehqkBZ6YcgJHLR0gLHia0oq9/R2myj8aJAO3LR5UYusx1j0kj
         o0iG/0KKx+oA2q0P1nRu6lHhPwCn+EZGGKghQ8meshUrFRRK1Je1i/zfN6VATz8v7JoN
         KyWQ==
X-Gm-Message-State: APjAAAWBpkcbih0TKHH2HYRQW7i+ynH2uztHdGUoA6dyarcGp8uae8WJ
        Q7i13y1p9Echw4NE48RrwkFPeA==
X-Google-Smtp-Source: APXvYqyNMe56nhpaM0QPg8Iq77aVz1Uk0rCoiJFQBIjfH0WChRwfqVoiuHVttVDhg0HUIlsXbAlCZQ==
X-Received: by 2002:a5d:6a8e:: with SMTP id s14mr33286303wru.150.1579108406382;
        Wed, 15 Jan 2020 09:13:26 -0800 (PST)
Received: from kpsingh-kernel.localdomain ([2620:0:105f:fd00:84f3:4331:4ae9:c5f1])
        by smtp.gmail.com with ESMTPSA id d16sm26943227wrg.27.2020.01.15.09.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 09:13:25 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>
Subject: [PATCH bpf-next v2 05/10] bpf: lsm: BTF API for LSM hooks
Date:   Wed, 15 Jan 2020 18:13:28 +0100
Message-Id: <20200115171333.28811-6-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200115171333.28811-1-kpsingh@chromium.org>
References: <20200115171333.28811-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: KP Singh <kpsingh@google.com>

The BTF API provides information required by the BPF verifier to
attach eBPF programs to the LSM hooks by using the BTF information of
two types:

- struct security_hook_heads: This type provides the offset which
  a new dynamically allocated security hook must be attached to.
- union security_list_options: This provides the information about the
  function prototype required by the hook.

When the program is loaded:

- The verifier receives the index of a member in struct
  security_hook_heads to which a program must be attached as
  prog->aux->lsm_hook_index. The index is one-based for better
  verification.
- bpf_lsm_type_by_index is used to determine the func_proto of
  the LSM hook and updates prog->aux->attach_func_proto
- bpf_lsm_head_by_index is used to determine the hlist_head to which
  the BPF program must be attached.

Signed-off-by: KP Singh <kpsingh@google.com>
---
 include/linux/bpf_lsm.h |  12 +++++
 security/bpf/Kconfig    |   1 +
 security/bpf/hooks.c    | 104 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 117 insertions(+)

diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
index 9883cf25241c..a9b4f7b41c65 100644
--- a/include/linux/bpf_lsm.h
+++ b/include/linux/bpf_lsm.h
@@ -19,6 +19,8 @@ extern struct security_hook_heads bpf_lsm_hook_heads;
 
 int bpf_lsm_srcu_read_lock(void);
 void bpf_lsm_srcu_read_unlock(int idx);
+const struct btf_type *bpf_lsm_type_by_index(struct btf *btf, u32 offset);
+const struct btf_member *bpf_lsm_head_by_index(struct btf *btf, u32 id);
 
 #define CALL_BPF_LSM_VOID_HOOKS(FUNC, ...)			\
 	do {							\
@@ -65,6 +67,16 @@ static inline int bpf_lsm_srcu_read_lock(void)
 	return 0;
 }
 static inline void bpf_lsm_srcu_read_unlock(int idx) {}
+static inline const struct btf_type *bpf_lsm_type_by_index(
+	struct btf *btf, u32 index)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+static inline const struct btf_member *bpf_lsm_head_by_index(
+	struct btf *btf, u32 id)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
 
 #endif /* CONFIG_SECURITY_BPF */
 
diff --git a/security/bpf/Kconfig b/security/bpf/Kconfig
index 595e4ad597ae..9438d899b618 100644
--- a/security/bpf/Kconfig
+++ b/security/bpf/Kconfig
@@ -7,6 +7,7 @@ config SECURITY_BPF
 	depends on SECURITY
 	depends on BPF_SYSCALL
 	depends on SRCU
+	depends on DEBUG_INFO_BTF
 	help
 	  This enables instrumentation of the security hooks with
 	  eBPF programs.
diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
index b123d9cb4cd4..82725611693d 100644
--- a/security/bpf/hooks.c
+++ b/security/bpf/hooks.c
@@ -5,6 +5,8 @@
  */
 
 #include <linux/bpf_lsm.h>
+#include <linux/bpf.h>
+#include <linux/btf.h>
 #include <linux/srcu.h>
 
 DEFINE_STATIC_SRCU(security_hook_srcu);
@@ -18,3 +20,105 @@ void bpf_lsm_srcu_read_unlock(int idx)
 {
 	return srcu_read_unlock(&security_hook_srcu, idx);
 }
+
+static inline int validate_hlist_head(struct btf *btf, u32 type_id)
+{
+	s32 hlist_id;
+
+	hlist_id = btf_find_by_name_kind(btf, "hlist_head", BTF_KIND_STRUCT);
+	if (hlist_id < 0 || hlist_id != type_id)
+		return -EINVAL;
+
+	return 0;
+}
+
+/* Find the BTF representation of the security_hook_heads member for a member
+ * with a given index in struct security_hook_heads.
+ */
+const struct btf_member *bpf_lsm_head_by_index(struct btf *btf, u32 index)
+{
+	const struct btf_member *member;
+	const struct btf_type *t;
+	u32 off, i;
+	int ret;
+
+	t = btf_type_by_name_kind(btf, "security_hook_heads", BTF_KIND_STRUCT);
+	if (WARN_ON_ONCE(IS_ERR(t)))
+		return ERR_CAST(t);
+
+	for_each_member(i, t, member) {
+		/* We've found the id requested and need to check the
+		 * the following:
+		 *
+		 * - Is it at a valid alignment for struct hlist_head?
+		 *
+		 * - Is it a valid hlist_head struct?
+		 */
+		if (index == i) {
+			off = btf_member_bit_offset(t, member);
+			if (off % 8)
+				/* valid c code cannot generate such btf */
+				return ERR_PTR(-EINVAL);
+			off /= 8;
+
+			if (off % __alignof__(struct hlist_head))
+				return ERR_PTR(-EINVAL);
+
+			ret = validate_hlist_head(btf, member->type);
+			if (ret < 0)
+				return ERR_PTR(ret);
+
+			return member;
+		}
+	}
+
+	return ERR_PTR(-ENOENT);
+}
+
+/* Given an index of a member in security_hook_heads return the
+ * corresponding type for the LSM hook. The members of the union
+ * security_list_options have the same name as the security_hook_heads which
+ * is ensured by the LSM_HOOK_INIT macro defined in include/linux/lsm_hooks.h
+ */
+const struct btf_type *bpf_lsm_type_by_index(struct btf *btf, u32 index)
+{
+	const struct btf_member *member, *hook_head = NULL;
+	const struct btf_type *t, *hook_type = NULL;
+	u32 i;
+
+	hook_head = bpf_lsm_head_by_index(btf, index);
+	if (IS_ERR(hook_head))
+		return ERR_PTR(PTR_ERR(hook_head));
+
+	t = btf_type_by_name_kind(btf, "security_list_options", BTF_KIND_UNION);
+	if (WARN_ON_ONCE(IS_ERR(t)))
+		return ERR_CAST(t);
+
+	for_each_member(i, t, member) {
+		if (hook_head->name_off == member->name_off) {
+			/* There should be only one member with the same name
+			 * as the LSM hook. This should never really happen
+			 * and either indicates malformed BTF or someone trying
+			 * trick the LSM.
+			 */
+			if (WARN_ON(hook_type))
+				return ERR_PTR(-EINVAL);
+
+			hook_type = btf_type_by_id(btf, member->type);
+			if (unlikely(!hook_type))
+				return ERR_PTR(-EINVAL);
+
+			if (!btf_type_is_ptr(hook_type))
+				return ERR_PTR(-EINVAL);
+		}
+	}
+
+	if (!hook_type)
+		return ERR_PTR(-ENOENT);
+
+	t = btf_type_by_id(btf, hook_type->type);
+	if (unlikely(!t))
+		return ERR_PTR(-EINVAL);
+
+	return t;
+}
-- 
2.20.1

