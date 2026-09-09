Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA7D48F02C
	for <linux-security-module@vger.kernel.org>; Wed,  9 Sep 2026 09:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788944497; cv=none; b=HtaMnlrPMfiKkFBR4qGWv725k8ePXi7uHDQl6jIUeii5w+IV4Oh2S89tJmIfBF1DIDZJlYekA9ce4hRm9c4wyyCxFIeN2geg9KriURzRAKXj3HeEtRhYM5ek+8ifz+liiU3UUuu2jZy2lLAaBIaiECxhzw57hzoSlLx2wFQIUOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788944497; c=relaxed/simple;
	bh=jhgRCcb7mvKVZxOJ1EM1RoAJ+ehrjZv/eQIaG8NPXAc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bZ4ZjB0PxiHfjfVY06Oaz1wl/wJa94IDq1i36v9WMNHbSVRh+ybKhtAQdcb1ojyY/jGGP6JGgkGH4KtAbBGpghfHL0UZJRNKDP6eUoJCw0tcddMbrV6mtWBzw2jQikgwkR24Bb4ov9sk/r3qQewTUN5etFCJ2DgwCJvb7GA08dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=D3hBpL7j; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="D3hBpL7j"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-39675172593so4589789a91.2
        for <linux-security-module@vger.kernel.org>; Wed, 09 Sep 2026 02:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1788944489; x=1789549289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tYH8W8/cakUiUYwi0P1xd+OFPw98tjeFCA4aRl63o4I=;
        b=D3hBpL7jO1bVMfYC78IMXfkgLMf4BMzVGv3zHb6mDDsn55CkT9uxaViDvnZMYwS6N/
         SoQnpFvZ0ERcy9zWt1Bw6QRH3q/BWgA4AVnWBAZ4nluxaBikwSfOlm8HFdPKXAs4/9XE
         AX2YuUAkae3jCrtlLIm9kWUeMEICwTUMsM8R0al5hlkI0lYiE9e5VFeYWi6XuOFj42DK
         7X0CCA0ljtQB6/bHtUV8XYgux8T2bG8NXoh8hzBJp4Ly9H1Su/25SnWtysrKayUa3nyJ
         1o0++avvZidmFpNeiR7ClQdlxq1fjvtrSIhcVBubCDHTQ2wRWJsLFGNqQ7vE7cF2j0a5
         SnjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788944489; x=1789549289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tYH8W8/cakUiUYwi0P1xd+OFPw98tjeFCA4aRl63o4I=;
        b=oi6V7L31z9P/1L0qSL4ag3lXkYZhNv6MBr/Bg3S/PKNltKuS52GzjOueBzUL3zvUSZ
         8htwRFDZiSgJjC1EgnKJT/hc4aJsQTflBNA6pKfX+KIVFkcwSFrGHowc2woknTe9wApX
         YibEUK/+BUQegeh6GrHqLjUgPvNB2rKswk23MsUHP2QzPa93InZaibrpvIeJnEzZalZ3
         Pjf1VARVCLgyAhNpyQoxD5TCTMJCq9W0apG3bsPy/HcIESHhVbDVJvCkHuRhrB9C68mH
         dve/RItefazidhRczeAtjcNQ39Rb70iKHi47f1h/mh42pAwu8fVpUBbZoSTbGWAQ8MlG
         LvEQ==
X-Forwarded-Encrypted: i=1; AKwUvBxfk23hzvjj6U/A/u2kji/CjAt8uLtkZ49KY+otwOyQSTVZUeoJDLtzHsMLlCtiKZfZ0CgospU9Zyx6aYbVG1Il/2DmRc8=@vger.kernel.org
X-Gm-Message-State: AFuF++l3kW0g1ro3e1EoSFwlCVgUdYo4HDZrcOLc94a8jh3di3pL5Zwe
	KFrBD8l3WZ8Hv67DcYX0B56Fvtt9lqSAPg0uF2r/597lwoJu4CNKJiWnBJsmSv+vxLQ=
