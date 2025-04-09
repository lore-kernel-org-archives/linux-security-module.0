Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0F127C17D
	for <linux-security-module@vger.kernel.org>; Wed,  9 Apr 2025 18:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744224829; cv=none; b=CoTOl68hm2389LSkKHNaZNG7OBLIRtv0rmmT2o47hKtzriZ6QvXBYM79tMNyNKbLRY5ibwdxUk/eymmXk1n8FbpRErfHz+tgnSYgXt8xViPoftKvDRUoiHWwc5ZwAPmG8eA7fnqxV5rm8h9Q8yr2AEj8V7HvM7jHZ7PDjw9/V4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744224829; c=relaxed/simple;
	bh=U0J8daT5qbdY0XH0/6KwMZfXF6KoGXdJq3T5B3kThVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EZ2JGuR83KIIH2CzRU39d7IH12vJKtcTYEg9Xwp6bzdwAfBjVnOwV8JTFD/82DXofzochTvxIdJ3mZi1FbOopn5zopnTOfS+69YY2L1byfbs47QiBx9ocmnM4RX6O4qwj0QSyh4a6Y+6fy9w2PuRehWJjMWkqi6W7XgjC20UGEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=MlUMReY1; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="MlUMReY1"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c5f720c717so111594285a.0
        for <linux-security-module@vger.kernel.org>; Wed, 09 Apr 2025 11:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744224826; x=1744829626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XOHKz9d/qjT2CE9duhaUIeD9jISgOoKf1CYvh/h5rto=;
        b=MlUMReY1lCgQD/eolgpi9Nr2raLx8fyK/f/5UFvFpjgpC+ghisy+6p8O9hvspmDe7h
         ZxD2q9eEHqdyI4QOCghfzrj9w5sqG3+Bpl9jFIhbYI+msYw9pLQdV9CxYdkQ77QE3AkP
         uKoU6SFRCvV38f6t1iv5r/MncgpusEajtdgBYvgIE8UePHbsaMyIsJD+maZ9fd2pepIb
         iYIQDO6q3xBPNHRG+FiqNyGVrqkTDlguV5JOk7b8zAwmTBz3OWuUVX4dF02YU4dOYNiR
         QWf3wJMVAtivjAyvIEy2xf9IpB2Q6Yr4mYdo0FEBlBqj0sm+tzkuoRdoqTDj01kn44k6
         MY7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744224826; x=1744829626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XOHKz9d/qjT2CE9duhaUIeD9jISgOoKf1CYvh/h5rto=;
        b=ahgXGcpjSb+fIu8qUY/WCH9FHYbG/ghiy/ILkJzC5/3oRk2C/HYx+f9+/52FlDF/3W
         LVxlgvBXmUUYbYq3FLBqAKArmjKYQM3uE1JjOiI/x3X/o2gR9NQkzzg3yeTnApEEsUCZ
         BznWUIoDum6spBXbfcS9iz6AwNzWamG/fJugZZ7BQWxrf2DLoOdp8SohQpMQ2hZKSTz1
         MaqSkpndBBLCzM2BS85RmkqK3gNFhyriTIwEIz3wpbiDLZlS+VfG2r+ASYmlNxJO/rGQ
         vdiYEqAwDXgo2i1cnSdCb6E+yNSzi/Rat5AQLmdJo4ySkUqtDcVBq7JP4ofCfryZIyBX
         VzGg==
X-Gm-Message-State: AOJu0Yy/NaALHwrIO1KP70tN9eP0DfcM84hUPiGlNpXEGEs1NYqS6EHH
	LT6QFa1e55I05dSYCQlXDetsBUN7hHwsrgIojVL5WXGNru9gVe/2T6QqqiuMH0O8ZJ46VXXuvCA
	=
X-Gm-Gg: ASbGncs2fr6aKgRWxL+5xMIfySIQHGEqzFbAdqNBzXzh84tfpIc3nhsREo678AcREnj
	u3wbY7kJ9hV2Mgqmq4IHMlgBo7WMHdes3OUQD79/xBXpCHYJJiqYEevcz9gzCFe6hdMXFRdslr/
	jFzPBj71s3PADeYJA9Lu68ZG95IixtkIfhdbxL+VJFh7IfsEv52I1OSgK1hgRug32bMvusrQOV5
	j5fzsQ7pXtg4Oim2OUEzHzoDSTsFEeIHIYOTAXgNfR+9JkGJtM3TtvaJlFAXFET3EeEtPuc2lOo
	NbNXbFAVzwtmZrmBsGyqwYSuKDDowoeE5CHhd5FJcTZ68akD8bdUq3tIguisSZT10j5Ie0XKu8o
	6GN1F5C+7zw==
