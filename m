Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F6F186E41;
	Thu, 30 May 2024 14:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717080051; cv=none; b=m5HylEPwVQJfLbaxA5PVNq1qqrZc9htSPJnkh+kzSuI+P+wwvJ0nRlmHuL9GWxdOnh7RXrXob2Gpa53Qae+PDT77AnYVslYyvzHxthozP7k7ijAfNkUD9TXyRP019WTZBJTNjEmIc/FOKeEHnYY47rwgn/pet7eP0TlR0QRTAN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717080051; c=relaxed/simple;
	bh=XWlxAnuC/u9UwVSre4Bh7CKn2L/WZWSl+q4IsHzdHg0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O+FwoD0hG46yW1cUgfWZ0coGCKP94Qhu6hOobfliBTlHvfH2AZKEcWegurMbrDBGwtsCs7FXA6Q3W96jSaOTvCVp0G5H3DPjmWMohquYLk0btWR0y0C4jfgltc9vfPBrAFH3XkBkLm/pPetRLilbBKx/dwQcWI3QP//jLXbe8Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X7k4EgZF; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7k4EgZF"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52b79447c58so1368664e87.1;
        Thu, 30 May 2024 07:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717080047; x=1717684847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MiUZAyRllirKKzsD89/yIKCX3SIy5qsFBAtFuiUEDms=;
        b=X7k4EgZFA2ZOU1fNksV7NmNlzXAmfMbX8++wQQ3wxibs/OAJjhxNcfFxJJNU1oxaqn
         o118YyNLk5Q8E3InBOJPZH+s9sFjZxRkQqlm4LLEXI6grZ3++quj38w98KYdpsYT1Y8J
         K/jotjBrFV3TXCTyr9CBqhytGG4mT/TaLUj0eBx+ACWj2XyUuBPlMCZiM+hPW0Y6OzSu
         rMuLZMtJiv4zTVjlEaXAHCBY2nVfGaBKWKXOfccwI3P3aRSC6nbgAR2fxBKgBBUcwq/U
         4phxfu9mXLb0dUC4oTY1klYLc7V/8RELWdFzxByAOeQ7TFIiY17u1LgZiqarGZ4Qc2HM
         wYsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717080047; x=1717684847;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MiUZAyRllirKKzsD89/yIKCX3SIy5qsFBAtFuiUEDms=;
        b=jBfqzpBT4HH0W2rq4Br2Zpvn+UHhngst+LCB74HK9xMyxbR+xxIIAmW5BD07/ZoSt1
         Merl6qh3WgT8tA6TVRlECFbtxuvEkFa+mPhYTO97IgKggG1kFLell0gE5PC9uquHRDKL
         sIFUz2LYo0Dk4yO8jc/ypZqeLoVENkEc3kIYWAzQjGQtK6Al2BdoZoceJ5ucHqPnaTp/
         wKqAfAf48YzegBa1Ph3WuHVOjScxdkOdDlVoGrWHvBUbwhJsB6Vcmz8xELUS0plZneIJ
         ik+Fywfje9TQX+s4gOEGXntXUSq4yaYCirWBVXQ/9SqbYzYTFHdWkW+U4ug5HXpF5lcz
         blSQ==
X-Gm-Message-State: AOJu0YwTDpvykcwkz9PkG8jpw/X4iq8fFzsrpWdzgHV46singNoGknW0
	jAYrVq8U1mhbRMJcrnlZZYLy92w+SYYlN27nhSWv/kbFP9f7Evh8jmUXoTk5
X-Google-Smtp-Source: AGHT+IG7nJ/NQimAb6ENu+Mt1IVoSFruIV2XJFdrCKecJVtj80xQ6v5uM62Ivd1eYoeWqqIfmUtOdQ==
X-Received: by 2002:a19:430e:0:b0:52a:a91e:3f55 with SMTP id 2adb3069b0e04-52b7d499782mr1658316e87.47.1717080047196;
        Thu, 30 May 2024 07:40:47 -0700 (PDT)
Received: from f.. (cst-prg-8-232.cust.vodafone.cz. [46.135.8.232])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a66dbfc4ca6sm27932366b.165.2024.05.30.07.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 07:40:46 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: linux-security-module@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	paul@paul-moore.com,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] cred: plug a hole in struct cred
Date: Thu, 30 May 2024 16:40:40 +0200
Message-ID: <20240530144041.569927-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

/*     40      |       4 */    unsigned int securebits;
/* XXX  4-byte hole      */
/*     48      |       8 */    kernel_cap_t cap_inheritable;
[snip]
/*     88      |       1 */    unsigned char jit_keyring;
/* XXX  7-byte hole      */
/*     96      |       8 */    struct key *session_keyring;

jit_keyring can be moved up to the 4-byte hole.

Size goes down from 184 to 176 bytes.

Note total memory usage does not go down because the struct remains
backed by 192-byte chunks, but space is made for future expansion.

No functional changes.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

I have some plans to hack up distributed reference counting for this
struct, soon(tm). Should it land it is going to add at least 8 bytes.

But even if nothing comes out of it this looks like a trivial clean up
worth including.

 include/linux/cred.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/cred.h b/include/linux/cred.h
index 2976f534a7a3..a936a291e9b1 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -107,6 +107,9 @@ static inline int groups_search(const struct group_info *group_info, kgid_t grp)
  * that task is going to act upon another object.  This may be overridden
  * temporarily to point to another security context, but normally points to the
  * same context as task->real_cred.
+ *
+ * NOTE: some fields have placement picked to plug alignment gaps -- don't
+ * shuffle things around without looking at output of pahole(1).
  */
 struct cred {
 	atomic_long_t	usage;
@@ -119,14 +122,16 @@ struct cred {
 	kuid_t		fsuid;		/* UID for VFS ops */
 	kgid_t		fsgid;		/* GID for VFS ops */
 	unsigned	securebits;	/* SUID-less security management */
+#ifdef CONFIG_KEYS
+	unsigned char	jit_keyring;	/* default keyring to attach requested
+					 * keys to */
+#endif
 	kernel_cap_t	cap_inheritable; /* caps our children can inherit */
 	kernel_cap_t	cap_permitted;	/* caps we're permitted */
 	kernel_cap_t	cap_effective;	/* caps we can actually use */
 	kernel_cap_t	cap_bset;	/* capability bounding set */
 	kernel_cap_t	cap_ambient;	/* Ambient capability set */
 #ifdef CONFIG_KEYS
-	unsigned char	jit_keyring;	/* default keyring to attach requested
-					 * keys to */
 	struct key	*session_keyring; /* keyring inherited over fork */
 	struct key	*process_keyring; /* keyring private to this process */
 	struct key	*thread_keyring; /* keyring private to this thread */
-- 
2.39.2

