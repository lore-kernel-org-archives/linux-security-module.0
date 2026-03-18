Received: from sonic305-27.consmr.mail.ne1.yahoo.com (sonic305-27.consmr.mail.ne1.yahoo.com [66.163.185.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C2730EF84
	for <linux-security-module@vger.kernel.org>; Wed, 18 Mar 2026 17:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773855012; cv=none; b=tlRpAG48v1FB9ARalxdpRdhCMV0bE9B7jJ/lL+9ErlY23xvAthzdQrggfmj/DfxYqIa3VLIMeQc8/GI0bv8zfJi0qto8k5zV/xDdRyI9KqHzK2T/mhNMvV51u5YXxm2O4PaboFXwiXw2RjNqlz9e4KlviIxWKMovPplf4D81/24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773855012; c=relaxed/simple;
	bh=bIzeQVGkCiUG162ntNSPeRIL8qyOp9EaP3VlvtQ3OA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dwGUInUwbx/3axV+Ezme1HA7rHurmqnkVEkgFqD4kjePyOov1Sv7dmIxfzjzOhkmbcb1opF/2ZpEGrAG/qrZPrI4iPCHYLR190f/IHJHj5BCB4xgfeqewI7xFvAL5zIo3roy1PMe/oMGtvUZ7ZXmgW1JqpR4lWquoG58GR4ypq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=CwkO8GQD; arc=none smtp.client-ip=66.163.185.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="CwkO8GQD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773855010; bh=F1grKodDVN14w3TCFp79PXRXW7VTHNJ1sL3qraWxeoM=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=CwkO8GQDmb9dZy7231m8whggO0vUXbYxTxwvp+BHtpd9W6hdEQGs5UQ//NinPY8+VtS35OoEyR6qJB6d9oqLzkvMIo+dm9rKe3/vTHnQ2N/nAJFcWnY0mdQLH1rh/Oq3LMYmOxb5pHWkCd4rJaCu13N2FMeb06g+2EgfihBSjdSfSJHiolGkhadPmPLgC5HrG0K+f6fNEbdZi3Kn49tXFFmja6cWZxFwa7fF8gBN/HahChanIyxpFURgxFugiz3qFuFc2YE4AmxWHaShuUDtNRGATrc4VHN1rCdps7TndvZ3biZ/kgBWzehrDF39lZiKQ0MSRTYZII1jpNwesZNkiQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773855010; bh=tZg+3PTl4nWrwo3MGGjQrxl/cAJCWsyLALPY52MZa1v=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=fkJwuMuCB2bI5XVmODENe7XKEQt9Fvbw+3NlB0SXbI0Z89+qYHCpEtEtGICjlK2WvyHLcD5wPiwlJJNQUV1d9MpOT3++KiV5QNDFnIS4D6K6DzwGfKWJ1y7D/Vby01gVFi9z9dxxLfcjCno5yO7+sXpNPPN8ZqkVHqHvbiJK4sSvCOr4qllEzF8py+yZfogHDTBA/2ncH3JqFlLhrQ2zkhrAh33ZoYkSksYH/xEMHskoo8BU+x8worOgcgD/aUlouNFwnCVjzo1B3yAg3Dd90mIFRPXfzIZkDDw+w2yr/nUlK0XXwN5vIBqnQ/D7U8Sa9H7W/Fhix2Uqo0htc1p7bw==
X-YMail-OSG: O_m32nYVM1kNKUn5gfLXI4Rscj2o8.lg2gJtolG9A0EltIBRExmTmbeV03xTUsJ
 XeywVARySrC_4Ep.vzSIKYKY5hpjbqOgczVbxYBI.NEv1dHQLgAXICtpMTkBh6ydrcRScIes3gZb
 N_mZIXJDQEZ5BHHmdBl3KuWBncz3W_6aDVQBrLfvBn1zpwld671Yg_z10IBK4QAMaw33D.JxaBKj
 ZzezqItqKkkxZax7x8FqsBGhZGzrt.2_ip9HIo0FgkbKPQELPnAJO1Xzfghu1CdXkI7rzeUHhh6a
 NhnOz0IgN13OyJuhknNYcSooCq0E1LcIedHJIFN49dlJGNi.x.fkIUvHHBD0KzHeBg.VrAgu2FOS
 0od0JIgcxYK0ADeiVf6p_omt2KzyxEB7bI4oOXrg9MYugr8ryQSzQNq8wE6xMyMj8GXPbX0nK8Z7
 2n9hNAP73.xEQPuGhi_PxBTIsQy3wbThcAOBz7_Gm_C1dx3r5z1_0l7NJg.gx27iqf8ZsRbAUD9n
 L7Xa6tLA7DgTLC2Q3dOP1EyQ6UMn4KB8LD61HPxk.h1bzjLJ1uM1AEOJCWqwPPSnbaxAHQ4YADT2
 aApmw7ObCbAB1rtVLXQKvuLHOrRs0ZJ9XPYg9cRPcqHO1tSfZqp0UyEDrZW0mcuLRxU3F9AEAJrd
 ty4_sfhD5k9rcU2l80SSxhQSyDfHU_58gMFet_bIES9fszxMJRKXQXnYzLt7n5o1y1UYenJLamGP
 d9UiYeX.kpM3Qp1Lt2k9sTVTQyXqdsbmmPYqHUiwgBV6M3tGyrCPVrc7i9ecgvpx4SCCui.KrUFA
 gZitS9u4doABz3wHxtToTo_JUy3IG1AK2yW8UQUqSxB9MQMyaEXx2812P7RL16zBGYhkA6sZVaEB
 gUEZXC9t7vNN50xuCZeaHy1shBli8lCIuBnuFLsojN5qFKTK1nsidBsIRg9dzgopw5AFW0RBVo3W
 vGVVxo0ltZpsaBc1pAN7sPhmg4q9CD9TVboTxNWkbC_UPP39WkVn6.eSBeS7mFMgGtybqgboFy6Y
 yYzE68tAhoBgAGOzDC25GpqGd5.2D.qNssjkFfYctiCSKtcIRbdSwL8tYolNeYsvIOeyXL_VMYKR
 wjlHCmtqEfkRh3GIEmPYGY9XjoHKO0Gae8pGPQeEdrST0mZ1UACpadxxo_LFQv.lzti784fNl.ya
 0OIeMyToAlWtyvKz7dDaZd9kGw8oouhBtA__62gpM_3NAXPGKHqXq6gUP37orApdlDSjUMPZry31
 LR8yrKrtSxZwosGvouAnxU4OhR2wKh_CtI9xZBMEu209DZgENUd.Hqxe36QNmcDYWufSXQLn.pNp
 RXV5w_sciMmb_kn4FfmjTC2JNSlenAWDsnvBpAnXLsye.LRqYS0OebeEkWdXhDlpkPaKeLq.77t4
 tG7M_DKOO8gSaUhEe.9GadwwrG3J.xYSXy5wrYonkyQYCozdZ3o_gcxFolieKUzi9Xzv7R6qvWai
 .SJ3Vz7.tGmFNJwHGp2SAH5vqRpSBaKZ1E4F6jAj2SVFwhDQvpqnaxRcysHAMzh5yHC4j7joRXXi
 YxDoaQM3Xlui9wVubvz5m_YK6CKgmVOTmtTtLPB9S66cy8S1nDRy6zXfKwNYuwyIy8Cr0A9_U.oi
 cEDxocIFSFy2hnkINiorMvN4rFad8UgZnr70IEbiUS0XAbzbneID98uPfwy5X9UmA76m18gjv.FO
 Wuc4c_muNC5T6PHFMNPgstLHREa2wluikMnVJeJauOvN2ozTJQKa9Q9tahErbVrDNfR2AtNn2b1V
 jT4tUqrJjgG2kRFBXJ2RpSTKPL4uw9O9nI52QYKGgJHwI86S8E1tMhHDkNhvdGkbvcI9kTG0wYRw
 t16Y5qs.k2wOX_s3RTm4O7jzh7LzDe4qHbY7l8DzY7vQmvbDlDhwiT263tk0DbB4WBiZjIuyA8lO
 1YgvEuqjfSbbXiDFevroWwNkTAzM3C2lnjWjAVIJ5vcO8YeJ6ZJafexOZMh0R1tsfOLIrb4OsHrR
 y83a7i9NNJ4Ms0owUGnWZVSgn80UFJvPQhMOsKGIzpQ_KRDnKg2ztt9P_42vX6ERum8SRImznlXm
 TM7Fx.tMFzA5fwns0WdaYYb7RgZ65VK2qbFyfOtwdYmzshynnxJpmKcD4ievXnopkVcvEU05FCdy
 .hL427kM_b0XdnxHL1J9xG_22jaU29wWhYXO77TC8GWwXnwbKZcxS6pfYfij44BzXTXbIagScgg5
 hhBYA_Wafetk4uGMSvNk3HNyQLVCjjbqRHOFCa5r8mdeZdEUY1Hx6NqjE_BSu7X_08OMjc1WnKil
 pNvq7yhThXbhE1cFeLBKK
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 15040319-32fb-4b75-97e7-8b3229ed246b
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Wed, 18 Mar 2026 17:30:10 +0000
Received: by hermes--production-gq1-6dfcf9f8b-gxljn (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 1eedf1af817e90a127bd795e708c76f5;
          Wed, 18 Mar 2026 17:09:49 +0000 (UTC)
Message-ID: <df35542e-d58f-47db-8a4f-92698281a69a@schaufler-ca.com>
Date: Wed, 18 Mar 2026 10:09:47 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lsm: Fix the crash issue in xfrm_decode_session
To: Feng Yang <yangfeng59949@163.com>, paul@paul-moore.com,
 jmorris@namei.org, serge@hallyn.com
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20260318061925.134954-1-yangfeng59949@163.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20260318061925.134954-1-yangfeng59949@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.25380 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 3/17/2026 11:19 PM, Feng Yang wrote:
> From: Feng Yang <yangfeng@kylinos.cn>
>
> After hooking the following BPF program:
> SEC("lsm/xfrm_decode_session")
> int BPF_PROG(lsm_hook_xfrm_decode_session, struct sk_buff *skb, u32 *secid, int ckall)
> {
>     return 1; // Any non-zero value
> }
> Subsequent packet transmission triggers will cause a kernel panic:

LSM hooks that use or provide secids cannot be stacked. That is,
you can't provide a BPF LSM hook and an SELinux LSM hook and expect
correct behavior. Your proposed "fix" removes a legitimate check.

>
> [  112.838874] ------------[ cut here ]------------
> [  112.838895] kernel BUG at security/security.c:5282!
> [  112.838902] invalid opcode: 0000 [#1] PREEMPT SMP PTI
> [  112.838905] CPU: 5 PID: 4962 Comm: test Kdump: loaded Not tainted 6.19.0-rc5-gae23bc81ddf7 #2 PREEMPT(full)
> [  112.838907] Source Version: 55e2f799c748c8e195569363edbd1d6a4159675a
> [  112.838908] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
> [  112.838909] RIP: 0010:security_skb_classify_flow+0x3f/0x50
> [  112.838914] Code: 85 db 74 28 49 89 fc 48 8d 6e 14 eb 08 48 8b 1b 48 85 db 74 17 31 d2 48 8b 43 18 48 89 ee 4c 89 e7 e8 05 33 86 00 85 c0 74 e3 <0f> 0b 5b 5d 41 5c c3 cc cc cc cc 66 0f 1f 44 00 00 90 90 90 90 90
> [  112.838915] RSP: 0018:ffffc28400200b10 EFLAGS: 00010202
> [  112.838918] RAX: 0000000000000001 RBX: ffffffff91d346d8 RCX: 0000000000000000
> [  112.838919] RDX: ffffa0890f5eaf80 RSI: 0000000000000001 RDI: ffffa0890f5eaf80
> [  112.838920] RBP: ffffc28400200d04 R08: 00000000000000c7 R09: 0000000000000002
> [  112.838922] R10: 0000000000000000 R11: 000000000000000f R12: ffffa089086dedc0
> [  112.838923] R13: ffffc28400200cf0 R14: ffffa08901ab2000 R15: 0000000000000000
> [  112.838926] FS:  00007fb087dd2680(0000) GS:ffffa0891ba80000(0000) knlGS:0000000000000000
> [  112.838927] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  112.838929] CR2: 00007fb087d1b940 CR3: 0000000107520006 CR4: 00000000000706e0
> [  112.838930] Call Trace:
> [  112.838931]  <IRQ>
> [  112.838933]  icmp_route_lookup.constprop.0+0xd7/0x460
> [  112.838941]  ? switch_hrtimer_base+0x135/0x180
> [  112.838944]  ? update_sg_lb_stats+0x9c/0x440
> [  112.838949]  __icmp_send+0x3d3/0x740
> [  112.838952]  ? __udp4_lib_rcv+0x427/0x6f0
> [  112.838955]  __udp4_lib_rcv+0x427/0x6f0
> [  112.838957]  ip_protocol_deliver_rcu+0xb7/0x170
> [  112.838960]  ip_local_deliver_finish+0x76/0xa0
> [  112.838961]  __netif_receive_skb_one_core+0x89/0xa0
> [  112.838967]  process_backlog+0x95/0x140
> [  112.838969]  __napi_poll+0x2b/0x1c0
> [  112.838971]  net_rx_action+0x2aa/0x3a0
> [  112.838972]  ? swake_up_one+0x41/0x70
> [  112.838974]  ? kvm_sched_clock_read+0x11/0x20
> [  112.838977]  handle_softirqs+0xe3/0x2e0
> [  112.838980]  do_softirq+0x43/0x60
> [  112.838982]  </IRQ>
> [  112.838982]  <TASK>
> [  112.838983]  __local_bh_enable_ip+0x68/0x70
> [  112.838985]  __dev_queue_xmit+0x1c4/0x820
> [  112.838987]  ? nf_hook_slow+0x45/0xd0
> [  112.838989]  ip_finish_output2+0x1da/0x4a0
> [  112.838992]  ip_send_skb+0x86/0x90
> [  112.838994]  udp_send_skb+0x15e/0x380
> [  112.838996]  udp_sendmsg+0xb9a/0xf80
> [  112.838998]  ? __pfx_ip_generic_getfrag+0x10/0x10
> [  112.839003]  ? __sys_sendto+0x1e4/0x210
> [  112.839005]  __sys_sendto+0x1e4/0x210
> [  112.839007]  ? __handle_mm_fault+0x2fc/0x6c0
> [  112.839013]  __x64_sys_sendto+0x24/0x30
> [  112.839014]  do_syscall_64+0x5f/0x270
> [  112.839017]  entry_SYSCALL_64_after_hwframe+0x76/0xe0
> [  112.839020] RIP: 0033:0x7fb087cfdb17
> [  112.839021] Code: 0c 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b8 0f 1f 00 f3 0f 1e fa 80 3d 55 c8 0c 00 00 41 89 ca 74 10 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 71 c3 55 48 83 ec 30 44 89 4c 24 2c 4c 89 44
> [  112.839023] RSP: 002b:00007ffea64704e8 EFLAGS: 00000202 ORIG_RAX: 000000000000002c
> [  112.839025] RAX: ffffffffffffffda RBX: 00007ffea6470638 RCX: 00007fb087cfdb17
> [  112.839026] RDX: 0000000000000008 RSI: 00007ffea64704f8 RDI: 0000000000000003
> [  112.839027] RBP: 00007ffea6470520 R08: 00007ffea6470500 R09: 0000000000000010
> [  112.839029] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
> [  112.839030] R13: 00007ffea6470648 R14: 0000000000403df0 R15: 00007fb087e15000
> [  112.839032]  </TASK>
>
> This BUG_ON was first mentioned in [1], but I could not find any explanatory record of why this check is needed.
>
> [1] https://lore.kernel.org/all/Pine.LNX.4.64.0607122149070.573@d.namei/
>
> In the existing LSM_HOOK_INIT(xfrm_decode_session, selinux_xfrm_decode_session),
> when the `ckall` parameter of the `selinux_xfrm_decode_session` function is 0,
> it can only return 0 and will not trigger BUG_ON.
> Therefore, remove the BUG_ON check to fix this issue.
>
> Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> Closes: https://lore.kernel.org/all/4c4d04ba.6c12b.19c039b69e6.Coremail.kaiyanm@hust.edu.cn/
> Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
> ---
>  security/security.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/security/security.c b/security/security.c
> index 67af9228c4e9..198f650070da 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -4991,10 +4991,7 @@ int security_xfrm_decode_session(struct sk_buff *skb, u32 *secid)
>  
>  void security_skb_classify_flow(struct sk_buff *skb, struct flowi_common *flic)
>  {
> -	int rc = call_int_hook(xfrm_decode_session, skb, &flic->flowic_secid,
> -			       0);
> -
> -	BUG_ON(rc);
> +	call_int_hook(xfrm_decode_session, skb, &flic->flowic_secid, 0);
>  }
>  EXPORT_SYMBOL(security_skb_classify_flow);
>  #endif	/* CONFIG_SECURITY_NETWORK_XFRM */
