Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21F438A9BF
	for <linux-security-module@vger.kernel.org>; Fri, 30 Jan 2026 22:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769812805; cv=none; b=ZNgat0MV4s5iMeHN17zJAPl8CD8N/2Ytd8fgxKjZdIr+tzE/0h9XWiMFz1vGq5z8pnfOXB7kTztphSP/OLNQJwWbOCTuroDuxRK9pfv0RMxV1ZRheO0Wj//7W+EwjlErlp6B1mzIM5VRp1DiQ6ZXUVwIGrWeVt3u+BvYvZh6Izk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769812805; c=relaxed/simple;
	bh=z6Lb6+ePLVA8CXO/fQsgr/T3R5dJYxJxOz7/MekKJTg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l0vAqlMpWYUCgrHSn2eBEVnF6jCg5URefyt1PtoE9lL+MdmjeBWO6OdrONGLaqOTXdgbShGvPRHKHrTHmfdcVcu7PfHR2N3AWbmIBr6fPR7SvtLiK1Plh89/bLkzr8MT2+ZwwHte0FcDKdnbJ+DLVJT6juW+G844Xqv+NQ88Y2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=PwSiCF3t; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="PwSiCF3t"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-45c7a71ba20so1077138b6e.2
        for <linux-security-module@vger.kernel.org>; Fri, 30 Jan 2026 14:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1769812801; x=1770417601; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rU19TJuUpJsA3wTKDBviJ3u+aESdBzfWv1RhaMcQ8es=;
        b=PwSiCF3tykJ1mGz3PPdxd8c+Bo5lKfdjTA/UpkhSgy5qLZQfHejHhbY+sgiXO7WUT6
         oaaGAKEtkrEUv3okyFlKHsEcyN8AIxK/IQXbUpu6mVH+k+I8cAL1RC4I4AsAZCJ0gSuk
         e9OL2VD+KhsUW/VCMNhdAttfzk0xE6COvJL1MRHboIWLyJtatopw7jYJgZ3pNWxoB9Fp
         symvWZ7badmDQ+xFdQF71lTT0IWixss4UfeGNme6r5J9s1zs0TmBurA/niuFypLrFI/v
         t36BV5poUwEE/JGA80pgBBonhlP52vk1KAFaeBTVT4UMUD+snEf4M37VIr4hAGR4uZTH
         dH2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769812801; x=1770417601;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rU19TJuUpJsA3wTKDBviJ3u+aESdBzfWv1RhaMcQ8es=;
        b=RWkkuio1DyKotqE3EvMUB034I+wfDRhQa9mmuHlSljIO0FbqV0YfzgslCfZ2S37iHG
         w2FyKXsuqBXbUnsExHpwrngafTVkw8hyLIfWkxmnp4PRAA/zunxXCUwTQDQdv7hVyu5A
         PlkYahwxWx2g3hOSWfI+wrb/oukGKi66WN3eZxNdKWCC4Scstx0Z8g2WlBAlUljs/16Z
         u6cgrazpJJuOqmQJHIlNw5NewZ32sN2hLUnDXe0fRZjbiTkjQw2OCg+/SKKKnnJwK1gR
         4wcGOlOPbAlRalmumR9L+F1ICUAvVwEw6xw0LkAPLZXI+GXxBmBgjNQ/tmQiASTUHoxt
         +4eA==
X-Forwarded-Encrypted: i=1; AJvYcCXRBvAeDALLCKWle3zeK7ondINj0rE69ZJQaO1N+2wbj7T0CmHYhklGF6u73cm6GqQWWCJ3eToa1iu6Rmcr1xszhY/Tg8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHKZYgeQ8u7IiJas5TUp8YqP6KU1fYlP9H6KX7q1opm/UMXkQ3
	pjg7gb+HHYR9sDNJqTjbXjbOuS2WLVZ5EgRRuGo/yBLHqE/Di0BkYrZ6Ei3AZiGZ2Ts=
