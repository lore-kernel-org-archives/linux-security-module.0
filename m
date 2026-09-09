Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2284B4854FF
	for <linux-security-module@vger.kernel.org>; Wed,  9 Sep 2026 09:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788944510; cv=none; b=gZJ2IkhYn7077KJ6TrfRilRWO0y9lE7OYLIxRFndKj+fRUHWi7qVbJGmZ174Se0wSYXLCVadLc9K3Ta7DHea6yhPCRWZXAWK8mxcsOVE4B39oJU7pW40So4vt/hQPrbp3+0LkH0GJGj5m7XUwJ39W5XZAu/wCeTFla3kp8a2GeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788944510; c=relaxed/simple;
	bh=8FHBC5gbFeIC4E/lA238Bv5TaDRS4lUM54i1wq/3L1M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d5oDQuxJt7e4BfjsGZ5N2a53lVEPEFdmCQ6YHRVjFr+XehXnqOHQhGUXRSAcUEe4gBeB972RvqS8naYL9kYATb5lNsx78m/V+Chtj875T9NwnqA16I6tj3wFgmlG1BYp0P5FeV98ntqcCMXOqNwl5nlWiphDwspEnrtZyudy14c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=i21l73xr; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="i21l73xr"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-85590c5aeabso3924964b3a.3
        for <linux-security-module@vger.kernel.org>; Wed, 09 Sep 2026 02:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1788944505; x=1789549305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zE9gpwYGcyFTdwIyA0S+65+Mdt3hWydj4aldKyaFgJI=;
        b=i21l73xrU1JcJWRHJZzhcaeSRm8nFycZx6beX8G1uwxlOwoojRkfTGCKbbWCPLP3SX
         m5x97TCh2sdiNd3dlrh2WjDHfeojBXrZh9FIBrGOUCCTTpUsh+RluCiWo3E4Wk+hwJEW
         BWq4DHpSXLT1SIja1wzaBTE4x65I74ev+ui+MCPfO8c7pbmDaSpKuiSMB8pEXQUrW7Gv
         ZAQ6BjAgJZuwqLjqwCS+KNvpf/9zUvJV8Kmx65qr4DmYOqz7PqtClI5wY5uz3IVKjEcJ
         93sYdyHLd4qbrnNdUZ8hPpSHAIHDSZ0aSizGxtJmfIWjZ52t/KAJO2wwqn9dk48ANlfg
         cdrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788944505; x=1789549305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zE9gpwYGcyFTdwIyA0S+65+Mdt3hWydj4aldKyaFgJI=;
        b=HMMUxA9r0IjYV/pr2H3arE7DlHmeYClxX6bovok+6OZb9nCAIaaOTJna9kNgmKtmZV
         G8VTWqhUK6uwVF+WmfSbe3Jd13JncT2wXDB301PQKaeiZ04mCTS62vyEZq1/tTVV3r91
         ef6b5cdLBdPRyXXnp6NlrhSdeyKvkwLTTe0GnqndOC4z9lD+MtBJFHGlytvEERz0fEO0
         PJxgowCYg8g4qoaAQU1Tt6qfZVHGQMiuRl9IGGVwr5mjkMsMzGrPjBaz1lNRGaw/3Bgs
         DFeX0nhrPSHCVYEBCULC99XirDDVnJwX6SHKC/BCEIx8lHr+sASEeN9ICUxrfFtl5uXL
         v3Cg==
X-Forwarded-Encrypted: i=1; AKwUvBygVaprgHJ5l86gGwfWr6sWqYDJGpYdri/3BUHmRfkEPkWTv3QHA+1k8rIr6kwhstrwkLj1LNeXP+Kvl5UbYX1Sq4VGT/s=@vger.kernel.org
X-Gm-Message-State: AFuF++n107LMfvznZTQ5P0qIOJUzc8BcTrtz0ZgDyBFaTFXgw/iYi7aO
	Y7WQOFGc3H0hbjrW/Q9ZbzGzw+nQ3eZI9edWl1nDvGWplsEPQHjPQvi0VbByb9zE4jw=
