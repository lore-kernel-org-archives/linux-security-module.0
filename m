Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4101FBEA2
	for <linux-security-module@vger.kernel.org>; Fri,  6 Dec 2024 11:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733485323; cv=none; b=nP/JChkiKrs3twGB5aQv5qIeUoJ35rh+en1OArCubpcZufDzK0ZKqVV9UPKwhHsDlwL+7Ykvaw6dYMgyS7DzRXBaV1C75h+19hu3tg+m5xn4q10ZJnrYwouoLwpiZWpomfZDVmN5VGhNDIbXlr+m83wcuHLbWNTJkGchyP6DWe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733485323; c=relaxed/simple;
	bh=PzHcvH2V5dGKwcgDVsjspgeBcICqxUtmPek7gx4K/hU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jh85picninPbFqtlnNHRhI3B9gvh3DQwKRx8SFpo8AZC2j0SWnZ3Ht2MANU3bsHPFg/Md/ObvEERfLD3LdJTc9bEyFSq5AnDyKk2V7Jy95S5b1DyHIPI/Q4ImjK11n3lI0qgCG9SQFWmltRFEky9QLs71bID22cpo9PrIOFnaj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=KfYjIUuw; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="KfYjIUuw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=TJOYJ
	7UIGW4QayZIaYv7pbzV7gX+FikENzBjvOV8tNA=; b=KfYjIUuwuG1rKIa6NT/Ue
	hG+ulyBNO03i+iDHRg1boHkhCaZyHJzl0RZPe6sMAdhQrhS+sFi3bCIhS9a92Ubh
	9Onzn/2ryLmJfA12C3CP6/MWCN6Pk1UVvjBsvmdt/yvEPbb3MMzaSrKZQ/OPU78o
	kIRchjCcO5JHZ+4woq85lM=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDnTz7L4lJnUPZfAA--.13083S2;
	Fri, 06 Dec 2024 19:41:01 +0800 (CST)
From: 15074444048@163.com
To: paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	linux-security-module@vger.kernel.org
Cc: 15074444048@163.com,
	lihaojie <lihaojie@kylinos.cn>
Subject: [PATCH] lsm: add reserved flag in lsm_prop struct
Date: Fri,  6 Dec 2024 19:41:08 +0800
Message-Id: <20241206114108.342819-1-15074444048@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <aef181673159ac72f1e7922548186fc6@paul-moore.com>
References: <aef181673159ac72f1e7922548186fc6@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnTz7L4lJnUPZfAA--.13083S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJr4UWF15Cry7uF1xAw4xJFb_yoW8Wr4rpF
	4DC3yxGr4DAFWDW3ykuF13G3ySq34kWw42qFyI9w40yr9rtryIvrZ3Cay2ka4YyFs5C398
	Aa1qg3yvyF1DuaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uco7_UUUUU=
X-CM-SenderInfo: rprvilauuukiiuy6il2tof0z/1tbiOR2tUGdS23W5GQAAsi

From: lihaojie <lihaojie@kylinos.cn>

lsm_prop size is controled by macro, lsm_prop size will be 0
when marco don't define. add flag to alloc sm_prop basic size.

empty struct will make target_ref & target_comm in audit_context
located at the same address, __member_size of target_comm is
same as __member_size of target_ref, so strscpy warn buffer
overflow when compile time.

Signed-off-by: lihaojie <lihaojie@kylinos.cn>
---
 include/linux/security.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index cbdba435b798..f502deecb142 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -164,6 +164,7 @@ struct lsm_prop {
 	struct lsm_prop_smack smack;
 	struct lsm_prop_apparmor apparmor;
 	struct lsm_prop_bpf bpf;
+	u8 reserved;
 };
 
 extern const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1];
-- 
2.25.1

Hi paul


The root cause is that target_ref is empty, that make __member_size of target_comm will 
return target_ref size, because they have same address, so, overflow will be detected.
as you said, I should not change member size, there may be other potential hazards.

so i add patch v3, please check above. 

I have been test local.
-gcc will alloc empty struct 0 byte. __member_size of member behind empty struct will return 0 byte;

-g++ will alloc empty struct 1 byte. __member_size of member behind empty struct will return normal bytes; 

-pahole result
        struct lsm_prop            target_ref;           /*   812     1 */
        char                       target_comm[16];      /*   813    16 */


thanks
lihaojie

