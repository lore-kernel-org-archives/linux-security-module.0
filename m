Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0DF322B83
	for <linux-security-module@vger.kernel.org>; Tue,  3 Feb 2026 04:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770092097; cv=none; b=RqGYZ0i2rVtHftYkM0l8r9AyMW5wgQXeF0fBHzD5UGxTNCsEla9SjBXJQN5qi5wunQEdATbYXDXWxjVAxxGTOlRi2ZBJBVEeNDbdoN2JZyihYl9HymRM7+xI7KJEmJv26Cm8Z2CVzEhBh8pk7IxiwJU25ymq+eRfZhKQtgjGV1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770092097; c=relaxed/simple;
	bh=sJHfecm+9PgAuBM+q5zub2xzR1ygcAgU4V485eo94bw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=m89LzNjXchVoLLZ5+j5svURn/66zzAnYOsKBOGEc6LggU3YHLEeLgqtxWDNQt3clpfDRpLsqVmrhflXmgzni61ru/O4jkEmNo344bNvu4Ke5lmjq2tMV2W4QpfNoXVr8lyGF39IdFOx3l3Han/AIaU2BGkl5tHzwJk7iq8V/5ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BrFpq7Wx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BrFpq7Wx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770092095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6/dgoz1907GpWsw9tjXtaDcvG7jiC8B/ivCp+i6DkyU=;
	b=BrFpq7WxfvH9B4WGaloS8+OfduCgp1eAUX3gAVmoefcIOsZ65Qogb6PVcM+ug8bkmm7/c+
	lnWW8+fVOWnQk+H0dg802/qtHFORiTtgcS7lvyNRo3r+71OxqHAVqezQUVVSLFEFpSI9bu
	qdiMrxEjWvcS0A95FiExyeGdNjEFIbs=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-t-J__O8uMTSV9PcML0eC7Q-1; Mon, 02 Feb 2026 23:14:54 -0500
X-MC-Unique: t-J__O8uMTSV9PcML0eC7Q-1
X-Mimecast-MFC-AGG-ID: t-J__O8uMTSV9PcML0eC7Q_1770092093
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a79164b686so52790435ad.0
        for <linux-security-module@vger.kernel.org>; Mon, 02 Feb 2026 20:14:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770092093; x=1770696893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6/dgoz1907GpWsw9tjXtaDcvG7jiC8B/ivCp+i6DkyU=;
        b=bZQFwiVRWEipdYais2gbxnoFLLtbgKEZy5PKokZ/YrN4goX7CnxaqRduFvcwMB9Pii
         znFUgMgJFN4dEgwIjKaTjOU/ylk9BB33ZUkns4VXHHGQ3NUs7EwrK7t/3FK4jRbxRJzb
         AZxZyULzTEJT8q1viGT+g9CfmUH+x/jfgqoyl3jLQNHmshYLP55yH+d2P/dQbZFDqRjb
         rek1Nht50xqUiKgSpQFzRS7zhg0/0lGPPLq0lKsXjLz3dzXfVcZQEVMO4nG+cldp/LuI
         Ys3uwwr4Ccd7+w8DG1Y+J/ejyTA/XyAnMc7Dv9+5117CWRmWuPliwjCsV3lKFZBpASXx
         g0bA==
X-Forwarded-Encrypted: i=1; AJvYcCULkav52mVngAWmDMTXL0QJ3yBSKYke4wn5d0mnzdg806k7mDjXbHuw3BQEd+/v908ehUfQ4W9GIZkzWGSssXRetePNq+I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf04Q3P6WXrPBIA73odYAp+sV9pwKl1Ce4ddYWBN8RxA4O0SaH
	MczAT+W2YDLzm4K/ekRFx16dAaJ89yH/BYOVAEJt4feMi37Za5538gHTGCUeAhtFRU+5GRJQNnC
	dWosy0Fj72S2emsZyCZzlXNGA94T+F1MF3A7YRbvUMSj+7FaLN6fAo1u+/yyWGgT6L41roJjqqV
	F2zQ==
