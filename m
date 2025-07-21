Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB17C253F03
	for <linux-security-module@vger.kernel.org>; Mon, 21 Jul 2025 23:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753140269; cv=none; b=pqzAmTl8YxMkjvgcOqwJP/6HmAv89S0OpPLHNIVvUrQqze/mtO9rFKIXm0qYWSYeakHhhBAyLyJM2ICtTH+8sVLmx5woiwAADJXIFbPIVgKcW3c5dRa+j1R4Q/XdizC4BH5mcSm7AAPyxfK4OPRSXV9u+xhZX2Z7hKJixpSMweY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753140269; c=relaxed/simple;
	bh=B134/zRHtlL58bjVcbvW0Phl+TZp3TNRoB775vnMRoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J/1zVz4BcHj/c1CbzOJwnI1DduX5oHnYtiRnZ5HooTJNV2gah0svHHUxGLakSEQqmC+7efwkE9IZVoITzD9XREUxSNQ9qSXXSFGeqQdIwV14QDUdjW3mgRiGAqwetIPF5IoiiNOZbhaZt7/VifHcdGXpDGU4yqso3J5GNEDUtpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=BgK0qDBf; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BgK0qDBf"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-701046cfeefso77125316d6.2
        for <linux-security-module@vger.kernel.org>; Mon, 21 Jul 2025 16:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1753140266; x=1753745066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4VE9Gz5X5rdXslwTaTGKKll5oZCtBH2VN2kjyo7ucTc=;
        b=BgK0qDBf5ZYgOoOmxEficwhEc8Ypw3vWgl31gAh2OMlRSBqu/q/LX36Ps05ritQ0M0
         kH+fY91trJ7zTLZditOMEsrojg4vMlqFFNU+2bY5cLPj7gLKy5rFJQDkQVNgTIa+mSmR
         aK4+Lj3uUJeNS1TbK2Zneqfz5iARieoeAJU7DFPERyelx4D6n4R34QHkQdPR4vlqCvtb
         G9ZzV8XnesDiBY24JGPojqdZGvx5ewE+z+ZMvrMfne41a2nxlVf0a76LsCQcYXw7qcNl
         YBfjCHQGkZSNS27t6bvdXZBgwkExGmCkrS9HRU9SEKb2pTIZsenqouVJjIZN4B3GSTn1
         iEjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753140266; x=1753745066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4VE9Gz5X5rdXslwTaTGKKll5oZCtBH2VN2kjyo7ucTc=;
        b=NjLDqimFijuV0+dbL4QV/t3XMgVWYDSWtYvc6f1siRGPy0SbeEzTWpOEJdlSFpizYP
         nn/hygLINqu2IcFerNBKhPJkPewAxYmt6lLSPIB3o8Z8C6itlmC7pxOeJ7bnOUzK6tmN
         SHoXHln6zxLtMH/TyzuaALBz4EV1qUNlhRFOd6zmKI/zfhEF379sRpO/u/YKx+4x1Q4p
         qgDN5zr4F9jMA2lfsxYu91Uc0sqhQlFtOW8Pmwzx8Z0VcIY+fjWbdGxKZ2aWUy8+9r1l
         gRJpnMC5t705tAchAyA0eKqa0QlL3hZ5JJvI5maedJA8QHLvbgNBzXQjoBIBmCdQtGvQ
         mgnw==
X-Gm-Message-State: AOJu0YydO3Iz6i6IOiwyDV9PxyHHIAxq+aQL+Vv2xOEUqnXXXFLpvOEf
	PXN2fv797JG21Kr5sp0l5q6ZP6vq0ogi4fjOeb7hOWkw24U2JxohSGp+yn1hZL0PSRoopmjRDdB
	DW/E=
X-Gm-Gg: ASbGncvIdI+ElKoYqwEyM0OvfDh6UZa4nzuhGSmhtmVWVz8Y+Wj687I5ERNtjwyW3Cl
	BQfM/60Q84NmJMjr7ebrer+tdkaxTAOD3J8Am71OyKP3l/CN+d7U+kuhj92RUJ+KVlYLUgH1suk
	NSqvT59nWffUCJWXE6J2GTzGuEIvqNdBLMTRl5SCs681/ymVSdWfRO2ZnjtieCZ9OX1HsJcfzh/
	9t9ZXuPOETwuJ7zURaW5N3VO993CADN+AftfuiLBqnegC33HDIAP+t0fkQGnOkny+smA/IX1NsW
	vfmLdLgBucpV3PNfzUbhLB3VKGC/ZhLxtUyFKX4y92XSVZ6e+iV1LX/e+sdXB5Q4ori3RK8uPDr
	sBAuuEEA5xWRBLeMYZug6prv/QxO0ckcPgwTb2JfpJu2qbD+GHd3TfiHKRemUn/hvim4=
