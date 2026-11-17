Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794918386;
	b=aYSTVDPoMnym16urhvlXn2h9WFMGb140FLWUB6Skv8KznyvmiE2EmpXdMdu7w4kr450p
	 L0BTAd9mCveamI6K52H1sbN9FETlpCEaEHt/StR+HEzllvxETdUoJ2ME1fzbtiXNX6bWh
	 v4P34fMNsqxkgzgJYmeldcrnkU03XC835+NpkF5dBdzjA+XSbARehYQEr0SMi38ZGPDm+
	 qOuTj5fL/7OpzXu9OIKkM2PyrbG1aFMtxFk4lCpfMPUbC7JEgp+U5+HrNVMVrGh79H4Cd
	 yc/6qlgHFUkxKIYMWefahNgYrbQy3a3VmD6Jajw9339k+VhoeksN0DlGxeKsstmcPRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794918386;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:From:In-Reply-To:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Language:
	 Content-Type:Content-Transfer-Encoding;
	bh=JhEF3QYgCBT5k7drshdDG8SKBLfKYdoUoRI0T7Kouwk=;
	b=2ehIoqhSIk8yrHdj8uSdVn4YoE/MAr+nhRVZLDgJhE3flquaJP5Jb5SR6e3uPM1rwGFX
	 p2po/FGi7WZZoRgOnDjWNLrwnnNg7UVwsAD4Ji57ucMssIYgBKog5CYRVzOhaohZ3RtOl
	 OwoFFTlHgrCzlzKoVsFvznFOQAyOfWaQ1WLy3SWO8sSvyfmQ3e3/jaQ3hBu0BM/s69zwh
	 40dJ41jcVaLE8gPufeoDQos+mQOeCcL9wUNNm7brWbltH/8s79zePigdFfqyAAC6egNBd
	 LxQkOpWOSA9pJ4f74+okYsG62YdBmYIf8+r2+uuT7oBvbyFzjf4mAenMQ+GmPiXilQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Re81gehC;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A32606A323
	for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 12:26:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93A32606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Re81gehC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794918384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JhEF3QYgCBT5k7drshdDG8SKBLfKYdoUoRI0T7Kouwk=;
	b=Re81gehCZ1PHaOLfqlohfNTAeFiyuygY7XqGFzmmtBbKKDws/IXQKiBjM071xinvLcYodu
	86jH6eStHehKFzeNjdffLWhcNPf3YO3Xv/Cxuca86yI8H5wnEt1cmdayiuY59LHh4MqMa8
	PfZ5ujOTHOfUfJdp/8Tv3riUwWMy3X8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-OUpwOjXhOZeqbkV9GEKuPQ-1; Tue, 17 Nov 2026 07:26:23 -0500
X-MC-Unique: OUpwOjXhOZeqbkV9GEKuPQ-1
X-Mimecast-MFC-AGG-ID: OUpwOjXhOZeqbkV9GEKuPQ_1794918382
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4bb67b2c00cso4603225e9.1
        for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 04:26:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794918382; x=1795523182;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JhEF3QYgCBT5k7drshdDG8SKBLfKYdoUoRI0T7Kouwk=;
        b=huizmd2toi3jNHyLlvG7UKk11y85Z6f3dhiCT4hGLQYxKsTNBT9f4AyApSEj2OYPn4
         Nzr0yfseiR8VRqImkdIKGEwVy6NuSdwTtX+G6L9pNrgP1wVUKyct6BU2tasaAy/89ziO
         7irxgXMO6lMIjJc9PinGjXngQvskVmiyne9fmTxdsSp/laFnpTcYUrGQuKt2URFGWlug
         1mouFWMOHw9UiAvidU4qNa6kJopRAv2OmizT0bZ8G0DrLSiDHpZGv1wQfVj/NRSR2CK5
         PS6Wbq/guuKhfFRvHaEU/G7GLu+18Jxqh3munPB7h1UcDoMVTmsTL0QI5Z9UUHwouUXT
         N/tQ==
X-Forwarded-Encrypted: i=1; AL+hErGJYIFSLVqTH3HCIZrfsGPJmWEQ6YMtm89pTSgaVLmQa7tQ17RBW5lyXLXCKn5qFf88sd4M0WIFtv1Bzearv4un1ft+Dqs=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Av9YMIa5oYxYT2qimP6BfvsRUFS8MpzaE6i0Ku2GtU9kk2Ydp
	xqsT+GHqJz+G325+C3ewbwUs5HyoTvtyWOpJYp8R1UcoQddY1tfOrRObaKQUeHy+cUYG9HVNVcx
	dH9Y5BnaJg+KJSqh+2Ff9Xp97YTb9RGelqoLXFiCRBMyAXYE8DtJASEIRP+ts6cqKDjW3NsxmBE
	ecww==
X-Gm-Gg: AYBFou0xPl80Vpr0dpx0o4FwRTmqMSF4rlOMbMxJ3mCc5bcQOFwApSuTaZ+6nVL4Nmz
	VZsva8ZCLvm4iHO0/D/IzX5tMv3ntP+7CRfcxnXDrVMXQ5IJ7PmUPP6lr0+Ga5OI8VNERPmHpkZ
	RdS80wI5tf2A/U0+MGRhP2BCFwtRAOV/dL/wMjELj0zlsh4HKIA1Sgx5+uGNAQJQAjdaetffAxV
	LuPfc5xFwooJKFEByIUDmJDYFN9cLvdKk05JKyrgEDQOe+u2d6GuZ2mYrXN6FMlBEjyxE4GjlvV
	Q97O9UAkV+JJcuAliLC6WDEwPSBnIeGyfRzM01SB6pVpbb1G+vvmLLhLyuPiu2+s/Td/vM9SMxF
	hmu1Q5qSrStzBbJAXf1b7YnAn16idN43dJ0PzVR2awuPr3TyzB8AyD2rzlnDZuyY/C7SyeBAyX1
	TtXB7aYBoPcUXKJMwykafDthUWPtHk4OI3fRmhjHJNtRYA
