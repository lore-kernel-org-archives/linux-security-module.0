Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A592DAFD7
	for <linux-security-module@vger.kernel.org>; Tue,  9 Sep 2025 04:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757391605; cv=none; b=CCHGoVXv1TKOkW0qtC3AMMAsCQYerMdCm6vjMmO3osZ78SiQ1WrEtRWMBYtMoXDquD1DK+0tKUsmc1FPuxo/AcJGMNo7zkdp0yBtnjCkBIQNYt7VtQ23ZlKUptcD2WsK4qa2IIaDBOgTOW7/S4HORyPL7Rft4ppCvaO5uj9xQpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757391605; c=relaxed/simple;
	bh=kcJMNEpEeX4hcspzTai+arozdN7w9isGuN5jMeekjZA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=SBPU09tdENzaVLTMShpV5FUI6Edh9WhgCaA+McuyKg/QP2kEcYaUpsgOJLGS6vPrD6/umdIp5biVoQhVxxA87jyLqR5dkLCZVC2mUQ7NOXVIc4pfsY10QHfM5DDYreW+/5NpJp/EF6xtn0P7LylMoGJxm9cQcssOQch/DaCsGU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JpCgGhpA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JpCgGhpA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757391601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=54MsxNCmmlAlcM5f+BHWGLYP6L+NuEk1hd/wbu7HmzE=;
	b=JpCgGhpAy9uuCMGuSlsHmQyOgcQNQcAXPIwd/1WkB7leaxwwOwf4HLS/d387NY4FboQNv3
	KQb/hASZwNCIu30yO3fNyQHuA/Xt4KgZd5JNwelrq8zl5gzZcJSUFXvTFENjZB1TZQ+OdQ
	To0OHmwkMyianNB257RM619CKj6kcvA=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-rtIe_Y2vMIev89VQ_EMLsA-1; Tue, 09 Sep 2025 00:19:59 -0400
X-MC-Unique: rtIe_Y2vMIev89VQ_EMLsA-1
X-Mimecast-MFC-AGG-ID: rtIe_Y2vMIev89VQ_EMLsA_1757391598
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b4c72281674so3879726a12.3
        for <linux-security-module@vger.kernel.org>; Mon, 08 Sep 2025 21:19:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757391598; x=1757996398;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=54MsxNCmmlAlcM5f+BHWGLYP6L+NuEk1hd/wbu7HmzE=;
        b=s2TivXW1wtS8TZGB+6gIAHD44NiLz0lza5d9mxxxeB8B+JF4pP7Ftp6lApVi/klPX9
         QcUJ0be2hNQeW8ceXSOKLHjI0/m1WWlm4MgnJy34hofu92JQucFbnRMUbAeG+nUOsmhY
         Z/Nuvqo69mYVHnulnYeHreuGJeESomAFQuHZVaocWwMMeGat2MNBY4ENydkY772vBMw0
         HCNHKGwxRLFNH1R/dSEQO30oBO9HJgLb/DVWOaVJFZyio8mw2xQaK6lG60BZCW+pfihv
         NQ6casvNg9sKuUDHU6OMKJeSUp+RFoJ8BqFsOW5B5r0QRohk4/zZ9WhPPoNgRhWf7JT0
         WLbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBLEhxLuTBUuhk8mf4OpCX6GW3XK2R70ZfIb9mrEISg50xYVeIS5osmo+i10XqGJZav/MbQlCD4UOqWxRhgiarBb0UjsY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEYkOssRejTdlMCeQcYKEINoQ/HRIynK2+AVYlAM0Uh5G4EZlZ
	xWOBatXPCMdoBfkUIs5MuHr39ZtofWk+zZO8pVbqX5suJprg2YyvYJZ181foDASPBO2D7WMKSCd
	KNqj0Fj41LC6XZK+ojdDfjpZ674V4HGrtLkCpsrUyrdxLHpwtpo+OhhKDwGTaDxK0K1EaT5CHM6
	qQlA==
