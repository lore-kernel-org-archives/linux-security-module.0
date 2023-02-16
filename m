Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B975C61DA4
	for <linux-security-module@archiver.kernel.org>; Thu, 16 Feb 2023 21:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjBPVrB (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 16 Feb 2023 16:47:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjBPVq5 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 16 Feb 2023 16:46:57 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A033B846
        for <linux-security-module@vger.kernel.org>; Thu, 16 Feb 2023 13:46:55 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-52ee93d7863so35394067b3.18
        for <linux-security-module@vger.kernel.org>; Thu, 16 Feb 2023 13:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bAVGkn1V34UfXYCduywOhSCUf/aOV+M7/FaubotBnKo=;
        b=JZAUr2Tg5NuD448WHvjh+8YkRdoIacbUZPBD3nVNUVvSbitNVpesxnEV3FneQVL4u0
         +/hzv8QubrW6Hrxc4RBOd2e2k0+J8W8SXc9vMH2v2W4y/FuH+7TG3P9n08NUOFoubJR2
         /v6DSmmAQgl7dEA7IPz0hafu/rk7H7agMvCqxGa7limWbLJ1h3wl0tlOrGcjgOsl0qUI
         R6HZV/Hc46HTkG5A3uBRf6crZKCmrj8KbJMLGHbskVZ0GLsirSGfUP/euIiv0F1GUR8b
         7AKyDX/mp4A5SMT1pB0DSkK8vdgudro77O7VOPj6eMC4Akq1jKytnC17StBzri8QorxF
         k9WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bAVGkn1V34UfXYCduywOhSCUf/aOV+M7/FaubotBnKo=;
        b=F1KERWp7VxB+A/5nKKc+amCCmJjyhZUXRmthlnepB6F9Vck4OVKxRZjElvPtFpvBUQ
         i4PtGmHMRLZO/0p3s3d/hy8FD5BRxaZQK0EVuGt7PO4SSJU1hi8P+pYS4I8dhHwoCg2T
         QCYyiiLF9UvR9Br5WjtL5vp26FivKkCjQBGg9IW3HaYBfbwzQRVGIywGjadR+GzxBNrW
         Y1l1cc6r50YvdEQTj497Z4ef+wgGw2UJUZbwPmIf2iThqGX7hWsNeGyw4bwxJOPX2rQa
         oUkswrmZjHaEuyenNCm+P3WiOFsdBEO98CtigpInQ9N5SOoCviH4jSpuQj1wmgOyrzHa
         PHTg==
X-Gm-Message-State: AO0yUKVn91bcSVO0HRHXtgrQ4UGFhOoT0Erh8wOC3VzHef+dEeRp3jbl
        Mdj++ucqSeIC7pznXjp+DbZQSA1JfSVZ6A==
X-Google-Smtp-Source: AK7set+QV/wWuwbl6qV/GeSY5iFq0uelWYs66FJfk18i4lZzoABSqGvHLj83tbXBq2ewq0nMZjZxXwGJh+CP4w==
X-Received: from aaltinayspec.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:7fcc])
 (user=aaltinay job=sendgmr) by 2002:a05:690c:b83:b0:52e:b74b:1b93 with SMTP
 id ck3-20020a05690c0b8300b0052eb74b1b93mr8ywb.0.1676584014672; Thu, 16 Feb
 2023 13:46:54 -0800 (PST)
Date:   Thu, 16 Feb 2023 21:46:51 +0000
In-Reply-To: <20230216214651.3514675-1-aaltinay@google.com>
Mime-Version: 1.0
References: <20230216214651.3514675-1-aaltinay@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230216214651.3514675-2-aaltinay@google.com>
Subject: [PATCH 1/1] apparmor: cache buffers on percpu list if there is lock contention
From:   Anil Altinay <aaltinay@google.com>
To:     john.johansen@canonical.com, linux-security-module@vger.kernel.org
Cc:     aaltinay@google.com, Sergey Senozhatsky <senozhatsky@chromium.org>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On a heavily loaded machine there can be lock contention on the
global buffers lock. Add a percpu list to cache buffers on when
lock contention is encountered.

When allocating buffers attempt to use cached buffers first,
before taking the global buffers lock. When freeing buffers
try to put them back to the global list but if contention is
encountered, put the buffer on the percpu list.

The length of time a buffer is held on the percpu list is dynamically
adjusted based on lock contention.  The amount of hold time is rapidly
increased and slow ramped down.

Fixes: df323337e507 ("apparmor: Use a memory pool instead per-CPU caches")
Link: https://lore.kernel.org/lkml/cfd5cc6f-5943-2e06-1dbe-f4b4ad5c1fa1@canonical.com/
Signed-off-by: John Johansen <john.johansen@canonical.com>
Reported-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Anil Altinay <aaltinay@google.com>
Cc: stable@vger.kernel.org
---
 security/apparmor/lsm.c | 73 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 68 insertions(+), 5 deletions(-)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index c6728a629437..56b22e2def4c 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -49,12 +49,19 @@ union aa_buffer {
 	char buffer[1];
 };
 
