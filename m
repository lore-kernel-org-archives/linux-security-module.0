Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58879253F1A
	for <linux-security-module@vger.kernel.org>; Fri, 17 Oct 2025 20:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760734137; cv=none; b=IH/hMbntE66jZWODOqRZAFjDq3BIagNAyQ9c20nTxlbhGi2WhD2sq5e8791wPqwXG32DiXdALm2+0kO9kYBdk67ZPtwtRXfA2Rt94GStyst02Kg5Jxp6yp7N2LiHIsnt7vYmhLx+68HZ0LHzYVx/7JVAzc8S+3Iw5q2ARGxiVaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760734137; c=relaxed/simple;
	bh=JGlFU6E/2tmQ4XnJ0ph/P90SYDCublqUpGQcD6lRNks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FB1RbiMQbXmJYVFJD/8BV6vmUE0ghacaaHh4cNTc46GBkLvn1drD7I1vxuK/zod1xurb2U6B04epP6Rx/qWQJ/0aERplBWp4r+vQl6HrmcqAERUFes6csJRu1rzGrAUL3PBNP0WuwXdaMq7W0Q6Pq7gT+wFKkmp97H1WBZoZWL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=HzSyzQN3; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="HzSyzQN3"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-78f75b0a058so30981466d6.0
        for <linux-security-module@vger.kernel.org>; Fri, 17 Oct 2025 13:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760734135; x=1761338935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4EG/Tcx7xSSR76xgB9F1qvyT4rziYGi1m2gLwrNt5xM=;
        b=HzSyzQN3ESgj7kpeDwKsviPQm9wDuE+1eYesrdiSZ+4HU6zcZyeaGCeUZcCzHBKuUw
         jwiJ1k8+CX9Pl3q5xspXRhQdQUKVw/+Jddv916Nu92X3coO+eGy5uZa2zHScVasb54zh
         dL9eMoj6cqQKeWBCYz+Nz5jU2FdzCSPdrb9+bxs1BQ65XT4STsAuSIZq//xekBLdV48g
         IB6RT/21TyFOmm/bCxXqJAROPrrWl4WkOwwQQC5sjTwurNwJg7/qMxtaZLAxwrBHgbBe
         pnWcMBHdMFGrQpWux8cHE5JRbDS/ozSl4TBBLjn9H6FTlOi7ZdgILzdrXmSL9JU/xkCy
         lTzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760734135; x=1761338935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4EG/Tcx7xSSR76xgB9F1qvyT4rziYGi1m2gLwrNt5xM=;
        b=uRndBIqBTDmX1oQpDudRshhedMNBvBZt/0FWhBuFEahYhboU2CkruQjxPSelcCOUzt
         uviqZRmRVLHGhDHNXEZKNMRke862eUaasG1elayazhOfaGI51ncM+4UDr8tXrG2mALvN
         Wc2I+7AOWn8I5khRtiqRFl7uZTQsZ24RRV5dR/kYO9eyAZRT7TF+BTUfEStfgLa0dbfL
         XYDibMYQdLJGO13TwqsxyqjUYab38nfZaS9H3R1wLwH5xlDCKmfFIaL32kDRrwHCUD0A
         gUSyMfFwYeCG2dIOviDM/Nyv3z5DbLjgZlvdt0A3W9YtYIDRV4MXNYVEb34dnGj0BlwI
         sFjA==
X-Gm-Message-State: AOJu0YxRzxTwvfSlWh5/JVkQWGAo+FwCAaPGixdO40/tanziF0aZjoBf
	+aW2TPEJbQO43LyXrbwSvWd3hRZ+0Ie/J4L52yApC3jryosPL8Z5A/4cLOAeo9tPhiG29XQXiYX
	8jXKFVg==
X-Gm-Gg: ASbGncsnuysxdxUMlrhg8CcRYx3icCnAvhcx2pwfCJwFlB0QCGRFwwkETlfJm7TsCoI
	SUGctyzBFKFyaJOvuykJiuY+MlrdykupQJ9PHifV6pGS4bFMQQCO/nKsFPevekdyxFh1Equvhi+
	xEVi3Eqmi6kkSq8xbbkuF1M/b+hYeFzxqIP3nQ0ptRixZKCgPWWaguI1s7x0LQDaL7cb0iltHlB
	TlX9SDfLldwH1R/skFCIiNLaCA6zbdjS+cOUetepx37EGGf+BfFLTcYf79gRxF+ZV8dO1W0ouxd
	yQQaTLEKE9kGMCxUrEVsp25TuQLcGEoIw+uZkNa3xq3ic52mSugyhufodyboqhbivj5e4/WwHad
	Z5sm8XbVfR3UFZVCv/p9g6kcKdn0UucUneaEXZf4vI8EiTnLIPVqMaUL+euUNxeHjnwi7L35C6S
	+XMGC9GysTamL35o7E1tHTfHmhEShFsb/MMJxFqFtwp5pbIA==
X-Google-Smtp-Source: AGHT+IEGdLNXz23CG8KqK7rDaB7Dp52IkYR5NyL4skr0Jr1LGPBEskrMXt59MvAt0zYrT8eiVHlovg==
X-Received: by 2002:a05:6214:d8f:b0:87c:1d89:a245 with SMTP id 6a1803df08f44-87c20639474mr67649936d6.49.1760734134702;
        Fri, 17 Oct 2025 13:48:54 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87d028ad781sm4953426d6.49.2025.10.17.13.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 13:48:53 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org
