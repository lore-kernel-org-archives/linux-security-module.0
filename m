Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A343AC15
	for <linux-security-module@vger.kernel.org>; Mon,  1 Dec 2025 03:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764559230; cv=none; b=L+7CUy2AkGJN2I1xp5b/QODYs6mZUiGvNkjE81PhkqFEscTPD0MKQQPtdxT0a8bcHzBPHIs93cyizaF+9HtJBaJJwIH3k0yBc3xl3KqenBVRQ0GzoOYqX7Kj1ekRHOEPHXhFvdjsD50h9UjXkfPPWoWKGv0uUo8Djyxm+ate9aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764559230; c=relaxed/simple;
	bh=Vb9WroDq0864t5M9Kfx9rMxovILlwh8aLsQ3w4hqx98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ZW3uGTUMHtLxwtY0viEGyKtfETvKQtsPJrcQ23XQUuJokZHci7IEWWBETfDBe2nEqU/VM8jFSAETtIFQLg0ClOlpSgypjy52JTGLW/McMQyZftzJNNhgQZ5fTqSNAAy/EE11nvbHRhKAOFIo20DUA85WjVIoAGXS8QQxIRUxtsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dlq2UzK9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dlq2UzK9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764559228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tXqJZcWcz9ZC2ozfLNEA1toKq3+LmZ/LDwDkCPxnFBE=;
	b=Dlq2UzK9P8qnXwgslnxNefBKGI62TqzVNrOZ4Wqwv7afPFlPYXMY300+WTsq2nzn0j+jm+
	J84jc3BYjHIs+bMvIqlgcoEpc2qJaGq7UEZndfhR3uxJ7By4hdiuM2cjRlbC6Mc7iB9FsG
	vuBfihuPpLouJTVgf0VXev07U4+9E60=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-2_AwwqS3Nc2mFVJVJLaVMA-1; Sun, 30 Nov 2025 22:20:24 -0500
X-MC-Unique: 2_AwwqS3Nc2mFVJVJLaVMA-1
X-Mimecast-MFC-AGG-ID: 2_AwwqS3Nc2mFVJVJLaVMA_1764559224
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7aa148105a2so3177497b3a.1
        for <linux-security-module@vger.kernel.org>; Sun, 30 Nov 2025 19:20:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764559223; x=1765164023;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tXqJZcWcz9ZC2ozfLNEA1toKq3+LmZ/LDwDkCPxnFBE=;
        b=IP1dulyCPvTwZbj+46k832atRp39/qJ1Mizj7SoV+Lf/D3uTnTGkB6XHnfZGHCzaIn
         ECE1MmrTmCZpGFj74n9M2Ue4mPv/PV+KWfBrK7DbtOF1vKWX7z0AM2MycZoKzAEv/epf
         QOkrt7RQCQ9sA5cLu7XKf1zdJqmO+AIQILoPO3Mp7C3P1oeOfljll6PpbLwYfln+/mtq
         vPzc5Gc75pFG15GQn7HI/HCIlAHcToPbdKR0K1jjGTPbmeZo780JLoh3pM5ZOdR70YLj
         ZrLAHz0q/Mq0tVYB2TCWeUewGN7FnFmO3Ld+qQJuloqsps5T0xELFYnoEnP3GIaL4cwH
         rv7g==
X-Forwarded-Encrypted: i=1; AJvYcCV8gzroPrtnQLcw45u8mzQ1nBI7MOt6zFqA8Ui4wFZ0IuSukjwGxAsR5nJiuaE/wlnhWFCMdWl4mnsudnBNLImx+K3GruI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa3s1PBHJWk/0/YOy7PsnFTweNgGNMIiBNIY63WjM+P3/1DYx6
	1t2xgzLqS0J6n7FJ1yu8Y0kcrg6YReiBR2NP4xa34ZdAzYy2N67mssW8NtIzKEY7IoKnVSvgawE
	xwh/of51kU/R28QQeUwmW/6VDwZFJA2n8/zgUjG7vWAkPyYZihWSPvz6oJCOJM9q5zxaQLPJw6Q
	Z3fQ==
X-Gm-Gg: ASbGncu1PIpHtH2a5mJhfKStmDO4C5lGcSEZ2R4XPqOdAcemFy6YGpsmU+Mk7TvhvGM
	UuDp0VKuG0PYlL9NZhd4uoVOuPJ/sFv5l3x2m6CKdUgSxrlkkJXTT4K+HAaV5Gp2MBmUImGD2sM
	sWXV4HtpmLJLHC0/YrNXj1YFaLDaA6AElNsafv3QjKtk6tsBEZE6/yuU4ePrT0W3PvAOvT/lVDO
	uRq1G90dTzMcJE8TU4jAasjUPvzt1FtrZ82AgMbprXlld8dG1SggR85XPjqk1NB5j8tdNea51Yy
	Qy+2oujrELvM9WKBenk92Veri2/n774/51x6TMKrtZZAaBqpj5ZmCukzV+ZMPr9js8GtXfsEFmj
	+
X-Received: by 2002:a05:6a20:9151:b0:35f:6e12:186f with SMTP id adf61e73a8af0-3637db4bbb2mr25840190637.23.1764559223412;
        Sun, 30 Nov 2025 19:20:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE9CuPuZntzrNRAc04pPvyHRQQFm4CPQPSh2uI+CpI/gCSssPYukObheQILQqmBeE4dtx5swQ==
