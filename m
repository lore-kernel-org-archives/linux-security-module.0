Return-Path: <SRS0=4Vpg=CB=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF5A2C433E5
	for <linux-security-module@archiver.kernel.org>; Sun, 23 Aug 2020 16:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E9402074D
	for <linux-security-module@archiver.kernel.org>; Sun, 23 Aug 2020 16:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CwhyfZh5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbgHWQ5t (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 23 Aug 2020 12:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727849AbgHWQ4W (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 23 Aug 2020 12:56:22 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092C0C061574
        for <linux-security-module@vger.kernel.org>; Sun, 23 Aug 2020 09:56:20 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id c19so4609210wmd.1
        for <linux-security-module@vger.kernel.org>; Sun, 23 Aug 2020 09:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7EGajeDiJIxrlPr3Y0NRvAuPtl3AEsFbIm2NTrH6ZEc=;
        b=CwhyfZh5+VOoAaJmKYhren9Fal42PrPyNC7OVekZ4j0KJizvXdmylkSyryY0Oj3Tx7
         hXFUiir7tLOxUSsQEQQUpc0kAaT/t8VQizZlo5lTv7UoKwMkw82Zk3/1w3zRXjb63eiN
         Axl3Gczb/oVreJdGL999ylrFbqrmg6Q7h67e4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7EGajeDiJIxrlPr3Y0NRvAuPtl3AEsFbIm2NTrH6ZEc=;
        b=RK3btIyneIxvbfbWzKointjyA4e0wPGl9B1407LTOsjOXhMOKjdHjBl2ekirSrzgjl
         oy/HAkT3oSZ9gVFi3TkNzNQ/CaJDfzTiI96SjD8VkH7u9MEnGB3DZ+okPtV0lDcmlJWN
         LNtpw6vWhJj3wyvWIGjux7ij54fivzuz7Ogu1WsMxtLnSuc0sOwjmslLLVjq5pup1W8w
         b4mbPESGC4jN7FjyhFngz5dH7RX/1JfXSJY8S68c9yeaQWy7VWsBhmcTvIuRiIt3GvJa
         8uV2lECjufi9KwGjNjYO0CM05jgKFmX/879J+4ocU4TLkQIVJ/WJ+Lu178uHBzHOeQ6M
         zBkw==
X-Gm-Message-State: AOAM533aLuk0bQtFnhF/fzwtyOPNDcx1xItduNLKeZuGhoUNkxy5XXNa
        V0jtHVBN69Ljc/0NulVGRenEPQ==
X-Google-Smtp-Source: ABdhPJzZCM/fPFw3SRazDY87wFNAxYWhIa+cd5mpCui3imi1t0pFeqDbVi0bEdk/AIA3k60/U/mAVQ==
X-Received: by 2002:a7b:c452:: with SMTP id l18mr2178956wmi.13.1598201778936;
        Sun, 23 Aug 2020 09:56:18 -0700 (PDT)
Received: from kpsingh.zrh.corp.google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id d10sm5425974wrg.3.2020.08.23.09.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2020 09:56:18 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next v9 2/7] bpf: Generalize caching for sk_storage.
Date:   Sun, 23 Aug 2020 18:56:07 +0200
Message-Id: <20200823165612.404892-3-kpsingh@chromium.org>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
In-Reply-To: <20200823165612.404892-1-kpsingh@chromium.org>
References: <20200823165612.404892-1-kpsingh@chromium.org>
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

Acked-by: Martin KaFai Lau <kafai@fb.com>
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
index f975e2d01207..ec61ee7c7ee4 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -14,6 +14,8 @@
 
 #define BPF_LOCAL_STORAGE_CREATE_FLAG_MASK (BPF_F_NO_PREALLOC | BPF_F_CLONE)
 
+DEFINE_BPF_STORAGE_CACHE(sk_cache);
+
 struct bpf_local_storage_map_bucket {
 	struct hlist_head list;
 	raw_spinlock_t lock;
@@ -78,10 +80,6 @@ struct bpf_local_storage_elem {
 #define SELEM(_SDATA)							\
 	container_of((_SDATA), struct bpf_local_storage_elem, sdata)
 #define SDATA(_SELEM) (&(_SELEM)->sdata)
-#define BPF_LOCAL_STORAGE_CACHE_SIZE	16
-
-static DEFINE_SPINLOCK(cache_idx_lock);
-static u64 cache_idx_usage_counts[BPF_LOCAL_STORAGE_CACHE_SIZE];
 
 struct bpf_local_storage {
 	struct bpf_local_storage_data __rcu *cache[BPF_LOCAL_STORAGE_CACHE_SIZE];
@@ -521,16 +519,16 @@ static int sk_storage_delete(struct sock *sk, struct bpf_map *map)
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
@@ -538,18 +536,19 @@ static u16 cache_idx_get(void)
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
@@ -601,7 +600,7 @@ static void bpf_local_storage_map_free(struct bpf_map *map)
 
 	smap = (struct bpf_local_storage_map *)map;
 
-	cache_idx_free(smap->cache_idx);
+	bpf_local_storage_cache_idx_free(&sk_cache, smap->cache_idx);
 
 	/* Note that this map might be concurrently cloned from
 	 * bpf_sk_storage_clone. Wait for any existing bpf_sk_storage_clone
@@ -718,7 +717,7 @@ static struct bpf_map *bpf_local_storage_map_alloc(union bpf_attr *attr)
 
 	smap->elem_size =
 		sizeof(struct bpf_local_storage_elem) + attr->value_size;
-	smap->cache_idx = cache_idx_get();
+	smap->cache_idx = bpf_local_storage_cache_idx_get(&sk_cache);
 
 	return &smap->map;
 }
-- 
2.28.0.297.g1956fa8f8d-goog

