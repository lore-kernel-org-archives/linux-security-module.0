Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6D4298CB7
	for <linux-security-module@vger.kernel.org>; Tue, 16 Sep 2025 22:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758060873; cv=none; b=S7dFoSzfU2FBpnDvL3DuoU+ts6ROiZ+4A35q2RGvra9CyTEEEDv+BDYOyyxWE997qhJSgJqnMic4X4DL0hpc3nDajXcBT4EzFUPYcFqy6I6E8FhDW19Xc6Q9FFgaglSREQQDlNMtv9Prh2Np1IYYy7c+c//j00vhAs7VM6dJIX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758060873; c=relaxed/simple;
	bh=a/V49kLSKtGG6Su9YcwPVXSqjWuSXtkOHwF3bku/bnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T9a8j0/Lx6/AxCtRlfOIhc8g40niWmgixtxwiMpAsxC6+tmscoDFHuxRaMr7X52IzkhnHVQqu/3coquqFv9Q8X5yRFq78F0BdYq27e/Rp2qNYLvr13P6R9hopVwtO5piZINyAAvpVfGA3LXEP+x1fdSkCl/04ZM247/QEXnkC6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=TYz5JR5G; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="TYz5JR5G"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8173e8effa1so385734785a.0
        for <linux-security-module@vger.kernel.org>; Tue, 16 Sep 2025 15:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758060869; x=1758665669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jqEdXP+h5cgn5aUTyFbpUadd1OBxruvOR6+xm+U/M5g=;
        b=TYz5JR5GanUEzxqlgvM/TOHgK1mFgSEzDqE8tdFJVJik7aESyKgGrhLzY5gJqX2amD
         JcV5kEo3aWE1O6jPr0mxX+6fAZjdOke1E67pyoQokgNA4lUESp8+Uo2w0uTngW6U4OBt
         pkszyLjJgwGaFK+1NBJOO58lvU7Wa2p1GWJfd+7TQ/ZWzMCfoA3PCLjzmUSgngquMe6R
         Ol1/yqmX5UebOXGJ3O+lhV0HaT7so9xAVqTTfJyAK7NESuY1OJc7BZi2anNa2EwPxbjR
         dHYHHsaEpFKy3KA0nvcHXEeas/fxpLsHjbosn6gAw0lkk5mwgxUPgEEh3lICcV1yMYiV
         /5Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758060869; x=1758665669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jqEdXP+h5cgn5aUTyFbpUadd1OBxruvOR6+xm+U/M5g=;
        b=OHMTYBCIqjYW41YlD4/xe1LPAihixpK4holsgIiGC+N6CiZzZCBsRJH7El5a5v4opM
         Uj6RwM+tDOVMsMNPVNdPj0aV4S1R75YjODept46HNPEElr0Lgjunixu2MdsV89sIenwI
         +YJ2Xvb/Ttht7wiCuxhcrT7fTlMkSFGHNXevYZWeBuWKV0GM7Q0DVk7syeuq9Flt2UMA
         x5EWGxGt9zGSSXsVdY7jaYSydMjEAK7J/8Bt9cbdJxTm3YG/UJjBR92PBzaRWuzsVJni
         YJC9j+XOiDqf2rSBxCzjY8nfPuVKN1HCKGER8xMTAOdHcbWYrVAfp8IOlenhFK9efPFN
         6xVQ==
X-Gm-Message-State: AOJu0Ywz5MBrjUH3zwWq964nyr9mftCnrUaDU5ZmhfAby2J9BJhfaisw
	szWlbbBYAOsXhM0DJGeVEYPC7s7foZINumjG96XqbkHU9dCZ+vBzxKa9t/6LxU4s/zeeW5kXdau
	jZaY=
X-Gm-Gg: ASbGncuNd+xcqenFI+xGFmx7hprSEKL1TxmL+TJ2oFpK7ApOGivCTOVshmHbIGEQhL3
	dcZ/9Vt0eTAh4IwGvs7bBnxJlAYCbKX1gsc/ynOQC8JFvjad+zQ6x08V1lme717WR6HWeWTkCX8
	6PDkryPQH3uIUGkdZT2juLcRHq0IyR8Rv6LEJALDF+sleeeiJW9Sa8T2G1/JqojITzjdC1TSGMg
	OQgnYMJQcUTs1RaPj0xEjOn6X92X8Mxsh+ehK3CQYP0hYd3UzWh85mleOVhI5DcgqPyqKy1IKmU
	xxBMDUiq8Tf++Qt0lCF+HFVS+IoqYpjUWJxijxDzAyv+nVXLPyOCDJiOkthWhQlu8wdgZyWmFHN
	I6afUGAbEI6wt8FyDizZg84nbYgp7tTJCWz0MTbu+9gGW8EHCelUbtUSzUSAU8v5BlfJd
