Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F212F8E80;
	Tue, 26 May 2026 13:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779803961; cv=none; b=PvGkeLKCldqPrYua3D/Z7LCHbDMlFB6g7ZrnWVu4+IsH0QAqtjozPSklAtQmtw3iih1hdI70Sa53ilOn37vqYLlnWYpgFOhQfbnp7yd2FLQqfzdx03W77exK6x4FrykddZFWDl7iOEt9vpMQFu2zRfAl+KEh+x+TPjL2gK7CJS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779803961; c=relaxed/simple;
	bh=RnN0j7pi3mmQyWPIBquEzKiilJBUPPQC8QFkR638DCo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EeYr8dVqFtj817N/8hVvRYNE1OxQbTe+l7XIO8mNrOASphcS6VjVwoISupTnVrhUHkSM2uHWuto11+cYu11+7nCBgUopcjXrazTPT7ai3DwQXu3/xUcKVqYQcFVhpy+nU2FqfRVayajgF7tLkIGCZwC1a/0GMT7/wBbl+YI5TW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn; spf=pass smtp.mailfrom=mails.ucas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.ucas.ac.cn
Received: from fric.. (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowABng9ojpxVq0OhwEg--.2821S2;
	Tue, 26 May 2026 21:58:59 +0800 (CST)
From: Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
To: penguin-kernel@i-love.sakura.ne.jp
Cc: jmorris@namei.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	paul@paul-moore.com,
	serge@hallyn.com,
	takedakn@nttdata.co.jp,
	xujiakai24@mails.ucas.ac.cn
Subject: Re: [PATCH] tomoyo: Fix NULL pointer dereference in tomoyo_init_request_info() when domain is NULL
Date: Tue, 26 May 2026 13:58:59 +0000
Message-Id: <20260526135859.3211799-1-xujiakai24@mails.ucas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <814a7f61-67b2-49e9-b5bf-fd049b458079@I-love.SAKURA.ne.jp>
References: <814a7f61-67b2-49e9-b5bf-fd049b458079@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABng9ojpxVq0OhwEg--.2821S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CF4fWw18Kw47tr1UJFW3trb_yoW8Kr43pF
	W3JF1j9r48JF4Sv3yUCw43Wry09ryrGas8G3s8Kws5CFs0grn2gF1agFW5uFn8Ar4ftw12
	yw17Z3ySgFWDJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
	YxC7MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
	cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
	nxnUUI43ZEXa7VUjPEfUUUUUU==
X-CM-SenderInfo: 50xmxthndljko6pdxz3voxutnvoduhdfq/

> Thank you for a patch, but I don't think we need this change.

Thanks for your review! I understand your perspective, but I believe
the crash is a real NULL pointer dereference, and I'd like to explain
why the defensive check is warranted.

> TOMOYO's initial domain is &tomoyo_kernel_domain, and each thread belongs to
> a non-NULL domain. Therefore, tomoyo_domain() is not supposed to return NULL.

While tomoyo_domain() is not supposed to return NULL under normal
operation, there are code paths that leave s->domain_info == NULL:

  a) Pre-init window (security/tomoyo/tomoyo.c, lines 598-612):
     The task security blob is zero-allocated via kzalloc(), and
     security_add_hooks() at line 603 is called BEFORE
     s->domain_info = &tomoyo_kernel_domain at line 606. If any LSM
     hook fires during that window, tomoyo_domain() returns NULL.

  b) tomoyo_task_free() (tomoyo.c, lines 533-545) explicitly sets
     s->domain_info = NULL after decrementing the refcount.

  c) tomoyo_find_next_domain() (domain.c, lines 876-883) writes
     s->domain_info = NULL when the domain transition fails.

> > Found by fuzzing. Here is the report:
> > 
> > Unable to handle kernel paging request at virtual address dfffffff00000003
> 
> Is this a NULL pointer dereference?
> It seems to me that this is just a random memory corruption.

This address is the KASAN shadow byte for memory access at offset 0x18
(24), not a random corrupted value. On RISC-V with sv57 page table,
KASAN_SHADOW_BASE is `0xdfffffff00000000`, and the shadow address is
computed as:

    shadow_addr = (access_addr >> 3) + KASAN_SHADOW_BASE
                = (24 >> 3) + 0xdfffffff00000000
                = 0xdfffffff00000003

In `struct tomoyo_domain_info` (security/tomoyo/common.h, lines
680-693), the layout is:

    offset 0:  struct list_head list;          // 16 bytes
    offset 16: struct list_head acl_info_list; // 16 bytes (next at 16, prev at 24)
    offset 32: domainname;                     // 8 bytes
    ...

Offset 24 from NULL is `domain->acl_info_list.prev`, which is
dereferenced by the `list_for_each_entry_rcu()` loop in
`tomoyo_check_acl()` at security/tomoyo/domain.c:171 when `domain` is
NULL. This is KASAN catching a NULL pointer dereference in action, not
random memory corruption.

I think adding a NULL check makes the code more robust. What do you 
think?

Best regards,
Jiakai

