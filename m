Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DB748E0D7
	for <linux-security-module@vger.kernel.org>; Wed,  9 Sep 2026 09:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788944508; cv=none; b=mJMMVvBCNwyEJ0YNeL4GvSLot+o7dhvcr2zvgtN7FJ9cLNIqkscx4vDHrrHMcxoJIWtjKdsgRkAN804+rFVyMMxPIihmGoyg5Z/iITTT+id7qqeK3eZZwQi7zRk+xxbF8yBroGfUx0LG6gxJCRW+5UJEpP4iJhpuMmtKP1eJAuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788944508; c=relaxed/simple;
	bh=SAkZAInoNDJlwE4Vz0Q6DNK1AolKSJ1RECb+CGpp1bo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A5F4t9QQwfYcbVsIMtI3bg6iyaHljOta69th3n+6HB8j5GXeeuYEaygX+kpyFof9O8Kr/oZzksaffwnMbyNlThVA51jFRHUOabxnONYAbq/WUoGAYs90NtIgDAkrPnp2+KvcHDuqFyghPJM1PqPfGmkplentvnbDur32jPjlSrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=O9H84TDg; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="O9H84TDg"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8690079f2c1so201907b3a.2
        for <linux-security-module@vger.kernel.org>; Wed, 09 Sep 2026 02:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1788944500; x=1789549300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=16fpww6sBpVAinXNCcY2u0zfGvd2bv+kcIua+w/wNXg=;
        b=O9H84TDgaJ8XqSQXKMQDDDiZkkrZIZ8OgFliWpLPCCSxEAXqqt3NWSha6xKivV+V3F
         VuhOH3vkUluEfsUGCQ58H5FSw4o8iqs/lrfhsExQfZSeKBJxtPeIi86rF16+Gl0AXqK4
         UJTWAEzPM2ClO26O1LLYOeAVYgR1QM6778/joUMyzZtD3YqHavK6OcTQpH1J8Y5RhPhw
         HBoiSKUt77KZmNLu0euhokHwZrlUU1s7BQpH/UduDZG9v57zRvJ5tZzx7n6//fNWM08/
         Sa6+SGBV61oux85OqeOLph6qyfzVrE6p/L+Wd2w/YXYU9SAoaVEHuyWC95eqsd82+XB7
         ZlYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788944500; x=1789549300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=16fpww6sBpVAinXNCcY2u0zfGvd2bv+kcIua+w/wNXg=;
        b=Y4hKilRL97PvVjBbXRCzy2lWjq6Zk1vDmtxbNh8krjdyfq34juUqJHBAnZREpBo5uR
         ifzZCCHv5ALg/sleEHmGpHPXrj1jE2JMUM89aC5+dHB05i1icU0cTnQq82kJfbGOrT+u
         JnfkO4dB0CnWB8RrhXIrfGLyTmhZdlasFTMFwULfx+Rya7DS1+u9Ol891NLbIGHfwrUr
         NN1d6kVFRTw1MBRev4bVIUEr9icZuAmYnnS5GPiW2RioH3XaG6wDsLEOv+VtYvyqDlVC
         YOClzHWCRaFSB3bX75ezCRzzCC+7Pev4Qv6s+ngT1T5MxRWrBD8y0IyBu3S2qMpWTjn0
         127g==
X-Forwarded-Encrypted: i=1; AKwUvByxjbpdyV0hcAi+ncsJch1aCaR5Glq7cuvZhnqMsb0XkJYNDORQk0W8hgN+RLhpg6IUhs+iCKyWlOejb7qvm0RTRVNIrx4=@vger.kernel.org
X-Gm-Message-State: AFuF++n+pELAq2Vwh+VaqPclcV1wQmWopTv+77RpsYnpIhi3AX3TGxg0
	VFWKQL7enDCnf1qar7KaqIXyLN4BM41PC11UJ1auhsizRInTwolnZ5lpJj7XgauAKtU=
X-Gm-Gg: AYBFou0dhZ6UVhipmAVuJq28WlnNnPdxPQ2rHZMz3n61pJD0ECh67T0QT/O2AeOBTYD
	JR5/+3GW7zsmm0tmCBHsk0Lub0KiSFoPlPjQWo4POobrBZsExuiECjkKDtmqKfq4u4qERqBEkX9
	5GPsG82loobe6yXYzw7nLzojSpYJ7qQsZHSLsfgc9VpNmRTzePmaoqqdkGcOPbCCvNCyWXDKC1X
	ubko2DNqzK8TStc42V6DkZJ5T4X5Zi6lQXdwXMcndf3VK8mqddCKR5vGop/fnznF7s2ECSq2tlP
	tFJzGLUd9/veJwQXccqJv+6NljeIUffjMgQHBndf1V+qvcAaPaUfh0m+iYcjZnneqG+nRj8hCMv
	g6vnLw3yY9AwO/7Gye/MQEoiFsNtbY1D0w+xpyk7FX//qQjezPlI0qpxMylmwFBEyQPA6rP95DY
	ERtnA4nwerReYWCbsDr1CaxvasaPSV29xhjpKb75HwcIOMjaAilNFAkN1JGnampGPdYQTI5AsOk
	g==
