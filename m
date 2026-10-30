Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793394617;
	b=sT0Cb7WHY6ocKiTvn+acUaMkOxWITQK3x5R635pd36/N9jG8q43SGsSQWAgce1ZTs8k7
	 WeXs8efGku5jcIItxalEBeI1VLtd454gk7oa7Rxns2HOOV9GQHVzmkAtOz2eKMzbUY9Bg
	 YcrBytXW1wbk8fgsFMGkdhbyL6sXvXNuvJCxdB/p+Vi3Rn7PnjJQdUZVJ25SJ/Lr2J/za
	 lrd8nXFmYFxt0SKX9dUmZdNZAU81K1vT2FatcrkHjPWLwRwIdmFK8IH/HqM6+wKOIC07v
	 RP4r+fNpL1DFh6H4exf3kkbGHo5Zlgdg1zAp5k+yrASXAmFCWewpsv0mVDHA7mHCjRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793394617;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=GEs52XSVkXr3Lysumh8vBcPCuRt3C+96FDYzKDRWk9o=;
	b=iaEoHYduc9dGyq9ql/06EOsaEAN2cHAjiE6zoIpku4z1FOBYqxttft5iVHjMppqstOyl
	 gCVcUpkG2N4ZOqDYRIgNu2cLLmLTBVbsKKQQa5uj/gsfr7uOodXAstwWD7t28rEPdkV0X
	 1ezzqzrzg4+YD1wA3B4k8d/M01pMQ7OiwvilTg5vfw9a3JjyG6Di2ihk4UuxCGh0tXoqP
	 l5kEdZBxGgh8bWCNZJofYm/VnA/Yw92Ts5v/txyHU1+QCjwS6DmYy3jKcvP3l/sKiyX+s
	 4q4GJXF5jXQLQ4u0X4BTvXCdi1WorAoxQnDJeGxs8Ww6mUPkA/Gis8Xuysa6vcz1jqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arista.com;
	spf=pass smtp.mailfrom=arista.com;
	dkim=pass header.d=arista.com header.i=@arista.com header.a=rsa-sha256 header.s=google header.b=T8Rv2qIG;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27981606A330
	for <linux-security-module@vger.kernel.org>; Fri, 30 Oct 2026 21:10:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27981606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arista.com header.i=@arista.com header.a=rsa-sha256 header.s=google header.b=T8Rv2qIG
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-14fc585291cso1060411c88.1
        for <linux-security-module@vger.kernel.org>; Fri, 30 Oct 2026 14:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1793394614; x=1793999414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GEs52XSVkXr3Lysumh8vBcPCuRt3C+96FDYzKDRWk9o=;
        b=T8Rv2qIGkZSI3KgoQ+cTGx4+bgXGd8WYNQ5lR46WQZvuOnZX3V48ggLUEp6l0WMJcv
         6Ca2MKTHWA52a1MHs8UI6ldMUudkELX0cmFn6FkgsHJnKrDLna/soV7go2c8P3w2amlP
         XIhPAlza8W7dTt/OCpYzvmD/gnS9By5nqF3GojGBOjwq3ERq+VYpPFeBPf6Q+hXW1NI5
         VqjFQK3PmN5I5sj++Qu4mXAF6Sxdl/Wiho2uHHd3v45rLSzMFkXQCoWMrU2Bjtmj4pdR
         b6xgxQA2Svnn5Pzcqh6vTiHg7erDcCWyAUIU1cHhMFgRpxw0KI3cvtR82scnZgm9oZNY
         FgPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793394614; x=1793999414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GEs52XSVkXr3Lysumh8vBcPCuRt3C+96FDYzKDRWk9o=;
        b=QqiDUbGrc/aV24Mqi2QTHJRlN3TaH7fHW/bmMObQEj9RewoMmre44hYOg5lwtjDNPC
         Rv6Ty3zQeFsbTpGEgP/QRYZKBGok03LJW+S71quSvhy5xtzg7UYeFJ7QKKgbIGAF5NKb
         HXkE14RNcU6y+vQId1WiOUkHkoCx/loPMTY3WwgVeGkxfE7mA4u3YCUv96g6x4rTqjc6
         L1MpRd1ZMEHWafLehkN3caogcQs9BGF+IPl+P6jcA3Chr5RCFpF6cADyf7Bgf/kDtfK2
         z2bGBaA4NxSnx3r20oSBw18Qh+EqPLu7giUJSYNq1XqNjRJkvWGyITFOhmT2LYjCeObB
         hs4w==