X-Google-Smtp-Source: AGHT+IGwnaIXEtPCsUr4ecfBhenFTu9eSJIfPQ+Z8jGoBCKJsOoPDK/OIr/b0J1j6sIaaclyymaJrA==
X-Received: by 2002:a05:622a:3cf:b0:4b3:4fdb:f2a4 with SMTP id d75a77b69052e-4ba6b93ee64mr896491cf.73.1758060869586;
        Tue, 16 Sep 2025 15:14:29 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4b7a9e98f12sm32966181cf.9.2025.09.16.15.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 15:14:28 -0700 (PDT)
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
Subject: [PATCH v4 28/34] safesetid: move initcalls to the LSM framework
Date: Tue, 16 Sep 2025 18:03:55 -0400
Message-ID: <20250916220355.252592-64-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916220355.252592-36-paul@paul-moore.com>
References: <20250916220355.252592-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1882; i=paul@paul-moore.com; h=from:subject; bh=a/V49kLSKtGG6Su9YcwPVXSqjWuSXtkOHwF3bku/bnc=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBoyd8kzWm3iBISsjtxkGxWRBbxUTgWmeQShsQw9 jGMHW8P5DyJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaMnfJAAKCRDqIPLalzeJ cxHTD/91e8kfGyFQqfXAFm42CnRYKTkZWeIEAy6BBDXum8ilT+cssdzqR5Ap0+hTCdsp8nuY+KN k4VqyLs0QP3M0InBMyuSQnCEjFbZYkUhTqY14FH3AHdy7xqa1lBauD+wtryD2QLWkQmndCb+tXb 7hmu9/ihhzvIobQslLK9jJIPX+6V2FuiFNjGSX9ynpHkSTnN8A5DzT0bmPtx+8xsp+cMVSahYao 954/5DWCZMFmoUBl0R6hDw9kYsOTOT6ZhG9PCuWz/ozB74O91Rt3VedwkJcjCJfTVOOp//1RsOr SIABMSof70mpziLin+NM9VcB0KvzFjov8c6Yd3YZL3fCL1dR5J/NWE1aGAdopLnGpAp6IGInjnT Hh804Gl/JRkzw8BWfm/sdKtBK9ZfdKEZ8hDmIQLKKgNN2Yt7JOL+sfF/dBm1qAGsmk6em7omZE7 YC5SVSG3pCu6aJBafilt9K0506WVsawurUb4EXrs9L/ZprxstI+up41dByI2XN8i8WCpoSgsRUG 4ywLvSQOJ+VbcVDQqn7Qc8DER04r9hVIeOBwztGDESDPlFec9wa2UUTTcTI3YEGm0G82y+jGvqo 0bM+kWHYovpEOlT8d4qvJH56kGnA0h32s+XEZM7R35749TUmBa17rsmQizkfelutgJW/ZmMorF6 33Cf+n30MrB5rUA==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Reviewed-by: Kees Cook <kees@kernel.org>
Acked-by: Micah Morton <mortonm@chromium.org>
Reviewed-by: John Johansen <john.johhansen@canonical.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/safesetid/lsm.c        | 1 +
 security/safesetid/lsm.h        | 2 ++
 security/safesetid/securityfs.c | 3 +--
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
index 9a7c68d4e642..d5fb949050dd 100644
--- a/security/safesetid/lsm.c
+++ b/security/safesetid/lsm.c
@@ -289,4 +289,5 @@ static int __init safesetid_security_init(void)
 DEFINE_LSM(safesetid_security_init) = {
 	.id = &safesetid_lsmid,
 	.init = safesetid_security_init,
+	.initcall_fs = safesetid_init_securityfs,
 };
diff --git a/security/safesetid/lsm.h b/security/safesetid/lsm.h
index d346f4849cea..bf5172e2c3f7 100644
--- a/security/safesetid/lsm.h
+++ b/security/safesetid/lsm.h
@@ -70,4 +70,6 @@ enum sid_policy_type _setid_policy_lookup(struct setid_ruleset *policy,
 extern struct setid_ruleset __rcu *safesetid_setuid_rules;
 extern struct setid_ruleset __rcu *safesetid_setgid_rules;
 
+int safesetid_init_securityfs(void);
+
 #endif /* _SAFESETID_H */
diff --git a/security/safesetid/securityfs.c b/security/safesetid/securityfs.c
index 8e1ffd70b18a..ece259f75b0d 100644
--- a/security/safesetid/securityfs.c
+++ b/security/safesetid/securityfs.c
@@ -308,7 +308,7 @@ static const struct file_operations safesetid_gid_file_fops = {
 	.write = safesetid_gid_file_write,
 };
 
-static int __init safesetid_init_securityfs(void)
+int __init safesetid_init_securityfs(void)
 {
 	int ret;
 	struct dentry *policy_dir;
@@ -345,4 +345,3 @@ static int __init safesetid_init_securityfs(void)
 	securityfs_remove(policy_dir);
 	return ret;
 }
-fs_initcall(safesetid_init_securityfs);
-- 
2.51.0

