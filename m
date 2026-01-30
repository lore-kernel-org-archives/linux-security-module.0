Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A9038A9AD
	for <linux-security-module@vger.kernel.org>; Fri, 30 Jan 2026 22:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769812804; cv=none; b=uXiFJU0vEw8CB08+DnP5F9CA2r2lyMYUaMK7Q3k3/cnFJmaPdpGiolJhWKFN8xgbT5scYZMQZsXj4Q9AaX35PKVZez+V0eMgHhrQgrEgi+cn/ZxKWusoVU+BFHZzoYPYU4ekC7oMmCA0CmKKj4q+7K9KKmevFeGXdgjwsY4jTgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769812804; c=relaxed/simple;
	bh=E44D0I52YoGh+U5fwPkQ5hEITkBV+sZorQSKCWfktmc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=np4xJWzczNnHEgDk0z2GB6I4J3/2z7JchU1v/W+cpY4LO04z1N7P7EzjucVeQFoF2/NFzTFzM6N0K/lKtQ9JjO/yeCpHZwQGunupul/QfThHox2Z3pfx8oDg4sCRYWsnbUqdT7kobmWPP3cIc46d9Cd1x/M48pflRdlAOwseZ18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=YOYIrEYL; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="YOYIrEYL"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-45c715116dbso1832472b6e.3
        for <linux-security-module@vger.kernel.org>; Fri, 30 Jan 2026 14:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1769812800; x=1770417600; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B8RijGQOfqPIwUgELzLaWOi9LUBjEfJ1NBk4LJfVwV0=;
        b=YOYIrEYLSK+OwBtj0/SiziEZrvSggpPapTl/A8IcZiuCMzAzbck2AezXIrkI6FZBni
         ElhmNNdFgJoQlhbbQvakPZrGqbswkRRZgmj/kX2P8CwxPIjTQ1jMldHGbOYmTjFGB4Oo
         4B6QOuRWPZuEYSOsOCG5VrSfMqk3uieU1I22eedsFsqEPGkMPAaZ6oSwqWxMllmD1s/z
         89SFm2uZZzjfbG94BsyqfCuMmNvUnvFxEOYD4qUciUSbKf8v810yYVkxzkUUi/QMd/5L
         qaT0SePIda0ReozNvrgksypvVBDbZdgr8dKrOhvs6knDvxmqcjQGVgNFdbz363CsyFfE
         LItA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769812800; x=1770417600;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=B8RijGQOfqPIwUgELzLaWOi9LUBjEfJ1NBk4LJfVwV0=;
        b=kSyrw7GrhjXBMa1/NjY0tv6/U8TMTboPvHKGY5iLo4hBYZ8LLrX29n5i8vZXL5/1LW
         guiUrrt0447Uoffv0gX53Yxvxd6qhCFb2uRn0b+3RdcvriTtWFgb/s7nnIZdvQ57kKMb
         JCu1KwHgGEdBRqwZfYVSqWAhOv5QBpey8hZy9d+1FuadvKCN0FjTXKCVst3Kuwfdq+2u
         Gl4Xb7vqno4ROnXdUD64NLv5+T+9RYTK5tDt4aHWPu7LfFRa3gWB0UlbnNBaDDwt9RzY
         4FOtsLIX2TzXOpuNrwwTu60F++khZ7DRkR//g/mpY9SH6DzNApzK7AfkkI/qeVmkHg1w
         CvVw==
X-Forwarded-Encrypted: i=1; AJvYcCWyTQK5zNX5DUXrbLJnSn+8cCBVjJzYXvNqa0l0cw22S8YQqIibl67ybd+DmeKb+05jdCH7D9AL5qBd2j0AJTkhhVWcNJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH4sgZurheEdGoIMO+U0b8LjdQxH1p4uGL/M5lDwyN3wzO5mij
	Bw3hAAs3dqovxi0a/ri7iaQJqVTkLisuDaOPz/V1p4BSJoqUCUe65zOIF5DBsVidhno=
X-Gm-Gg: AZuq6aLkfybSIJqZwDmILVaozY6HploRVbbxRhucx0aJybBWXmf8yjZH8MsoabshJ0U
	1OPtWZ46jnOXlCDfPjVEuMVbKoiu5M+pKVO1MPYP2n1e6N8hURUwExwMDYcacxEXTDRHVe1ZvwX
	xd+Ur1Ti/LcBIKOvO0tUWtNJ/nFTIpw4/udfqC28FGOPDhNAVWqHs3lL3fx9tD/lSRiVCNhQnhg
	IvM8xrnYQZ2G0wKzxlFFuIyZB6ankO8LrktDV6cQmMFsO4gkHzLIKpUiZN3DO6pXoUf7u64L2C5
	jHWsQlkl/4fG/IaOyhe0Mcu69ibSDjI7lkG3/HZHA5kYJNsjB77M/xC0oskh64DeE8Df6g4Ya6R
	k8fh/U8w73ki4Ycsnwk1z0yt1OpcocrxB91epiSFpBIienSAy2zL00+Qjk42NHhBIxEQCN0s=
X-Received: by 2002:a05:6808:11c5:b0:45e:d128:4d13 with SMTP id 5614622812f47-45f34d19956mr2522871b6e.49.1769812800117;
        Fri, 30 Jan 2026 14:40:00 -0800 (PST)
