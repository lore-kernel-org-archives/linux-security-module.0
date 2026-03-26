Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D1C428473;
	Thu, 26 Mar 2026 17:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774546309; cv=none; b=E0y0rOK5kqDsHQ9ZGqkFqeYLfzxufG39w8BADZmqxdlA37XGZlm7BOWOz7umZJ11nMv4HHUqyf5AwawIYQxZb+LzTRGChhUWrMlZtaPHcWOaZHBYple0+pvc0ZaH2s/XEbdJxNUgJmHmPFBEoVEG3F3cxdZAitu3cp1z3J0M1M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774546309; c=relaxed/simple;
	bh=XrG5Rzjw97/k4hs9NuHnDSP9PLebkbtARyW+dgXrZZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nRWCul4ptqDeLbqhsuJp95+LVPKuegRhKh0h8jVOglYm/OSkOollDfZXRFwh0QWt6DePa+la2wx0VdllIYA/WzyLBF7aE1HNONAWRe9V5yA3rwL9sKLp+VdXEZerDnC/V42hruEnb8FGyvXQUeC67KRreZiGEkKkh/rK2l6O/s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.235])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTPS id 4fhW202NKkzpW04;
	Fri, 27 Mar 2026 01:27:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 8F18A40560;
	Fri, 27 Mar 2026 01:31:40 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwB3Yu84bcVppGUvAQ--.1881S9;
	Thu, 26 Mar 2026 18:31:40 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: corbet@lwn.net,
	skhan@linuxfoundation.org,
	zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	gregorylumen@linux.microsoft.com,
	chenste@linux.microsoft.com,
	nramas@linux.microsoft.com,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v4 07/13] ima: Use snprintf() in create_securityfs_measurement_lists
Date: Thu, 26 Mar 2026 18:30:05 +0100
Message-ID: <20260326173011.1191815-8-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260326173011.1191815-1-roberto.sassu@huaweicloud.com>
References: <20260326173011.1191815-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwB3Yu84bcVppGUvAQ--.1881S9
X-Coremail-Antispam: 1UD129KBjvJXoW7tFy5XFWDWw1rtF1kWr4rXwb_yoW8tF48pa
	ySgF18Crs5J3yxKFn3K3Z7uaySk3yagF1UW3yvg3WkAFn3XrWFkr4vkr1jkr95Kr10yFy8
	XrsFqF13C3Z0yaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPlb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrV
	C2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
	7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262
	kKe7AKxVWrXVW3AwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s02
	6c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GF
	v_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvE
	c7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aV
	AFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZF
	pf9x07jhXo7UUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAEBGnEnS4T6QAAsm

From: Roberto Sassu <roberto.sassu@huawei.com>

Use the more secure snprintf() function (accepting the buffer size) in
create_securityfs_measurement_lists().

No functional change: sprintf() and snprintf() have the same behavior.

Link: https://github.com/linux-integrity/linux/issues/1
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima_fs.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 68edea7139d5..7709a4576322 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -472,11 +472,13 @@ static int __init create_securityfs_measurement_lists(void)
 		struct dentry *dentry;
 
 		if (algo == HASH_ALGO__LAST)
-			sprintf(file_name, "ascii_runtime_measurements_tpm_alg_%x",
-				ima_tpm_chip->allocated_banks[i].alg_id);
+			snprintf(file_name, sizeof(file_name),
+				 "ascii_runtime_measurements_tpm_alg_%x",
+				 ima_tpm_chip->allocated_banks[i].alg_id);
 		else
-			sprintf(file_name, "ascii_runtime_measurements_%s",
-				hash_algo_name[algo]);
+			snprintf(file_name, sizeof(file_name),
+				 "ascii_runtime_measurements_%s",
+				 hash_algo_name[algo]);
 		dentry = securityfs_create_file(file_name, S_IRUSR | S_IRGRP,
 						ima_dir, (void *)(uintptr_t)i,
 						&ima_ascii_measurements_ops);
@@ -484,11 +486,13 @@ static int __init create_securityfs_measurement_lists(void)
 			return PTR_ERR(dentry);
 
 		if (algo == HASH_ALGO__LAST)
-			sprintf(file_name, "binary_runtime_measurements_tpm_alg_%x",
-				ima_tpm_chip->allocated_banks[i].alg_id);
+			snprintf(file_name, sizeof(file_name),
+				 "binary_runtime_measurements_tpm_alg_%x",
+				 ima_tpm_chip->allocated_banks[i].alg_id);
 		else
-			sprintf(file_name, "binary_runtime_measurements_%s",
-				hash_algo_name[algo]);
+			snprintf(file_name, sizeof(file_name),
+				 "binary_runtime_measurements_%s",
+				 hash_algo_name[algo]);
 		dentry = securityfs_create_file(file_name, S_IRUSR | S_IRGRP,
 						ima_dir, (void *)(uintptr_t)i,
 						&ima_measurements_ops);
-- 
2.43.0

