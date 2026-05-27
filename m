Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C351246782;
	Wed, 27 May 2026 00:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779843459; cv=none; b=gtvHbez/irGn5remzf996VaXNUZqRaZwiAgkmWkP2HhWKpf7TUdJU9ddkt6zqkWdNvlCh1xuoQHXtTWMHanDU6FJggJ28QjNqFwVfgj90hBZtbS462cBgwFpPeYneR8E8ZR6BkhYE0LDmb07WW1q+zkmCWErPxefkqvP+j2UjDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779843459; c=relaxed/simple;
	bh=6DIiRcujPeLWlaL5AeBxyIwyQw19BFbHuAzRrNk/hz4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uvrHMoeSaI5qmfczRkYmPU5YwyrWz9nRiaQzVeHkE8X8mCrcbUrvuvTDYmiP1b4NZZ12hNMdSTq5en0gKDmOK98EoJkYmzaBCj5FU/Uu/ZFLwJxxJgRjVNBrzOC2Z95CNOsftHeLnkGmpW55Vu3V2/ubscCQ2f/pAr5PnmA6d4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn; spf=pass smtp.mailfrom=mails.ucas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.ucas.ac.cn
Received: from fric.. (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAAHHdRzQRZqMQR_Eg--.5918S2;
	Wed, 27 May 2026 08:57:23 +0800 (CST)
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
Date: Wed, 27 May 2026 00:57:23 +0000
Message-Id: <20260527005723.447004-1-xujiakai24@mails.ucas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <973e7bd1-6919-46ad-aa3b-f4e02737462e@I-love.SAKURA.ne.jp>
References: <973e7bd1-6919-46ad-aa3b-f4e02737462e@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAAHHdRzQRZqMQR_Eg--.5918S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZw4UtrWxKw48Jry5tF1DJrb_yoW5XF43pa
	y7K3ZFvw47JF10vr4kuwsrWa48t345Ja45Cwn8Kw4kAF90qr97WF4jqayY9Fn8Cr4rt3Wj
	yr12vrySgF1DAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9j14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8v
	x2IErcIFxwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvf
	C2KfnxnUUI43ZEXa7VUbq-e5UUUUU==
X-CM-SenderInfo: 50xmxthndljko6pdxz3voxutnvoduhdfq/

> >> Thank you for a patch, but I don't think we need this change.
> > 
> > Thanks for your review! I understand your perspective, but I believe
> > the crash is a real NULL pointer dereference, and I'd like to explain
> > why the defensive check is warranted.
> > 
> >> TOMOYO's initial domain is &tomoyo_kernel_domain, and each thread belongs to
> >> a non-NULL domain. Therefore, tomoyo_domain() is not supposed to return NULL.
> > 
> > While tomoyo_domain() is not supposed to return NULL under normal
> > operation, there are code paths that leave s->domain_info == NULL:
> > 
> >   a) Pre-init window (security/tomoyo/tomoyo.c, lines 598-612):
> >      The task security blob is zero-allocated via kzalloc(), and
> >      security_add_hooks() at line 603 is called BEFORE
> >      s->domain_info = &tomoyo_kernel_domain at line 606. If any LSM
> >      hook fires during that window, tomoyo_domain() returns NULL.
> 
> This code is executed during early boot stage. Other LSM hooks are not
> supposed to fire.
> 
> > 
> >   b) tomoyo_task_free() (tomoyo.c, lines 533-545) explicitly sets
> >      s->domain_info = NULL after decrementing the refcount.
> 
> This code is executed when a "struct task_struct" is about to be released.
> Nobody can find this "struct task_struct". Also, this "struct task_struct"
> cannot be the current thread.
> 
> > 
> >   c) tomoyo_find_next_domain() (domain.c, lines 876-883) writes
> >      s->domain_info = NULL when the domain transition fails.
> 
> I couldn't catch, but old_domain is initialized as
> 
>   struct tomoyo_domain_info *old_domain = tomoyo_domain();
> 
> which cannot be NULL.
> 
> domain is guaranteed to be non-NULL because old_domain cannot be NULL.
> 
> 	if (!domain)
> 		domain = old_domain;
> 
> Therefore, s->domain_info is guaranteed to be non-NULL because domain cannot be NULL.
> 
> 	s->domain_info = domain;
> 
> If domain were NULL, the kernel should have already crashed at line 884.

Thank you for the thorough explanation! You are absolutely right,
and I really appreciate you taking the time to walk through each path.

> > 
> > I think adding a NULL check makes the code more robust. What do you 
> > think?
> 
> Then, this will be NULL pointer dereference.
> But fixing the location that is setting NULL is the correct approach.

I fully agree. The NULL check I proposed would only mask the symptom.
The real bug is that something corrupted the task_struct's security blob
and zeroed out domain_info before the ioctl hook fired.

Unfortunately, I don't have a reliable reproducer. The fuzzer triggered
this only once on riscv, so I can't easily track down the source of the 
corruption.

Either way, thank you again for the review. I learned a lot about
TOMOYO's domain lifecycle from your explanation.

Best regards,
Jiakai

