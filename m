Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E795A2853F9
	for <linux-security-module@vger.kernel.org>; Thu, 14 Aug 2025 22:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755212099; cv=none; b=nUxD9FKjmqWR2vaemijQqiUcxamomOSWQ/DBOvkEBef4XgNpqPtKR/R5nmn+ZPGKUjtmvuxpgrfoAMSBUW34XWQdvCd5jKeHCvX4IvA1JGsow8RMJWd3KuAjKO0HQeY+mNllPmXnTendRiY8P/+m+f7/DX0uUjywX+uuvjEwGc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755212099; c=relaxed/simple;
	bh=fXylwXXBB6mvLKxQHAl/i0nDwp3GIxUSzI5Ds9tCq5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DqcXg4cnl9g/fTfKZkq+DiMHJKrF8Wmn8c5Wbfnse9R5X9oBZ61+9Etj7j6gFugpPyED59gPzIh40SEzkhulhqdBassUXA+JruVfjFDajD7WzfNf5KkepZZtTYOv68vpM+XiSovWl9tbhWnSYXsZ+aCbtoA2xrmPLuskG0aHJ/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=fnLncjD8; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="fnLncjD8"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b1098d1bbaso22207541cf.1
        for <linux-security-module@vger.kernel.org>; Thu, 14 Aug 2025 15:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755212096; x=1755816896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AChpKruSXH4shBW9tTAspXM8SkY0T38J4dZ44b7wxoM=;
        b=fnLncjD8vgSAVXoS4TJe2Rd+VDe//S2N+fNYCrYsoiU0rHFFUEeZS+4az7Kq6NFKEF
         NN/Cvq3vSGm8v31UJzNkTVTYhAZuGWC8Ot9ctjB2PBuUDc0aGKzwX3qkSXUB5chLityY
         iHjysZmxoVe+M0YGXX+FWPaiPccd/vlgxZHqWpSF7+/ca9Fi3YbKN2lUA/rqhEr3mOK+
         E0CbGaZUNuF2NnGASuqAsdqtXSlHAdlElFAEUO2L2SpE+8P5n1LJKbBA8MgxheNrlN8u
         1BmZMbbw81arZgu3Rmnu1KRw9nMnQNFikjGvvvzPswsIIVSWy4To2VxpUcr0887dcm+f
         0Hbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755212096; x=1755816896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AChpKruSXH4shBW9tTAspXM8SkY0T38J4dZ44b7wxoM=;
        b=fkd5OMz1pDMIlp0NhAUS51w7xcCgIDxAFMqTbYgmNfr6YoPnnrUD5QwiHKhHwT/XL5
         Zt8GcfebRxSf/0xm5VEySedMpW6piLRgKl9Fbf0Wd00Gm7+pmkUcRDYM3aIuy7iOhMbI
         +qM24jQCHF38Z9PEYOj3fMGvnuRlKDzLKVewmOoWXAGzkIYAZMhsd8W1EUcJoVfk7HWN
         KZbnn6OD+o39WELzinLCKpnY6qgpGNWtd8Bo4V6ULcrxCKERsf/k1/CG7+O40YZYpzjl
         SkTaEQGbNfuJHlUAb6oX7+DaiqGzI2BqT/ktmTMkmk9/aJSYa4Dcou1HgnFOKXRcmrjh
         ed9Q==
X-Gm-Message-State: AOJu0YyHd7MIel434CI6+dAKDLceu1p6ZsXdEC86UyXWI9keCt9kIt9m
	Ty/MN4HB2i921ET53UTSkZ9hvODJULZV/zN0HeyF6ndOBEKS7Paa8/5HdtHP5hi0xRr36p/LfLv
	Qwy8=
