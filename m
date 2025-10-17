Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EE227A130
	for <linux-security-module@vger.kernel.org>; Fri, 17 Oct 2025 20:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760734143; cv=none; b=d23nvdsewhyHI/Oga8iFWR3T50aer6TFTyBi5z04fC43H6mVTNWYFUVNc0O7/i6LFu0GraQAYHQAYtAy1gTWUEwFPadNinH2Vc4x+6cOzInbiM47lSg4A9zpJZSvnBt0wdw7zj2YyID9UCpLO1wrlAU1Lx6WD7Odr15l844/zkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760734143; c=relaxed/simple;
	bh=3nN+Lf2xoX8WCto15YACwl8uoSNV/UuSmv+Lj7xFNSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pwt7Fq+tj0fRRKrod0Wg4bK9sQKxq1a/wUMn32DwII/Tf6f3QWijYGGGNejwGze53nEf/+Yrz0lwetDpyqWOG30LdrLHJWMc5Dh57jY4q3tva46faAOHqnxizlRwL50UkWsh8pOy6JhSpBBKDLY0mOM/9nBLvK9Lp1c4VUOipmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=BEAsUfw0; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BEAsUfw0"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-88f79ae58d9so313440185a.2
        for <linux-security-module@vger.kernel.org>; Fri, 17 Oct 2025 13:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760734139; x=1761338939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zTjzhsNjIDUZSYUv02RN7INkAicrlPW3NA8BHgcVnfg=;
        b=BEAsUfw0/AnOPKK2JmIER3XD1EpzBYcY5YEOuVrtRMLcbGEvaciMEHn7z6Ph2/C3K0
         nr8mp5SFmG80PuMAq5mdLJ90nSJBxg7AaoAhbWVPIv5od1ZPRZ8+lpeHzjqfl9qn0Fa0
         dkY7SfhDd30yVrZjto1H3nYY4tpKbEEyFC2Tz07XPmAYywQiqnBITP1h+fTi8oMpHa0O
         b1W0230ib/QUe4FurRFhsTqAQ6XGsV+vXUHDXLcYoi3twxbi4/ABGebr7P/d9g+cEvni
         J0S9hrcX3ugcEwMoqpK9ujIimKz+Z1SvlQkyDxF2BxaJfC9jKpiFSvAFwzPmYq8Gq2Ah
         WvnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760734139; x=1761338939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zTjzhsNjIDUZSYUv02RN7INkAicrlPW3NA8BHgcVnfg=;
        b=S/oVEpkBe9HTcCe0B1Sq+9UJ7NX6xmzsTU9wPQCJ0XPd/rmW+ASJwDOjcb+4lwIE5a
         pFZxByXEjOLZrj+vnTRhCGzAalsSoYifAIPWzUvQUc9VylHzMVmDhSWdyE1qSSXAOfSV
         Ic1We2fzcwUpc6NPn7urpTN/lrvcTHjMHnZh161oeIyeGps6v0PazMCurUf3XJbiUQE8
         qKvPnkeP30FT0ftf50Un3SMORexHDs0Aur66W6zivWGEchbYSrcmrBZDJVvBxj0603GI
         vcCQzVQ3lHeYBPstzE9s+eU1xwz9iYhjIT7EkeU8Ar3GY6W+ztmCWNvNu81DPz4IBJal
         5JRw==
X-Gm-Message-State: AOJu0YwCTPD6BvBFDnMoOYTBaQfr7ilf7hmWQ0Q2LJSZrLYrlfP/JD1N
	POALisj072Kz1rslYmgNOFp/i0GMHRm9nd8TO1Bg28wPAfrqCk3Q2xunz+x10L0ALaT5l27gSCL
	9A4Kpuw==
X-Gm-Gg: ASbGncsoZTk9yG5xfJ4uGFPqXHxdtSGwT3+uRUXWjmJ7uKMr68q/S5JAu83OFbrLAw2
	oDYvXL80jKxHcCsmS1WhB4s4TevO5jIV3PY3+kPM/6x//V+zLTea69zXNJtG29EpvtKR1bA27iF
	qUGedS7/VCx50YNxT0hrUeUwtwYj9vizlD7YgocSWpQr/xda32zpaQDoefH7k5fGMzNFVBdDCRL
	h5L4rAk7kZr3M+fZWrzLngm4zczOyJJIHtOfSLuIIf6R7D6sf3L0Tq/pOY6etHrX++MAof6DEVk
	umgYPG8wNp95SG/jwBNR1g+GMq8pCvBTcK8xPN/ghOBhEvZem2t6w+RWvX4EFY3zngJH5t1JxLZ
	jeupLLVm5JYi9tccWLafJB9qsEHfN4atkmsGodMo2MpXvpp9PVqORylA+3PXAheFeHas9HsM0hI
	s6/ksI0KL377zvqtZuLvPl1HF0lgL5dgvtEZZkEcCumuzMHz5J4giWmlEX
X-Google-Smtp-Source: AGHT+IHicyBQ95yOsVG+sT/sDWfpw2MK015YQ7gM54Wnw8Y95CKJfoAVamgfEMm9rAgzcgYNKKBH0A==
X-Received: by 2002:ac8:7d8a:0:b0:4e8:a6c3:4322 with SMTP id d75a77b69052e-4e8a6c343dbmr31965431cf.68.1760734138594;
        Fri, 17 Oct 2025 13:48:58 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-891cefba8f0sm42490285a.40.2025.10.17.13.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 13:48:57 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org