X-Gm-Gg: AZuq6aKCCDCkUIYoh7yGCpJ8ylFc2/XoSlMaXbrcv96hJx8PCXHpvwgmpgfNCE240mb
	+xc9124USTZXRyUGkZs8hO6eLfIXP0cxmGTyZO2G7O77PE5Zc4pMCg8sEo9BsuwIUQr2CZuUcyU
	MNXkZCa6RqAOQ2tmRegkcgBzTaO0KG7Fwuw24c28rWgUIvTLyoxil3siYp+nBq9uT/Ewzgr8mv/
	txBSKn5jQW04YspS+DozcHI8jV7oxAWY4Gpu1XZC/g78ghFgzK28DoOlMQKMs0TlDM6nyuDVUF0
	h0jp6HZSmp5z1Is/v0p7aZo4Dv8LhbYUyGfLJFtPrdyZewbxCNUqIoNDJ4RCbvlK85ISN83y4/m
	o
X-Received: by 2002:a17:903:46cb:b0:297:d764:9874 with SMTP id d9443c01a7336-2a8d96a7688mr136629905ad.21.1770092092972;
        Mon, 02 Feb 2026 20:14:52 -0800 (PST)
X-Received: by 2002:a17:903:46cb:b0:297:d764:9874 with SMTP id d9443c01a7336-2a8d96a7688mr136629755ad.21.1770092092472;
        Mon, 02 Feb 2026 20:14:52 -0800 (PST)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b5d93cdsm157121635ad.70.2026.02.02.20.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 20:14:52 -0800 (PST)
From: Coiby Xu <coxu@redhat.com>
To: linux-integrity@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>,
	Alexander Egorenkov <egorenar@linux.ibm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Dave Hansen <dave.hansen@intel.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/3] evm: Don't enable fix mode when secure boot is enabled
Date: Tue,  3 Feb 2026 12:14:30 +0800
Message-ID: <20260203041434.872784-3-coxu@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203041434.872784-1-coxu@redhat.com>
References: <20260203041434.872784-1-coxu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PvIYMRb_bCW7ILUCm31OMCeYC7taPt8Hwco8ltp2ox0_1770092093
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Similar to IMA fix mode, forbid EVM fix mode when secure boot is
enabled.

Reported-and-suggested-by: Mimi Zohar <zohar@linux.ibm.com>
Suggested-by: Roberto Sassu <roberto.sassu@huawei.com>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 security/integrity/evm/evm_main.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 73d500a375cb..a54cb73b51ee 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -72,17 +72,25 @@ static struct xattr_list evm_config_default_xattrnames[] = {
 
 LIST_HEAD(evm_config_xattrnames);
 
+static char *evm_cmdline __initdata;
+core_param(evm, evm_cmdline, charp, 0);
+
 static int evm_fixmode __ro_after_init;
-static int __init evm_set_fixmode(char *str)
+static void __init evm_set_fixmode(void)
 {
-	if (strncmp(str, "fix", 3) == 0)
-		evm_fixmode = 1;
-	else
-		pr_err("invalid \"%s\" mode", str);
+	if (!evm_cmdline)
+		return;
 
-	return 1;
+	if (strncmp(evm_cmdline, "fix", 3) == 0) {
+		if (arch_get_secureboot()) {
+			pr_info("Secure boot enabled: ignoring evm=fix");
+			return;
+		}
+		evm_fixmode = 1;
+	} else {
+		pr_err("invalid \"%s\" mode", evm_cmdline);
+	}
 }
-__setup("evm=", evm_set_fixmode);
 
 static void __init evm_init_config(void)
 {
@@ -1119,6 +1127,8 @@ static int __init init_evm(void)
 
 	evm_init_config();
 
+	evm_set_fixmode();
+
 	error = integrity_init_keyring(INTEGRITY_KEYRING_EVM);
 	if (error)
 		goto error;
-- 
2.52.0

