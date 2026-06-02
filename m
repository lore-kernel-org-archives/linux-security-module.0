Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B917B3DB65D;
	Tue,  2 Jun 2026 11:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780398965; cv=none; b=PxscAtrVFZjA7JOwYatgiI3oCNwlNN5OHYsSVMe7wkznQtMCkoEarPoS3b8TeKWeRLipA1WsVouQrZPxtofsJfZfFD+DZnlzd1LixUTQoRnf5CFtChytZ/vW+Wrfad4HqJB+pkrHsj9tUXoH3eyQMRhfd7MYdPup4U5JoD5xz7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780398965; c=relaxed/simple;
	bh=CY1g+HWSJ1CC4crle0RIsA1WpKR7Aicyhf4LN+xBXbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m4BM84/kAjrK7O00E3tzfIE6hUUQoSMZN1cwaxJlxMSZcCOT+E9PNI3hm7kszTJ0Kak5GUlNnu31OiWKqEvGZe8Xu1R5lrrUMoDiRVvHiSx4nJMOeFjtA9chZSN59+W4EgnQScBNYla6PnUtmjNOWMBHgW0QaqDXZGoB09dz2ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.235])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTPS id 4gV7RT0Z5HzpTJ7;
	Tue,  2 Jun 2026 19:10:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id D318D4056C;
	Tue,  2 Jun 2026 19:15:56 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwA3o84fux5qKBozAA--.30704S10;
	Tue, 02 Jun 2026 12:15:56 +0100 (CET)
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
Subject: [PATCH v6 08/12] ima: Introduce ima_dump_measurement()
Date: Tue,  2 Jun 2026 13:13:57 +0200
Message-ID: <20260602111401.1706052-9-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260602111401.1706052-1-roberto.sassu@huaweicloud.com>
References: <20260602111401.1706052-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwA3o84fux5qKBozAA--.30704S10
X-Coremail-Antispam: 1UD129KBjvJXoW7CFyfXrW5CFy7Gw13Aw43Jrb_yoW8Aw4Dpa
	9IgFy8Cry8JFyxKrn3GF98Ja1F93y8AF1DW3yDWwn3XF1DJr1q9rn3Cr1Ivr98KrZIyF1x
	twsIgF4ru3Z0yaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPlb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrV
	C2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
	7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262
	kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s02
	6c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GF
	v_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvE
	c7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aV
	AFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZF
	pf9x07UZTmfUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAMBGoeRrcEpgAAst

From: Roberto Sassu <roberto.sassu@huawei.com>

Introduce ima_dump_measurement() to simplify the code of
ima_dump_measurement_list() and to avoid repeating the
ima_dump_measurement() code block if iteration occurs on multiple lists.

No functional change: only code moved to a separate function.

Link: https://github.com/linux-integrity/linux/issues/1
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
 security/integrity/ima/ima_kexec.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 8dc9459622b3..26d41974429e 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -80,6 +80,17 @@ static int ima_alloc_kexec_file_buf(size_t segment_size)
 	return 0;
 }
 
+static int ima_dump_measurement(struct ima_kexec_hdr *khdr,
+				struct ima_queue_entry *qe)
+{
+	if (ima_kexec_file.count >= ima_kexec_file.size)
+		return -EINVAL;
+
+	khdr->count++;
+	ima_measurements_show(&ima_kexec_file, qe);
+	return 0;
+}
+
 static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
 				     unsigned long segment_size)
 {
@@ -97,13 +108,9 @@ static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
 	khdr.version = 1;
 	/* This is an append-only list, no need to hold the RCU read lock */
 	list_for_each_entry_rcu(qe, &ima_measurements, later, true) {
-		if (ima_kexec_file.count < ima_kexec_file.size) {
-			khdr.count++;
-			ima_measurements_show(&ima_kexec_file, qe);
-		} else {
-			ret = -EINVAL;
+		ret = ima_dump_measurement(&khdr, qe);
+		if (ret < 0)
 			break;
-		}
 	}
 
 	/*
-- 
2.43.0

