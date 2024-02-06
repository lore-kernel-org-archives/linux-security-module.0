Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B555B1E500
	for <linux-security-module@vger.kernel.org>; Tue,  6 Feb 2024 14:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707229896; cv=none; b=ax1VOPUnM3nTeyY+yUlEOZ6y9AU+R8wp/DZeDMSWSrKb1WZfoMOdiSKpC6rpezPDhRabikdZn5XmMQJqzKTVtQys+dNmLejRhfi/A77D9HQmJoZgLDcd67GkKh4E7nbT0m4eOKBKsIPK5nFHlnfcvfZBnY1h/HwL18xghjBVuOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707229896; c=relaxed/simple;
	bh=h4gt95Y6olW8Hatd0M00N6Ti4aN6WfFZeSvcCVEcWeQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:Cc:
	 In-Reply-To:Content-Type; b=sxG4KAvfRcDcYuYva/lzHwAJ2i7TTCJ8Hw+d2a9XTBk+AS5vY5HG3y5MdIolwCurEI9264E06Ut+Cp16OSKJSGIGLQEvxhiabwhZfnAtWfXTm3c+5OVgdepoKOU/5x0f55q/9/a5taogJ5+Af1hTGa1Fko8x4MDTrgevbF4jaow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav311.sakura.ne.jp (fsav311.sakura.ne.jp [153.120.85.142])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 416EVSO2030911;
	Tue, 6 Feb 2024 23:31:28 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav311.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav311.sakura.ne.jp);
 Tue, 06 Feb 2024 23:31:28 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav311.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 416EVRXV030907
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 6 Feb 2024 23:31:28 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <fa719d6f-1960-491e-89c2-ed2c14d184fc@I-love.SAKURA.ne.jp>
Date: Tue, 6 Feb 2024 23:31:28 +0900
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: smack: Possible NULL pointer deref in cred_free hook.
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Casey Schaufler <casey@schaufler-ca.com>
References: <ad9dddfe-0fa1-40f6-9f8c-f2c01c7a0211@I-love.SAKURA.ne.jp>
Cc: linux-security-module <linux-security-module@vger.kernel.org>
In-Reply-To: <ad9dddfe-0fa1-40f6-9f8c-f2c01c7a0211@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello, Casey.

I confirmed using fault injection shown below that smack_cred_free() is not
prepared for being called without successful smack_cred_prepare().

diff --git a/security/security.c b/security/security.c
index 10adc4d3c5e0..690136b60d28 100644
--- a/security/security.c
+++ b/security/security.c
@@ -3059,7 +3059,7 @@ int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp)
        if (rc)
                return rc;

-       rc = call_int_hook(cred_prepare, 0, new, old, gfp);
+       rc = -EPERM; //call_int_hook(cred_prepare, 0, new, old, gfp);
        if (unlikely(rc))
                security_cred_free(new);
        return rc;

