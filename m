Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229872F83B1
	for <linux-security-module@vger.kernel.org>; Tue, 16 Sep 2025 22:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758060877; cv=none; b=fSZZPZdX4jNEhc/+TeP/OSM4lhgds9PXj8/GqVLnBFufL7esRZms562eOQeIGpY2j8vxIJ1z5/dF8Vyvxs5HGfjZXLZ2wCL5/UcNpkj66/JZXDZi/4ljNTdlpNjhHhXxUm6xaS+2i0PqDgcm9MWUNK2pTunMfIVFqzeJAt4om7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758060877; c=relaxed/simple;
	bh=eSPJ9IwafgtR568e6umiFwslA/7AiGEUrM0feWmarW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mnnlEQFsulhkZ069y/QXMiZ9lPS9U+B27RNALf8eG7cd9SV65DyicLmYM7B7fP6Jc2kKmae2jp9pBvTSe/14oigC32goGSZiIOFRDNXk64ayKRYaNtUlJ2L56ClmcuyBWtOQASnRmRMDrC22gxQWU8NFQarfmAI1hZuweWZ8xjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=D/CQy/Dn; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="D/CQy/Dn"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-80e3612e1a7so994200885a.0
        for <linux-security-module@vger.kernel.org>; Tue, 16 Sep 2025 15:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758060874; x=1758665674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DAtmfNQ6iTWPMtQABHuMDq5EmFwIC3YnzX4TbmWfkjc=;
        b=D/CQy/DnKM9zzYmA7lBmci04DG4SdlUoqg9vT4nwNbOt5jjtykj2IsOuF5Dq2VkOcq
         m7/xSjdrbxanugLl2PIdv6m7auChEcNIQ4pyuN44gCNipycSFuK9nerPYu8ePk5M18Ak
         5UNoV9tTnz0LFqLMScEwkaZTxhEo1e2PyPIRxUk7fhoK1ILex1gKH27po2Uy5TEIhW0K
         vZKcwvGszoGIFW0OLZP/sDNr/rnGiVQ8SeKaeesxTqPagmV39o27Yh9xGs0abxuSl2ER
         SZIYV+qAqJysH8kBHC6HS040kQUWTumC0MOBlBzUNgvAQ6N6ukx7UzCJlEaYcpTzgc6x
         fFtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758060874; x=1758665674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DAtmfNQ6iTWPMtQABHuMDq5EmFwIC3YnzX4TbmWfkjc=;
        b=mN65nTFFKnuJTy/uQ4Vts3rA/6BZ2SnKRmqy0encthhzqx/+yPciTbrxGPH8zyCFnU
         r7+xeugA0VQKnqYluTqQGQq6t8HVEi3fjnM4eLMyaC8fz9uvK7hU2vOEd9y0ExBzIYNj
         FAMsQY5ifzWfJn+oKpc1a24ppZ38vUQnxAkwpkHYrRhIrGnhUvLPS4Te/36WAdFQTRk6
         IxF6rGN4p73QJgx06LmizyBRGNZpF/tvaX0YMB3LSs/cxr7VcVWOJLuA0rROrnHnGvTP
         hUCbz68wPAVxD28dOYLgIHjODJAM0VNlx5hOfft6NB//lVeLh9pikAwlpzuYQta7r5rJ
         wryQ==
X-Gm-Message-State: AOJu0YyE69mUjZdz+7hYMk8iQqOGGoAo8FdgLGbZ+msYNSVgo1GE6MFh
	4A6VFnMI07I+G+i+b0crlXYIM3xg2y9wFnqZbVEyL45VydQc9KPSFSCBSdvwy2bA1QoE+XkaOLr
	zM4A=
X-Gm-Gg: ASbGncv7KobY6nRwww/8rodyMU6NT70EJy0y9gPCW8tSnvnsVopWx7FBKVfu+eeNZuw
	K5xyf0Dv3QDFbejf8hZkdWDHHKTkGosujPAXgZXuqk6KwvcN9oDGTKYyulLdOQo9po80pfQ+y6U
	xBi47BzC9lP1RT8FuMH1JqSOIzpv3dpYuFvZR7ScdPcci59U2vFDEWeE/t/3xwlCLMC1PpW3diF
	juxPf8+X9I/1HBD2lL1xTAiqcTQ/VQScbyBlm7DwA7qbO/WRfGAgEGZSjzc2usBk31ChSl9QVLa
	Gv+o1dCdpgfbvirOm8zfPHFyCaGq81q83NVdGRnTwn1jcIUGgCtQ9gt9Lvk1h/OdHs/f/UlEUWj
	FzgzSAX5cJ+kx7yFKeKIW95pkTxZeWBc//XkOLAqQYLc2wwj6SSUZe/1Usjsq72JFoyN5