Cc: john.johansen@canonical.com,
	zohar@linux.ibm.com,
	roberto.sassu@huawei.com,
	wufan@kernel.org,
	mic@digikod.net,
	gnoack@google.com,
	kees@kernel.org,
	mortonm@chromium.org,
	casey@schaufler-ca.com,
	penguin-kernel@I-love.SAKURA.ne.jp,
	nicolas.bouchinet@oss.cyber.gouv.fr,
	xiujianfeng@huawei.com
Subject: [PATCH v5 04/11] tomoyo: move initcalls to the LSM framework
Date: Fri, 17 Oct 2025 16:48:18 -0400
Message-ID: <20251017204815.505363-15-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251017204815.505363-12-paul@paul-moore.com>
References: <20251017202456.484010-36-paul@paul-moore.com>
 <20251017204815.505363-12-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1895; i=paul@paul-moore.com; h=from:subject; bh=3nN+Lf2xoX8WCto15YACwl8uoSNV/UuSmv+Lj7xFNSc=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBo8quYRZW1vHN9gN6QmYxFAglkZ5tHHx+hvPTJk s7MsGvYHHuJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaPKrmAAKCRDqIPLalzeJ c6DUD/kB/LfjEcv1Lj+kjNlh5nwM00Tb9fVsgQ1QLqTFcKi8ro4VvEdAtsf1j7te8yTv0byxPrf bf5tO+H+YDc2zH228OoSV1ayvEiaerL/byhf4Usvm1iDqzJ+2QvanG0WLsvaq65W/XFxgklY3G7 GQvCJ+oO/ZEpRXr25gDWDoTiKphL8k5sKJ1nwsUa74qmcWpKrluPTjZHFOW1Q5+H9mqVf9JufOl qNYh3cRP8XCC00mZQboQrkr5JmZeYXhFYHoFaL48tW50Fb4B5xnmwGz28MPr3rQom3Y6m4H06Qi iFGSzexu/UsE62w8Dnaa4EB/nSNzr5q3GFud7RfMPfQxHMRKiXn66VNgFzTeqmsMDx0SemnK+7X IsP5fpvYwEW1IhCfylkmLNkvicT0BiKl0TyW9X2OoytIgDqQOUpGjuR2OVkoxwirYvDCg4vp/ni Ju2jD0AxZplPSXAvUd0UBSQ6RsT5JWOgGRBg9ML4Rqj/ikexrbOa487YX6uJ0tFS8EdaOmeMsT8 xbq5ua38AgdvwKk5fGfK2LsZGG9zGNuhwVHKd3tlloJrn1B0hbiTewTZ/NGAfQI4N6dg3CmX6Qr qnGNmQEhU+Us6qSdbwVQlCHemCv/kF+rO7PJ6ykIPflrX2f5tvyRiMNCv7ilCQnlJ8Y90okITIX 4mB+iWdjyASGdoQ==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Reviewed-by: Kees Cook <kees@kernel.org>
Reviewed-by: John Johansen <john.johhansen@canonical.com>
Acked-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/tomoyo/common.h        | 2 ++
 security/tomoyo/securityfs_if.c | 4 +---
 security/tomoyo/tomoyo.c        | 1 +
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/security/tomoyo/common.h b/security/tomoyo/common.h
index 0e8e2e959aef..3b2a97d10a5d 100644
--- a/security/tomoyo/common.h
+++ b/security/tomoyo/common.h
@@ -924,6 +924,8 @@ struct tomoyo_task {
 
 /********** Function prototypes. **********/
 
+int tomoyo_interface_init(void);
+
 bool tomoyo_address_matches_group(const bool is_ipv6, const __be32 *address,
 				  const struct tomoyo_group *group);
 bool tomoyo_compare_number_union(const unsigned long value,
diff --git a/security/tomoyo/securityfs_if.c b/security/tomoyo/securityfs_if.c
index 7e69747b2f77..33933645f5b9 100644
--- a/security/tomoyo/securityfs_if.c
+++ b/security/tomoyo/securityfs_if.c
@@ -233,7 +233,7 @@ static void __init tomoyo_create_entry(const char *name, const umode_t mode,
  *
  * Returns 0.
  */
-static int __init tomoyo_interface_init(void)
+int __init tomoyo_interface_init(void)
 {
 	struct tomoyo_domain_info *domain;
 	struct dentry *tomoyo_dir;
@@ -269,5 +269,3 @@ static int __init tomoyo_interface_init(void)
 	tomoyo_load_builtin_policy();
 	return 0;
 }
-
-fs_initcall(tomoyo_interface_init);
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index cb003c460dc2..c66e02ed8ee3 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -617,4 +617,5 @@ DEFINE_LSM(tomoyo) = {
 	.flags = LSM_FLAG_LEGACY_MAJOR,
 	.blobs = &tomoyo_blob_sizes,
 	.init = tomoyo_init,
+	.initcall_fs = tomoyo_interface_init,
 };
-- 
2.51.1.dirty

