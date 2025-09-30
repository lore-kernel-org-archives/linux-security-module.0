Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392A221B196
	for <linux-security-module@vger.kernel.org>; Tue, 30 Sep 2025 02:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759199229; cv=none; b=ANuHCTs7u0TUKXkQBehhGw1P/94qa/Z7Exc+uNIcXN6kldkjjXUbd8e6Rm+kfpt3uKvufgRCSRkTabOaL8eFDZr4RRTZqmHbrhdQggL7Zwf50A8U6cdeyJol6FwtW5/a4q4mSwJyYScbrHhw0b4cR9ZLGvgp4123MtX0+CEBCPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759199229; c=relaxed/simple;
	bh=6RVM/NL0ZDYk67kJzkhFeoTVqrVSQZgDBYioTsdcFlc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=fJ7XNMJzhuZ6ybvcWGUtoRisFwCyqrLtX+zjoFWcM3GonL6UVzQMBDDWWL8VD2LQE2Kk8Z7dScMHzN25GAgcGDxcB9NUuuky3nQHXyccP0Ndx2+uQLyJZ6zRpzwoFEE3U7i7MJHftASC9f+FCdcNoZPtulwunqzWJDoQQzwEOb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VqCU4TAW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VqCU4TAW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759199226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sg4kvyN9cH3Ka6BbQeKrM7RCNfTYVS9zo7EtNkElASs=;
	b=VqCU4TAW2ivvlh9O5JaYgaG1qXZSeULbJSpUPAfqgwqOnh09IFUkEOlDvXNCbFl+v8zKEZ
	EyUgXcrDfx7o2e7CrUAa4kfwI3gVMqKjtH+KX9YGOFqAWXEpJgnSrXsqH5xCsDYRshouPN
	MWLSXbLStou/RXfz4dsikQQcN9pQHms=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-L7LW3hFYN0K2-1WysxOc1A-1; Mon, 29 Sep 2025 22:27:04 -0400
X-MC-Unique: L7LW3hFYN0K2-1WysxOc1A-1
X-Mimecast-MFC-AGG-ID: L7LW3hFYN0K2-1WysxOc1A_1759199223
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-286a252bfc2so21087095ad.1
        for <linux-security-module@vger.kernel.org>; Mon, 29 Sep 2025 19:27:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759199223; x=1759804023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sg4kvyN9cH3Ka6BbQeKrM7RCNfTYVS9zo7EtNkElASs=;
        b=xFmzKmAfJFEjajP4uGdH+E92LkHvmJs3wkIQ9nOIvy3mz6Eb0U60bxHUeJvGwp0z5h
         eeX/7QK0aPkY3V0gWuPofTj6ByRpgIea7ZuZyDSSGub5lzYAM18SaCtNpfaQnrUnb1iB
         Fm8a6jpA93EWZ2fMoAlnx3F3VSJb00nD6n4q4Kdl66t2gAP8A9EADUzus/8lsWMiioiH
         NmgDCCdyCPljGMFwsMFhdlM1F+p5fDxIq9XtcWFeq8yPhxCYqANMI7QnC3a97pzsHk8T
         8WGqNMyaeqpIL4Pq788/PtEUbWFvDXcNcFriz1/lYFyC6GcFbf2dP1CbrTaoZV7gB85x
         VWMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWr65ZS8ke/rMI4TyJfuWkXQ0X+72UDXFE1D+nQekiowq7+EtVPs5vuThSarNCbhpeGMULNZZBgVeDeaAwE7VLnd8GLeZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YynfTN4uJ66MeweXIFcgQhN6v0Zd1LXU6eKrC/dtiDcrrBNGHsD
	j21XmSYcp9Pp2Lz+Lqt8rcN044xh+XR0cS7jtjNP/qa+FwX2UzHDlfFrxAmUBL06mh3Yj2SsE8x
	9M5EQGvlSO2MBf9/uz1Stj+MeqsRNwmcAOGsFmK40PRRi8sloGvyAC2JHszMetjBmxF+vdizYGx
	9DWw==
X-Gm-Gg: ASbGncu1GI9RBdBwXc1Qk8zlCUo6gOotwPriKysAg7zaehLDjg9/wIHJbq4n0XEXJbB
	cc5iM2wm+3CT+NiY8kK7N/6EmrDhqBHxXE9S9w1i7cVNH+WgK9Z+Ym6+mtDqo9YxMZLhP/42KyV
	1GkHdgsAkvDWvWjqMYGhtb2kPGjhfRopunCRO+lr7aUqa+U7WHMbck41A4vEs/Rfx3TjrkFKhpD
	v7dhC9GU/bhf4xiGrFyyZh8qeyI2TYb/wW/wUisnxCxoma29C7AxRGFoqRny69i2u04/BZJ2eSS
	V9UFb5fWs42iRnsiRsB4HKPUJ/apziCvpXky