X-Gm-Gg: AYBFou3ZfHPU/yplCJp58yeFR5btYq5HyUmL/lJs7aV0snNGOg2w9Iqpwlkz0ZRSNjQ
	phlJHUMjIt48fNZw0OOjRcW1KnDn5bOcafd90iabxHm6Fk7w1s3TGVan3OmrBelcnqlLo+RW2GN
	BouKToM2iU0nHW3a6KlPxIcB8cbOIiuzOx1Sbu585uXwqgVJ+xk0IgsUKA8t9jNwFOZC1g5D4x/
	qXIJfdYqSAPfBPNB16GijfE/H09U8yq2BF2CMzzub6FKyMBfbWROROgeQ0tBWvROF3waXeSqPA5
	mERNRxabXRrDqiDS6sLKlDaCgjPNtX5x56ylSKC1qWe4eXSr1KDton2+DCieKdp11iHvwCv6ejZ
	sh6ZV9fOt4QcPInG5T6zuyFgfNl3+Xqbx/z234ADUU9BZv2/OfszeKAwHPNWGj9aCbG5vqitCrr
	MGtN/hZJpV5uQaJHWSBPAKqSFAhGkrUD8awDig+z+Oo4as4UPEeXiuuyIbkeue4ewJE3xEqlMzd
	Q4=
X-Received: by 2002:a05:6a00:909a:b0:857:7317:cff1 with SMTP id d2e1a72fcca58-8616a168525mr51310976b3a.18.1788944504640;
        Wed, 09 Sep 2026 02:01:44 -0700 (PDT)
Received: from localhost ([106.38.226.231])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-868d1e4ff97sm483493b3a.17.2026.09.09.02.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 02:01:44 -0700 (PDT)
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
Subject: [PATCH 7/7] landlock: use sb_for_each_inodes() when detaching a superblock
Date: Wed,  9 Sep 2026 17:01:12 +0800
Message-Id: <20260909090112.790006-8-sunjunchao@bytedance.com>
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

Convert hook_sb_delete() to sb_for_each_inodes() and release each
callback's inode reference outside s_inode_list_lock. This removes the
prev_inode reference used to preserve the walk position while retaining
the synchronization with release_inode() and the final wait for pending
inode releases.

Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
---
 security/landlock/fs.c | 150 +++++++++++++++++------------------------
 1 file changed, 60 insertions(+), 90 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 30aa6ce13590..3dcde8cbfb6a 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1369,110 +1369,80 @@ static void hook_inode_free_security_rcu(void *inode_security)
 
 /* Super-block hooks */
 