+struct aa_local_cache {
+	unsigned int contention;
+	unsigned int hold;
+	struct list_head head;
+};
+
 #define RESERVE_COUNT 2
 static int reserve_count = RESERVE_COUNT;
 static int buffer_count;
 
 static LIST_HEAD(aa_global_buffers);
 static DEFINE_SPINLOCK(aa_buffers_lock);
+static DEFINE_PER_CPU(struct aa_local_cache, aa_local_buffers);
 
 /*
  * LSM hook functions
@@ -1634,14 +1641,43 @@ static int param_set_mode(const char *val, const struct kernel_param *kp)
 	return 0;
 }
 
+static void update_contention(struct aa_local_cache *cache)
+{
+	cache->contention += 3;
+	if (cache->contention > 9)
+		cache->contention = 9;
+	cache->hold += 1 << cache->contention;		/* 8, 64, 512 */
+}
+
 char *aa_get_buffer(bool in_atomic)
 {
 	union aa_buffer *aa_buf;
+	struct aa_local_cache *cache;
 	bool try_again = true;
 	gfp_t flags = (GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_NOWARN);
+	/* use per cpu cached buffers first */
+	cache = get_cpu_ptr(&aa_local_buffers);
+	if (!list_empty(&cache->head)) {
+		aa_buf = list_first_entry(&cache->head, union aa_buffer, list);
+		list_del(&aa_buf->list);
+		cache->hold--;
+		put_cpu_ptr(&aa_local_buffers);
+		return &aa_buf->buffer[0];
+	}
+	put_cpu_ptr(&aa_local_buffers);
 
+	if (!spin_trylock(&aa_buffers_lock)) {
+		cache = get_cpu_ptr(&aa_local_buffers);
+		update_contention(cache);
+		put_cpu_ptr(&aa_local_buffers);
+		spin_lock(&aa_buffers_lock);
+	} else {
+		cache = get_cpu_ptr(&aa_local_buffers);
+		if (cache->contention)
+			cache->contention--;
+		put_cpu_ptr(&aa_local_buffers);
+	}
 retry:
-	spin_lock(&aa_buffers_lock);
 	if (buffer_count > reserve_count ||
 	    (in_atomic && !list_empty(&aa_global_buffers))) {
 		aa_buf = list_first_entry(&aa_global_buffers, union aa_buffer,
@@ -1667,6 +1703,7 @@ char *aa_get_buffer(bool in_atomic)
 	if (!aa_buf) {
 		if (try_again) {
 			try_again = false;
+			spin_lock(&aa_buffers_lock);
 			goto retry;
 		}
 		pr_warn_once("AppArmor: Failed to allocate a memory buffer.\n");
@@ -1678,15 +1715,32 @@ char *aa_get_buffer(bool in_atomic)
 void aa_put_buffer(char *buf)
 {
 	union aa_buffer *aa_buf;
+	struct aa_local_cache *cache;
 
 	if (!buf)
 		return;
 	aa_buf = container_of(buf, union aa_buffer, buffer[0]);
 
-	spin_lock(&aa_buffers_lock);
-	list_add(&aa_buf->list, &aa_global_buffers);
-	buffer_count++;
-	spin_unlock(&aa_buffers_lock);
+	cache = get_cpu_ptr(&aa_local_buffers);
+	if (!cache->hold) {
+		put_cpu_ptr(&aa_local_buffers);
+		if (spin_trylock(&aa_buffers_lock)) {
+			list_add(&aa_buf->list, &aa_global_buffers);
+			buffer_count++;
+			spin_unlock(&aa_buffers_lock);
+			cache = get_cpu_ptr(&aa_local_buffers);
+			if (cache->contention)
+				cache->contention--;
+			put_cpu_ptr(&aa_local_buffers);
+			return;
+		}
+		cache = get_cpu_ptr(&aa_local_buffers);
+		update_contention(cache);
+	}
+
+	/* cache in percpu list */
+	list_add(&aa_buf->list, &cache->head);
+	put_cpu_ptr(&aa_local_buffers);
 }
 
 /*
@@ -1728,6 +1782,15 @@ static int __init alloc_buffers(void)
 	union aa_buffer *aa_buf;
 	int i, num;
 
+	/*
+	 * per cpu set of cached allocated buffers used to help reduce
+	 * lock contention
+	 */
+	for_each_possible_cpu(i) {
+		per_cpu(aa_local_buffers, i).contention = 0;
+		per_cpu(aa_local_buffers, i).hold = 0;
+		INIT_LIST_HEAD(&per_cpu(aa_local_buffers, i).head);
+	}
 	/*
 	 * A function may require two buffers at once. Usually the buffers are
 	 * used for a short period of time and are shared. On UP kernel buffers
-- 
2.39.2.637.g21b0678d19-goog

