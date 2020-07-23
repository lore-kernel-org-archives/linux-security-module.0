Return-Path: <SRS0=LdBn=BC=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 615EEC433E5
	for <linux-security-module@archiver.kernel.org>; Thu, 23 Jul 2020 11:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B376206F4
	for <linux-security-module@archiver.kernel.org>; Thu, 23 Jul 2020 11:50:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dJgXDq6o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728472AbgGWLuk (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 23 Jul 2020 07:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728476AbgGWLui (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 23 Jul 2020 07:50:38 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E42C0619E3
        for <linux-security-module@vger.kernel.org>; Thu, 23 Jul 2020 04:50:38 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id dg28so4298762edb.3
        for <linux-security-module@vger.kernel.org>; Thu, 23 Jul 2020 04:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TEaUq+sWoEZqNt0u37xw6q5hH3h2Y2mNgz4rAdiOMPI=;
        b=dJgXDq6omlUbU4qrQRO2AhtlyL+XQ1Om4fgANqVEWyZgrX/rD1+667dTGrgwRmeRHD
         VSzypXP6KQfgyJ4S7a23vYc5mnEMchj9sUsxcoWH8gDCHwNrM9gdlkRZkCXDwfw42GwL
         8gYE8B316EIZhRHZ/5YU/UIGhwl7rHQkPEJlo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TEaUq+sWoEZqNt0u37xw6q5hH3h2Y2mNgz4rAdiOMPI=;
        b=TB7JiKrM4EzcaSLf7aMrWQ3z2YB7c7RQAnl08h/VIO5CmP60y8wEse3MkN5iEhuwmv
         mq8FkfNBbrmieff6HRMIX7XaEMqgsa8UH+THmQobwVFK1C8Lq0Of+Iupjp4qElOEDq4v
         GLs9URvZ5t8nsFBpXUySM7o5etQGSRZtpRF96wLyVNEc7H1mUl0UbA8vfNWtma+wTfgK
         csfCaecCkspse3Snbs+X/XpGBFU4xB8C4IvJ6Q6D2vyHx/FdrHpiObWQdfabxhtzJuWI
         ylaMFH9kccLmdE9iJ1CaGUFak7yOI24gXNXIyow2VAv8UVUYB6mzdi2V9CcUxLLIkRDT
         mk3g==
X-Gm-Message-State: AOAM533YxyX6f1+DY/AWnq4MrfEC174xfyd0QwmXyh4YqH+PQPRMqa11
        6oSuheKZiWhOsKaRtXSPAn2r1b/C6ImJig==
X-Google-Smtp-Source: ABdhPJwwfG15lG2x4CkDn9jMPbKxIt8JeZG32L72lzewUV5/CijS/jhn8o9d9fShl/TgipFGQROCBA==
X-Received: by 2002:aa7:d744:: with SMTP id a4mr3824356eds.94.1595505036737;
        Thu, 23 Jul 2020 04:50:36 -0700 (PDT)
Received: from kpsingh.zrh.corp.google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id h27sm579302eje.23.2020.07.23.04.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 04:50:36 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next v6 2/7] bpf: Generalize caching for sk_storage.
Date:   Thu, 23 Jul 2020 13:50:27 +0200
Message-Id: <20200723115032.460770-3-kpsingh@chromium.org>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
In-Reply-To: <20200723115032.460770-1-kpsingh@chromium.org>
References: <20200723115032.460770-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: KP Singh <kpsingh@google.com>

Provide the a ability to define local storage caches on a per-object
type basis. The caches and caching indices for different objects should
not be inter-mixed as suggested in:

  https://lore.kernel.org/bpf/20200630193441.kdwnkestulg5erii@kafai-mbp.dhcp.thefacebook.com/

  "Caching a sk-storage at idx=0 of a sk should not stop an
  inode-storage to be cached at the same idx of a inode."

Signed-off-by: KP Singh <kpsingh@google.com>
---
 include/net/bpf_sk_storage.h | 19 +++++++++++++++++++
 net/core/bpf_sk_storage.c    | 31 +++++++++++++++----------------
 2 files changed, 34 insertions(+), 16 deletions(-)

diff --git a/include/net/bpf_sk_storage.h b/include/net/bpf_sk_storage.h
index 5036c94c0503..950c5aaba15e 100644
--- a/include/net/bpf_sk_storage.h
+++ b/include/net/bpf_sk_storage.h
@@ -3,6 +3,9 @@
 #ifndef _BPF_SK_STORAGE_H
 #define _BPF_SK_STORAGE_H
 
+#include <linux/types.h>
+#include <linux/spinlock.h>
+
 struct sock;
 
 void bpf_sk_storage_free(struct sock *sk);
@@ -15,6 +18,22 @@ struct sk_buff;
 struct nlattr;
 struct sock;
 
+#define BPF_LOCAL_STORAGE_CACHE_SIZE	16
+
+struct bpf_local_storage_cache {
+	spinlock_t idx_lock;
+	u64 idx_usage_counts[BPF_LOCAL_STORAGE_CACHE_SIZE];
+};
+
+#define DEFINE_BPF_STORAGE_CACHE(name)				\
+static struct bpf_local_storage_cache name = {			\
+	.idx_lock = __SPIN_LOCK_UNLOCKED(name.idx_lock),	\
+}
+
+u16 bpf_local_storage_cache_idx_get(struct bpf_local_storage_cache *cache);
+void bpf_local_storage_cache_idx_free(struct bpf_local_storage_cache *cache,
+				      u16 idx);
+
 #ifdef CONFIG_BPF_SYSCALL
 int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk);
 struct bpf_sk_storage_diag *
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index fb7ea6f4174d..aa3e3a47acb5 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -13,6 +13,8 @@
 
 #define BPF_LOCAL_STORAGE_CREATE_FLAG_MASK (BPF_F_NO_PREALLOC | BPF_F_CLONE)
 
