Received: from sonic302-26.consmr.mail.ne1.yahoo.com (sonic302-26.consmr.mail.ne1.yahoo.com [66.163.186.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03617F4E2
	for <linux-security-module@vger.kernel.org>; Wed,  7 Feb 2024 01:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.186.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707269986; cv=none; b=lwCU1a2httIsMmME/LDszvsJ34L+iC7PjQcIe/JReDLvvyoq0e6OJDKRQNAhuRrLABHW1ePEa+8JR7mOoeQ0B+NbwPL9PgjlJ5pyXLwGpzLBWlbWMVJ78VTseHEYHSaQZ97ekMwo647X73L9vUfjaO0mfxWINUguGflszlRL+Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707269986; c=relaxed/simple;
	bh=yj/Mk2425wQyEZZVTddsnh60JIXhYZiq6vhD1gMim3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WjJ08BX/92eHR58rMl4gsQwYKCi139o+Gomw0dHAagb+STyNq93Xsy5QUCF4ZSzTVPP3vOxclQsgjhrlkhta75Iws/fltQZAuL+b9mR6XY5HHojAl9lQWvnQFzCNqXmitls9I5JcLDmxNGZs26fjIWQqklWZZLfyld9miADM8qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=lFzD1nLk; arc=none smtp.client-ip=66.163.186.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="lFzD1nLk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1707269983; bh=MDvu9GCBcX1JDdo5TymYr7QastCmSidkjH1vuvB3yDw=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=lFzD1nLkwHD30ekJdOT5cS5+s3FAMxxYyoiNPJ32WdGUEVNHa4Wu8EswAlTzsMXkK73X4qwzISHJATLQJLexBrwBsGxayytF75+VT397GVxLriNn3FvAs8Eq2OPnCX49rpr9oX+QScgLIW3NgPDuqzTQvENiY3FPVuhFxVbJyUvYAW4k6FkDWOAM4k176YSjG8ixVPRzc8agWRuIc0FFkFn4FcwL6JwC4i6TDs1OCrsU3ocBkzCtCbnyvX5gyeBi8P8LWxRVq2WOACqYCFD/ptqbNJiaNYu3BvEaHJOHgrNyWVAxbDUW1C5LwAm+MK0XyKPvrzVM9hMb334GBgYgRg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1707269983; bh=L5AQal4FJevMvsz4yg5mVxWl1E1EceiiJo1jpugj6fV=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=dfQAJSCcTH9Y5xKR6dTiEpgjbhpcVkLdwza4jsW9ZOA7v7btbbjQ4fnPZizFvXuVm5Kc+/S7PMQXkuMW7wf57Y75AVQXuHSp8UV2sTPi9v4AhGJuAKlbdo3vG7i629RRTcxYNkcGK5Je/BwUiTD5eUpMO+a+plZd2NeBbefZ2lqfWz8vVdKdGImKoMP5gkbbxkCZ8hWkAg+9aLzQ+JGSAcUqNUMEPIuPd0G9KBUSejipIrBO8oIu6RnVgKEUYXK7+v9JoTSiXyiaOfftS6qxjHjvukJBzFcW2Zc6eczRMqQjjlsJOthu6RkZQw6yCxtYKg3fZzBBh0Ck/BYIKohwUQ==
X-YMail-OSG: c_HS7.YVM1nJaJ4IBDPlvUjyeknAlI9poXXaTtlK3VlgaPudXKV.VFtTWSH3KiK
 AUB72kxWlLBKmK.Sre5m7ml6rybBTQ2YQwJBEqnE8UWN3Lo5sSx6r_arLMe_QoA2oBq9.eIXQf3z
 0mFoXfEL9BYi46a9Jno3378EQbnIy1xGo9XXKiJ1GG4va57KE0y.wftYOUj4YH3E6H.ysdzVY.7F
 sXGP5yAPgTGYqXAnG06zWpGCOxjPSSaJXUmHoYwSA70TbwwvzmyoDXTMqzGHPzTDv6qWwksTenja
 dkgrckiy.k4ZvsK7lqdpwhhiTLDl56wAUwaTbTH07RQY7G5mIhlntfC810JKSZEVa4iOaBmn7AHl
 Q4c7BaU2CFya40b.FFJlB.9VEhtTOz70nYzhs1_8ARk8hF3sYp1T9QNOXoTnm0FJ.6mA7daJC5hq
 YO0QXtLFmzqpazqQmrKkQaKiLk.0mKigmffOmN2c5PqgrygJD6kxHJNqIP_qmM5hzSOeFPzmSrfZ
 aR6aaBZz5wmmrIoVKu8W4_HABdf.852i19NgRS86ufR2VPIcy.3szLwpcRJRAv4mrwW_JyKLGK9H
 .B2IVURvZruGb5fey71LymqaMstUY2N7jhtP3BMGnKIfFurBzLkcjAa4iGLDL1ledJDpq67fwClJ
 ShcrpScChK3kNTKY1FzWqT_F56K4KELKkOmRAnwEA9A9Pkqd33SLBD468Il90fGzpB.L5ByvIer2
 p8pecAa6C3Uipl9nehcxjTK1z1MMLBoPblyQlxmYlUqfu_2G6f71AhOzJP_1nr6mUuzleVXA.7_w
 BYUTJK8umV_fUDqY63Fyc.fokU8aozWWZAvYD1jVsQcZEaBPll44E.Q9Ib6F7r80Ax_XGST7QFYT
 tVFPAmpbyNQla2bZFv3PcKc7kYtg3WjnlfJqBdDqmn_1bZfilfJrVHWc6QhBgd5Iv_LjwZSgWpp_
 ZaMGPeBVbP0WBcxBFDs0N3DoesOPVocVaTOiVSZSapTNjJfEZHeqssPIFJUDwYIh2vFu_oa6mlBE
 6FfEMoH6vK6qPUvkWyABSU5IVXKH5Q26j1.9f0oHpBH4lMFKzq_bD6GM_aimgw9DWZf1Ze6h2lzt
 mIyRzZ8sKp7t4tMGnz9rm8B47b1tMZmN1qoKJsgfyttF_ObDTyi4R0Wqwj2Z52TruCkutcGEXYYW
 ENcWqTJ_yIZj8lApY91lYlSwpqM5xZ_Pfkxrarcgdgmtb625nEZFMsHsuYGYzKWJOB5vQ1tN3F6_
 VKNALtvClChOUy1cNbwkiqkBjzZv424JpQdLmqV2lFmj44IjZZXp6QT4lK5p0V2eKcK5jAFSPtKN
 SAGDGRF6BZgk0VTdDe1GWd6MBNAn4N3UyP38ae4OP3_7VuTTpv8BNmF461bf5y1o0dlFsL0cYatw
 Rjs8KQIDWOUDzaIRgwVXAiGBpRadWr9.x8mKdPIYJMXfr0q5hqA7Qf2fRctZ_mWthiBv3KQrHeuR
 AIM2pWuI7kgSJJLrjZXGvNqEXaUMx9lNOhSJjNs3l7vdfYXY0s7Twu8inDFk.B2KoAk6LcL4h7VC
 W2yENGhtcC7fC352dV0.Kv010uZi3rry_fmHok23Hz9x66aEL3RRRqBQps5Uhwwt5NW9ZV.IDcsp
 X.EzWmZGj2KG6QdRyXbNNbPItbda_3BHeEqY4105fV.z8gF7otorGjnfelmINQpeji2z4ZH4UvXM
 5Q.rG8oDbrB_q5rZqtvGGoeseuTeCsEX3z7i3Ss79gn1q33fQ3YIXrsXUaYfVCJm0KpGEsRyBSmi
 VuRwjTjG.k7n7m.uP62rXFuWEsD5N9oB8kU0_DeaFjslTOfBx677xk3hC6AmdtV4KgdeKmmApm4j
 1HYgZG3pS6IMuhUXP_TK4I9twe6wbAOetse6ERSA7gO0iiN23XWtF3KoeiZQI48I8URSUcN_xR3f
 ia7_3Kvp_dpWGQ9qF5ViqYKofA6AMioKZ5RiF41c.THOAnHi8R8TIFfRhvjA_X46np4jF2wz22Oe
 _wY6lJJHHn6R7y8YdzgTGCYmZ4JNor8hiT8Lrw9.xXQYNo7.BP1_UMHC1l1upfteIMR81xbUSdC8
 oRgzDMzQOLNDM5CvPvwSsoStcbGDmENRzFe.ZJ6rhMMIEd5OP2qKAjt7c8m3z0nsMBwKN4ifi1kb
 AGwxYZ5yOg5CyZgqCvFLaNeiTC2mvw5kbCHqJSu7G7EzoKY9jH8fS02_oO2eDQUObu0Ytc7_ENoQ
 r.WL7R9g.646rqklWM4xtKDMFRNLdRozeUk1_7dVNYc_3mr_bid3KUiFYM1AvUO6efpn7axEM2W6
 3EA--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 6c96bfe1-a21d-4c57-ae0b-620d2654f045
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Wed, 7 Feb 2024 01:39:43 +0000
Received: by hermes--production-gq1-5c57879fdf-bmngc (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID cac5f956564549d26650d4b49aeb117c;
          Wed, 07 Feb 2024 01:39:37 +0000 (UTC)
Message-ID: <2fa0a73a-1d03-4937-8599-e4560297af3f@schaufler-ca.com>
Date: Tue, 6 Feb 2024 17:39:34 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: smack: Possible NULL pointer deref in cred_free hook.
Content-Language: en-US
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: linux-security-module <linux-security-module@vger.kernel.org>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <ad9dddfe-0fa1-40f6-9f8c-f2c01c7a0211@I-love.SAKURA.ne.jp>
 <fa719d6f-1960-491e-89c2-ed2c14d184fc@I-love.SAKURA.ne.jp>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <fa719d6f-1960-491e-89c2-ed2c14d184fc@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22046 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 2/6/2024 6:31 AM, Tetsuo Handa wrote:
> Hello, Casey.
>
> I confirmed using fault injection shown below that smack_cred_free() is not
> prepared for being called without successful smack_cred_prepare().

The failure cases for smack_cred_prepare() result from memory allocation
failures. Since init_task_smack() is called before either of the potential
memory allocations the state of the cred will be safe for smack_cred_free().
The fault you've described here removes the init_task_smack(), which will
always succeed, and which is sufficient to prevent the smack_cred_free()
failure below. Are you suggesting that there is a case where a cred will
be freed without ever having been "prepared"?

>
> diff --git a/security/security.c b/security/security.c
> index 10adc4d3c5e0..690136b60d28 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -3059,7 +3059,7 @@ int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp)
>         if (rc)
>                 return rc;
>
> -       rc = call_int_hook(cred_prepare, 0, new, old, gfp);
> +       rc = -EPERM; //call_int_hook(cred_prepare, 0, new, old, gfp);
>         if (unlikely(rc))
>                 security_cred_free(new);
>         return rc;
>
> [   11.366204] LSM: initializing lsm=capability,yama,smack,integrity
> [   11.368005] Yama: becoming mindful.
> [   11.371997] Smack:  Initializing.
> [   11.373957] Smack:  IPv6 port labeling enabled.
> [   11.379072] Mount-cache hash table entries: 16384 (order: 5, 131072 bytes, linear)
> [   11.383676] Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes, linear)
> [   11.400071] Running RCU synchronous self tests
> [   11.450967] Running RCU synchronous self tests
> [   11.453956] BUG: kernel NULL pointer dereference, address: 0000000000000000
> [   11.454948] #PF: supervisor read access in kernel mode
> [   11.454948] #PF: error_code(0x0000) - not-present page
> [   11.454948] PGD 0 P4D 0 
> [   11.454948] Oops: 0000 [#1] PREEMPT SMP PTI
> [   11.454948] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.8.0-rc3+ #47
> [   11.454948] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
> [   11.454948] RIP: 0010:smk_destroy_label_list+0x11/0x40
> [   11.454948] Code: 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00 0f 1f 44 00 00 55 48 89 fd 53 48 8b 3f <48> 8b 1f 48 39 fd 74 13 e8 c2 bd e2 ff 48 89 d8 48 89 df 48 8b 1b
> [   11.454948] RSP: 0000:ffffffffa3003c50 EFLAGS: 00010286
> [   11.454948] RAX: ffffffffa1f763e0 RBX: ffffffffa2f19b00 RCX: 0000000000000100
> [   11.454948] RDX: 00000000000000d8 RSI: 0000000000000000 RDI: 0000000000000000
> [   11.454948] RBP: ffff8d71c03300c8 R08: 0000000000400dc0 R09: 00000000ffffffff
> [   11.454948] R10: ffffffffa3003c48 R11: ffff8d7259ffc220 R12: ffff8d71c0330018
> [   11.454948] R13: ffffffffa3003e48 R14: ffff8d71c03c8000 R15: 0000000000000001
> [   11.454948] FS:  0000000000000000(0000) GS:ffff8d7259e00000(0000) knlGS:0000000000000000
> [   11.454948] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   11.454948] CR2: 0000000000000000 CR3: 000000014e03c000 CR4: 0000000000350ef0
> [   11.454948] Call Trace:
> [   11.454948]  <TASK>
> [   11.454948]  ? __die_body+0x1e/0x60
> [   11.454948]  ? page_fault_oops+0x15b/0x470
> [   11.454948]  ? local_clock+0x15/0x30
> [   11.454948]  ? lock_release+0x275/0x350
> [   11.454948]  ? exc_page_fault+0x74/0x1e0
> [   11.454948]  ? asm_exc_page_fault+0x26/0x30
> [   11.454948]  ? __pfx_smack_cred_free+0x10/0x10
> [   11.454948]  ? smk_destroy_label_list+0x11/0x40
> [   11.454948]  smack_cred_free+0x30/0xa0
> [   11.454948]  security_cred_free+0x2f/0x60
> [   11.454948]  security_prepare_creds+0x2b/0x60
> [   11.454948]  prepare_creds+0x1b3/0x2c0
> [   11.454948]  copy_creds+0x2e/0x380
> [   11.454948]  copy_process+0x47e/0x2080
> [   11.454948]  ? find_held_lock+0x34/0xa0
> [   11.454948]  kernel_clone+0x9f/0x6c0
> [   11.454948]  ? __mutex_unlock_slowpath+0x43/0x2c0
> [   11.454948]  ? synchronize_rcu_expedited+0x3fa/0x4e0
> [   11.454948]  user_mode_thread+0x5f/0x90
> [   11.454948]  ? __pfx_kernel_init+0x10/0x10
> [   11.454948]  rest_init+0x22/0x1d0
> [   11.454948]  arch_call_rest_init+0xe/0x30
> [   11.454948]  start_kernel+0x63e/0x720
> [   11.454948]  x86_64_start_reservations+0x18/0x30
> [   11.454948]  x86_64_start_kernel+0x91/0xa0
> [   11.454948]  secondary_startup_64_no_verify+0x184/0x18b
> [   11.454948]  </TASK>
> [   11.454948] Modules linked in:
> [   11.454948] CR2: 0000000000000000
> [   11.454948] ---[ end trace 0000000000000000 ]---
> [   11.454948] RIP: 0010:smk_destroy_label_list+0x11/0x40
> [   11.454948] Code: 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00 0f 1f 44 00 00 55 48 89 fd 53 48 8b 3f <48> 8b 1f 48 39 fd 74 13 e8 c2 bd e2 ff 48 89 d8 48 89 df 48 8b 1b
> [   11.454948] RSP: 0000:ffffffffa3003c50 EFLAGS: 00010286
> [   11.454948] RAX: ffffffffa1f763e0 RBX: ffffffffa2f19b00 RCX: 0000000000000100
> [   11.454948] RDX: 00000000000000d8 RSI: 0000000000000000 RDI: 0000000000000000
> [   11.454948] RBP: ffff8d71c03300c8 R08: 0000000000400dc0 R09: 00000000ffffffff
> [   11.454948] R10: ffffffffa3003c48 R11: ffff8d7259ffc220 R12: ffff8d71c0330018
> [   11.454948] R13: ffffffffa3003e48 R14: ffff8d71c03c8000 R15: 0000000000000001
> [   11.454948] FS:  0000000000000000(0000) GS:ffff8d7259e00000(0000) knlGS:0000000000000000
> [   11.454948] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   11.454948] CR2: 0000000000000000 CR3: 000000014e03c000 CR4: 0000000000350ef0
> [   11.454948] Kernel panic - not syncing: Fatal exception
> [   11.454948] ---[ end Kernel panic - not syncing: Fatal exception ]---
>
> On 2024/01/27 23:36, Tetsuo Handa wrote:
>> The cred_free hook might be called without successful cred_prepare
>> as long as cred->security != NULL. It seems to me that smack_cred_free()
>> is not prepared for that case. Please check.
>>
>> prepare_creds() {
>>   new = kmem_cache_alloc(cred_jar, GFP_KERNEL);
>>   if (!new)
>>     return NULL;
>>   new->security = NULL;
>>   security_prepare_creds(new, old, GFP_KERNEL_ACCOUNT) {
>>     int rc = lsm_cred_alloc(new, gfp);
>>     if (rc)
>>       return rc;
>>     rc = call_int_hook(cred_prepare, 0, new, old, gfp) {
>>       // cred->security != NULL and one of callbacks returned an error
>>     }
>>     if (unlikely(rc)) {
>>       security_cred_free(new) {
>>         call_void_hook(cred_free, cred) {
>>           // at least one callback is called without successful cred_prepare
>>         }
>>         kfree(cred->security);
>>         cred->security = NULL;
>>       }
>>     }
>>   }
>>   goto error;
>> error:
>>   abort_creds(new)
>>   return NULL;
>> }
>