X-Gm-Gg: ASbGncutcx21JnFp4gNiSUy48S/8gJ0xvga339PTw4DesyARImBHNk3zcgcBDBJkblu
	ArL6NmdBVRSq7YxaXYT6zAaVe4KM0iPa/zwG970z4WWOKnI6mzZz5+4tlfQYe3eiFUyKN98R5oR
	DuNSYH2u8kjW4A5CyotEX6/y3qMcPkD0LGtbCGzQ1Y8SpP4ItfMeFr/1p+TQKHFz4lYyDfjNDSh
	TtSZ1OTSr/fWau20p4sIUb7wIALR/hQhcf5uEAHTydbnRhl15LDmZmx8/s6j66bmmwA4TlVZ3rj
	xxMPy13zo4m/kFO1lQLWh9i5lGvhLDP61QizpHv4D3Cj8hUy1sFQ1i2ZfgzNzPp3zkttJ53pRP/
	rFqRlrPKdIJO0vHczQNpKOQc4lKKt6H02TCO+H5874eyFHDmUBIMGmIoHvVF/VG6YQ0Q=
X-Google-Smtp-Source: AGHT+IHG0+hnq1queyYlWuZxewv9D0CnHIlLuYop0aXb8+J/bvqxPEP+d8C6eJNa1TXIkGn5Nkyb9A==
X-Received: by 2002:ac8:598e:0:b0:4af:68f3:4a17 with SMTP id d75a77b69052e-4b10bf86485mr66398491cf.14.1755212096096;
        Thu, 14 Aug 2025 15:54:56 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7e87b32ef87sm44199885a.7.2025.08.14.15.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 15:54:54 -0700 (PDT)
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
Subject: [PATCH v3 28/34] safesetid: move initcalls to the LSM framework
Date: Thu, 14 Aug 2025 18:50:37 -0400
Message-ID: <20250814225159.275901-64-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814225159.275901-36-paul@paul-moore.com>
References: <20250814225159.275901-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1823; i=paul@paul-moore.com; h=from:subject; bh=fXylwXXBB6mvLKxQHAl/i0nDwp3GIxUSzI5Ds9tCq5k=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBonmjnk4z0QvdJFbI8xzz63crkC3dDkkM1dTnFz NCzwCtbYEqJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaJ5o5wAKCRDqIPLalzeJ cxpJEACArlVukrEIGt63PCXe+PPT1fK0R4Hxejf4S2xYZwnEjQYzuG7Ca63NUaODnxOym7e5/e4 lL3Gml5G7xg88pk1tK4bPFmVrAcpvzUf4RzFUALDbJosYNLB7wxFLrx/gOTvGQn6JXaXU/P3xQT s3E7yNbUyyacv8hfCb1H/IXvH0UhQpczPiYcgyZ1JsgC1zVr79gCse+FYbaueMAAmNCqMFf9Np7 AHL1j+/4f0Dke0LAEZHzS2mJh7Jw8EXlSqDmecEPzXVXog1R0ReJjEsuk7Kvz0QADOBUbX0IDhA ALEJrWsr0pqTTcFWRXVL2dI8QGTXpdGQ3qyxJFaVBDT7yhV+kDr9z99G0iYWi46IQsq4mC+M/SB HKTVbGGtIEVjaS/fjTt1/THl/k3DMaCCWLJVbFIY3cShoLNta7t/SifTcm0ZBE2G4sCEeJMmRpO eGB3V6U8l62/r+jf+TDBhjaUQ8kKHR+gIxvR7lbzjwzcj/brnwBbv4M20nlLF/2p0oZ+PVuDhAi +YQgSjHU8mpis2KUDfHuaEpXJSMoaP6iYaeEuSk3QvF0AQVcGXOkPetGABCjPxMgq+G7HTUScZR r5NXhSf/K1tfmKhvqpej/9JzC+bmPhMwsIbqNcACdOsKG1k/Z9Jf5eQ2X30aNIxGJxCtcjB5RrD jzSqs6QW/dwKuHA==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Reviewed-by: Kees Cook <kees@kernel.org>
Acked-by: Micah Morton <mortonm@chromium.org>
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
2.50.1

