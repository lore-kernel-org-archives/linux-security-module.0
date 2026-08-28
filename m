Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527EE25B08B
	for <linux-security-module@vger.kernel.org>; Fri, 28 Aug 2026 01:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787879454; cv=none; b=exaMLX7Xve8IwEoPL6UuKZ3KePtUCUrhOpUMcBD3fi3XYNLZuOeNnGRYPU9KptM+7y+NlhU2UbPiFETPQoQneMSs5gGYM/zDlqxbMscMu/mPepQ+T7TnAgAo3gGe5UqbIvMt3q53RHEfjTLR64iZHPbcBsUuqO1UePy+SDpVa3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787879454; c=relaxed/simple;
	bh=NFG1n41lVJCrqXWncd4MldYqy9CGGkGjSMKD/ApclJM=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=tD15StsIVs56VaAAqoAHY+D+l6+Tey7Q4s/705mWVlkdwF2HjQvPNoypsicSe/xbXtPO9bxRs992smlmHDX8ziTYiZqMYHNAb/Cyh+jlvSwOexXrn81s++YBgJKVBSN8pMy3Ov4TjQGPPRKXdzivbHQQfps9xzYfPzwcNMYdvjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=DiexHerO; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="DiexHerO"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-9387752a4d0so24518685a.2
        for <linux-security-module@vger.kernel.org>; Thu, 27 Aug 2026 18:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1787879449; x=1788484249; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DqRGrR0heNmSPrtTW9+v9FKZZ7RwzxehXvY0MCzvxnw=;
        b=DiexHerO6+IFexSx6JA9an3k0XR2yhU62zhjz0PIvuFDUeoTTa7PZx2vVbdtp+2Z+z
         fc4/yiZkz88x+eA0bilvSLbQdQxku2hqt4Ux3oQ5feErrmumPEYW3wmV/eQBfe9H9pes
         eqhf0xDOkQR1MnNJEiEcdmlv+jiEkVtHG559KcdmkmqYb+5BIMgRvvc/FFNAE35xFpbJ
         xq5Xu7O3xZCNR+cu3iAw5LM66zHF0LGlOrjrNQ8ibx0WvKtE7KwaQFE8LCd4Xe+f8M8b
         Sr0Mx40iQRVtzFiLMhx9gxctNXDlX6yCP+vfYVWHbxjsSNA2WdBvVLLv5AcMBCBp31rk
         PZOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787879449; x=1788484249;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DqRGrR0heNmSPrtTW9+v9FKZZ7RwzxehXvY0MCzvxnw=;
        b=nfB25ie9dZ1QXci+791niHfKMPS5EgH+a+B3gHL8plyxLt8TOAWTFbvCMALtKQEg1n
         e5nmJ1ZXv1xs4zIAvyAoSd4Bzu6wCdG6xLMVTyP4PXszaSD+on0Rp8gWu/8bE0KxD7k6
         KRnuF2eipXtUKm6/a5iStP22XVktKZ+J66Oz4ciEfiNqCnwf0TUhgAdtTiBuadoR+42Q
         3MjLWngO4GVkKzBO3BWKUDXdHUYTwA9GAWZgCPXIGxtAucbEnjUQhGtFEmTYUGUTxTJ7
         Fi4JcWSh+/0FBn7Wpn+0adUXCsUBgJvA76dXPhoyWVq32emKujKKxK3j+mEkEbUXWkQ1
         wNbw==
X-Forwarded-Encrypted: i=1; AHgh+Ro27YaTk3lfRegL4MN/qTija4+5Fzqa6azGPrc63OlSdHVt/G+F3KMTRIfbSXE2N+s39pc/+cjxOnG1rSzIn4Xx7RnOXdU=@vger.kernel.org
X-Gm-Message-State: AFuF++lh4uMLeAQATFkehhC9rA+DxnP/hwFUJFZ84VPdadvcCXLHU+ey
	MJ65KfmU3ojYUnvHtldyIMGu7aPxrI2Jk45bQizsgfV9SiPFAzbRP/8u9/lTbkWqRQ==