X-Google-Smtp-Source: AGHT+IEbqjualJU/XfMiX4TA7ZuPn8FRnSa8wwLfLCgZInNnnuLK2vsGbYixuZTDi99FKjwV7ZuDPQ==
X-Received: by 2002:a05:620a:2686:b0:81f:fed6:a727 with SMTP id af79cd13be357-823fc891024mr1928760285a.26.1758060873984;
        Tue, 16 Sep 2025 15:14:33 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-820cd701cabsm1026717585a.41.2025.09.16.15.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 15:14:32 -0700 (PDT)
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
Subject: [PATCH v4 30/34] lockdown: move initcalls to the LSM framework
Date: Tue, 16 Sep 2025 18:03:57 -0400
Message-ID: <20250916220355.252592-66-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916220355.252592-36-paul@paul-moore.com>
References: <20250916220355.252592-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=884; i=paul@paul-moore.com; h=from:subject; bh=eSPJ9IwafgtR568e6umiFwslA/7AiGEUrM0feWmarW0=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBoyd8rZ7FFCreg76jup3ccUSlvkc56RqACpDMht +VkjvZ5Kt2JAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaMnfKwAKCRDqIPLalzeJ c/quD/4414VbtAzq0xezZsKY1Dz0kZUb+420OoogoEcbhxnFXsBQd1MglzaKbAoc0kbE15bXWUE nDMO7THHrEkAg3yQ4KPmsfB5e84P/aZUoGgi1YDyLOblOwqLIAJW4YI4/wGzxI+igDiik8NxwbL n1489P78ZL/rv+wIbmT+Kv1sPBI7hhIVFOgN5LSc01xmO4WXwBrnm/c8+ganiUrd0NwWkR9TZLS mIQcj6kNt4wQXaqkAvCV6hJP2vZ6JDJNTnOExtSytzBA2rCqMu5APQ/RRo9KeM5bqvPCZZ4iuzg XJ+i4xstMTStK1vsJukzbQyLCdKO9DIOPtE3Nf2MBX5tLLNNd6GrTi9xJkgTa1q6SoO1d/8zYHz hs4qcpT8AAgGXe0/7EyXtVnLDUpXKzFfb1T7XZl/PHB4KQwkMuoEoTlUMI+zWsWwpDrKlQvPuC5 wks5txf95jvLOMLryo0/16r/Ube00SPeDudHLLLM9hG8jpMyv0SbP+GcZHqGttB4m/T+GNMKuLz XpoPJYzrzBU0kGG66HKDQ1cnYbpng/WQPcWbjwN7hZiWgnkZsrrqRCQDepD+tkrj9Qh/3mIr9l+ qRKypRvNocNLTPMp+tJC1xMPFQm99y89Z4rm348ca+UzqOqRigryzmiccFfOb709Y4PoW/UxZ6+ 8hOBVnV75nCZPwQ==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Reviewed-by: Kees Cook <kees@kernel.org>
Acked-by: Xiu Jianfeng <xiujianfeng@huawei.com>
Reviewed-by: John Johansen <john.johhansen@canonical.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lockdown/lockdown.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 4813f168ff93..8d46886d2cca 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -161,8 +161,6 @@ static int __init lockdown_secfs_init(void)
 	return PTR_ERR_OR_ZERO(dentry);
 }
 
-core_initcall(lockdown_secfs_init);
-
 #ifdef CONFIG_SECURITY_LOCKDOWN_LSM_EARLY
 DEFINE_EARLY_LSM(lockdown) = {
 #else
@@ -170,4 +168,5 @@ DEFINE_LSM(lockdown) = {
 #endif
 	.id = &lockdown_lsmid,
 	.init = lockdown_lsm_init,
+	.initcall_core = lockdown_secfs_init,
 };
-- 
2.51.0