X-Forwarded-Encrypted: i=1; AKwUvBw4tq8UphOqNQXZ9CWPiH6mnhUtqQYXlvl5kAMPXQroh8ocvWPD0wJW2PcfiHavNakH3LlV+Dha5Lzs458WN0T20CQ07Fs=@vger.kernel.org
X-Gm-Message-State: AFq9FYI/3AuVZGU703c0wvBZXo7WsYxz5FAsbV1Cy2AWWudU5Ups61jp
	d5xqVnz/imNm7rqrchUa3gcEdS9OIBZAw7rlGYPxuuR/9hacdbUBiBjlbi1GbkQWqw==
X-Gm-Gg: AYBFou1e1ItvBxyM13EaixNassn/SdRW/nUciroIt6XePOzVuyUTdBvcU7OGCOqg0iA
	v6IMRKXOFTSnH/6IKFYB6A5SEnkTwOwaClHug94/PD8fe9A3IpCeanCFJ8QpEay/O3mVI2nQQLT
	nzg+cTLThxMdiSDcI4bJwZOBP92H2RyDtOuJrT/3n/AvfqL7TP1MhwE+RVmQPI+UT/dfNdrXgrc
	ECoATnrAAg9ADyYGOIQPFKCRPgJnPK3eyLK1DhXqiPAWUh6v4UhzSSxgHcBvR+2cOdEyI2IHQe5
	FJhRPwf2EZ7K98mYeKvZKmmSLpmMCDEmsql1rT9PjD/DpScplQLoFBIU3QZVupRGLM/DB79tmgl
	2KxaAhHd+RytxS30Mdnc8JydpkRHM4vF0gnUDzsrwTx376VHoVvBcHFs2/jxdpP1yR771CL8EXx
	4OT/fXCbhzh9vkcluysT58eYSwhgXjVc3/s+qHA8nRejk0PlzVQ88q1AxpZlaNitqtZOdBg6lby
	YnjLT9Uaj+kSXAYKBKTCE2d5hYHZgNitls8svm6bI5x3Cfvb6wdao0Umcz6o0VZ2Nkn+4rLyV0D
	yioX+nMgJsELswSCBr1aT7ZnoAQ/osZAGWhENUd23WIDzM+Tc0I7PuO4XXU7XhYgbZ8fH8s+Pm4
	y7stxMmnYRG4fnP+NKeVitl4=
X-Received: by 2002:a05:7022:3f0d:b0:196:7742:3928 with SMTP id a92af1059eb24-1ac4fb0c862mr4604513c88.0.1793394613926;
        Fri, 30 Oct 2026 14:10:13 -0700 (PDT)
Received: from dannyhu-upstreamLinux.sjc.aristanetworks.com ([74.123.28.18])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1abcf67csm9471777c88.21.2026.10.30.14.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 14:10:13 -0700 (PDT)
From: Danny Hu <dannyhu@arista.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Jan Kara <jack@suse.cz>,
	Victor Kamensky <kamensky@cisco.com>,
	Taras Kondratiuk <takondra@cisco.com>,
	Tianxing Zhang <zhangtianxing3@huawei.com>,
	Zheng Zengkai <zhengzengkai@huawei.com>,
	zhoushuiqing <zhoushuiqing2@huawei.com>,
	zhangguangzhi <zhangguangzhi3@huawei.com>,
	Danny Hu <dannyhu@arista.com>,
	Jason Yan <yanaijie@huawei.com>,
	silviu.vlasceanu@huawei.com,
	hpa@zytor.com,
	arnd@arndb.de,
	rob@landley.net,
	james.w.mcmechan@gmail.com,
	niveditas98@gmail.com,
	pierre@arista.com,
	julien@arista.com,
	kbharathi@arista.com,
	erosca@de.adit-jv.com,
	alexandr.lobakin@intel.com,
	jim_baxter@mentor.com,
	linux-fsdevel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	initramfs@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bug-cpio@gnu.org