Received: from [127.0.1.1] ([2a09:bac5:947d:4e6::7d:80])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45f08f20e38sm5400250b6e.10.2026.01.30.14.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 14:39:59 -0800 (PST)
From: Frederick Lawler <fred@cloudflare.com>
Date: Fri, 30 Jan 2026 16:39:54 -0600
Subject: [PATCH v5 1/3] ima: Unify vfs_getattr_nosec() stat comparisons
 under helper function
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260130-xfs-ima-fixup-v5-1-57e84ea91712@cloudflare.com>
References: <20260130-xfs-ima-fixup-v5-0-57e84ea91712@cloudflare.com>
In-Reply-To: <20260130-xfs-ima-fixup-v5-0-57e84ea91712@cloudflare.com>
To: Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, 
 linux-security-module@vger.kernel.org, kernel-team@cloudflare.com, 
 Frederick Lawler <fred@cloudflare.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1964; i=fred@cloudflare.com;
 h=from:subject:message-id; bh=E44D0I52YoGh+U5fwPkQ5hEITkBV+sZorQSKCWfktmc=;
 b=owEBbQKS/ZANAwAKAasltHYDktNtAcsmYgBpfTM8lcduKiPT2v6M91vJwSr90uuaDvHoZheB/
 F9zKNZBePSJAjMEAAEKAB0WIQTLNBqMVmu1PHvjOe2rJbR2A5LTbQUCaX0zPAAKCRCrJbR2A5LT
 bSSED/sEVZhlYPnUNKkoKX0RoLgIVqQ1qaf8NUtXQvOWWKw3yRufG8Z20gSOt4Xhmuw7C2alPNL
 8LL5hiT5WrMjuOL/PPX9AXqaBDEpCLhUbPQoR5g3ar7lBvOnEMBdKO1tUgqE1HpTcBwT52wkgl5
 9Yt/I3KjWimJf50jNOhlS10Bb4a+UoIbTPTfRPuJ6mTZwi9ov7IQL2cCzdbf8RURF9OGyyzTjX1
 V/UEI8hRwljjwU3c2LVKhsy1NSrSrp23skSVtGe+M5+j2ZB2B8WKAT8SGNErBHbZJ84r4Ocv8KM
 3XKaIl1iQPA7ZZgQDWovxs4FYKAiaNT0mKCcgLCyzh3kzg/Vq1VvnsZpeD9VeUGjv6/25Mr2/U7
 CZmohozREPihYLOHpFLXB7u+dG8/E8io5+G5L0QMug943Yx+V44L0SZBk7z1iQXILscb5uM/EJf
 wqOTQBOHmmWCvT5Q0JDsX2CRPnojAl8evdpQguUM7jXZWWFXqEML0j3iVuIfhbF2LxqrWfkXjtj
 NO1oHSoGBCBMjiGqE/mW0NdZ4SRf//jyH80O8phnCO9SK192ynXXiHqufKIEPqvTunKPjPa+Va0
 MkR4lwI1FM2+fk0lRExqD4H/pudElvIJBnUswN6ARQdZpBwXbvJy1xlZYUfcGUFWcNEgzdWQr8Z
 2c14LUU0n1dZppA==
X-Developer-Key: i=fred@cloudflare.com; a=openpgp;
 fpr=CB341A8C566BB53C7BE339EDAB25B4760392D36D

The logic for comparing kstat.change_cookie against IMA version is
hard to read. Abstract comparison logic into a new function
integrity_inode_attrs_stat_changed().

No functional change intended.

Signed-off-by: Frederick Lawler <fred@cloudflare.com>
---
 include/linux/integrity.h         | 11 +++++++++++
 security/integrity/ima/ima_main.c |  4 ++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/linux/integrity.h b/include/linux/integrity.h
index f5842372359be5341b6870a43b92e695e8fc78af..beb9ab19fa6257e79266b58bcb5f55b0c5445828 100644
--- a/include/linux/integrity.h
+++ b/include/linux/integrity.h
@@ -49,6 +49,17 @@ integrity_inode_attrs_store(struct integrity_inode_attributes *attrs,
 	attrs->ino = inode->i_ino;
 }
 
+/* Compares stat attributes for change detection. */
+static inline bool
+integrity_inode_attrs_stat_changed
+(const struct integrity_inode_attributes *attrs, const struct kstat *stat)
+{
+	if (stat->result_mask & STATX_CHANGE_COOKIE)
+		return stat->change_cookie != attrs->version;
+
+	return true;
+}
+
 /*
  * On stacked filesystems detect whether the inode or its content has changed.
  */
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 5770cf691912aa912fc65280c59f5baac35dd725..6570ad10887b9ea1172c78274cf62482350e87ff 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -201,8 +201,8 @@ static void ima_check_last_writer(struct ima_iint_cache *iint,
 		    vfs_getattr_nosec(&file->f_path, &stat,
 				      STATX_CHANGE_COOKIE,
 				      AT_STATX_SYNC_AS_STAT) ||
-		    !(stat.result_mask & STATX_CHANGE_COOKIE) ||
-		    stat.change_cookie != iint->real_inode.version) {
+		    integrity_inode_attrs_stat_changed(&iint->real_inode,
+						       &stat)) {
 			iint->flags &= ~(IMA_DONE_MASK | IMA_NEW_FILE);
 			iint->measured_pcrs = 0;
 			if (update)

-- 
2.43.0

