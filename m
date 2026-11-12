Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=14.137.139.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794493885;
	b=Aae3wsEGymBgtk7iC3gK2PonK9LV3A3VbM4jTjaYSlmaq7FljeXOZBmgpaImNPnBN/ub
	 21k4bgKb61JkWj4KmIe+OQnSE6a8b7ff//p60IvKMh4E9I7H7Q2YFgG47GEn0cBFI18Cv
	 A7UHQE7+DGJo5YNWS9UWqdbAaX5SQiwnZr1QwdUb2ixQ6QBBPC2m1UpizYCZaGOehNHXH
	 uaKZIOVELj//mTSIpVMJoOfwuZIDLUOr5Mq8jMoRNjuJ2244vsTiZRI0PEqKY3vjhNrJC
	 41RbiC56FaSrlJ4CXLGEq6wk5WRQacyGiWIpDYdPAu6nk0af1DX671HL8jfo2/NkEYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493885;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=vlI/E+9ZqMQyue2QpJ08GrGohLxg/G6tTl/Pq3uCBfU=;
	b=bEvzS0E9QSTiPZ7xCCQcYYuAKFK6ZS7Gd9RXWZLZyHngoqyjM8tfLo9MH9Ui/BnxkFYf
	 vuKqX/ZfC4mDRR6dAWIKwrTO1c/bDerQ27PD99VbzSgZF1buBGuRsgjeyfqUEnWjNIZo7
	 dnI76FP2twJs8Y5emFOZHw0SkACeIm/Mr+g/tddUz1+WNpv4pCjOXWAR3imxeNConTZdT
	 7YdzQFGakVa1+vPUNiYSBA6pGQa0IOyPssHXcMGBqfZNNXbQCdejdqaCBoWCng0VuYkic
	 ss7LlUVB8DRZwM7g4nzPxRZ0trao+u+wuH+Wygv5YuEaocdHudM9hWbthRpd2pfiVlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=14.137.139.46
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C7D606D544;
	Thu, 12 Nov 2026 14:31:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09C7D606D544
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.196])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTPS id 4jQN930MsLzpV6n;
	Thu, 12 Nov 2026 22:30:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.157])
	by mail.maildlp.com (Postfix) with ESMTP id 17FFC40009;
	Thu, 12 Nov 2026 22:31:14 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by dep2_app1 (Coremail) with UTF8SMTPA id nRC2B0Cmh12pzfVqvJwRAA--.7096S2;
	Thu, 12 Nov 2026 15:31:13 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	fabrice.derepas@canonical.com
Cc: linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH] ima: Fix out-of-bounds read in ima_read_policy()
Date: Thu, 12 Nov 2026 15:30:29 +0100
Message-ID: <20261112143029.4159022-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2e59cc97ad2e6fe5b9b5a5b5988668da29155703.camel@huaweicloud.com>
References: <2e59cc97ad2e6fe5b9b5a5b5988668da29155703.camel@huaweicloud.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:nRC2B0Cmh12pzfVqvJwRAA--.7096S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXrW7XryDArWrtw4xJrW7twb_yoW5Xr4kpa
	98Ka45AryDWry7Crs3CasxXa4Fka93JFWUWayrW3W0vF45ZrnI9w18tFyFgF1Fyr40yryI
	qrs0gryYk3WqyFJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	xU4NB_UUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQABDWr1L0x2ZgACsj

From: Roberto Sassu <roberto.sassu@huawei.com>

ima_read_policy() reads the policy file with kernel_read_file_from_path()
and splits it into rules with strsep(). However, the buffer allocated by
kernel_read_file_from_path() is exactly the size of the file and is not
NUL-terminated. If the policy file does not end with a newline, strsep()
scans past the end of the buffer while looking for the next separator. If
the file size is a multiple of PAGE_SIZE, the scan reaches the vmalloc
guard page and the kernel oopses.

If the last byte of the policy is not a newline, parse a NUL-terminated
copy of the buffer obtained with kmemdup_nul() instead, and account for
the NUL terminator in the remaining size, since ima_parse_add_rule()
counts it in the length of the last rule.

As a side effect, a policy whose last rule is not followed by a newline
is now loaded, instead of being rejected with -EINVAL due to the
terminator being counted in the length of the last rule but not in the
file size.

Fixes: 7429b092811f ("ima: load policy using path")
Reported-by: Fabrice Derepas <fabrice.derepas@canonical.com>
Closes: https://lore.kernel.org/linux-integrity/20260814085443.1211989-1-fabrice.derepas@canonical.com/
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima_fs.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 2a0bca554316..6d5e061f88c2 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -528,7 +528,7 @@ static const struct file_operations ima_ascii_measurements_staged_ops = {
 static ssize_t ima_read_policy(char *path)
 {
 	void *data = NULL;
-	char *datap;
+	char *datap, *buf = NULL;
 	size_t size;
 	int rc, pathlen = strlen(path);
 
@@ -548,6 +548,23 @@ static ssize_t ima_read_policy(char *path)
 	rc = 0;
 
 	datap = data;
+
+	/*
+	 * kernel_read_file_from_path() does not NUL-terminate the buffer.
+	 * If the policy does not end with a newline, parse a NUL-terminated
+	 * copy, so that strsep() does not scan past the end of the buffer.
+	 */
+	if (size && datap[size - 1] != '\n') {
+		buf = kmemdup_nul(data, size, GFP_KERNEL);
+		if (!buf) {
+			vfree(data);
+			return -ENOMEM;
+		}
+		datap = buf;
+		/* Count the NUL terminator, included in ima_parse_add_rule(). */
+		size++;
+	}
+
 	while (size > 0 && (p = strsep(&datap, "\n"))) {
 		pr_debug("rule: %s\n", p);
 		rc = ima_parse_add_rule(p);
@@ -557,6 +574,7 @@ static ssize_t ima_read_policy(char *path)
 	}
 
 	vfree(data);
+	kfree(buf);
 	if (rc < 0)
 		return rc;
 	else if (size)
-- 
2.43.0