X-Gm-Gg: AYBFou2hm9KLJWn6Zd8zlA3tau8XN9wKgH9Mlx2KQ2jR7CAbnSBbDxYvLfDWP7/iLK/
	aSGrXtgckTt8n5fRzcT3jY/NAkDMnNY/BbGqOowAX/yOn8OKJW9ZvOol7D/V1dQEftWTISP7Q6C
	5IijSJlmsSmsU5RwmqQNUUNNP/gHFWRHaYJjiveMIbOOEIVuRr92tArbkiOPtaP8Wue+Sg00pfV
	ciB7J33tYeISEyy3lQYoajf1f1jxbRf4Oi9btpOuBgtWa+0Dsgs4w/Tm/YK1jynbqAqC1pD6RrE
	53lzNzdl4PMfEGvwTBiE6Y4ydRLGp94snUbgguNirWntSswShDNkaEGQqFCQ6fNHtyHbKWJy3zc
	J8lHrW4mf+h7b/JfeGQGWVuY15JjUeyx4kkISEljhlbuDRkegKLLjIwQ686M0JEIBfkXqovlllY
	rmfBJczm6gwB/EvWSiWn2Mr3ZhjLhmMQZrfEYVf4YCu457PCeK6Ye0Jdk/Dr4asQjJU9MoFrki8
	TuDpZLSYw3pbw==
X-Received: by 2002:a17:90b:544b:b0:398:c8ef:3644 with SMTP id 98e67ed59e1d1-39b26203e7amr48533741a91.15.1788944483947;
        Wed, 09 Sep 2026 02:01:23 -0700 (PDT)
Received: from localhost ([106.38.226.141])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc4640bc66bsm5418841a12.10.2026.09.09.02.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 02:01:23 -0700 (PDT)
From: Julian Sun <sunjunchao@bytedance.com>
To: linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-security-module@vger.kernel.org
Cc: jack@suse.cz,
	agruenba@redhat.com,
	mic@digikod.net,
	gnoack@google.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	aleksa@amutable.com,
	legion@kernel.org,
	djwong@kernel.org,
	ebiggers@kernel.org,
	sandeen@redhat.com
Subject: [PATCH 2/7] fs: introduce sb_for_each_inodes().
Date: Wed,  9 Sep 2026 17:01:07 +0800
Message-Id: <20260909090112.790006-3-sunjunchao@bytedance.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260909090112.790006-1-sunjunchao@bytedance.com>
References: <20260909090112.790006-1-sunjunchao@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add sb_for_each_inodes() to share s_inodes traversal and preserve its
position while s_inode_list_lock is dropped.

Track active iterators on sb->s_inodes_iters and advance their saved
positions before unlinking an inode. Callbacks manage inode references
and per-inode work, allowing both normal walks and eviction to use the
same interface.

Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
---
 fs/inode.c                     | 93 ++++++++++++++++++++++++++++++++++
 fs/super.c                     |  1 +
 include/linux/fs.h             | 15 ++++++
 include/linux/fs/super_types.h |  3 +-
 4 files changed, 111 insertions(+), 1 deletion(-)

diff --git a/fs/inode.c b/fs/inode.c
index ba7da39be4a3..b4279063a5dd 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -69,6 +69,15 @@ const struct address_space_operations empty_aops = {
 };
 EXPORT_SYMBOL(empty_aops);
 
+struct inode_iter {
+	struct list_head	iters_node;	/* sb->s_inodes_iters */
+	struct list_head	*next;		/* next node going to iterate */
+	unsigned int flags;
+	inode_iter_cb func;
+	void *data;
+	int ret;
+};
+
 static DEFINE_PER_CPU(unsigned long, nr_inodes);
 static DEFINE_PER_CPU(unsigned long, nr_unused);
 
@@ -641,12 +650,96 @@ void inode_sb_list_add(struct inode *inode)
 }
 EXPORT_SYMBOL_GPL(inode_sb_list_add);
 