X-Google-Smtp-Source: AGHT+IGv0NYDUq8rwcxWrFNBf1D5JMT4Wh6HXrqlXRiD++qIeRcnGjBN5BjjKOWpQkR3xgEt5JgB6Q==
X-Received: by 2002:a05:6214:2421:b0:701:945:68a0 with SMTP id 6a1803df08f44-7051a11473amr254014246d6.26.1753140266593;
        Mon, 21 Jul 2025 16:24:26 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-7051b8df533sm44467846d6.26.2025.07.21.16.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 16:24:26 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Fan Wu <wufan@kernel.org>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Kees Cook <kees@kernel.org>,
	Micah Morton <mortonm@chromium.org>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Xiu Jianfeng <xiujianfeng@huawei.com>
Subject: [RFC PATCH v2 25/34] ipe: move initcalls to the LSM framework
Date: Mon, 21 Jul 2025 19:21:28 -0400
Message-ID: <20250721232142.77224-61-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250721232142.77224-36-paul@paul-moore.com>
References: <20250721232142.77224-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1600; i=paul@paul-moore.com; h=from:subject; bh=B134/zRHtlL58bjVcbvW0Phl+TZp3TNRoB775vnMRoc=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBofsvhxtLgE+LO3UQh1Im04NbOkPNN05CgdGeJT V4UFbxyEJKJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaH7L4QAKCRDqIPLalzeJ c9LhD/9uuxuxZhRTxPKiman0g6ufoe+zV/8DKkaAzTtOFVGELZepaX1z7y4ok2fbpwWH99XBoQA uvF4cSLDJIlURin3VUJ+dYaTnMOLbc9fGQT7TfkflRmwvMjI/4gBqolwhPROFZZGnOSFHR3JZeU dPq5pioPDWV5i7tnkBr55LV9dvc/MNO8vuLDp03Cnf8uYQnozaU8ULkZebs9581PpY5hRmaXNMK WobhWUl3fPqnogh3g9RV3o0rtLXIaWY8gHyp15YdAoy2BeiUFSM0iFP7+G/bM70M9nUvQD8dTKN DeLxGBcGkqNUJbTkApHasOCFq6/FKkg6vB8+YiagF0mqEXWgWPudZcFsgE7FS1X15e0499VpfNU VxnY8xTBqR3gAUHpFCPamZZfKmkY5ZL4LLhavlzycx1jFKhuXrF6yd3dktAZos0W/Zk9oPzR1Nr IO0PDMzDmwlyjC5lfdty6IqMiTlF9wlatWifZREsuow9CQ+krHY4b1GXPoRYqfME6pmJMTk870W nqc/9/z4yPFQz1DbPwv1GCtq46KV26Q2u7DLD0nJIG74n9I/TtnMDJd9HKQ66UxncGbClopfaid kpKE7O7sgaqwadvK3J0Ki7B7ijEKRz4y93UvmfVROT8UITaP+2v7hoBNM+ptV8c7ZaKRt/cDcFr c8zWrcB4pmW6MOQ==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Reviewed-by: Kees Cook <kees@kernel.org>
Tested-by: Fan Wu <wufan@kernel.org>
Acked-by: Fan Wu <wufan@kernel.org>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/ipe/fs.c  | 4 +---
 security/ipe/ipe.c | 1 +
 security/ipe/ipe.h | 2 ++
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/security/ipe/fs.c b/security/ipe/fs.c
index f40e50bfd2e7..395e62700055 100644
--- a/security/ipe/fs.c
+++ b/security/ipe/fs.c
@@ -196,7 +196,7 @@ static const struct file_operations enforce_fops = {
  * Return: %0 on success. If an error occurs, the function will return
  * the -errno.
  */
-static int __init ipe_init_securityfs(void)
+int __init ipe_init_securityfs(void)
 {
 	int rc = 0;
 	struct ipe_policy *ap;
@@ -252,5 +252,3 @@ static int __init ipe_init_securityfs(void)
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
2.50.1

