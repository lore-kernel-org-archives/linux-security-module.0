Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B75443E25
	for <linux-security-module@vger.kernel.org>; Wed,  9 Sep 2026 09:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788944507; cv=none; b=uosywuLPE3EyqoaQt8sJYJuRFx089dlPJjnKknxNqXazQEIAsFKx9hApBcsWY9rVzT5jnzZpxwyomcCvs/Txkza0BarXsHCM7KqKxCXX1RBEC8D/+BF/VexniOWv8p5WF7L7rvNd5FLTUUWOwOQkKritk9b9A5z8/DAKRYX7u/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788944507; c=relaxed/simple;
	bh=HwU/ru9C3cqaYxeWB4WaVZIJTnLTox6zR3se4so5PpA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WWRNLXOuyyXsAG4wmpaTzIc0LHGWUzyYksFszK9a+YyK3aHoLlX+lt30po0U0xl2u5yl1TI3rqcoFlNnjRsRNkkjehMiX4BqbWToc8lushPIAEtUt96fOe+LeQVjCWZuHiTh0GleOMqBk3UXn08IjStu7tPnxgMQG78fWKgI270=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=AX2uX71x; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="AX2uX71x"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-39266382df6so4590572a91.3
        for <linux-security-module@vger.kernel.org>; Wed, 09 Sep 2026 02:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1788944501; x=1789549301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fnw+bbx2n8GI1P1qJxz04Evujcp+PRs2H97tReO8VaY=;
        b=AX2uX71xfP4rA9rlsPsV1ctTljMrgE2/hCHFzu/sWVEFPBCz8j/KsGEKZ5Njc5zDMC
         fr0WDVNSImBsY1Vbw+5G2iWDxrU33q7q+/jnTN7Ag5AzRM0nrIT3sIOrStifhhOLSjcD
         2EDFQg1HGxObWx5GNA4GTN8T2C4sixYXG2tdLcwMbVHSM4PDH7xNRLGn4r4zgjoBLJg1
         ZR18etssQHriB23gS9BsKzI6ZlJSAyQsvNBtpbPNCW6L2pKph8arSJhs1kCARg9tre4z
         /UMHQNrBH3w4HS9EYintIkQ3l6bfoGdmM1HgwBrYbzoVjKRmJl19JNmveUeg3Mnq1HFv
         Hc9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788944501; x=1789549301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fnw+bbx2n8GI1P1qJxz04Evujcp+PRs2H97tReO8VaY=;
        b=TOcl66O2dcoMtED61/jJGd749Sd+WX0rY67UgsVLrYbTja1vYFYDGBCOy+AnGXXGhX
         bW+gbIYMK7IwnCuvp0OHtEjRADBoNNAoIk1J+8HH3JRzI20zO2n/+xRI5GTQyfs5CRh5
         XY058sX2BaxL011a1m1fMkkxSIQszlj2ubXvk3XL+GGrazbE1jOPzp7KdV4EYx9ppsbA
         qyQ95jduQ/eKrwRsJa+Zur46HTM5LEBeaOQ3bCsIc5NU6D4Fw6ECa2vKIdVH2nw4yoGW
         Y6kT5idZX4LrU3EFJKEuaHXZKEzBLI7jbQxX6VSI4cyDpwmcfosLAlnmzIk2qXpzzD4c
         9Kxw==
X-Forwarded-Encrypted: i=1; AKwUvBwzrLjS/fuoTenvrowcWXu+nkmuXlAtD02ijSQxsFtwKkj4CZwCNY8cftn0OsgcAfWsw5KNk+3QT+Mdvr4AcoCVNIBhfOY=@vger.kernel.org
X-Gm-Message-State: AFuF++kA1P+oj95XxsMYrriinsVg8tG7gDqHIkR6ZIOYdriNkeGGaTsY
	gVR82rj1fGAPeHecyCHxsIkAh+k90EkNA7LfGgiwj02Ptbs27ac4SBuXFpQDQIqM5Q0=