X-Gm-Gg: AZuq6aI+5J4YD+dWG6NPMInWa76/SPq3+FTBCC9Xmz185ObfPJFdIvg2O+7lgjre4N1
	22qPZlBqbKdULeSgJUxtZD1algQK0w6UFzn20YObdFPRR48NriF+y7dPVnrwL/+1CN0CIEmU6nu
	yLpJ93sWSOIGYSTPSmYbkZsZmqPWp1+HWmXr9CIAW6x1sAyfrAINgnHrRQ9WEq4xdyQEbiyT8VX
	qIKWvq47z9+IMBQ6KpChVTeoe8jtFwsn94s50ha/opFh6mCIi0FyidqGFskYxJSIVJUP2rSqzWV
	OQLinsgJ0fa5k+AcCCqPF/C9Pl5N8g/8YoY49Le0jLvv7ZE/0aY/TTwU6mO7eq3eaeSvoRq28tm
	0aq9mzbRtR9WR5URRJL1awvwqt9JXZBJEtKiiLGmkJqU5wFxNzu/mFOvG8pa9Oa1V315kt5U=
X-Received: by 2002:a05:6808:1b0c:b0:455:db31:a680 with SMTP id 5614622812f47-45f34d8b8e1mr2058357b6e.63.1769812801483;
        Fri, 30 Jan 2026 14:40:01 -0800 (PST)
Received: from [127.0.1.1] ([2a09:bac5:947d:4e6::7d:80])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45f08f20e38sm5400250b6e.10.2026.01.30.14.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 14:40:01 -0800 (PST)
From: Frederick Lawler <fred@cloudflare.com>
Date: Fri, 30 Jan 2026 16:39:55 -0600
Subject: [PATCH v5 2/3] ima: Make integrity_inode_attrs_changed() call into
 vfs
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260130-xfs-ima-fixup-v5-2-57e84ea91712@cloudflare.com>
References: <20260130-xfs-ima-fixup-v5-0-57e84ea91712@cloudflare.com>
In-Reply-To: <20260130-xfs-ima-fixup-v5-0-57e84ea91712@cloudflare.com>
To: Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, 
 linux-security-module@vger.kernel.org, kernel-team@cloudflare.com, 
 Frederick Lawler <fred@cloudflare.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3748; i=fred@cloudflare.com;
 h=from:subject:message-id; bh=z6Lb6+ePLVA8CXO/fQsgr/T3R5dJYxJxOz7/MekKJTg=;
 b=owEBbQKS/ZANAwAKAasltHYDktNtAcsmYgBpfTM9Qr4QWn0gskmoTP3gBCkBf94vdfd8ocQEE
 5Tb9icWCOWJAjMEAAEKAB0WIQTLNBqMVmu1PHvjOe2rJbR2A5LTbQUCaX0zPQAKCRCrJbR2A5LT
 bVSdEADsVtc/TtKM1xv5L5y29nfE2m8qig/KZsYSTP9RTmNF9dR3e6EIQhN82zcgahKUZfIUI67
 zjZXk5EZOmIIU+LYlyS0bMZvMXY32bUqh4NW/eyeIFgzjhOlhFz7jh+X6WB48iIxTckn1MaBgLg
 juIBsHgrPE2/qnTDwwTopyYt3HiHrBpIYkOEwGo9yvHVcqfQI2xrsILzDhnB54Q+ZWFkmcIecXX
 4ClNt6vbDS5SHF52bkB4VK5B2lbovTnKwFDRH0kBq3yHLgczTYjWSlMQmcnjgnV5p/bHj8RXUv6
 bbyVVutlgd6sWbJ/KQLHObHimytWt80xDpmvkK4g8VmjJ5B5cpE2fPG3ydbTqETMKbcoFzZ6XYk
 19OenOYNIM/gkuHu+8whUnfuojNmCPtyvWXaypurq4GBN1VTRqfHK8PJm3PXv+YGyGTwLDyvXod
 9nx6uC/Whs9qrSTzWZPxCK324UzKtPsQ2xgnviEs2uX1D07KDByVTDtLy/njM4yL1txMpnwl/qu
 CXs0sNbCPd6/bEfIgCh++dtY25gjuuxohygL/0px3MtJVhRKWdBqQ0XjIukM73ZKrGpNenf7yk6
 ztFL9z59XlWoqmke38etUnpsC2prGRFONWkRW4X8wBrhKy8H2i8RH4wrIxDZYcxmf2Ali3jD2kJ
 AKEwEVsSn4YHxqQ==