[   11.366204] LSM: initializing lsm=capability,yama,smack,integrity
[   11.368005] Yama: becoming mindful.
[   11.371997] Smack:  Initializing.
[   11.373957] Smack:  IPv6 port labeling enabled.
[   11.379072] Mount-cache hash table entries: 16384 (order: 5, 131072 bytes, linear)
[   11.383676] Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes, linear)
[   11.400071] Running RCU synchronous self tests
[   11.450967] Running RCU synchronous self tests
[   11.453956] BUG: kernel NULL pointer dereference, address: 0000000000000000
[   11.454948] #PF: supervisor read access in kernel mode
[   11.454948] #PF: error_code(0x0000) - not-present page
[   11.454948] PGD 0 P4D 0 
[   11.454948] Oops: 0000 [#1] PREEMPT SMP PTI
[   11.454948] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.8.0-rc3+ #47
[   11.454948] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
[   11.454948] RIP: 0010:smk_destroy_label_list+0x11/0x40
[   11.454948] Code: 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00 0f 1f 44 00 00 55 48 89 fd 53 48 8b 3f <48> 8b 1f 48 39 fd 74 13 e8 c2 bd e2 ff 48 89 d8 48 89 df 48 8b 1b
[   11.454948] RSP: 0000:ffffffffa3003c50 EFLAGS: 00010286
[   11.454948] RAX: ffffffffa1f763e0 RBX: ffffffffa2f19b00 RCX: 0000000000000100
[   11.454948] RDX: 00000000000000d8 RSI: 0000000000000000 RDI: 0000000000000000
[   11.454948] RBP: ffff8d71c03300c8 R08: 0000000000400dc0 R09: 00000000ffffffff
[   11.454948] R10: ffffffffa3003c48 R11: ffff8d7259ffc220 R12: ffff8d71c0330018
[   11.454948] R13: ffffffffa3003e48 R14: ffff8d71c03c8000 R15: 0000000000000001
[   11.454948] FS:  0000000000000000(0000) GS:ffff8d7259e00000(0000) knlGS:0000000000000000
[   11.454948] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   11.454948] CR2: 0000000000000000 CR3: 000000014e03c000 CR4: 0000000000350ef0
[   11.454948] Call Trace:
[   11.454948]  <TASK>
[   11.454948]  ? __die_body+0x1e/0x60
[   11.454948]  ? page_fault_oops+0x15b/0x470
[   11.454948]  ? local_clock+0x15/0x30
[   11.454948]  ? lock_release+0x275/0x350
[   11.454948]  ? exc_page_fault+0x74/0x1e0
[   11.454948]  ? asm_exc_page_fault+0x26/0x30
[   11.454948]  ? __pfx_smack_cred_free+0x10/0x10
[   11.454948]  ? smk_destroy_label_list+0x11/0x40
[   11.454948]  smack_cred_free+0x30/0xa0
[   11.454948]  security_cred_free+0x2f/0x60
[   11.454948]  security_prepare_creds+0x2b/0x60
[   11.454948]  prepare_creds+0x1b3/0x2c0
[   11.454948]  copy_creds+0x2e/0x380
[   11.454948]  copy_process+0x47e/0x2080
[   11.454948]  ? find_held_lock+0x34/0xa0
[   11.454948]  kernel_clone+0x9f/0x6c0
[   11.454948]  ? __mutex_unlock_slowpath+0x43/0x2c0
[   11.454948]  ? synchronize_rcu_expedited+0x3fa/0x4e0
[   11.454948]  user_mode_thread+0x5f/0x90
[   11.454948]  ? __pfx_kernel_init+0x10/0x10
[   11.454948]  rest_init+0x22/0x1d0
[   11.454948]  arch_call_rest_init+0xe/0x30
[   11.454948]  start_kernel+0x63e/0x720
[   11.454948]  x86_64_start_reservations+0x18/0x30
[   11.454948]  x86_64_start_kernel+0x91/0xa0
[   11.454948]  secondary_startup_64_no_verify+0x184/0x18b
[   11.454948]  </TASK>
[   11.454948] Modules linked in:
[   11.454948] CR2: 0000000000000000
[   11.454948] ---[ end trace 0000000000000000 ]---
[   11.454948] RIP: 0010:smk_destroy_label_list+0x11/0x40
[   11.454948] Code: 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00 0f 1f 44 00 00 55 48 89 fd 53 48 8b 3f <48> 8b 1f 48 39 fd 74 13 e8 c2 bd e2 ff 48 89 d8 48 89 df 48 8b 1b
[   11.454948] RSP: 0000:ffffffffa3003c50 EFLAGS: 00010286
[   11.454948] RAX: ffffffffa1f763e0 RBX: ffffffffa2f19b00 RCX: 0000000000000100
[   11.454948] RDX: 00000000000000d8 RSI: 0000000000000000 RDI: 0000000000000000
[   11.454948] RBP: ffff8d71c03300c8 R08: 0000000000400dc0 R09: 00000000ffffffff
[   11.454948] R10: ffffffffa3003c48 R11: ffff8d7259ffc220 R12: ffff8d71c0330018
[   11.454948] R13: ffffffffa3003e48 R14: ffff8d71c03c8000 R15: 0000000000000001
[   11.454948] FS:  0000000000000000(0000) GS:ffff8d7259e00000(0000) knlGS:0000000000000000
[   11.454948] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   11.454948] CR2: 0000000000000000 CR3: 000000014e03c000 CR4: 0000000000350ef0
[   11.454948] Kernel panic - not syncing: Fatal exception
[   11.454948] ---[ end Kernel panic - not syncing: Fatal exception ]---

On 2024/01/27 23:36, Tetsuo Handa wrote:
> The cred_free hook might be called without successful cred_prepare
> as long as cred->security != NULL. It seems to me that smack_cred_free()
> is not prepared for that case. Please check.
> 
> prepare_creds() {
>   new = kmem_cache_alloc(cred_jar, GFP_KERNEL);
>   if (!new)
>     return NULL;
>   new->security = NULL;
>   security_prepare_creds(new, old, GFP_KERNEL_ACCOUNT) {
>     int rc = lsm_cred_alloc(new, gfp);
>     if (rc)
>       return rc;
>     rc = call_int_hook(cred_prepare, 0, new, old, gfp) {
>       // cred->security != NULL and one of callbacks returned an error
>     }
>     if (unlikely(rc)) {
>       security_cred_free(new) {
>         call_void_hook(cred_free, cred) {
>           // at least one callback is called without successful cred_prepare
>         }
>         kfree(cred->security);
>         cred->security = NULL;
>       }
>     }
>   }
>   goto error;
> error:
>   abort_creds(new)
>   return NULL;
> }