-/*
- * Release the inodes used in a security policy.
- *
- * Cf. fsnotify_unmount_inodes() and evict_inodes()
- */
-static void hook_sb_delete(struct super_block *const sb)
+static int hook_sb_delete_inode_iter_cb(struct inode *inode, void *data)
 {
-	struct inode *inode, *prev_inode = NULL;
+	struct landlock_object *object;
+	struct super_block *sb = inode->i_sb;
 
-	if (!landlock_initialized)
-		return;
+	if (!atomic_read(&inode->i_count)) {
+		spin_unlock(&inode->i_lock);
+		return 0;
+	}
 
-	spin_lock(&sb->s_inode_list_lock);
-	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
-		struct landlock_object *object;
+	rcu_read_lock();
+	object = rcu_dereference(landlock_inode(inode)->object);
+	if (!object) {
+		rcu_read_unlock();
+		spin_unlock(&inode->i_lock);
+		return 0;
+	}
+	/* Keeps a reference to this inode until the next loop walk. */
+	__iget(inode);
+	spin_unlock(&inode->i_lock);
 
-		/* Only handles referenced inodes. */
-		if (!icount_read_once(inode))
-			continue;
+	/*
+	 * If there is no concurrent release_inode() ongoing, then we
+	 * are in charge of calling iput() on this inode, otherwise we
+	 * will just wait for it to finish.
+	 */
+	spin_lock(&object->lock);
+	if (object->underobj == inode) {
+		object->underobj = NULL;
+		spin_unlock(&object->lock);
+		rcu_read_unlock();
 
 		/*
-		 * Protects against concurrent modification of inode (e.g.
-		 * from get_inode_object()).
+		 * Because object->underobj was not NULL,
+		 * release_inode() and get_inode_object() guarantee
+		 * that it is safe to reset
+		 * landlock_inode(inode)->object while it is not NULL.
+		 * It is therefore not necessary to lock inode->i_lock.
 		 */
-		spin_lock(&inode->i_lock);
+		rcu_assign_pointer(landlock_inode(inode)->object, NULL);
 		/*
-		 * Checks I_FREEING and I_WILL_FREE  to protect against a race
-		 * condition when release_inode() just called iput(), which
-		 * could lead to a NULL dereference of inode->security or a
-		 * second call to iput() for the same Landlock object.  Also
-		 * checks I_NEW because such inode cannot be tied to an object.
+		 * At this point, we own the ihold() reference that was
+		 * originally set up by get_inode_object() and the
+		 * __iget() reference that we just set in this loop
+		 * walk.  Therefore there are at least two references
+		 * on the inode.
 		 */
-		if (inode_state_read(inode) &
-		    (I_FREEING | I_WILL_FREE | I_NEW)) {
-			spin_unlock(&inode->i_lock);
-			continue;
-		}
+		iput_not_last(inode);
+	} else {
+		spin_unlock(&object->lock);
+		rcu_read_unlock();
+	}
 
-		rcu_read_lock();
-		object = rcu_dereference(landlock_inode(inode)->object);
-		if (!object) {
-			rcu_read_unlock();
-			spin_unlock(&inode->i_lock);
-			continue;
-		}
-		/* Keeps a reference to this inode until the next loop walk. */
-		__iget(inode);
-		spin_unlock(&inode->i_lock);
+	spin_unlock(&sb->s_inode_list_lock);
+	iput(inode);
+	spin_lock(&sb->s_inode_list_lock);
 
-		/*
-		 * If there is no concurrent release_inode() ongoing, then we
-		 * are in charge of calling iput() on this inode, otherwise we
-		 * will just wait for it to finish.
-		 */
-		spin_lock(&object->lock);
-		if (object->underobj == inode) {
-			object->underobj = NULL;
-			spin_unlock(&object->lock);
-			rcu_read_unlock();
+	return 0;
+}
 
-			/*
-			 * Because object->underobj was not NULL,
-			 * release_inode() and get_inode_object() guarantee
-			 * that it is safe to reset
-			 * landlock_inode(inode)->object while it is not NULL.
-			 * It is therefore not necessary to lock inode->i_lock.
-			 */
-			rcu_assign_pointer(landlock_inode(inode)->object, NULL);
-			/*
-			 * At this point, we own the ihold() reference that was
-			 * originally set up by get_inode_object() and the
-			 * __iget() reference that we just set in this loop
-			 * walk.  Therefore there are at least two references
-			 * on the inode.
-			 */
-			iput_not_last(inode);
-		} else {
-			spin_unlock(&object->lock);
-			rcu_read_unlock();
-		}
+/*
+ * Release the inodes used in a security policy.
+ *
+ * Cf. fsnotify_unmount_inodes() and evict_inodes()
+ */
+static void hook_sb_delete(struct super_block *const sb)
+{
+	unsigned int flags = INODE_ITER_NORMAL;
 
-		if (prev_inode) {
-			/*
-			 * At this point, we still own the __iget() reference
-			 * that we just set in this loop walk.  Therefore we
-			 * can drop the list lock and know that the inode won't
-			 * disappear from under us until the next loop walk.
-			 */
-			spin_unlock(&sb->s_inode_list_lock);
-			/*
-			 * We can now actually put the inode reference from the
-			 * previous loop walk, which is not needed anymore.
-			 */
-			iput(prev_inode);
-			cond_resched();
-			spin_lock(&sb->s_inode_list_lock);
-		}
-		prev_inode = inode;
-	}
-	spin_unlock(&sb->s_inode_list_lock);
+	if (!landlock_initialized)
+		return;
+
+	sb_for_each_inodes(sb, flags, hook_sb_delete_inode_iter_cb, NULL);
 
-	/* Puts the inode reference from the last loop walk, if any. */
-	if (prev_inode)
-		iput(prev_inode);
 	/* Waits for pending iput() in release_inode(). */
 	wait_var_event(&landlock_superblock(sb)->inode_refs,
 		       !atomic_long_read(&landlock_superblock(sb)->inode_refs));
-- 
2.39.5