Cc: john.johansen@canonical.com,
	zohar@linux.ibm.com,
	roberto.sassu@huawei.com,
	wufan@kernel.org,
	mic@digikod.net,
	gnoack@google.com,
	kees@kernel.org,
	mortonm@chromium.org,
	casey@schaufler-ca.com,
	penguin-kernel@I-love.SAKURA.ne.jp,
	nicolas.bouchinet@oss.cyber.gouv.fr,
	xiujianfeng@huawei.com
Subject: [PATCH v5 02/11] ipe: move initcalls to the LSM framework
Date: Fri, 17 Oct 2025 16:48:16 -0400
Message-ID: <20251017204815.505363-13-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251017204815.505363-12-paul@paul-moore.com>
References: <20251017202456.484010-36-paul@paul-moore.com>
 <20251017204815.505363-12-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1665; i=paul@paul-moore.com; h=from:subject; bh=JGlFU6E/2tmQ4XnJ0ph/P90SYDCublqUpGQcD6lRNks=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBo8quSvjuDQIaVzQWgja9v66CULtMt81uoCGI0s gmhoxS/+3GJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaPKrkgAKCRDqIPLalzeJ c3uhD/4qyKvSbS9UIUKBRodckuN0e5WYq6N9clQ0+h96wr70XzU/A0L07Kf80Adsz0g42pL8ssj wQbmF0UuZH4sF67R+UQ1Nihd7p96KL9xFV2dzVSh8zK0ZHpOLbld0nohYOrt0yC4WQeZCcQtQmW nqSS2e26UG2VA+/9uwbmGKR46m7mSESgfA5RRfT1dExYAjbnQWI9MwMF3ZWKxHw4n3lMJJZ9dtf gMEBJHZ6juo+pyZUDrawSCoyE5bdIAW9ypkLxODssboq+mcYv5SmQw0Dg3FBfMuSl/mIXTdGl8I 7EMFIrfxk5Vdcu0JN4GqYO9aFNkhsmx7k9Jb+VmSv1QOmoC2nNW8kL1dFt3mpZkOk6zYUgYaR/C lzFNCmE5mfWHS310goChBwRhrs9ErYjI7W9PUG4YzFtRycKmR8x1COANsjCKc8gMZXttb7re/Qy PPugOpQH+tQBKQuA4ZfDiODJPjzAymrSBo/EPkyBtOrz9yjwS7LKQ+T1eCWpMAsb/USJ1MT7cj7 G4SGv3dEOvnOIs8okpoRDPbATa6mspkbeE/PpaMIOQW0fvoqqLcWhcTtkW9GgKWCDXhhFak4JE3 4xN4pHxBtbNFYzKDQmGyi1zMfNKHx7EmkT1NTcB9Tl2ru8Er9McLiaMuNGPVN6t0Qvf/FPKiq/d tG3CBMTUCHxiWkg==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Reviewed-by: Kees Cook <kees@kernel.org>
Tested-by: Fan Wu <wufan@kernel.org>
Acked-by: Fan Wu <wufan@kernel.org>
Reviewed-by: John Johansen <john.johhansen@canonical.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/ipe/fs.c  | 4 +---
 security/ipe/ipe.c | 1 +
 security/ipe/ipe.h | 2 ++
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/security/ipe/fs.c b/security/ipe/fs.c
index 0bb9468b8026..076c111c85c8 100644
--- a/security/ipe/fs.c
+++ b/security/ipe/fs.c
@@ -193,7 +193,7 @@ static const struct file_operations enforce_fops = {
  * Return: %0 on success. If an error occurs, the function will return
  * the -errno.
  */
-static int __init ipe_init_securityfs(void)
+int __init ipe_init_securityfs(void)
 {
 	int rc = 0;
 	struct ipe_policy *ap;
@@ -244,5 +244,3 @@ static int __init ipe_init_securityfs(void)
 	securityfs_remove(root);
 	return rc;
 }
-
-fs_initcall(ipe_init_securityfs);
diff --git a/security/ipe/ipe.c b/security/ipe/ipe.c
index 2426441181dc..71644748ed56 100644
--- a/security/ipe/ipe.c
+++ b/security/ipe/ipe.c
@@ -95,4 +95,5 @@ DEFINE_LSM(ipe) = {
 	.id = &ipe_lsmid,
 	.init = ipe_init,
 	.blobs = &ipe_blobs,
+	.initcall_fs = ipe_init_securityfs,
 };
diff --git a/security/ipe/ipe.h b/security/ipe/ipe.h
index fb37513812dd..25cfdb8f0c20 100644
--- a/security/ipe/ipe.h
+++ b/security/ipe/ipe.h
@@ -23,4 +23,6 @@ struct ipe_bdev *ipe_bdev(struct block_device *b);
 struct ipe_inode *ipe_inode(const struct inode *inode);
 #endif /* CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG */
 
+int ipe_init_securityfs(void);
+
 #endif /* _IPE_H */
-- 
2.51.1.dirty