Subject: [PATCH v5 1/4] ima: skip algorithm availability check until initramfs unpacking is finished
Date: Fri, 30 Oct 2026 14:09:40 -0700
Message-ID: <20261030210944.2143778-2-dannyhu@arista.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261030210944.2143778-1-dannyhu@arista.com>
References: <20261030210944.2143778-1-dannyhu@arista.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With CONFIG_IMA_APPRAISE=y, restoring xattrs during initramfs unpacking
can deadlock the kernel if the xattr being restored is signed with a hash
that the kernel does not already have available. This occurs when the
ima_inode_setxattr() hook calls crypto_has_alg(). crypto_has_alg() may
synchronously request a module leading to a circular dependency where the
userspace helper waits for initramfs unpacking to complete while initramfs
unpacking waits for the userspace helper.

Guard this crypto availability check in validate_hash_algo() until
initramfs unpacking is complete. This prevents the kernel from requesting
a module during unpacking and allows security.ima xattrs to be restored
even if the hash algorithm is unavailable in the running kernel.
Essentially, this flag distinguishes restoration of existing metadata
during initial population from setting/changing an xattr during runtime.

A benefit of this approach is that once unpacking is complete, all
subsequent xattr updates go through the same codepath as before which
preserves the existing behavior during normal userspace operation.

Signed-off-by: Danny Hu <dannyhu@arista.com>
---
 security/integrity/ima/ima_appraise.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 63b0cb957c65..1403f5653973 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -20,6 +20,14 @@
 
 #include "ima.h"
 
+static bool ima_initramfs_populated __ro_after_init =
+	!IS_ENABLED(CONFIG_BLK_DEV_INITRD);
+
+static void ima_notify_initramfs_populated(void)
+{
+	ima_initramfs_populated = true;
+}
+
 #ifdef CONFIG_IMA_APPRAISE_BOOTPARAM
 static char *ima_appraise_cmdline_default __initdata;
 core_param(ima_appraise, ima_appraise_cmdline_default, charp, 0);
@@ -738,6 +746,22 @@ static int validate_hash_algo(struct dentry *dentry,
 		if (likely(xattr_hash_algo == ima_hash_algo))
 			return 0;
 
+		/*
+		 * IMA validates the crypto algorithm whenever the security.ima
+		 * xattr is set. Restoring xattrs during initramfs unpacking
+		 * can call crypto_has_alg() before unpacking has completed.
+		 *
+		 * If the algo is unavailable, crypto_has_alg() may
+		 * synchronously request a module. The userspace helper waits
+		 * for initramfs unpacking to finish and creates a circular
+		 * dependency.
+		 *
+		 * Skip the algorithm availability check until initramfs is
+		 * populated to avoid this deadlock.
+		 */
+		if (!ima_initramfs_populated)
+			return 0;
+
 		/* allow any xattr using an algorithm built in the kernel */
 		if (crypto_has_alg(hash_algo_name[xattr_hash_algo], 0, 0))
 			return 0;
@@ -829,6 +853,7 @@ static struct security_hook_list ima_appraise_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(inode_set_acl, ima_inode_set_acl),
 	LSM_HOOK_INIT(inode_removexattr, ima_inode_removexattr),
 	LSM_HOOK_INIT(inode_remove_acl, ima_inode_remove_acl),
+	LSM_HOOK_INIT(initramfs_populated, ima_notify_initramfs_populated),
 };
 
 void __init init_ima_appraise_lsm(const struct lsm_id *lsmid)
-- 
2.51.0

