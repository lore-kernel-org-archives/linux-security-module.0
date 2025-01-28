Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4684E28DA1
	for <linux-security-module@vger.kernel.org>; Tue, 28 Jan 2025 23:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738107701; cv=none; b=pzSYaNlsMDVIK5r+YEInQPRe/0frrFcAMJYvrZ2e8XY1f+FPXJW8qcZMmXxOW31k4tgBS2AzL1djs0b6dJtU3n/i9fDLTJTkihNbQLIFGXGPcBr8w1GGoLUdDVxqLA6l7BFpJ8r9Eyb/f1usP/yylwwWlPtMe5uett4mME+HFvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738107701; c=relaxed/simple;
	bh=+REOG522unL42MtunHC5bfcM8U9it12+9IlFiFH1pxc=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=pz2RzMd9y6f6WL/Hm8GfgZ2oYT0hWotrSeCX+VnWp6z4ckmDa5svoLvy0ILVVzXZFGO/H1jtyBSVHybwUHQ16CpUPhpDXEqNmtWjsyw2DUMiYOBLmO7AEgo7KeJ1xoNq7iqcpY7POYbwJepFt4HvZXqJ9w+kocSzeoW/UboDQkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=DCcgSNen; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="DCcgSNen"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4678cd314b6so62183231cf.3
        for <linux-security-module@vger.kernel.org>; Tue, 28 Jan 2025 15:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1738107698; x=1738712498; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+wzUCgK2QvGoOOyiHtBqsqcjcDIIOCHi8bVaY5LEVb8=;
        b=DCcgSNenj74/eaU8H72ljUpKdYSkzNew6ObEo+QXbi+NhdohyfyPaT2imsEHMz3q+R
         LA6OahMXiZNViIAXrYn4W8gM1H2+omZbZMa/8X1SihesnAu52CR2nD/jo9Sv5D8eM78Q
         RDsKCVjZhh6QXXZqTggrcQSY0C77N+OwRWorXfYlAUiYDvnt9zF4fiVjCs2X52xTj3cF
         npmWD713x8JyhQVo/uQ2D8CDPvUNhQ+B7ddeNlByISTvLlE9X9Z+xNfVyH+ziPP4obxA
         pPMOew+kmxs+BdbXBsJx1mp4+JhaKLA/9bQYNjQ8VlKTQHyVOxMSF6DDcm2qxT0NQtL3
         b+IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738107698; x=1738712498;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+wzUCgK2QvGoOOyiHtBqsqcjcDIIOCHi8bVaY5LEVb8=;
        b=DKklamr7iLkO9uVW1Ft3ulcOVVUmqrtsuZMXcrLNXQy2Bc9MTTPB67N5hkXQBUCJgC
         JazXrz3GXz/mTqYepTAcds6s+quT8UySQqByNrATCyi5qKRPtpAkiiTKa5VB8BhhREiN
         EKYLClGSv6u/ZxF0aszHrGuvPiGEBixUuEoJk62t4EeXL/WugswvPaQONquEhRkDX4LK
         0Fc4wP29iQZDfqYE3VEJUqB9McVpaKY4I2xgACI2lEN3RslqCoBYxVwwF/Qw//x+ACkI
         9/XYYjR2ZkOdT2Ugc79sVbULeLdiGjYKBrc4QfaiW+0pKxppBMjbgXWMNAwahSqKzipl
         hreQ==
X-Forwarded-Encrypted: i=1; AJvYcCULk4FiaQXms1uDsEX396tOWtl0ViXmmOCzI4fWqFMavGfk6Xim8RMz0JI/5LQjJCsGLh4UokJviB/y+aHhFwtbfbCfsTM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7ZWXnP8hAd/OpWP14JfHSH1qx4zJjtujMc6w77om9k56GfKOG
	yVLNX9XlBBnfozUCtprZsrVMHxtk+UKBRlc+0NYFSaDo6sKK9dn1sGKiratw+g==