+DEFINE_BPF_STORAGE_CACHE(sk_cache);
+
 struct bpf_local_storage_map_bucket {
 	struct hlist_head list;
 	raw_spinlock_t lock;
@@ -77,10 +79,6 @@ struct bpf_local_storage_elem {
 #define SELEM(_SDATA)							\
 	container_of((_SDATA), struct bpf_local_storage_elem, sdata)
 #define SDATA(_SELEM) (&(_SELEM)->sdata)
-#define BPF_LOCAL_STORAGE_CACHE_SIZE	16
-
-static DEFINE_SPINLOCK(cache_idx_lock);
-static u64 cache_idx_usage_counts[BPF_LOCAL_STORAGE_CACHE_SIZE];
 
 struct bpf_local_storage {
 	struct bpf_local_storage_data __rcu *cache[BPF_LOCAL_STORAGE_CACHE_SIZE];
@@ -516,16 +514,16 @@ static int sk_storage_delete(struct sock *sk, struct bpf_map *map)
 	return 0;
 }
 
-static u16 cache_idx_get(void)
+u16 bpf_local_storage_cache_idx_get(struct bpf_local_storage_cache *cache)
 {
 	u64 min_usage = U64_MAX;
 	u16 i, res = 0;
 
-	spin_lock(&cache_idx_lock);
+	spin_lock(&cache->idx_lock);
 
 	for (i = 0; i < BPF_LOCAL_STORAGE_CACHE_SIZE; i++) {
-		if (cache_idx_usage_counts[i] < min_usage) {
-			min_usage = cache_idx_usage_counts[i];
+		if (cache->idx_usage_counts[i] < min_usage) {
+			min_usage = cache->idx_usage_counts[i];
 			res = i;
 
 			/* Found a free cache_idx */
@@ -533,18 +531,19 @@ static u16 cache_idx_get(void)
 				break;
 		}
 	}
-	cache_idx_usage_counts[res]++;
+	cache->idx_usage_counts[res]++;
 
-	spin_unlock(&cache_idx_lock);
+	spin_unlock(&cache->idx_lock);
 
 	return res;
 }
 
-static void cache_idx_free(u16 idx)
+void bpf_local_storage_cache_idx_free(struct bpf_local_storage_cache *cache,
+				      u16 idx)
 {
-	spin_lock(&cache_idx_lock);
-	cache_idx_usage_counts[idx]--;
-	spin_unlock(&cache_idx_lock);
+	spin_lock(&cache->idx_lock);
+	cache->idx_usage_counts[idx]--;
+	spin_unlock(&cache->idx_lock);
 }
 
 /* Called by __sk_destruct() & bpf_sk_storage_clone() */
@@ -596,7 +595,7 @@ static void bpf_local_storage_map_free(struct bpf_map *map)
 
 	smap = (struct bpf_local_storage_map *)map;
 
-	cache_idx_free(smap->cache_idx);
+	bpf_local_storage_cache_idx_free(&sk_cache, smap->cache_idx);
 
 	/* Note that this map might be concurrently cloned from
 	 * bpf_sk_storage_clone. Wait for any existing bpf_sk_storage_clone
@@ -712,7 +711,7 @@ static struct bpf_map *bpf_local_storage_map_alloc(union bpf_attr *attr)
 	}
 
 	smap->elem_size = sizeof(struct bpf_local_storage_elem) + attr->value_size;
-	smap->cache_idx = cache_idx_get();
+	smap->cache_idx = bpf_local_storage_cache_idx_get(&sk_cache);
 
 	return &smap->map;
 }
-- 
2.28.0.rc0.105.gf9edc3c819-goog