+static void inode_sb_iter_start(struct super_block *sb, struct inode_iter *it,
+				unsigned int flags, inode_iter_cb fn, void *data)
+{
+	it->flags = flags;
+	it->func = fn;
+	it->data = data;
+	it->ret = 0;
+	spin_lock(&sb->s_inode_list_lock);
+	it->next = sb->s_inodes.next;
+	list_add(&it->iters_node, &sb->s_inodes_iters);
+}
+
+static void inode_sb_iter_end(struct inode_iter *it, struct super_block *sb)
+{
+	list_del(&it->iters_node);
+	spin_unlock(&sb->s_inode_list_lock);
+}
+
+static bool inode_sb_iter_next(struct inode_iter *it, struct super_block *sb)
+{
+	struct inode *inode = NULL;
+	int ret;
+
+	while (!inode && it->next != &sb->s_inodes) {
+		inode = list_entry(it->next, struct inode, i_sb_list);
+		if (it->flags & INODE_ITER_UNUSED) {
+			if (icount_read_once(inode)) {
+				it->next = it->next->next;
+				continue;
+			}
+
+			spin_lock(&inode->i_lock);
+			if (icount_read(inode)) {
+				spin_unlock(&inode->i_lock);
+				it->next = it->next->next;
+				continue;
+			}
+		} else {
+			spin_lock(&inode->i_lock);
+		}
+
+		if ((it->flags & INODE_ITER_NORMAL) &&
+		    (inode_state_read(inode) & (I_NEW | I_FREEING | I_WILL_FREE))) {
+			spin_unlock(&inode->i_lock);
+			it->next = it->next->next;
+			continue;
+		}
+
+		it->next = it->next->next;
+		ret = it->func(inode, it->data);
+		if (ret) {
+			it->ret = ret;
+			return false;
+		}
+
+		if (need_resched()) {
+			spin_unlock(&sb->s_inode_list_lock);
+			cond_resched();
+			spin_lock(&sb->s_inode_list_lock);
+		}
+	}
+
+	return it->next == &sb->s_inodes ? false : true;
+}
+
+int sb_for_each_inodes(struct super_block *sb, unsigned int flags,
+		       inode_iter_cb fn, void *data)
+{
+	struct inode_iter it;
+
+	inode_sb_iter_start(sb, &it, flags, fn, data);
+	while (inode_sb_iter_next(&it, sb))
+		;
+	inode_sb_iter_end(&it, sb);
+
+	return it.ret;
+}
+EXPORT_SYMBOL(sb_for_each_inodes);
+
 static inline void inode_sb_list_del(struct inode *inode)
 {
 	struct super_block *sb = inode->i_sb;
+	struct inode_iter *it;
 
 	if (!list_empty(&inode->i_sb_list)) {
 		spin_lock(&sb->s_inode_list_lock);
+		list_for_each_entry(it, &sb->s_inodes_iters, iters_node) {
+			if (it->next == &inode->i_sb_list)
+				it->next = inode->i_sb_list.next;
+		}
 		list_del_init(&inode->i_sb_list);
 		spin_unlock(&sb->s_inode_list_lock);
 	}
diff --git a/fs/super.c b/fs/super.c
index 05e443173038..3e069150c544 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -382,6 +382,7 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 	spin_lock_init(&s->s_roots_lock);
 	mutex_init(&s->s_sync_lock);
 	INIT_LIST_HEAD(&s->s_inodes);
+	INIT_LIST_HEAD(&s->s_inodes_iters);
 	spin_lock_init(&s->s_inode_list_lock);
 	INIT_LIST_HEAD(&s->s_inodes_wb);
 	spin_lock_init(&s->s_inode_wblist_lock);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 09c4db5e9ae0..f3176ab10e65 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -870,6 +870,21 @@ struct inode {
 	void			*i_private; /* fs or device private pointer */
 } __randomize_layout;
 
+enum inode_iter_flags_enum {
+	INODE_ITER_NORMAL = (1U << 1),  /* Exclude inodes with (I_NEW | I_FREEING | I_WILL_FREE). */
+	INODE_ITER_UNUSED = (1U << 2),  /* Only return inodes with (i_count == 0). */
+};
+
+/*
+ *                             start          end
+ *  inode->i_lock              locked         unlocked
+ *  sb->s_inode_list_lock      locked         locked
+ */
+typedef int (*inode_iter_cb) (struct inode *, void *);
+
+int sb_for_each_inodes(struct super_block *sb, unsigned int flags,
+		       inode_iter_cb fn, void *data);
+
 /*
  * i_state handling
  *
diff --git a/include/linux/fs/super_types.h b/include/linux/fs/super_types.h
index ecd96aeb1cee..1f81cc219b8e 100644
--- a/include/linux/fs/super_types.h
+++ b/include/linux/fs/super_types.h
@@ -269,9 +269,10 @@ struct super_block {
 	 */
 	int s_stack_depth;
 
-	/* s_inode_list_lock protects s_inodes */
+	/* s_inode_list_lock protects s_inodes and s_inodes_iters */
 	spinlock_t				s_inode_list_lock ____cacheline_aligned_in_smp;
 	struct list_head			s_inodes;	/* all inodes */
+	struct list_head			s_inodes_iters; /* all iterators */
 
 	spinlock_t				s_inode_wblist_lock;
 	struct list_head			s_inodes_wb;	/* writeback inodes */
-- 
2.39.5