X-Gm-Gg: AR+sD12Rw/DLcKFULtfZ/f+Hd7gMrzhgp7edEkWD2hkUYjrA7uwMatmn2afKTp27Myh
	W1Bn3sY9MLSZrTEfXSJKzxaSbMrIt+2sozUGAm+xMa9D2DtYKEW6PN7QhuMJq83bpAAoMv6w92k
	dsc47Z7iUIzdMKunFY22ChI5LG3trp5TSHLDd9BVNYl0SpfsSdV4IuyUt+moRUwzBRK10zi3oG6
	AKUtlqaQzCFIRZpNgAzPbQNKhp7nUueEtXBzBBalA2uToFivjd6dUo4HTzXl6ChscOrk5DIxTzl
	+OOAi6wEelzM51CmjqVLjXOoqw50yFjItCRfBnXJqf0Fa23132SMmhVJF1EhBMWUwpPlfwtt3FI
	OIMXvgpaZ5+ET6cDYUvfMcNyfivfG49muPXM1Uy7fl1lkgIWv1xLnZWpwfELslK2lLBsxiSVNYv
	cMn4JWv8KeaRzqIKR/qTJwaUrADMsIXwirnwMyjKAUvWtC4OXTyYQikk+UgAvqAvcgR6NQQSKYh
	czQlX/k+xhMQtl8ZGAUZ+XH3CDRHemQ5OxlfS4jaiNh
X-Received: by 2002:a05:620a:290a:b0:934:9524:2e89 with SMTP id af79cd13be357-93913809957mr300256985a.13.1787879448634;
        Thu, 27 Aug 2026 18:10:48 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9391725670dsm34787285a.19.2026.08.27.18.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 18:10:47 -0700 (PDT)
Date: Thu, 27 Aug 2026 21:10:46 -0400
Message-ID: <de5f1c2fb1ccbb92beda6906e23ac457@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260827_1122/pstg-lib:20260827_1501/pstg-pwork:20260827_1122
From: Paul Moore <paul@paul-moore.com>
To: Jann Horn <jannh@google.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Jeff Xu <jeffxu@google.com>, =?utf-8?q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@kernel.org>, linux-mm@kvack.org, Jann Horn <jannh@google.com>
Subject: Re: [PATCH v2 3/3] selinux: require PROCESS__PTRACE for FOLL_FORCE  introspection
References: <20260825-selinux-pokemem-v2-3-b46bc64916d8@google.com>
In-Reply-To: <20260825-selinux-pokemem-v2-3-b46bc64916d8@google.com>

On Aug 25, 2026 Jann Horn <jannh@google.com> wrote:
> 
> On systems configured with PROC_MEM_FORCE_ALWAYS, ensure that a process can
> only create anonymous executable memory via /proc/self/mem if it has
> PROCESS__PTRACE (like when using /proc/$pid/mem of another process).
> 
> This closes a hole in code integrity enforcement that Project Zero has used
> in a remote Android exploit chain:
> It was possible to use a memory corruption bug in a service without
> EXECMEM/EXECMOD/PTRACE permission to overwrite executable code via
> /proc/self/mem, which made it possible to load and run shellcode containing
> a kernel exploit.
> 
> Signed-off-by: Jann Horn <jannh@google.com>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  security/selinux/hooks.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 18dd28b2bb13..2c2c60e9e0fe 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2157,6 +2157,27 @@ static int selinux_ptrace_traceme(struct task_struct *parent)
>  			    SECCLASS_PROCESS, PROCESS__PTRACE, NULL);
>  }
>  
> +/*
> + * Decide whether it should be possible to read non-readable VMAs and write
> + * non-writable VMAs via /proc/self/mem.
> + * This only applies to systems configured with PROC_MEM_FORCE_ALWAYS, and only
> + * triggers on accesses that are not visible to selinux_ptrace_access_check()
> + * because of the introspection exceptions in may_access_mm() and
> + * __ptrace_may_access().
> + *
> + * This allows a process to overwrite read-only code in its own address space.
> + *
> + * Creating an audit record on denial doesn't make sense here, since we can't
> + * tell whether FOLL_FORCE matters for the accessed VMAs.
> + */
> +static int selinux_mem_foll_force_opened_by_owner(const struct cred *subject)
> +{
> +	struct av_decision avd;
> +	u32 sid = cred_sid(subject);
> +
> +	return avc_has_perm_noaudit(sid, sid, SECCLASS_PROCESS, PROCESS__PTRACE, 0, &avd);
> +}

I realize not all of the SELinux hook callbacks use proper kdoc comments,
but I'm trying to fix that.  If you could make this a kdoc function header
comment I would appreciate it.

--
paul-moore.com