X-Gm-Gg: ASbGncuGXtqv7e7nFx3IfarS8zq6s/4P0bkw1Jt0Q6I1TOisDxrFDsNA/n2Noe/d+sa
	9Bnz2jzPr2piVH8ycCp67LP7Paonr6golaMiQrh4V/TAjxDLtGQ+egfxHPpEVccsN5bmSzEscMT
	fUpld998TyO7DtjAAw/GljeG+1z6MmQ6jHLLRrGs/Oc4zKqz0GhFPyHp4sxY+3VPHC5JusymJKx
	HLWPS8cBz76ubdsD6hMi0MDoweoSQTVZEmqyYRIr16MJLs5DE5sBdw99jcapBm5gog0U7Mperi2
	c94UAadfuw==
X-Google-Smtp-Source: AGHT+IGP6OnBNAJZ5InHFaJKtOfZTbH9t7b80ceHIm+d62RDj/wxsm38Y1GxOWCkJI4fiHC7uQlyuQ==
X-Received: by 2002:a05:622a:285:b0:461:169e:d2dc with SMTP id d75a77b69052e-46fd0ba3b44mr21967781cf.49.1738107698105;
        Tue, 28 Jan 2025 15:41:38 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-46e668c921dsm57893251cf.47.2025.01.28.15.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 15:41:37 -0800 (PST)
Date: Tue, 28 Jan 2025 18:41:36 -0500
Message-ID: <7c6419901a0f6958c58dc138fe5fd348@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250128_1833/pstg-lib:20250128_1833/pstg-pwork:20250128_1833
From: Paul Moore <paul@paul-moore.com>
To: Huacai Chen <chenhuacai@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, Eric Paris <eparis@redhat.com>
Cc: James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, Casey Schaufler <casey@schaufler-ca.com>, audit@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH v2] audit: Initialize lsmctx to avoid memory allocation  error
References: <20250125141435.205096-1-chenhuacai@loongson.cn>
In-Reply-To: <20250125141435.205096-1-chenhuacai@loongson.cn>

