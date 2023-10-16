Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 909F4CDB474
	for <linux-security-module@archiver.kernel.org>; Mon, 16 Oct 2023 03:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbjJPDgt (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 15 Oct 2023 23:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjJPDgs (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 15 Oct 2023 23:36:48 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E6DC5
        for <linux-security-module@vger.kernel.org>; Sun, 15 Oct 2023 20:36:45 -0700 (PDT)
Received: from [192.168.192.84] (unknown [50.39.103.33])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id B18613FB9B;
        Mon, 16 Oct 2023 03:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1697427403;
        bh=KjtzBYvRcPSpY9VVNSB7JvEwKiD4cpS5vA/uvFcf7cI=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=cbKikxIM9ajuAojP4s4VFWlyF1Sr5mBAMJpAq90SiiXyGnAkSVXna+fhpgep27ubl
         FqQUTGFV23HlgEXFdayhKuLHjhTwBxvEAzzxPtCP5EcImlHOw27QGk1N5//NJyVUfo
         /dolFN0qGjXPta1kOfdl0utknbxYfRzxPFqdbJOvdDTsOh4/pFUBp+WaaUlNOpnlbI
         9nOouKOJNXufkhymhbbxcQS5FQCWddExBD7iFm4jnwoB/uG8txj+a1sxmU0NAHNZlZ
         RrDnP8MRsb0w+Hp/kxFnzgN09sZvZ2887RJxrkmCUtafB2768W4bQRuVkIxYaEwyD3
         d4us27PT7qFhQ==
Message-ID: <0e81fdc2-9c4b-4147-91cd-22fa263b0a3b@canonical.com>
Date:   Sun, 15 Oct 2023 20:36:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] apparmor: Fix null pointer deref when receiving skb
 during sock creation
Content-Language: en-US
To:     Xiao Liang <shaw.leon@gmail.com>,
        linux-security-module@vger.kernel.org
Cc:     Matthew Garrett <mjg59@google.com>
References: <20230902004841.614102-1-shaw.leon@gmail.com>
From:   John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20230902004841.614102-1-shaw.leon@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 9/1/23 17:48, Xiao Liang wrote:
> The panic below is observed when receiving ICMP packets with secmark set
> while an ICMP raw socket is being created. SK_CTX(sk)->label is updated
> in apparmor_socket_post_create(), but the packet is delivered to the
> socket before that, causing the null pointer dereference.
> Drop the packet if label context is not set.
> 
>      BUG: kernel NULL pointer dereference, address: 000000000000004c
>      #PF: supervisor read access in kernel mode
>      #PF: error_code(0x0000) - not-present page
>      PGD 0 P4D 0
>      Oops: 0000 [#1] PREEMPT SMP NOPTI
>      CPU: 0 PID: 407 Comm: a.out Not tainted 6.4.12-arch1-1 #1 3e6fa2753a2d75925c34ecb78e22e85a65d083df
>      Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 05/28/2020
>      RIP: 0010:aa_label_next_confined+0xb/0x40
>      Code: 00 00 48 89 ef e8 d5 25 0c 00 e9 66 ff ff ff 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00 0f 1f 44 00 00 89 f0 <8b> 77 4c 39 c6 7e 1f 48 63 d0 48 8d 14 d7 eb 0b 83 c0 01 48 83 c2
>      RSP: 0018:ffffa92940003b08 EFLAGS: 00010246
>      RAX: 0000000000000000 RBX: 0000000000000000 RCX: 000000000000000e
>      RDX: ffffa92940003be8 RSI: 0000000000000000 RDI: 0000000000000000
>      RBP: ffff8b57471e7800 R08: ffff8b574c642400 R09: 0000000000000002
>      R10: ffffffffbd820eeb R11: ffffffffbeb7ff00 R12: ffff8b574c642400
>      R13: 0000000000000001 R14: 0000000000000001 R15: 0000000000000000
>      FS:  00007fb092ea7640(0000) GS:ffff8b577bc00000(0000) knlGS:0000000000000000
>      CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>      CR2: 000000000000004c CR3: 00000001020f2005 CR4: 00000000007706f0
>      PKRU: 55555554
>      Call Trace:
>       <IRQ>
>       ? __die+0x23/0x70
>       ? page_fault_oops+0x171/0x4e0
>       ? exc_page_fault+0x7f/0x180
>       ? asm_exc_page_fault+0x26/0x30
>       ? aa_label_next_confined+0xb/0x40
>       apparmor_secmark_check+0xec/0x330
>       security_sock_rcv_skb+0x35/0x50
>       sk_filter_trim_cap+0x47/0x250
>       sock_queue_rcv_skb_reason+0x20/0x60
>       raw_rcv+0x13c/0x210
>       raw_local_deliver+0x1f3/0x250
>       ip_protocol_deliver_rcu+0x4f/0x2f0
>       ip_local_deliver_finish+0x76/0xa0
>       __netif_receive_skb_one_core+0x89/0xa0
>       netif_receive_skb+0x119/0x170
>       ? __netdev_alloc_skb+0x3d/0x140
>       vmxnet3_rq_rx_complete+0xb23/0x1010 [vmxnet3 56a84f9c97178c57a43a24ec073b45a9d6f01f3a]
>       vmxnet3_poll_rx_only+0x36/0xb0 [vmxnet3 56a84f9c97178c57a43a24ec073b45a9d6f01f3a]
>       __napi_poll+0x28/0x1b0
>       net_rx_action+0x2a4/0x380
>       __do_softirq+0xd1/0x2c8
>       __irq_exit_rcu+0xbb/0xf0
>       common_interrupt+0x86/0xa0
>       </IRQ>
>       <TASK>
>       asm_common_interrupt+0x26/0x40
>      RIP: 0010:apparmor_socket_post_create+0xb/0x200
>      Code: 08 48 85 ff 75 a1 eb b1 0f 1f 80 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 41 54 <55> 48 89 fd 53 45 85 c0 0f 84 b2 00 00 00 48 8b 1d 80 56 3f 02 48
>      RSP: 0018:ffffa92940ce7e50 EFLAGS: 00000286
>      RAX: ffffffffbc756440 RBX: 0000000000000000 RCX: 0000000000000001
>      RDX: 0000000000000003 RSI: 0000000000000002 RDI: ffff8b574eaab740
>      RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
>      R10: ffff8b57444cec70 R11: 0000000000000000 R12: 0000000000000003
>      R13: 0000000000000002 R14: ffff8b574eaab740 R15: ffffffffbd8e4748
>       ? __pfx_apparmor_socket_post_create+0x10/0x10
>       security_socket_post_create+0x4b/0x80
>       __sock_create+0x176/0x1f0
>       __sys_socket+0x89/0x100
>       __x64_sys_socket+0x17/0x20
>       do_syscall_64+0x5d/0x90
>       ? do_syscall_64+0x6c/0x90
>       ? do_syscall_64+0x6c/0x90
>       ? do_syscall_64+0x6c/0x90
>       entry_SYSCALL_64_after_hwframe+0x72/0xdc
> 
> Fixes: ab9f2115081a ("apparmor: Allow filtering based on secmark policy")
> Signed-off-by: Xiao Liang <shaw.leon@gmail.com>

not sure how I dropped this one, thanks for the patch. I have pulled it into the apparmor tree

Acked-by: John Johansen <john.johansen@canonical.com>


> ---
>   security/apparmor/lsm.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index 108eccc5ada5..0dbff677ac2e 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -1097,6 +1097,13 @@ static int apparmor_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
>   	if (!skb->secmark)
>   		return 0;
>   
> +	/*
> +	 * If reach here before socket_post_create hook is called, in which
> +	 * case label is null, drop the packet.
> +	 */
> +	if (!ctx->label)
> +		return -EACCES;
> +
>   	return apparmor_secmark_check(ctx->label, OP_RECVMSG, AA_MAY_RECEIVE,
>   				      skb->secmark, sk);
>   }

