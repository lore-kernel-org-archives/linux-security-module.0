Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55B62288E3
	for <linux-security-module@vger.kernel.org>; Fri, 13 Feb 2026 01:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770946150; cv=none; b=RdUpe2PhKs8+WbjUIM4Zk4PAyinKKBuvcd3PXDC6KInkOrNA89f0hHgntXzqHbaq9vEGLF6w/hRv05XomRnZZu76oesSeU+AOAM1U7wwu9oySM3Q6MlvjsAbzmOKEHdAD/HJCCIpv2y11wsjpAoak/HTI5Uzdn4ev+2RRBZ5nWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770946150; c=relaxed/simple;
	bh=+1Q2uF6WKVSZBZvU8j4Tlp8gBEODqavEONgkrktkcB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=B/u3n8ZZqGg2V7EI3VGJgg7FYxKOyr+fqU2za2rrwE9cuCtizgXy3/ueRVHOrJeJkG91R+k2aJauaYza0yUn5GmHu6dG2AriPJ39NZfXottnWZylePYf6xv79C5xWI7/36E4V5+gL+h/jBwqkNrIvzEHvolSxdILp/QVzCF52Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JiXKyJpq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JiXKyJpq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770946148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jxtKY2oW1YBZo5vKqUoQFLmHY/8Z8JRSUUM8/7xMXv4=;
	b=JiXKyJpq6NqL8xkReYvxWfjk2Wv9chZMYvoC7HPVqR0j9E4UHUNW1uUrPHbtS8h6TMpsfI
	md7ZqSZ1OLw0SkhaKxzwO5uj2Xl2SOw4k9sza4SFR4JEqzG8jBwRauCQqBEYCeRJexzz4P
	iegXxhMHSj0/hRokjdb9EcZHK+oTmTE=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-IWCyEsxdOzeb9xHWD4UJEw-1; Thu, 12 Feb 2026 20:29:07 -0500
X-MC-Unique: IWCyEsxdOzeb9xHWD4UJEw-1
X-Mimecast-MFC-AGG-ID: IWCyEsxdOzeb9xHWD4UJEw_1770946146
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a79164b686so5003255ad.0
        for <linux-security-module@vger.kernel.org>; Thu, 12 Feb 2026 17:29:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770946146; x=1771550946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jxtKY2oW1YBZo5vKqUoQFLmHY/8Z8JRSUUM8/7xMXv4=;
        b=GOb8vzO/WIMSyyEc8c9I1kEMCgnXZiZyFdY7sow3N2XOn4chSz8FuCrSnF8A+C+CFx
         rn4GhBAR5YPX0EnYinCY4Tl5ByN3rpnYS2aJSjbRlvUl5fAcgXgoXKu+pqGUx02PmiIq
         xjsqLYWemhyaKy4xKQ0z/CF+ZvOcls0MzxqaskuEhAMGUAWV2xdh/B4A47CvuMgUzGtC
         v+RIS11wdVDu+qijvgsSbRRUQLsApILZ3k9OqJvUs04Djzh33X56fqvQ1jRg3k1qJVNM
         HDWvcaPcjHftS0bHC0sdOZctISCEwZiBOWcnfrajqpV4wwFsaAia7rfGy7u9I2ghm5N+
         YJwA==
X-Forwarded-Encrypted: i=1; AJvYcCWUR+97TLlNei9a+cCFGMdo1SUosj5L9QHwfEpbcKexUo+50HsKJvDQM6uET45DjPrYDjsGWKWb/tm3ywqOpPckPVu4PqI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4KlLJp8sFwbDbIZIYogWfIrhtuUdhbAgKjqVTyBD9Fnri3LLt
	01osyorD2eF50v2eM0myBYlmmq6CkVHMIEZeW2LwT9PgNWJvDD1g1j0Qu+QveNzVyoeZQIbyxUg
	H3Wkom/mxM9JbzvDsI1e1r1lPKqkdeuutUEMY/wbrnu6RHYr/UkZtZgxTZuv9OjQXigE2nDYMAg
	WL3w==
X-Gm-Gg: AZuq6aJBOSm54nikpH79NwRtpavTbjOgso6gb5AF0LnX/kPzuiRvJVSfnw7gSoC4O4O
	HXDroFWuuyoUY5w6GF890N+Ws66m5JoDK8Cdp+9krdELev4PcYzHyj6hqHbsCv6FJdJpMd2riNE
	xSpa3gqWdP29afE0/EgQBm7Qi16pFI2HoRwBAWdHC3tQnoDwO1G3msLMQ67rhhnvKJZeI1P8B9x
	fzHCTjDbAIecNYEMh7JB81QlvNQqSlgCRlilYONR0IWyvS36mEW9W4Ya9NEe7hysI2wS7uB6s8i
	CYK23xrBWozpNfAJXFiD/bVxv8thWAl4bLFqrJdpNZZO75egaRiJuKl0VgaR+2T6cfvxB72XOFA
	Y0BdwYuqqwNcy
X-Received: by 2002:a17:902:fc4c:b0:2aa:d5e5:b12d with SMTP id d9443c01a7336-2ab5053ea30mr2483095ad.27.1770946146234;
        Thu, 12 Feb 2026 17:29:06 -0800 (PST)
X-Received: by 2002:a17:902:fc4c:b0:2aa:d5e5:b12d with SMTP id d9443c01a7336-2ab5053ea30mr2482775ad.27.1770946145756;
        Thu, 12 Feb 2026 17:29:05 -0800 (PST)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ab2999879dsm65059095ad.80.2026.02.12.17.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 17:29:05 -0800 (PST)
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
Subject: [PATCH v3 2/3] evm: Don't enable fix mode when secure boot is enabled
Date: Fri, 13 Feb 2026 09:28:47 +0800
Message-ID: <20260213012851.2532722-3-coxu@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260213012851.2532722-1-coxu@redhat.com>
References: <20260213012851.2532722-1-coxu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: v8ITnG8F5R7CYZBZbGwudo4fAeqMdb9BjU4xTEIStLU_1770946146
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
2.53.0