X-Google-Smtp-Source: AGHT+IG+c6drXp3nozaPsjXztwAoOvjGgCaW6rE/tB4NQI4PpZiDxVdOYrpKlKJ0q3cSZYNhC4QBsQ==
X-Received: by 2002:a05:620a:258d:b0:7c0:b384:77bb with SMTP id af79cd13be357-7c7a65e1ce2mr100060285a.14.1744224826739;
        Wed, 09 Apr 2025 11:53:46 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c7a11c9bd0sm105448885a.85.2025.04.09.11.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 11:53:46 -0700 (PDT)
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
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [RFC PATCH 18/29] loadpin: move initcalls to the LSM framework
Date: Wed,  9 Apr 2025 14:50:03 -0400
Message-ID: <20250409185019.238841-49-paul@paul-moore.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250409185019.238841-31-paul@paul-moore.com>
References: <20250409185019.238841-31-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1169; i=paul@paul-moore.com; h=from:subject; bh=U0J8daT5qbdY0XH0/6KwMZfXF6KoGXdJq3T5B3kThVs=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBn9sHWJoStLswLfKePDDr3dsFYxt6C8v3Zk7goC HEKVxevRFKJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZ/bB1gAKCRDqIPLalzeJ c2KMEACm7+2OCx2kQ5fG7StRMJW/3n1wX/suF7NH5uiAbGUkQgRDyX3aohGr/TNR1vI0WuBxcxd iKIdGrsFiPSGjQVFKWdgQmAA3zJYwHttMd+uS5G03hIGriID5uLDqrsS0x6/jkN9X1IrTgMWXNd 17OyZ6e4fOYvenc0FEn7YTz5Z1RIBC6zdeMSw8A9U1FFGzWltu8mkyQlTnwBBxQonW7ZZ5TLER+ t40CYiSURQJOBUllsApcrEz5+N64liy92cl726YpbmPrw159omGFxwf5WBG1rn11ERliOAlCRxZ qBo/r24HBp56gtHYSSLiVtKUziOqdVTPKEnhCRXJSx1U5ilJF1Sp1wMa+Biem4oqq1ujXQsK/Km 9Ezmy1vpGCuwmTeoZbWXfJO0K8iq2RSRD9RwpaTvcekvWqCbjOJb6AzQ5aaGAs+NI5QulV59d7J QnQrF2hKccrPBWm9TZrQi8k2S2oAstftdKSDzu57BCqJHT1QweyWXYUhN2TUneUPDNLJXfQ2xX3 IJXNGatmzo6V8malwATvZD5r8vEkCJlosykEOhY1nye5NsnenufsZPDWX7fEBy97J1T3oxhmTTP dUpVwCuOnSmTvsyqvwMopHrPMGloXaQBXAtRfVLJSbkgyDmaYBBntNgyOGRo2Y18lN5XoXHL/gG hT8O2jpwYddoTog==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/loadpin/loadpin.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index b9ddf05c5c16..273ffbd6defe 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -270,11 +270,6 @@ static int __init loadpin_init(void)
 	return 0;
 }
 
-DEFINE_LSM(loadpin) = {
-	.id = &loadpin_lsmid,
-	.init = loadpin_init,
-};
-
 #ifdef CONFIG_SECURITY_LOADPIN_VERITY
 
 enum loadpin_securityfs_interface_index {
@@ -434,10 +429,16 @@ static int __init init_loadpin_securityfs(void)
 	return 0;
 }
 
-fs_initcall(init_loadpin_securityfs);
-
 #endif /* CONFIG_SECURITY_LOADPIN_VERITY */
 
+DEFINE_LSM(loadpin) = {
+	.id = &loadpin_lsmid,
+	.init = loadpin_init,
+#ifdef CONFIG_SECURITY_LOADPIN_VERITY
+	.initcall_fs = init_loadpin_securityfs,
+#endif /* CONFIG_SECURITY_LOADPIN_VERITY */
+};
+
 /* Should not be mutable after boot, so not listed in sysfs (perm == 0). */
 module_param(enforce, int, 0);
 MODULE_PARM_DESC(enforce, "Enforce module/firmware pinning");
-- 
2.49.0

