Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1101E9B36;
	Sun,  2 Mar 2025 16:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740931630; cv=none; b=aVO2YBkNHgXFTDWKw/DlF9h1ndWhw9oVr6swwKhQPB0fCtMxs0yWI6gVeXSOCOG56H1TkkQFBxyAtSuhb1cGYUTYXWUctVwIeD5ZrLCEsKGvffpvtF3cuyGB5mwcmiWxnkqPltkdLB4FTzDo1V7InprLnVaMwJNtiaNDe9PtIsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740931630; c=relaxed/simple;
	bh=W6Ib8SUnJ1JU0HiaqnjJwSX+UKJG2AFtodiU7/gTTFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ekwFxYQXKWE2zKt3ly3ofRWW1/LznRNNfp4F/RUY7UGRwmnCQfbuW04KPq/gGNtpmbyPWxN9k3XnRZjqp5kupwfrocbp1L39PmWkST4qyDvFyBZZcF9C6kXmo7drMqg/6kc9XdbyqKRJG/oIjCNlJ23TCR/MocYsyw/sjWR5N+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=pNCwjOEA; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="pNCwjOEA"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1740931626;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XAjxnHbZt7O2sowQljNKhNG6jmP0PgDVtJXqvuqsprc=;
	b=pNCwjOEAHKlzf0wE7LNZ87/QTHMW/pzQfLR1ATk2Ir4ezHhvcADFFZmbdNhV22pWG8HcCD
	UIAFzWvW6DIsCoOJwqRdJqoRALQz/oK7FqTQ6CdEk66UJOSU9wGQsq2k3QRI2b4wiWlu55
	GFSk8k+/WGXnC/W7V9dk0Rd2SyJ7OzobelL8Ji4fIrW3inxWGmd6FFLzjXe919hLwq1Ew3
	4mEuWbkAZEHR0Qv4Uau5S7L3j2BDRtDKnqxdlalvkAn1m5b0W/fLyfrN+bIqPK0Ak8owJ4
	eQ6R+8OH5yX0cUFj2+Q8VLilquxrIiyYKu/4dnHoZp9pPXT2kSnEhyaUn+Tw5Q==
To: 
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Serge Hallyn <serge@hallyn.com>,
	Jan Kara <jack@suse.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	cocci@inria.fr,
	Frank Haverkamp <haver@linux.ibm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 05/11] genwqe: reorder capability check last
Date: Sun,  2 Mar 2025 17:06:41 +0100
Message-ID: <20250302160657.127253-4-cgoettsche@seltendoof.de>
In-Reply-To: <20250302160657.127253-1-cgoettsche@seltendoof.de>
References: <20250302160657.127253-1-cgoettsche@seltendoof.de>
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
Reviewed-by: Serge Hallyn <serge@hallyn.com>
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
2.47.2

