Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91853A1B5
	for <linux-security-module@vger.kernel.org>; Wed, 19 Aug 2026 23:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787183139; cv=none; b=hgQAluwPTmiuovpeJ+IXunY5pr0rRC5KwzrnDSO/+ry8K8Vsu1H/xyF/R/pffvqchNhPiREQhjs04opB6abFNxo0GTowMP1XVIpcMBgEfLPrbYJBWeUFiTLD6xxFDSa8Y5T6AoU16absl2wNCM3g+GlgvP5UlVA0LiaSdRFC7oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787183139; c=relaxed/simple;
	bh=4Dr8FUckZZs6x07b+xsKvc6HgeTnce7Z1vxgvZfvoJU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f20s0WkioI0LbEUonDLNKh68xI442h0W6Bq/SzRQ76Cupdc/ACWSjoDOyF/xeKeVm7F9KewoBvpWqLqbADxTyudhbRoKHJrcT74jHZxtYevwQpFAb3dBTF8tvGUt+UkI4SFeRzCeELOXsFv6sQaPDRdjwYwDu/hYWyAtv5+mOB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=A/IimmkD; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="A/IimmkD"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6aca0f482e5so1378272eaf.2
        for <linux-security-module@vger.kernel.org>; Wed, 19 Aug 2026 16:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1787183136; x=1787787936; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rXoczBGO5I6N9TIC59uDIKSOp13YmyqaSWTBgCd4pCI=;
        b=A/IimmkD/A04I1kuI19qd5BK7cx0r0NcofgxrbGtOh41zMeL56Pz+ewFYWt7n2TjD2
         Yx5CviJkwpxgj5jfsoYzxp7o3xb42hyTMrSPrdoJQdoPFkv2zfsAN7aINQ1JOPL0n1kc
         q1JOx0DSCPRypgAjmGGB4tuLGbmCC59B5a9iVFnVuVBz7GWh/eNhHzIc+3dOtyhH+pFP
         GGl/6KOiUcpwH22kK+PNVt1Kaw2KL/l4Zex+l6eIlK+BiXOLnfVHhcBVbE1Wp9piG0Rf
         fUqdfN+3dzZccAMQlXWJtNFBo4JgeBQo5PIHAw+45Q9O18iUwD3l/soqPYwtCml0mN8d
         8GMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787183136; x=1787787936;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rXoczBGO5I6N9TIC59uDIKSOp13YmyqaSWTBgCd4pCI=;
        b=USK7aLeJl1M1viGcCHL5whhzrBIc89vzIksLeSsPFcbpV6NhhLAvTyK9CoyEbnK3ak
         xkRj2l4+gCb0IjuSRVpPXTnAujDCUuZTsroSPJPPtnlLIGXBOgqFK0cQvT/JZOFC/WoS
         197H49AOhnd5SdOyTEJn6tdGDWa15CS5xBI/qL0vzJ19wOh4R2FIpzrK37Z6ZosLqZS0
         c6gQnAcbLslNmQ3hZRmtl8z4OAweHlHzNGnY8MkgR9pIizE2blsZNPTDHjJPMKQ3aT9x
         RdQS9AJFd4s0WWfrCWOibQocnFlpSBZpZ3DfJyY3D1P5CFoRLKLPNsN9diPGfEZItxLi
         6Usw==
X-Forwarded-Encrypted: i=1; AHgh+RrN6SZkzrW9jN4W8RM8NMf1VyQ3MN8KqY/BiRSz41brb2lw+ih444/VvbntUWBw2GNJ2QZcfidlS38IKi3KsC/zUSz3hoU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzukrvchzB9hYgYTQrYnN6fmjVcq89yz8J9mFfzgfcsFEDOW3br
	od5YnombZWmXMaCAD/KkrPOg6sDyiFpm8IJ2nh46HnIDNUjxtFLwIay59qWi+rfK0bXZlygCzXd
	l8NBUSauzAw==
X-Gm-Gg: AR+sD12GRW/2R8SwVLhkVb3+hkPPgpjNYFkk15TMDm0Uz1xWFYpy1Pz1TdZvYI6svEP
	mBlh7V/bil2TEE6fGtQXZDOLG0Q+9KefrnA7ZxxRaXKxxn/8S4FmjSLTSAgMZw+j1OugYUwDpFK
	HeiTxCbOCNQiXyE1ho72+GSecFRgeMqaZFZtll3nn9vmgN5OOHp5FrJbnBNo8n5bNSy+hOFhLjS
	ImxIZ6vZT0Zu7Xpszot62BtoRYd4eXv35qFaMvWgAOwouzkxrLfTTOUbjqDQjEiJ7kqc2mOTD40
	MWPJJ3zktrmP/1WniHBiMmrE/+coYKt63PloqJO+7Nab5R95djcqw8OsDZoM24WemZlfN5YXPs/
	ma+EzK4OphuOzDJtUrJ96I61qm9uezHed3LXvErk12/RRiDMijvQsquFwAgpFHD/DnCQH7t8AfC
	uTRf8UUYOu9+Mrre61xLJnomDRvmHXu0C08BCw5FAzRUDA6Jp4P4Gezo8=
X-Received: by 2002:a05:6820:6aca:b0:6b0:4a79:5d31 with SMTP id 006d021491bc7-6b13c650a92mr8098038eaf.30.1787183136559;
        Wed, 19 Aug 2026 16:45:36 -0700 (PDT)
