Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B76428504D
	for <linux-security-module@vger.kernel.org>; Thu, 14 Aug 2025 22:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755212103; cv=none; b=MuwZb6dNSiR+7TO2GnaWRoiWy0yO4DK7ohVRig4sUz7WvY2Ofuc5aGxDf2M3cQEyhzSWCmphKlaWvVY7lrWREY49KyV86JzUIlP4ix+mrM8G4kvo1Y4HBkdWzf5FlT4PyIsdkfpxod8R6reKS3RysSe9whPMIEZqLvzz9G9ICc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755212103; c=relaxed/simple;
	bh=URVWxfK85fttW3+Th+J6RoO8v/wxk5dtKWR/04cDVZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ms0++IElBVdSQuJWbXw92j0ZWxYX47RpNMr+BSgflU3CvymLwukspHr9RLbTHXP9gB6NufvmAG0fjqrugNpiGpRhfZ5hSu22HKH1Q2nqiVD1W9vE23AhZB++sTJoOmxSNC+7yUIdjeHUAA8NPxWXxknyzw4KOUR0vOpsyDuLl54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=NTkqa9QI; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="NTkqa9QI"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4b1098f9ed9so10052121cf.0
        for <linux-security-module@vger.kernel.org>; Thu, 14 Aug 2025 15:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755212100; x=1755816900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b4D+dMcKUsP+TdRIF7gesTZPNDJ8YR+vx6kSTZ1U4BY=;
        b=NTkqa9QItvAzpM9XUZ0SPdxDiqtP6Q8/jrMyGL+AeC4tdoiwFzbTc8gZf/YXWsAznB
         tE3Wapd4O8FsPttE9jtY6+ceiiaKbQ0t/Bq22ypkpQ4v8b3yQCfLDs7T+UPfJ8uFn14Q
         2T8dBDpnleFi2F+GqyP/kps5Yncxpu/COIHBbl6jKY2hZtoMQNiT8Qd/j/vXQhdpxt/g
         TpDe4llZBRgcFzPgVl6mpr36t9Pts51/rBqaAT8Idq9ua7lrfFk3zr26OTphs8kej168
         ri8v4tSpv35u3+QmXu7rnlEsBFZ9sCf/Gf24S/pclNGrhXJly+fm2xRw+9V1Vc1BzezP
         rVXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755212100; x=1755816900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b4D+dMcKUsP+TdRIF7gesTZPNDJ8YR+vx6kSTZ1U4BY=;
        b=dYV2H6K4vsBinilkzgDPh5MEKh+0fkqZNUw4hzMMYzV8SxE4OasoGoDY4EblKBwYCC
         LaMFJQBV5hRMQDrW8/gwVOV1eWoGKtRfnMH9ZNQc2IyAYPKbDJKwUj47hMNLNK7L030e
         /pm747c88bngmKk8HXS3TtWHBSa+/xibzMAtU5CHi+KDO37Ys39oHKr2NbOTzG/7pZD9
         SUIJOXdAvQFRHDb0nO2tg7VMuRZxUQCGK1fDOsYzi3U/t8hIO9PlgwdTL1XAOjdWbsxf
         EiG3THEc0Owr6lPEsR72Gjl3BaJPUFt+Lq8eitPRypaYynMVVMUbiSADEBTv8fkgEKzW
         QfzQ==
X-Gm-Message-State: AOJu0Yy7TbVDVWvNmJVYOwxnp1smPPJ0yVq7uIJNrjL2W+dZft0zzOjK
	TDj32VdiBL2uzQkHYlOX5YmedSubpp78arx85dhAIB76iqwuVcNH948zjlfx/BlTmMk4p5hWExN
	ijaE=