X-Received: by 2002:a05:6a00:f94:b0:857:7337:5db7 with SMTP id d2e1a72fcca58-8616ac58363mr49645804b3a.21.1788944500308;
        Wed, 09 Sep 2026 02:01:40 -0700 (PDT)
Received: from localhost ([106.38.226.64])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86152045f8bsm6902214b3a.15.2026.09.09.02.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 02:01:39 -0700 (PDT)
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
Subject: [PATCH 6/7] quota: use sb_for_each_inodes() in add_dquot_ref()
Date: Wed,  9 Sep 2026 17:01:11 +0800
Message-Id: <20260909090112.790006-7-sunjunchao@bytedance.com>
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

Convert add_dquot_ref() to sb_for_each_inodes(), passing the quota type
to the callback and propagating initialization errors. This removes the
old_inode reference used to preserve the walk position.

Leave remove_dquot_ref() unchanged to avoid adding per-inode locking to a
walk that never drops s_inode_list_lock.

Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
---
 fs/quota/dquot.c | 72 +++++++++++++++++++-----------------------------
 1 file changed, 28 insertions(+), 44 deletions(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 204afc5e984b..77c68149d4ae 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -1043,64 +1043,48 @@ static int dqinit_needed(struct inode *inode, int type)
 	return 0;
 }
 
-/* This routine is guarded by s_umount semaphore */
-static int add_dquot_ref(struct super_block *sb, int type)
+static int add_dquot_ref_inode_iter_cb(struct inode *inode, void *data)
 {
-	struct inode *inode, *old_inode = NULL;
+	int type = *(int *)data;
+	int err = 0;
+	struct super_block *sb = inode->i_sb;
 #ifdef CONFIG_QUOTA_DEBUG
 	int reserved = 0;
 #endif
-	int err = 0;
 
-	spin_lock(&sb->s_inode_list_lock);
-	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
-		spin_lock(&inode->i_lock);
-		if ((inode_state_read(inode) & (I_FREEING | I_WILL_FREE | I_NEW)) ||
-		    !atomic_read(&inode->i_writecount) ||
-		    !dqinit_needed(inode, type)) {
-			spin_unlock(&inode->i_lock);
-			continue;
-		}
-		__iget(inode);
+	if (!atomic_read(&inode->i_writecount) ||
+	    !dqinit_needed(inode, type)) {
 		spin_unlock(&inode->i_lock);
-		spin_unlock(&sb->s_inode_list_lock);
+		return 0;
+	}
+
+	__iget(inode);
+	spin_unlock(&inode->i_lock);
+	spin_unlock(&sb->s_inode_list_lock);
 
 #ifdef CONFIG_QUOTA_DEBUG
-		if (unlikely(inode_get_rsv_space(inode) > 0))
-			reserved = 1;
+	if (unlikely(inode_get_rsv_space(inode) > 0))
+		reserved = 1;
 #endif
-		iput(old_inode);
-		err = __dquot_initialize(inode, type);
-		if (err) {
-			iput(inode);
-			goto out;
-		}
-
-		/*
-		 * We hold a reference to 'inode' so it couldn't have been
-		 * removed from s_inodes list while we dropped the
-		 * s_inode_list_lock. We cannot iput the inode now as we can be
-		 * holding the last reference and we cannot iput it under
-		 * s_inode_list_lock. So we keep the reference and iput it
-		 * later.
-		 */
-		old_inode = inode;
-		cond_resched();
-		spin_lock(&sb->s_inode_list_lock);
-	}
-	spin_unlock(&sb->s_inode_list_lock);
-	iput(old_inode);
-out:
+	err = __dquot_initialize(inode, type);
 #ifdef CONFIG_QUOTA_DEBUG
-	if (reserved) {
-		quota_error(sb, "Writes happened before quota was turned on "
-			"thus quota information is probably inconsistent. "
-			"Please run quotacheck(8)");
-	}
+	if (reserved)
+		quota_error(sb, "Writes happened before quota was turned "
+			    "on thus quota information is probably "
+			    "inconsistent. Please run quotacheck(8)");
 #endif
+	iput(inode);
+	spin_lock(&sb->s_inode_list_lock);
 	return err;
 }
 
+/* This routine is guarded by s_umount semaphore */
+static int add_dquot_ref(struct super_block *sb, int type)
+{
+	return sb_for_each_inodes(sb, INODE_ITER_NORMAL,
+				  add_dquot_ref_inode_iter_cb, &type);
+}
+
 static void remove_dquot_ref(struct super_block *sb, int type)
 {
 	struct inode *inode;
-- 
2.39.5

