Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539EA610B
	for <linux-security-module@vger.kernel.org>; Sun, 28 Sep 2025 03:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759028648; cv=none; b=HjkWeorcxQp4ug8SuqXTRLSzZ+K/544tHlFR3OyIOgkDgCL20pevue32vGIG1KMb8BaX7rKcQkDC2GIQAhlEeDtt8g1/dxmFdh62RCAYPbfZVgjlUvD0i9ZkUZLJTNvXYDjHMV1e9ciOFiR8cK5X/M/fBczjpyR3ItDCfQJw+N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759028648; c=relaxed/simple;
	bh=VBcvsRhMgO/muYeWFgejs0y+LouNQ+vYo1QbX/Y+XRk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=eER3jLvdzhXLykAlWv1COLljNfRrYAGRjJ+I8KcEs7maHqmn0sq1Fsjo6N+IbpBTDS5uABmjxqbkFz94bewiQzGImtiQ4Gt78bykeCiy3WMoP9ga9keUTlqOVzZJH6H1znrYBONxF1C1MWk/7KunfTN03o0lOJ4JvKgV1Yg34+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dzn0PXgM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dzn0PXgM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759028645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qEw52ze8SdcNH5GneUi5j01Dzu2Pu+0KVOCFzVwvrUY=;
	b=dzn0PXgMCcKC1q27NzgbT1ySI4Q7zl+cu2qDtnfrYNmPbMdlsTjHOza5/eCfbgTUl462Y/
	IhBKHxya60x8MxJdS9lQ+6vqxdHBszgwhICU/EE3j0n0hO99fWEa2t5WmgsP3XjMeWCxJj
	wV2TOtgphmG3T+MWmv4pIHn7CTw4ClE=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-9joxctUMOf2NPifmk4BAcg-1; Sat, 27 Sep 2025 23:04:03 -0400
X-MC-Unique: 9joxctUMOf2NPifmk4BAcg-1
X-Mimecast-MFC-AGG-ID: 9joxctUMOf2NPifmk4BAcg_1759028643
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7810af03a63so5150624b3a.3
        for <linux-security-module@vger.kernel.org>; Sat, 27 Sep 2025 20:04:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759028643; x=1759633443;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qEw52ze8SdcNH5GneUi5j01Dzu2Pu+0KVOCFzVwvrUY=;
        b=kB+25j3hIz87vMtZbsKgkCRjwLJ8vuuigzls/bl/+UWWei2/LuLSY3UTQJJhvBvCgL
         D76Ac9iPNqQ3tjwEJ3IzcAvBq9MjlxZtgo80Vbr2o5TYBJMmowMUmrScWFE1Eq9i7dpa
         xntLfz2K1lRmAjTpdyiM7K2CckUVyE0p/rMqNSVbeG7YyG29yHKqpQnOuNYYpnDga/fw
         QK89wfUkcFmjCwnwgkQnnD7ARJew3MvmnySkV90tUA4SSiaIL6a+6BBRudgkWljxrtVN
         NAFyGvag+5WHLATQPhiQZnJaZK76hwU1jW/FOHuQYUP/Z0kzXMKPQc1pnu/75X+07jaS
         ad2w==
X-Forwarded-Encrypted: i=1; AJvYcCWFJNWfS+nMp9WvtlpG9QdaWxw8qGdaD30/LctuUMKZCRk1ypATYoqSm/j8bJYL+C9U977J5PXWHxb41I84xN2HKr9oJ4s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf4pGIAfYn4BeIMPfxSXUWsOJi5F715eJiKU8gx5ZPW4PI5p9q
	tWzqilUM2uMj46t94zd6KRlLJ+UsbEJWbI2IPEI8yRN4rytrPeb3+shS9NsQG+3edIhV+LmQwOO
	6kUyLo8iv5aqhdOJirnZeBC+zGDI4cJ8/Z2sMhVWhgj9k/20nP2OWCVmNdURDK8A9Nk8+QiDHJQ
	sGVg==
X-Gm-Gg: ASbGncvuwGriJEbbyBgmVaHh3vwaNewyFMKvkyRbJ+qMywnno6sCDL5axan+hjT4YIn
	lCg8Tzcj65HM3IT1eU5F70hgqpYlJLuQOkmQlOkeh7JXSLewRMpZ1jTud6iyw1SfvBGuVJvJkZl
	X2GR33ds7RB1EeupqLwzzmMd2QNWVqg6du1dckorQwM39Xw09uLbTPqCZFVKKaxOjgCGv0gxV++
	RG3K0k8Ru7I445NYI5nups2DqtVmlSUGUhM1uDzszkdvfw23FUveXL/jEiqP7IYZidJ8nBEi8oD
	xGJnD0FNDac/9jJ4xvPk92Y91evuGOY=
X-Received: by 2002:a05:6a00:8d6:b0:771:e4c6:10cc with SMTP id d2e1a72fcca58-780fcdd2cb1mr13863862b3a.6.1759028642772;
        Sat, 27 Sep 2025 20:04:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrlGFESxb4zyWUKxHw78NUwK96T66HWHGPWOIZ8CPuMROnTHK9D2/BRaau3akM7vrrkSoTGQ==