Received: from [127.0.1.1] ([2a09:bac6:947f:3af::5e:75])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b13c90d160sm3470216eaf.0.2026.08.19.16.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 16:45:36 -0700 (PDT)
From: Frederick Lawler <fred@cloudflare.com>
Date: Wed, 19 Aug 2026 18:45:22 -0500
Subject: [PATCH v2 1/2] configfs: move CONFIGFS_MAGIC definition to magic.h
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-configfs-v2-1-cb6e65d11589@cloudflare.com>
References: <20260819-configfs-v2-0-cb6e65d11589@cloudflare.com>
In-Reply-To: <20260819-configfs-v2-0-cb6e65d11589@cloudflare.com>
To: Andreas Hindborg <a.hindborg@kernel.org>, 
 Breno Leitao <leitao@debian.org>, Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, 
 linux-security-module@vger.kernel.org, kernel-team@cloudflare.com, 
 Frederick Lawler <fred@cloudflare.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1753; i=fred@cloudflare.com;
 h=from:subject:message-id; bh=4Dr8FUckZZs6x07b+xsKvc6HgeTnce7Z1vxgvZfvoJU=;
 b=owEBbQKS/ZANAwAKAasltHYDktNtAcsmYgBqhkAbRsSTJS9G2sPxjiFu59N81pvJcvRyNEY2j
 jNVCOkKGpuJAjMEAAEKAB0WIQTLNBqMVmu1PHvjOe2rJbR2A5LTbQUCaoZAGwAKCRCrJbR2A5LT
 bX4xD/9BUVDi6eSCaYdVaU0HrQZZklUbYQ3Qcv91ER5zNZ4CBqiQh8ih2Bd7N83O5qB+tLtXn+h
 2RQyapH/2XBDtNxiggB/XATmp7tiGbmGR9qvlEd0lYu+A+iqm6GRh1MgROUnULnSX3hGuDYGtia
 hqyddIctgRgI9T1Xko/lPHQGO20QXM3muiamVOWBGMU0woRSHLTH4yuYEYvhIxfQCYBKyTJ/YmY
 xUQaHkPqxnFkW3e/UDDNPC9vkyg1yaKpTOfpegRYQ0cAzArIaGyM1BYiqNjtOTeN2Q+gRvM+EeK
 9PtCaZ6dlk/iEMSRnMWUR9Rx2NjQk9HnE6IGqSVQMYk4/pmKbFE+CbztStQZkWsJmi9xMwxQ3sN
 yKT0fIcKgw7hyZbA/Qd65uIuPIrvWOLmopNOtGBmOgHn/HBgmt7q43IMegXstFonHqZwCdP1VTN
 6IsPKmbghn6rSB4Jwmu1YwJoBCLasPlbWYzgSKKh+/e+8Cy3um6fpvDQnde+RaN8G+UyKDKsXAq
 LLv5X+AKHnwCN4RARDjW5KAyr/tnsektIDaeKa0Q3GeHsVYckBpOuh+M79B5qC7CH5wFvZeeE/r
 E9dtdt0WBvJB58nZhSTpz7A6tVeO0he2gfYEDSCYpbHbdMqkp9FT9L83V+NhE7Q8YGapa0FgPYS
 Hz3gO886SmRWwCg==
X-Developer-Key: i=fred@cloudflare.com; a=openpgp;
 fpr=CB341A8C566BB53C7BE339EDAB25B4760392D36D

IMA shouldn't measure or appraise configfs, but currently does because
it's missing from the default exclusion policies. Move CONFIGFS_MAGIC to
magic.h to expose the file system's magic to IMA, as well as other userland
applications.

Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Frederick Lawler <fred@cloudflare.com>
---
 fs/configfs/mount.c        | 4 +---
 include/uapi/linux/magic.h | 1 +
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/configfs/mount.c b/fs/configfs/mount.c
index 4929f343118946eaa55a539db4192e9c6621a8dc..d8cac1cbf3bd573a0549f2f044714c9d669205a4 100644
--- a/fs/configfs/mount.c
+++ b/fs/configfs/mount.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/fs.h>
+#include <linux/magic.h>
 #include <linux/module.h>
 #include <linux/mount.h>
 #include <linux/fs_context.h>
@@ -19,9 +20,6 @@
 #include <linux/configfs.h>
 #include "configfs_internal.h"
 
-/* Random magic number */
-#define CONFIGFS_MAGIC 0x62656570
-
 static struct vfsmount *configfs_mount = NULL;
 struct kmem_cache *configfs_dir_cachep;
 static int configfs_mnt_count = 0;
diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
index 4f2da935a76ccae6e1c3310b2fae5379186548b8..d5b9958ddfaae90b270b66fe7853c5a3d49ce739 100644
--- a/include/uapi/linux/magic.h
+++ b/include/uapi/linux/magic.h
@@ -8,6 +8,7 @@
 #define AUTOFS_SUPER_MAGIC	0x0187
 #define CEPH_SUPER_MAGIC	0x00c36400
 #define CODA_SUPER_MAGIC	0x73757245
+#define CONFIGFS_MAGIC		0x62656570	/* some random number */
 #define CRAMFS_MAGIC		0x28cd3d45	/* some random number */
 #define CRAMFS_MAGIC_WEND	0x453dcd28	/* magic number with the wrong endianess */
 #define DEBUGFS_MAGIC          0x64626720

-- 
2.43.0

