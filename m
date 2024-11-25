Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22791925A6;
	Mon, 25 Nov 2024 10:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732531238; cv=none; b=IZltobQdi+K5XmRfwLxjLYcQhPFxZy2nMzwVYnD9BBNalJrEiEirfU5mXMUeekvwBRx40a/KR+M0SuXEnw8IZ2XDHouhz2RWLpZNAUP4jV148blNxC+MdBZUbdTQILTbivvMAIOHsCPI7Ag1tgXpCWkml8TOoz9DdRP9F7BhTQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732531238; c=relaxed/simple;
	bh=OINYhmpNgcEI4tTl8Cjxh0NZwDWWt5w395EWwdrZTOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FBQSNiIa+pXj4xkjAcgYnHw1lIsHrmSHgg6sw1s7OSJGiwlkV/FSVVKwuqkppRTVrwVlArjuYaFgmLiN6/XC4ilTg2LCq8CtpnWwioI79zMcBNbkMaEWKN3ncCqcL2E2ZBOvcnaXb/xsaooKuPnl1rPkYBzqqe9uW57dOvlECg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=fj/rRme9; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="fj/rRme9"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1732531226;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P6AGqeaWbUDe9y5vDnfY9zmRKUFqqfOHVoZc9OQ1JdE=;
	b=fj/rRme9yehwZA25c2Ni1/9tPmwADULk1KpFn/cVxyAjjBhxyj8Rg7aA5iUrANhXFj3LDF
	EVEGpnqH2qxuU7xy7zbZVAr4PN6VXR1u6SaguSc7GBpAUwBFP2HQJcV/7rETu2atweRoUA
	DK3HuU8potvt0ji3IF7E3NaCAPi/OzmAMILLwPVEudy8K/V1Sdv63rqOny0qQy7l6LvQi7
	Qnx0BqyipTaX8aKvcgEzC2iX2EuYf59bvAQ8Qid3xQZb/Mswa40vldOlKBAAKO8BzLXU81
	uOeCjHBIVLuJs5xjOP6IrtRBAxUkLS0+WGDcxbdL3NWIKBOcibJLOqsDLIBdFg==
To: linux-security-module@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Frank Haverkamp <haver@linux.ibm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Serge Hallyn <serge@hallyn.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	linux-kernel@vger.kernel.org,
	cocci@inria.fr
Subject: [PATCH 05/11] genwqe: reorder capability check last
Date: Mon, 25 Nov 2024 11:39:57 +0100
Message-ID: <20241125104011.36552-4-cgoettsche@seltendoof.de>
In-Reply-To: <20241125104011.36552-1-cgoettsche@seltendoof.de>
References: <20241125104011.36552-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

capable() calls refer to enabled LSMs whether to permit or deny the
request.  This is relevant in connection with SELinux, where a
capability check results in a policy decision and by default a denial
message on insufficient permission is issued.
It can lead to three undesired cases:
  1. A denial message is generated, even in case the operation was an
     unprivileged one and thus the syscall succeeded, creating noise.
  2. To avoid the noise from 1. the policy writer adds a rule to ignore
     those denial messages, hiding future syscalls, where the task
     performs an actual privileged operation, leading to hidden limited
     functionality of that task.
  3. To avoid the noise from 1. the policy writer adds a rule to permit
     the task the requested capability, while it does not need it,
     violating the principle of least privilege.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 drivers/misc/genwqe/card_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/genwqe/card_dev.c b/drivers/misc/genwqe/card_dev.c
index 4441aca2280a..77b2d191d21c 100644
--- a/drivers/misc/genwqe/card_dev.c
+++ b/drivers/misc/genwqe/card_dev.c
@@ -461,7 +461,7 @@ static int genwqe_mmap(struct file *filp, struct vm_area_struct *vma)
 		goto free_dma_map;
 	}
 
-	if (capable(CAP_SYS_ADMIN) && (vsize > sizeof(dma_addr_t)))
+	if ((vsize > sizeof(dma_addr_t)) && capable(CAP_SYS_ADMIN))
 		*(dma_addr_t *)dma_map->k_vaddr = dma_map->dma_addr;
 
 	pfn = virt_to_phys(dma_map->k_vaddr) >> PAGE_SHIFT;
-- 
2.45.2