X-Gm-Gg: ASbGnct3rokJWkPi2Bf/aoJeE6EPUaMHmNYkx1nAGZPwQXQ9gKFbzC1IOPIMKOuiZ2c
	anxy11CprWdGoYIdzwl1tPudBT77DcQJ7wj1NQD5Cx+NQZoBGWrbOCGwI+wa/5MlIC4883wQokC
	wxehOWwsg3QG0rZ16JPO9qP09NkqlzBLZ/s8rxIJ4fsOQOWBJ4DkGCNg9ribQ+4GtBaXV6zDNF5
	G/x8lHbuLguqN581Ro1IHSXssjfLhLBrz6pIzC45A7sJWBlOAJG5mBikgaXZ+lA9V6gYgWLqoXG
	HDRXAQN9WjyjIVBz+8jYBMsu18KOLNA2cobO7lu6nsQNODwnXHCuNzw3xoJQa0vdrpMzUTK4hOt
	CH0ycqFqBmC5HojStdtkdm6YDyex8a2QdTLM7rukb/+fs43pQrcqKDDIqvMJ/lfpB/EJYiGg+RZ
	dyVA==
X-Google-Smtp-Source: AGHT+IEEDKJm+l79Dx5z529UddvGnLjKvYxEwgpaywZhanewYGh2aS0aUs91oxzAAMjw0E1QYschiA==
X-Received: by 2002:ac8:594a:0:b0:4b0:7435:4243 with SMTP id d75a77b69052e-4b10ab02801mr62861771cf.49.1755212099684;
        Thu, 14 Aug 2025 15:54:59 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4b11aa11d85sm2325431cf.35.2025.08.14.15.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 15:54:58 -0700 (PDT)
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
Subject: [PATCH v3 30/34] lockdown: move initcalls to the LSM framework
Date: Thu, 14 Aug 2025 18:50:39 -0400
Message-ID: <20250814225159.275901-66-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814225159.275901-36-paul@paul-moore.com>
References: <20250814225159.275901-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=825; i=paul@paul-moore.com; h=from:subject; bh=URVWxfK85fttW3+Th+J6RoO8v/wxk5dtKWR/04cDVZ4=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBonmjuthZ1t1lTxmuY+UtzM+a7e6/s2EZ6P5DW0 Or7Vw5YKZ2JAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaJ5o7gAKCRDqIPLalzeJ c5fpEADDTwwkicUA6WRpdxsVirRfXxD6DnrC4rPBYSNiF2GMMN8k+zQOa4fetmFb3trSpXcJI0K z0UtocoE7nNyfqat072Ynfy9vQUz4kkMouvklXBUcJhVIXmmBP7q5+9i2zsLV9TBFdcpUsWkk31 D6MjthQPLEKfch0QlXHiWohjzWqu8o8oQ7QMqVHoLvXrEDeiHimACEoQQNMkZQ3O4M5gmeeJOnB uL1BVA4VqcB8HQZCqHjOt0QJCTmLuhZiuSHz5ytlHgkTF4CddZXRE4LDc2oG4vBGIZNuIATfVNP S/vVIlbm8qX49wYD7hocVRgmKSgWjvSa4RTbm5NZYl3f9o+21QUClU+pFMMP7mYE6vhG/E0tTU3 NHt07Q30kQJQh1mKxHy80g/acZzX6aZ3hMFqnoRZDZXSfbbkLylqPeouvDyi+2bQrUW5QlsIj83 UIl7O7adtvjLvTXBeM6WRTMF0z2wTGt6Xdba6ZT07PUEy8GNP1CvAlStz7QjAJynILqvjcuJeUW FEKdx14QdCPieNAuxOBN3VcjarXqGhe3Pc5pjNGabWCdQdcGRM03RO+2l9GkvIcOm8QzgEm0hBo jUNF+yzJAtbel0vjD46jenD8akmIhs+txWQ4mJGW1LYozW9xTC+WS2cx04DMg6xZKhdRDq2WFS7 Fi9SVYD4IrJoxVQ==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Reviewed-by: Kees Cook <kees@kernel.org>
Acked-by: Xiu Jianfeng <xiujianfeng@huawei.com>
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
2.50.1