X-Received: by 2002:a05:600c:5012:b0:4b4:a551:681a with SMTP id 5b1f17b1804b1-4bb7837264cmr54139535e9.3.1794918381863;
        Tue, 17 Nov 2026 04:26:21 -0800 (PST)
X-Received: by 2002:a05:600c:5012:b0:4b4:a551:681a with SMTP id 5b1f17b1804b1-4bb7837264cmr54138805e9.3.1794918381402;
        Tue, 17 Nov 2026 04:26:21 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb783f7eecsm114134115e9.3.2026.11.17.04.26.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2026 04:26:20 -0800 (PST)
Message-ID: <cbaa372f-6ec1-4ceb-a012-30eaac5ae8eb@redhat.com>
Date: Tue, 17 Nov 2026 13:26:19 +0100
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipv6, calipso: fix data-race in calipso_cache_add()
 bucketsize check
To: Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org,
 paul@paul-moore.com
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Huw Davies <huw@codeweavers.com>,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261115144508.71543-1-jiayuan.chen@linux.dev>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261115144508.71543-1-jiayuan.chen@linux.dev>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: aFQhki_VfphLkxJFR5vZyEXtgMljqSs7iNIm5B7h36Q_1794918382
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/15/26 15:45, Jiayuan Chen wrote:
> Issue found by sashiko when reviewing my data-races patch [1]. This is
> not a plain READ_ONCE() annotation like the rest of that series but a
> real fix, so it is sent separately.
> 
> calipso_cache_add() reads calipso_cache_bucketsize twice: the "<= 0"
> guard on entry, then the "size < bucketsize" test after taking the
> bucket lock. A writer can flip it to 0 in between:
> 
>    CPU0                                    CPU1
>    calipso_cache_add()
>      calipso_cache_bucketsize == 10 (> 0)
>                                            proc_dointvec()
>                                              calipso_cache_bucketsize = 0
>      spin_lock_bh(&bucket.lock)
>      size(0) < calipso_cache_bucketsize(0) -> false
>      -> else branch, but the bucket is empty
> 
> On an empty bucket the else branch takes list.prev (the list head
> itself), list_del()s it and then list_add()s through the now poisoned
> head:
> 
>   Oops: general protection fault, probably for non-canonical address
>   0xdead000000000108
>   RIP: 0010:calipso_cache_add+0x2f0/0x380
>   Call Trace:
>    <IRQ>
>    calipso_cache_add+0x4c/0x70
>    netlbl_cache_add+0x4a/0xa0
>    selinux_netlbl_skbuff_getsid+0x1ac/0x280
>    selinux_skb_peerlbl_sid+0x7d/0x100
>    selinux_socket_sock_rcv_skb+0x2d3/0x460
>    security_sock_rcv_skb+0x86/0x150
>    sk_filter_trim_cap+0x56/0x730
>    sock_queue_rcv_skb_reason+0x1e/0x80
>    rawv6_rcv+0x679/0xb20
>    raw6_local_deliver+0x1f0/0x5b0
>    ip6_protocol_deliver_rcu+0x215/0x9a0
>    ip6_input_finish+0xb0/0x1b0
>    ip6_input+0xa8/0x250
>    ipv6_rcv+0x14b/0x1c0
>    __netif_receive_skb_one_core+0x8f/0xe0
>    __netif_receive_skb+0x23/0xb0
>    process_backlog+0x27a/0x950
>    __napi_poll.constprop.0+0x61/0x2c0
>    net_rx_action+0x372/0x800
>    handle_softirqs+0x109/0x570
>    __do_softirq+0x10/0x18
>    do_softirq.part.0+0x47/0xd0
>    </IRQ>
>    <TASK>
>    __local_bh_enable_ip+0xf0/0x120
>    __dev_queue_xmit+0x578/0x23f0
>    neigh_resolve_output+0x278/0x3c0
>    ip6_finish_output2+0x4b1/0xcb0
>    ip6_finish_output+0x2b6/0x6b0
>    ip6_output+0x122/0x400
>    ip6_local_out+0x61/0xb0
>    ip6_send_skb+0xa0/0x260
>    ip6_push_pending_frames+0x2b/0x40
>    rawv6_sendmsg+0x1b7a/0x2750
>    inet_sendmsg+0xa1/0xb0
>    __sys_sendto+0x2fe/0x350
>    __x64_sys_sendto+0x7f/0xb0
>    do_syscall_64+0xe1/0x450
>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> Snapshot the sysctl into a local once and use it for both tests, like
> cipso_v4_cache_add() has since commit dd44f04b9214 ("cipso: Fix
> data-races around sysctl.").
> 
> [1] https://lore.kernel.org/netdev/179428999963.994134.16904544500890053668@kernel.org/
> 
> Fixes: 4fee5242bf41 ("calipso: Add a label cache.")
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
LGTM, but let's wait for Paul's explicit ack.

@Paul: please LMK if you prefer we apply this kind of
simple, clean fixes directly.

Thanks,

Paolo