X-Developer-Key: i=fred@cloudflare.com; a=openpgp;
 fpr=CB341A8C566BB53C7BE339EDAB25B4760392D36D

Align integrity_inode_attrs_changed() to ima_check_last_writer()'s
semantics when detecting changes.

For IMA, stacked file systems that do not set kstat.change_cookie,
integrity_inode_attrs_changed() will compare zero to zero, thus no
change detected. This is not dissimilar to what
ima_check_last_writer() does.

No logical change intended for EVM.

Signed-off-by: Frederick Lawler <fred@cloudflare.com>
---
 include/linux/integrity.h         | 28 ++++++++++++++++++++++++----
 security/integrity/evm/evm_main.c |  5 ++---
 security/integrity/ima/ima_main.c |  5 ++---
 3 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/include/linux/integrity.h b/include/linux/integrity.h
index beb9ab19fa6257e79266b58bcb5f55b0c5445828..382c783f0fa3ae4a938cdf9559291ba1903a378e 100644
--- a/include/linux/integrity.h
+++ b/include/linux/integrity.h
@@ -9,6 +9,7 @@
 
 #include <linux/fs.h>
 #include <linux/iversion.h>
+#include <linux/kernel.h>
 
 enum integrity_status {
 	INTEGRITY_PASS = 0,
@@ -62,14 +63,33 @@ integrity_inode_attrs_stat_changed
 
 /*
  * On stacked filesystems detect whether the inode or its content has changed.
+ *
+ * Must be called in process context.
  */
 static inline bool
 integrity_inode_attrs_changed(const struct integrity_inode_attributes *attrs,
-			      const struct inode *inode)
+			      struct file *file, struct inode *inode)
 {
-	return (inode->i_sb->s_dev != attrs->dev ||
-		inode->i_ino != attrs->ino ||
-		!inode_eq_iversion(inode, attrs->version));
+	struct kstat stat;
+
+	might_sleep();
+
+	if (inode->i_sb->s_dev != attrs->dev || inode->i_ino != attrs->ino)
+		return true;
+
+	/*
+	 * EVM currently relies on backing inode i_version. While IS_I_VERSION
+	 * is not a good indicator of i_version support, this still retains
+	 * the logic such that a re-evaluation should still occur for EVM, and
+	 * only for IMA if vfs_getattr_nosec() fails.
+	 */
+	if (!file || vfs_getattr_nosec(&file->f_path, &stat,
+				       STATX_CHANGE_COOKIE,
+				       AT_STATX_SYNC_AS_STAT))
+		return !IS_I_VERSION(inode) ||
+		       !inode_eq_iversion(inode, attrs->version);
+
+	return integrity_inode_attrs_stat_changed(attrs, &stat);
 }
 
 
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 73d500a375cb37a54f295b0e1e93fd6e5d9ecddc..6a4e0e246005246d5700b1db590c1759242b9cb6 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -752,9 +752,8 @@ bool evm_metadata_changed(struct inode *inode, struct inode *metadata_inode)
 	bool ret = false;
 
 	if (iint) {
-		ret = (!IS_I_VERSION(metadata_inode) ||
-		       integrity_inode_attrs_changed(&iint->metadata_inode,
-						     metadata_inode));
+		ret = integrity_inode_attrs_changed(&iint->metadata_inode,
+						    NULL, metadata_inode);
 		if (ret)
 			iint->evm_status = INTEGRITY_UNKNOWN;
 	}
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 6570ad10887b9ea1172c78274cf62482350e87ff..8cb17c9d446caaa5a98f5ec8f027c17ba7babca8 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -328,9 +328,8 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	real_inode = d_real_inode(file_dentry(file));
 	if (real_inode != inode &&
 	    (action & IMA_DO_MASK) && (iint->flags & IMA_DONE_MASK)) {
-		if (!IS_I_VERSION(real_inode) ||
-		    integrity_inode_attrs_changed(&iint->real_inode,
-						  real_inode)) {
+		if (integrity_inode_attrs_changed(&iint->real_inode,
+						  file, real_inode)) {
 			iint->flags &= ~IMA_DONE_MASK;
 			iint->measured_pcrs = 0;
 		}

-- 
2.43.0