On Jan 25, 2025 Huacai Chen <chenhuacai@loongson.cn> wrote:
> 
> Initialize the local variable lsmctx in audit_receive_msg(), so as to
> avoid memory allocation errors like:
> 
> [  258.074914] WARNING: CPU: 2 PID: 443 at mm/page_alloc.c:4727 __alloc_pages_noprof+0x4c8/0x1040
> [  258.074997] pc 900000000304d588 ra 9000000003059644 tp 9000000107774000 sp 9000000107777890
> [  258.075000] a0 0000000000040cc0 a1 0000000000000012 a2 0000000000000000 a3 0000000000000000
> [  258.075003] a4 9000000107777bd0 a5 0000000000000280 a6 0000000000000010 a7 0000000000000000
> [  258.075006] t0 9000000004b4c000 t1 0000000000000001 t2 1f3f37829c264c80 t3 000000000000002e
> [  258.075009] t4 0000000000000000 t5 00000000000003f6 t6 90000001066b6310 t7 000000000000002f
> [  258.075011] t8 000000000000003c u0 00000000000000b4 s9 900000010006f880 s0 9000000004a4b000
> [  258.075014] s1 0000000000000000 s2 9000000004a4b000 s3 9000000106673400 s4 9000000107777af0
> [  258.075017] s5 90000001066b6300 s6 0000000000000012 s7 fffffffffffff000 s8 0000000000000004
> [  258.075019]    ra: 9000000003059644 ___kmalloc_large_node+0x84/0x1e0
> [  258.075026]   ERA: 900000000304d588 __alloc_pages_noprof+0x4c8/0x1040
> [  258.075030]  CRMD: 000000b0 (PLV0 -IE -DA +PG DACF=CC DACM=CC -WE)
> [  258.075040]  PRMD: 00000004 (PPLV0 +PIE -PWE)
> [  258.075045]  EUEN: 00000007 (+FPE +SXE +ASXE -BTE)
> [  258.075051]  ECFG: 00071c1d (LIE=0,2-4,10-12 VS=7)
> [  258.075056] ESTAT: 000c0000 [BRK] (IS= ECode=12 EsubCode=0)
> [  258.075061]  PRID: 0014c010 (Loongson-64bit, Loongson-3A5000)
> [  258.075064] CPU: 2 UID: 0 PID: 443 Comm: auditd Not tainted 6.13.0-rc1+ #1899
> [  258.075070] Stack : ffffffffffffffff 0000000000000000 9000000002debf5c 9000000107774000
> [  258.075077]         90000001077774f0 0000000000000000 90000001077774f8 900000000489e480
> [  258.075083]         9000000004b380e8 9000000004b380e0 9000000107777380 0000000000000001
> [  258.075089]         0000000000000001 9000000004a4b000 1f3f37829c264c80 90000001001a9b40
> [  258.075094]         9000000107774000 9000000004b080e8 00000000000003d4 9000000004b080e8
> [  258.075100]         9000000004a580e8 000000000000002d 0000000006ebc000 900000010006f880
> [  258.075106]         00000000000000b4 0000000000000000 0000000000000004 0000000000001277
> [  258.075112]         900000000489e480 90000001066b6300 0000000000000012 fffffffffffff000
> [  258.075118]         0000000000000004 900000000489e480 9000000002def6a8 00007ffff2ba4065
> [  258.075124]         00000000000000b0 0000000000000004 0000000000000000 0000000000071c1d
> [  258.075129]         ...
> [  258.075132] Call Trace:
> [  258.075135] [<9000000002def6a8>] show_stack+0x30/0x148
> [  258.075146] [<9000000002debf58>] dump_stack_lvl+0x68/0xa0
> [  258.075152] [<9000000002e0fe18>] __warn+0x80/0x108
> [  258.075158] [<900000000407486c>] report_bug+0x154/0x268
> [  258.075163] [<90000000040ad468>] do_bp+0x2a8/0x320
> [  258.075172] [<9000000002dedda0>] handle_bp+0x120/0x1c0
> [  258.075178] [<900000000304d588>] __alloc_pages_noprof+0x4c8/0x1040
> [  258.075183] [<9000000003059640>] ___kmalloc_large_node+0x80/0x1e0
> [  258.075187] [<9000000003061504>] __kmalloc_noprof+0x2c4/0x380
> [  258.075192] [<9000000002f0f7ac>] audit_receive_msg+0x764/0x1530
> [  258.075199] [<9000000002f1065c>] audit_receive+0xe4/0x1c0
> [  258.075204] [<9000000003e5abe8>] netlink_unicast+0x340/0x450
> [  258.075211] [<9000000003e5ae9c>] netlink_sendmsg+0x1a4/0x4a0
> [  258.075216] [<9000000003d9ffd0>] __sock_sendmsg+0x48/0x58
> [  258.075222] [<9000000003da32f0>] __sys_sendto+0x100/0x170
> [  258.075226] [<9000000003da3374>] sys_sendto+0x14/0x28
> [  258.075229] [<90000000040ad574>] do_syscall+0x94/0x138
> [  258.075233] [<9000000002ded318>] handle_syscall+0xb8/0x158

If you are going to include the backtrace, please ensure that the lines
do not wrap when viewing the commit using 'git log' in an 80 char wide
terminal.

> Root cause: if we enable AUDIT but disable LSM, in the AUDIT_SIGNAL_INFO
> case, lsmprop_is_set() returns false, then kmalloc() may try to allocate
> a large amount of memory with an uninitialized length.

You shouldn't need to have a special "Root cause:" section, just work
that into the commit description normally.  I would suggest that the
commit description could simply be something like the following:

  When audit is enabled in a kernel build, and there are no LSMs
  active that support LSM labeling, it is possible that the lsmctx
  variable in the AUDIT_SIGNAL_INFO handler in audit_receive_msg()
  could be used before it is properly initialize.  This patch
  corrects this problem by initializing the lsmctx to a safe value
  when it is declared.

> Fixes: 6fba89813ccf333d ("lsm: ensure the correct LSM context releaser")
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
> V2: Update commit message and CC list.
> 
>  kernel/audit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/audit.c b/kernel/audit.c
> index 13d0144efaa3..5f5bf85bcc90 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -1221,7 +1221,7 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh,
>  	struct audit_buffer	*ab;
>  	u16			msg_type = nlh->nlmsg_type;
>  	struct audit_sig_info   *sig_data;
> -	struct lsm_context	lsmctx;
> +	struct lsm_context	lsmctx = { NULL, 0, 0 };
>  
>  	err = audit_netlink_ok(skb, msg_type);
>  	if (err)
> -- 
> 2.47.1

--
paul-moore.com