X-Received: by 2002:a17:903:2448:b0:278:f46b:d49c with SMTP id d9443c01a7336-28d16e88acamr27573265ad.9.1759199222957;
        Mon, 29 Sep 2025 19:27:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGw7cypH/nZLG0Swdh9MGBzOSAdgylrCMgf2ZcGSHw42AyW3kmcjyYfNc4ncFIysi/zvSQhvg==
X-Received: by 2002:a17:903:2448:b0:278:f46b:d49c with SMTP id d9443c01a7336-28d16e88acamr27572975ad.9.1759199222299;
        Mon, 29 Sep 2025 19:27:02 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed69bd869sm145301875ad.120.2025.09.29.19.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 19:27:02 -0700 (PDT)
From: Coiby Xu <coxu@redhat.com>
To: linux-integrity@vger.kernel.org,
	Mimi Zohar <zohar@linux.ibm.com>
Cc: Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [PATCH v2 1/2] evm: fix security.evm for a file with IMA signature
Date: Tue, 30 Sep 2025 10:26:56 +0800
Message-ID: <20250930022658.4033410-1-coxu@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Q5bVUHtItuOjlkwM02KQnL5FRQ_zzvjSB241ZiVgk_k_1759199223
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

When both IMA and EVM fix modes are enabled, accessing a file with IMA
signature but missing EVM HMAC won't cause security.evm to be fixed.

Add a function evm_fix_hmac which will be explicitly called to fix EVM
HMAC for this case.

Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 include/linux/evm.h                   |  8 ++++++++
 security/integrity/evm/evm_main.c     | 28 +++++++++++++++++++++++++++
 security/integrity/ima/ima_appraise.c |  5 +++++
 3 files changed, 41 insertions(+)

diff --git a/include/linux/evm.h b/include/linux/evm.h
index ddece4a6b25d..913f4573b203 100644
--- a/include/linux/evm.h
+++ b/include/linux/evm.h
@@ -18,6 +18,8 @@ extern enum integrity_status evm_verifyxattr(struct dentry *dentry,
 					     const char *xattr_name,
 					     void *xattr_value,
 					     size_t xattr_value_len);
+int evm_fix_hmac(struct dentry *dentry, const char *xattr_name,
+		 const char *xattr_value, size_t xattr_value_len);
 int evm_inode_init_security(struct inode *inode, struct inode *dir,
 			    const struct qstr *qstr, struct xattr *xattrs,
 			    int *xattr_count);
@@ -51,6 +53,12 @@ static inline enum integrity_status evm_verifyxattr(struct dentry *dentry,
 {
 	return INTEGRITY_UNKNOWN;
 }
+
+static inline int evm_fix_hmac(struct dentry *dentry, const char *xattr_name,
+			       const char *xattr_value, size_t xattr_value_len)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 
 static inline int evm_inode_init_security(struct inode *inode, struct inode *dir,
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 0add782e73ba..1b3edc6d26e9 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -787,6 +787,34 @@ bool evm_revalidate_status(const char *xattr_name)
 	return true;
 }
 
+/**
+ * evm_fix_hmac - Calculate the HMAC and add it to security.evm for fix mode
+ * @dentry: pointer to the affected dentry which doesn't yet have security.evm
+ *          xattr
+ * @xattr_name: pointer to the affected extended attribute name
+ * @xattr_value: pointer to the new extended attribute value
+ * @xattr_value_len: pointer to the new extended attribute value length
+ *
+ * Expects to be called with i_mutex locked.
+ *
+ * Return: 0 on success, -EPERM/-ENOMEM/-EOPNOTSUPP on failure
+ */
+int evm_fix_hmac(struct dentry *dentry, const char *xattr_name,
+		 const char *xattr_value, size_t xattr_value_len)
+
+{
+	if (!evm_fixmode || !evm_revalidate_status((xattr_name)))
+		return -EPERM;
+
+	if (!(evm_initialized & EVM_INIT_HMAC))
+		return -EPERM;
+
+	if (is_unsupported_hmac_fs(dentry))
+		return -EOPNOTSUPP;
+
+	return evm_update_evmxattr(dentry, xattr_name, xattr_value, xattr_value_len);
+}
+
 /**
  * evm_inode_post_setxattr - update 'security.evm' to reflect the changes
  * @dentry: pointer to the affected dentry
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index f435eff4667f..f48ef5ec185e 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -601,6 +601,11 @@ int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
 		     xattr_value->type != EVM_IMA_XATTR_DIGSIG)) {
 			if (!ima_fix_xattr(dentry, iint))
 				status = INTEGRITY_PASS;
+		} else if (status == INTEGRITY_NOLABEL) {
+			if (!evm_fix_hmac(dentry, XATTR_NAME_IMA,
+					  (const char *)xattr_value,
+					  xattr_len))
+				status = INTEGRITY_PASS;
 		}
 
 		/*

base-commit: e129e479f2e444eaccd822717d418119d39d3d5c
-- 
2.51.0