X-Received: by 2002:a05:6a00:8d6:b0:771:e4c6:10cc with SMTP id d2e1a72fcca58-780fcdd2cb1mr13863837b3a.6.1759028642348;
        Sat, 27 Sep 2025 20:04:02 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102c1203fsm7854159b3a.92.2025.09.27.20.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 20:04:02 -0700 (PDT)
From: Coiby Xu <coxu@redhat.com>
To: linux-integrity@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Karel Srot <ksrot@redhat.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ima: Fall back to default kernel module signature verification
Date: Sun, 28 Sep 2025 11:03:58 +0800
Message-ID: <20250928030358.3873311-1-coxu@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EVcGpssVvU3OO5mmYI1jHCDH-PRauEC3AnBqMExgSwM_1759028643
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Currently, for any IMA policy that requires appraisal for kernel modules
e.g. ima_policy=secure_boot, PowerPC architecture specific policy,
booting will fail because IMA will reject a kernel module which will
be decompressed in the kernel space and then have its signature
verified.

This happens because when in-kernel module decompression
(CONFIG_MODULE_DECOMPRESS) is enabled, kmod will use finit_module
syscall instead of init_module to load a module. And IMA mandates IMA
xattr verification for finit_module unless appraise_type=imasig|modsig
is specified in the rule.  However currently initramfs doesn't support
xattr. And IMA rule "func=MODULE_CHECK appraise_type=imasig|modsig"
doesn't work either because IMA will treat to-be-decompressed kernel
module as not having module signature as it can't decompress kernel
module to check if signature exists.

So fall back to default kernel module signature verification when we have
no way to verify IMA xattr.

Reported-by: Karel Srot <ksrot@redhat.com>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
Another approach will be to make IMA decompress the kernel module to
check the signature. This requires refactoring kernel module code to
make the in-kernel module decompressing feature modular and seemingly
more efforts are needed. A second disadvantage is it feels
counter-intuitive to verify the same kernel module signature twice. And
we still need to make ima_policy=secure_boot allow verifying appended
module signature.

Anyways, I'm open to suggestions and can try the latter approach if
there are some benefits I'm not aware of or a better approach.

 security/integrity/ima/ima_appraise.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index f435eff4667f..fcc75dd1486f 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -502,9 +502,10 @@ int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
 	enum integrity_status status = INTEGRITY_UNKNOWN;
 	int rc = xattr_len;
 	bool try_modsig = iint->flags & IMA_MODSIG_ALLOWED && modsig;
+	bool enforce_module_sig = iint->flags & IMA_DIGSIG_REQUIRED && func == MODULE_CHECK;
 
-	/* If not appraising a modsig, we need an xattr. */
-	if (!(inode->i_opflags & IOP_XATTR) && !try_modsig)
+	/* If not appraising a modsig or using default module verification, we need an xattr. */
+	if (!(inode->i_opflags & IOP_XATTR) && !try_modsig && !enforce_module_sig)
 		return INTEGRITY_UNKNOWN;
 
 	/*
@@ -517,8 +518,8 @@ int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
 	if (is_bprm_creds_for_exec(func, file))
 		audit_msgno = AUDIT_INTEGRITY_USERSPACE;
 
-	/* If reading the xattr failed and there's no modsig, error out. */
-	if (rc <= 0 && !try_modsig) {
+	/* If reading the xattr failed and there's no modsig or module verification, error out. */
+	if (rc <= 0 && !try_modsig && !enforce_module_sig) {
 		if (rc && rc != -ENODATA)
 			goto out;
 
@@ -549,8 +550,8 @@ int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
 	case INTEGRITY_UNKNOWN:
 		break;
 	case INTEGRITY_NOXATTRS:	/* No EVM protected xattrs. */
-		/* It's fine not to have xattrs when using a modsig. */
-		if (try_modsig)
+		/* Fine to not have xattrs when using a modsig or default module verification. */
+		if (try_modsig || enforce_module_sig)
 			break;
 		fallthrough;
 	case INTEGRITY_NOLABEL:		/* No security.evm xattr. */
@@ -580,6 +581,18 @@ int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
 	     rc == -ENOKEY))
 		rc = modsig_verify(func, modsig, &status, &cause);
 
+	/* Fall back to default kernel module signature verification */
+	if (rc && enforce_module_sig) {
+		rc = 0;
+		set_module_sig_enforced();
+		/* CONFIG_MODULE_SIG may be disabled */
+		if (is_module_sig_enforced()) {
+			rc = 0;
+			status = INTEGRITY_PASS;
+			pr_debug("Fall back to default kernel module verification for %s\n", filename);
+		}
+	}
+
 out:
 	/*
 	 * File signatures on some filesystems can not be properly verified.

base-commit: cec1e6e5d1ab33403b809f79cd20d6aff124ccfe
-- 
2.51.0