X-Gm-Gg: AYBFou14Ge50a4SCJAyfNNFEAzfd1xqfrV/Lit/WwAV7uNmT2q/OaH3isdwFee2ygkB
	FkQh93c7rcYA568OZ9OaAF0+RyhnxoxDja54QoajgMvjkNpGn7BfRXaY7w1O+h5wQjzLQMOnjEn
	flR47gPqRu9QnNJpoTT6HwDJc8w76aTM4p3nYntBrAqTt4bEYdhIwUN8EfS0+OyKyoFSdceumjK
	49g9KqKiu/wP20YPblJjiHhf8zpUR7/+HihxCJnRlkYrMq0HSnG7J9CIFP9ioQnc9940dL9A5Mp
	4lY+1ySqlgUSRi7RZkmxJ4/KVoofcOzyn9x9/nO1VUKLh6qN0KQ7tipYn9qM+DDEp+LAF5OYDgj
	EKPf9rbDz1VydVtUdzQQgACYZ0L1uZeImFBIAqUZRDPXHwloJLQVVPc3Pd5E+uuagRBpPAj963I
	0EpnwQFU83qRYEN8lbflgCoim23ll0DI+6q/Iqk7e7l31yGyX1Cjxj9CQKDuO6LdKm6EsdoJhqA
	gPr
X-Received: by 2002:a17:90b:1343:b0:398:d93a:b343 with SMTP id 98e67ed59e1d1-39b26123302mr60180972a91.3.1788944496615;
        Wed, 09 Sep 2026 02:01:36 -0700 (PDT)
Received: from localhost ([106.38.226.186])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39bac3a2809sm4683088a91.10.2026.09.09.02.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 02:01:36 -0700 (PDT)
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
Subject: [PATCH 5/7] gfs2: use sb_for_each_inodes() for cooperative eviction
Date: Wed,  9 Sep 2026 17:01:10 +0800
Message-Id: <20260909090112.790006-6-sunjunchao@bytedance.com>
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

Convert gfs2_evict_inodes() to sb_for_each_inodes(). Take and drop the
inode reference within the callback, with iput() outside the list lock,
to retain cooperative eviction. The iterator preserves the walk position
and removes the need for toput_inode.

Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
---
 fs/gfs2/ops_fstype.c | 38 +++++++++++++++-----------------------
 1 file changed, 15 insertions(+), 23 deletions(-)

diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index 718e0da7dfce..acdbf9ca44a3 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -996,7 +996,7 @@ static int gfs2_lm_mount(struct gfs2_sbd *sdp, int silent)
 		switch (token) {
 		case Opt_jid:
 			ret = match_int(&tmp[0], &option);
-			if (ret || option < 0) 
+			if (ret || option < 0)
 				goto hostdata_error;
 			if (test_and_clear_bit(SDF_NOJOURNALID, &sdp->sd_flags))
 				ls->ls_jid = option;
@@ -1719,6 +1719,19 @@ static int gfs2_meta_init_fs_context(struct fs_context *fc)
 	return 0;
 }
 
+static int gfs2_evict_inode_iter_cb(struct inode *inode, void *unused)
+{
+	struct super_block *sb = inode->i_sb;
+
+	__iget(inode);
+	spin_unlock(&inode->i_lock);
+	spin_unlock(&sb->s_inode_list_lock);
+
+	iput(inode);
+	spin_lock(&sb->s_inode_list_lock);
+	return 0;
+}
+
 /**
  * gfs2_evict_inodes - evict inodes cooperatively
  * @sb: the superblock
@@ -1741,31 +1754,10 @@ static int gfs2_meta_init_fs_context(struct fs_context *fc)
  */
 static void gfs2_evict_inodes(struct super_block *sb)
 {
-	struct inode *inode, *toput_inode = NULL;
 	struct gfs2_sbd *sdp = sb->s_fs_info;
 
 	set_bit(SDF_EVICTING, &sdp->sd_flags);
-
-	spin_lock(&sb->s_inode_list_lock);
-	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
-		spin_lock(&inode->i_lock);
-		if ((inode_state_read(inode) & (I_FREEING | I_WILL_FREE | I_NEW)) &&
-		    !need_resched()) {
-			spin_unlock(&inode->i_lock);
-			continue;
-		}
-		__iget(inode);
-		spin_unlock(&inode->i_lock);
-		spin_unlock(&sb->s_inode_list_lock);
-
-		iput(toput_inode);
-		toput_inode = inode;
-
-		cond_resched();
-		spin_lock(&sb->s_inode_list_lock);
-	}
-	spin_unlock(&sb->s_inode_list_lock);
-	iput(toput_inode);
+	sb_for_each_inodes(sb, INODE_ITER_NORMAL, gfs2_evict_inode_iter_cb, NULL);
 }
 
 static void gfs2_kill_sb(struct super_block *sb)
-- 
2.39.5