X-Received: by 2002:a05:6a20:9151:b0:35f:6e12:186f with SMTP id adf61e73a8af0-3637db4bbb2mr25840133637.23.1764559222769;
        Sun, 30 Nov 2025 19:20:22 -0800 (PST)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d15fc08bd1sm11621013b3a.63.2025.11.30.19.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Nov 2025 19:20:22 -0800 (PST)
Date: Mon, 1 Dec 2025 11:15:32 +0800
From: Coiby Xu <coxu@redhat.com>
To: linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>
Cc: Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, open list <linux-kernel@vger.kernel.org>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] evm: fix security.evm for a file with IMA
 signature
Message-ID: <7jzx432acnp7mrma7om5ccvrc3ucvm5psscst62bcl5t5yklh7@yxhcvmrgbgli>
References: <20250930022658.4033410-1-coxu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250930022658.4033410-1-coxu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dGCXVN8TKSBC9vrokUKs-p4e6psjRzBWLz5H6fIQKRM_1764559224
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline


On Tue, Sep 30, 2025 at 10:26:56AM +0800, Coiby Xu wrote:
>When both IMA and EVM fix modes are enabled, accessing a file with IMA
>signature but missing EVM HMAC won't cause security.evm to be fixed.
>
>Add a function evm_fix_hmac which will be explicitly called to fix EVM
>HMAC for this case.
>
>Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
>Signed-off-by: Coiby Xu <coxu@redhat.com>
>---
> include/linux/evm.h                   |  8 ++++++++
> security/integrity/evm/evm_main.c     | 28 +++++++++++++++++++++++++++
> security/integrity/ima/ima_appraise.c |  5 +++++
> 3 files changed, 41 insertions(+)
>
>diff --git a/include/linux/evm.h b/include/linux/evm.h
>index ddece4a6b25d..913f4573b203 100644
>--- a/include/linux/evm.h
>+++ b/include/linux/evm.h
>@@ -18,6 +18,8 @@ extern enum integrity_status evm_verifyxattr(struct dentry *dentry,
> 					     const char *xattr_name,
> 					     void *xattr_value,
> 					     size_t xattr_value_len);
>+int evm_fix_hmac(struct dentry *dentry, const char *xattr_name,
>+		 const char *xattr_value, size_t xattr_value_len);
> int evm_inode_init_security(struct inode *inode, struct inode *dir,
> 			    const struct qstr *qstr, struct xattr *xattrs,
> 			    int *xattr_count);
>@@ -51,6 +53,12 @@ static inline enum integrity_status evm_verifyxattr(struct dentry *dentry,
> {
> 	return INTEGRITY_UNKNOWN;
> }
>+
>+static inline int evm_fix_hmac(struct dentry *dentry, const char *xattr_name,
>+			       const char *xattr_value, size_t xattr_value_len)
>+{
>+	return -EOPNOTSUPP;
>+}
> #endif
>
> static inline int evm_inode_init_security(struct inode *inode, struct inode *dir,
>diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
>index 0add782e73ba..1b3edc6d26e9 100644
>--- a/security/integrity/evm/evm_main.c
>+++ b/security/integrity/evm/evm_main.c
>@@ -787,6 +787,34 @@ bool evm_revalidate_status(const char *xattr_name)
> 	return true;
> }
>
>+/**
>+ * evm_fix_hmac - Calculate the HMAC and add it to security.evm for fix mode
>+ * @dentry: pointer to the affected dentry which doesn't yet have security.evm
>+ *          xattr
>+ * @xattr_name: pointer to the affected extended attribute name
>+ * @xattr_value: pointer to the new extended attribute value
>+ * @xattr_value_len: pointer to the new extended attribute value length
>+ *
>+ * Expects to be called with i_mutex locked.
>+ *
>+ * Return: 0 on success, -EPERM/-ENOMEM/-EOPNOTSUPP on failure
>+ */
>+int evm_fix_hmac(struct dentry *dentry, const char *xattr_name,
>+		 const char *xattr_value, size_t xattr_value_len)
>+
>+{
>+	if (!evm_fixmode || !evm_revalidate_status((xattr_name)))
>+		return -EPERM;
>+
>+	if (!(evm_initialized & EVM_INIT_HMAC))
>+		return -EPERM;
>+
>+	if (is_unsupported_hmac_fs(dentry))
>+		return -EOPNOTSUPP;
>+
>+	return evm_update_evmxattr(dentry, xattr_name, xattr_value, xattr_value_len);
>+}
>+
> /**
>  * evm_inode_post_setxattr - update 'security.evm' to reflect the changes
>  * @dentry: pointer to the affected dentry
>diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
>index f435eff4667f..f48ef5ec185e 100644
>--- a/security/integrity/ima/ima_appraise.c
>+++ b/security/integrity/ima/ima_appraise.c
>@@ -601,6 +601,11 @@ int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
> 		     xattr_value->type != EVM_IMA_XATTR_DIGSIG)) {
> 			if (!ima_fix_xattr(dentry, iint))
> 				status = INTEGRITY_PASS;
>+		} else if (status == INTEGRITY_NOLABEL) {
>+			if (!evm_fix_hmac(dentry, XATTR_NAME_IMA,
>+					  (const char *)xattr_value,
>+					  xattr_len))
>+				status = INTEGRITY_PASS;
> 		}
>
> 		/*
>
>base-commit: e129e479f2e444eaccd822717d418119d39d3d5c
>-- 
>2.51.0
>

Hi Mimi,

I think this patch set just fell off the radar. Can you take a look at
it when time permits? Thanks! Btw, the patch set is still applicable to
current next-integrity tree Linus and main tree.


-- 
Best regards,
Coiby