X-Gm-Gg: ASbGncvrHitXk1rTGBaS1EBhhLHmd0oalm4dNlZpE9L9esBQGgjxHQy5GA0xOgfk7hB
	a2U1sR0e+7mc1d+tZjukJvM7ToP5mwYV5rkynPkILsfN2i/nLMVLedMRqvuj+GzDlZ3bPOxsJMI
	8MAFzfUcGpAj0CWlul4jST8MBDv+vNEHL16vSbdL4skYxTmOsbiuPDc+Rg/OEhHZ8yEY0zLtYGc
	e1kQvAaMUI3YV4WwSDQXe2ti3Gz1pKEemOuZsEzIOOEc09V4+LrO7ldWUAd2OE+K9Dr6kG+mwjO
	5nNhKnBtf+9akoFzaxjj13BFrG/26BQ=
X-Received: by 2002:a17:903:b0e:b0:258:fa62:ab17 with SMTP id d9443c01a7336-258fa62ac03mr15850415ad.29.1757391598386;
        Mon, 08 Sep 2025 21:19:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEv36p9UxA54Z3porfTlTxG7LAGzqKIDTmwybjkcWmGH9oQOVl5p8+shON8WpdrhlHXD9O2lQ==
X-Received: by 2002:a17:903:b0e:b0:258:fa62:ab17 with SMTP id d9443c01a7336-258fa62ac03mr15850235ad.29.1757391597940;
        Mon, 08 Sep 2025 21:19:57 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24c9952bccasm157077385ad.105.2025.09.08.21.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 21:19:57 -0700 (PDT)
From: Coiby Xu <coxu@redhat.com>
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ima: setting security.ima to fix security.evm for a file with IMA signature
Date: Tue,  9 Sep 2025 12:19:53 +0800
Message-ID: <20250909041954.1626914-1-coxu@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OEZJiBllmIMg2Bobn2tE9sJZfkSmUXwTDoJtFS5NpBQ_1757391598
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

When both IMA and EVM fix modes are enabled, accessing a file with IMA
signature won't cause security.evm to be fixed. But this doesn't happen
to a file with correct IMA hash already set because accessing it will
cause setting security.ima again which triggers fixing security.evm
thanks to security_inode_post_setxattr->evm_update_evmxattr.

Let's use the same mechanism to fix security.evm for a file with IMA
signature.

Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 security/integrity/ima/ima_appraise.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index f435eff4667f..18c3907c5e44 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -595,12 +595,27 @@ int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
 		integrity_audit_msg(audit_msgno, inode, filename,
 				    op, cause, rc, 0);
 	} else if (status != INTEGRITY_PASS) {
-		/* Fix mode, but don't replace file signatures. */
-		if ((ima_appraise & IMA_APPRAISE_FIX) && !try_modsig &&
-		    (!xattr_value ||
-		     xattr_value->type != EVM_IMA_XATTR_DIGSIG)) {
-			if (!ima_fix_xattr(dentry, iint))
-				status = INTEGRITY_PASS;
+		/*
+		 * Fix mode, but don't replace file signatures.
+		 *
+		 * When EVM fix mode is also enabled, security.evm will be
+		 * fixed automatically when security.ima is set because of
+		 * security_inode_post_setxattr->evm_update_evmxattr.
+		 */
+		if ((ima_appraise & IMA_APPRAISE_FIX) && !try_modsig) {
+			if (!xattr_value ||
+			    xattr_value->type != EVM_IMA_XATTR_DIGSIG) {
+				if (ima_fix_xattr(dentry, iint))
+					status = INTEGRITY_PASS;
+			} else if (xattr_value->type == EVM_IMA_XATTR_DIGSIG &&
+				   evm_revalidate_status(XATTR_NAME_IMA)) {
+				if (!__vfs_setxattr_noperm(&nop_mnt_idmap,
+							   dentry,
+							   XATTR_NAME_IMA,
+							   xattr_value,
+							   xattr_len, 0))
+					status = INTEGRITY_PASS;
+			}
 		}
 
 		/*

base-commit: b320789d6883cc00ac78ce83bccbfe7ed58afcf0
-- 
2.51.0

