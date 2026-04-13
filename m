Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67A533EB17
	for <linux-security-module@vger.kernel.org>; Mon, 13 Apr 2026 17:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776101973; cv=pass; b=GQpZNG36aTIHppx/Npe/0brVLbG12SMQumm9Fza3Q6QiewtluoUNmvFzriHnbHjQRn9czSc2qhFqjGoe9aU6x9JFIOOCXTeQC+abL12a62QNVT1PjD0vbg+2ItaHr7yC7FizKTS18L+uYYyXVCH0qxHjyC9AJt7mlUw0wyJmdoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776101973; c=relaxed/simple;
	bh=rKQ9Hpb6aVih0KTIEMP8PMbbVRPC/AvCTDbEfgEq8g0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FyG645At/SPcuHWUMCD1R6GCW3X9ZCoEEzwnM7pkaXsG+x4AzE3QaaNtPCVL7RILd3Q/Yrpr1LyEDA4/lqKlVCHw8XDKsrHatLricJB5PFyjIuM5IWEpNZKh7h87NK6Dgx1tCVrNQMgaNM3YMiSNyArQVu25WeKs09s8D77dPZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lvPK4ANn; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvPK4ANn"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2aae4816912so31248215ad.2
        for <linux-security-module@vger.kernel.org>; Mon, 13 Apr 2026 10:39:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776101970; cv=none;
        d=google.com; s=arc-20240605;
        b=BYO6J5ESOOZT4CKEEZE7FKvNHrg1JsEKcmuNdqKFVnd+61iT5E33+pyc/ntfVxFEWZ
         hKOcytD1b4j4in+5d1g4BLwG9c+ksvC09xYoQwOVUfar0xG/H/MIMoJ4nUTXr8xxEUnL
         JmiIT/c0tEeT5PMDLVEyrUR8xEy0L8mB65Ml9u0WJOhoXJgj4BqqTuWN7+cNJybB272U
         w3fUq8L6l1B0J7NY2DbfyLsozYToZ7C6XoiUVn3kTQ88XjE1EkRPBKa76RvcUkoxQTOT
         uBFu3H3P5rdzkXAyXTghDiI6kqqb2C/MDxkks7IEIsoNh2F2O6xilxa8hBay3jl0P37d
         WRUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fTz3nZwZa4XY+U5c6zkjfN45h/kh6vJ47bDjdrUBg6I=;
        fh=71mjMAyYm6jsTeOuFHfs0x4HtWA0kOpa4KREFO50UDo=;
        b=GtD+yjZCgpYaH0RbKpsXoJchIAaFxusZd1V6ZRr+DQSYNoRoAwKxh/GBnER/ziREub
         Tc0GXWqYQxooYb6e76FJ5G0js10Q4fguXiM0TQl2wOnbfhf5rvZZ/yy8GRD34ZH51APE
         WMNlyRgivYf+1LucpDycliTr69tV9V2zQBChV7Iz7DP94oa0usJQOn09fQ5cy0h1DqrD
         4s1UbkZshzopGUOT69x98ynYqE2ehA5RWaIuW0dvktNNqjxqTw/1lCYWc3V1wL799Jy1
         Tp/WC5dhT2c3a4pUY66Afho3HGR8+PiteK+SmWOXloqzRH0rWqoutMgUv6wMAcBN0ksD
         Ex9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776101970; x=1776706770; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fTz3nZwZa4XY+U5c6zkjfN45h/kh6vJ47bDjdrUBg6I=;
        b=lvPK4ANn2RZx1j+ueZ2usdO2Mofxqi8687VrzKl09WPB8fUkAH3iOlfnylLDyhQo2m
         MdwbjSoniyTf2iQ2/kMcgAHMz29gzdQ570rU6bp4B05Tpfv2tv5FaPP0KJB2ooP9MxQH
         pZ6WXMBxU1xBdSbWwXLnWfj8N8Ocbk6Y5CIP8sZDKlh0+gGYVEhKaSnvIzrT2nJVxZy5
         2Jxk49L7aBoJ/RClmgk0PN+Rc+lYP70ib8s58jCTOucEeiHb05aoxzNzg530PF+4vpiR
         ySh4kob90mq5C6m8/+iUkH74iGrG3gRaLW5bc940aIiTS+4IDA/4JrEagH3He90N6fWw
         G0Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776101970; x=1776706770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fTz3nZwZa4XY+U5c6zkjfN45h/kh6vJ47bDjdrUBg6I=;
        b=sAna2ztHaSl6pRihakimLOVYNz77Do663prVqb9DaFWQyL6fhvysIVkJo/BKNg0+7C
         eCwulOTin+H53nP8Qf8/uILMsk8Bmm5tSuaDR9QlafGjwa9oNkfHElDbT9RmUlk/7g0Z
         kXfwoDJQrFSGjes7jfEuH0EpGYJ3wwvAtNPWR0tZFydN4yjpLIqR5CBE0iRJOJTHfwod
         juC4XYU9k33NNQD0vlRMvPt9NYSDFi4/iv66uUaDxJjk3CZpXpQgJdRD40Ov+EZxVW24
         6r69nWfcFKV2DD3VByrd8VY+DrLZsXg2SH7IEYbsbKbQLxIbS2CYv0A82cABNrXfw3UZ
         STRw==
X-Forwarded-Encrypted: i=1; AFNElJ+UprnaYiY0IbKRgj6IxKjzbV64SdxxN5aUydiyCI66xDMLTzj5HQgqLVFDEgAny8lhDjoh89vj8ghhnXYPU7TluSTHePg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9AFvsGUrOLMz+3wMV4HB94EgajAReup8uspkCRg325kVXfuD+
	mgKvaTEQu3K6Ycd9qJr6bQj08x2NIgkHsTiOtLyncPsjgacBf2kkb6f6ATveD8ttIQmve8Vwf6x
	m0HCgS+LYwrPB3nLuxOU0s3Dg0IlMBf4=
X-Gm-Gg: AeBDiesIMfpujSjj8pcIxGNYlffhpGvDTp3E7DAcU9TSFTsmeZcarNhpcPDZ+sibX3w
	IcyS5YpHnhQcqC9B3DkFfQ9NEuVK0aqE16DZDE6ulkVbTDlmQiL+PzkgOTl//kBQAlH9PwZqPA8
	qz6Cza3qvPtkzPUSID04S3N+WiHfPVnbJJkuSxikk74AKkzG0Mnl8TFKTbKYmP2qBKKbemQJMxG
	VywbsnYDU9HmhnI0mGnOmRlSBX+aZL3ZQkOKyJvntkjNjusJ+QhhltYr2sEBwWdndsAFHj+fVNY
	ISyKFB0=
X-Received: by 2002:a17:903:11c3:b0:2b2:ec00:7966 with SMTP id
 d9443c01a7336-2b2ec008004mr75157345ad.21.1776101970070; Mon, 13 Apr 2026
 10:39:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318061925.134954-1-yangfeng59949@163.com>
In-Reply-To: <20260318061925.134954-1-yangfeng59949@163.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 13 Apr 2026 13:39:18 -0400
X-Gm-Features: AQROBzBYIB7SSDOkRvudsJjWuM3CfqQNyvnZgpYqJfbi-UlwukGVWSaPZN_SP-0
Message-ID: <CAEjxPJ6jPh9_P=56VfAhGQG-Y=njosFuV_Kys9kzhkm7PxRPLg@mail.gmail.com>
Subject: Re: [PATCH] lsm: Fix the crash issue in xfrm_decode_session
To: Feng Yang <yangfeng59949@163.com>
Cc: paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 2:20=E2=80=AFAM Feng Yang <yangfeng59949@163.com> w=
rote:
>
> From: Feng Yang <yangfeng@kylinos.cn>
>
> After hooking the following BPF program:
> SEC("lsm/xfrm_decode_session")
> int BPF_PROG(lsm_hook_xfrm_decode_session, struct sk_buff *skb, u32 *seci=
d, int ckall)
> {
>     return 1; // Any non-zero value
> }
> Subsequent packet transmission triggers will cause a kernel panic:
>
> [  112.838874] ------------[ cut here ]------------
> [  112.838895] kernel BUG at security/security.c:5282!
> [  112.838902] invalid opcode: 0000 [#1] PREEMPT SMP PTI
> [  112.838905] CPU: 5 PID: 4962 Comm: test Kdump: loaded Not tainted 6.19=
.0-rc5-gae23bc81ddf7 #2 PREEMPT(full)
> [  112.838907] Source Version: 55e2f799c748c8e195569363edbd1d6a4159675a
> [  112.838908] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS Vi=
rtualBox 12/01/2006
> [  112.838909] RIP: 0010:security_skb_classify_flow+0x3f/0x50
> [  112.838914] Code: 85 db 74 28 49 89 fc 48 8d 6e 14 eb 08 48 8b 1b 48 8=
5 db 74 17 31 d2 48 8b 43 18 48 89 ee 4c 89 e7 e8 05 33 86 00 85 c0 74 e3 <=
0f> 0b 5b 5d 41 5c c3 cc cc cc cc 66 0f 1f 44 00 00 90 90 90 90 90
> [  112.838915] RSP: 0018:ffffc28400200b10 EFLAGS: 00010202
> [  112.838918] RAX: 0000000000000001 RBX: ffffffff91d346d8 RCX: 000000000=
0000000
> [  112.838919] RDX: ffffa0890f5eaf80 RSI: 0000000000000001 RDI: ffffa0890=
f5eaf80
> [  112.838920] RBP: ffffc28400200d04 R08: 00000000000000c7 R09: 000000000=
0000002
> [  112.838922] R10: 0000000000000000 R11: 000000000000000f R12: ffffa0890=
86dedc0
> [  112.838923] R13: ffffc28400200cf0 R14: ffffa08901ab2000 R15: 000000000=
0000000
> [  112.838926] FS:  00007fb087dd2680(0000) GS:ffffa0891ba80000(0000) knlG=
S:0000000000000000
> [  112.838927] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  112.838929] CR2: 00007fb087d1b940 CR3: 0000000107520006 CR4: 000000000=
00706e0
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
> [  112.839021] Code: 0c 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b8 0f 1=
f 00 f3 0f 1e fa 80 3d 55 c8 0c 00 00 41 89 ca 74 10 b8 2c 00 00 00 0f 05 <=
48> 3d 00 f0 ff ff 77 71 c3 55 48 83 ec 30 44 89 4c 24 2c 4c 89 44
> [  112.839023] RSP: 002b:00007ffea64704e8 EFLAGS: 00000202 ORIG_RAX: 0000=
00000000002c
> [  112.839025] RAX: ffffffffffffffda RBX: 00007ffea6470638 RCX: 00007fb08=
7cfdb17
> [  112.839026] RDX: 0000000000000008 RSI: 00007ffea64704f8 RDI: 000000000=
0000003
> [  112.839027] RBP: 00007ffea6470520 R08: 00007ffea6470500 R09: 000000000=
0000010
> [  112.839029] R10: 0000000000000000 R11: 0000000000000202 R12: 000000000=
0000000
> [  112.839030] R13: 00007ffea6470648 R14: 0000000000403df0 R15: 00007fb08=
7e15000
> [  112.839032]  </TASK>
>
> This BUG_ON was first mentioned in [1], but I could not find any explanat=
ory record of why this check is needed.
>
> [1] https://lore.kernel.org/all/Pine.LNX.4.64.0607122149070.573@d.namei/
>
> In the existing LSM_HOOK_INIT(xfrm_decode_session, selinux_xfrm_decode_se=
ssion),
> when the `ckall` parameter of the `selinux_xfrm_decode_session` function =
is 0,
> it can only return 0 and will not trigger BUG_ON.
> Therefore, remove the BUG_ON check to fix this issue.
>
> Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> Closes: https://lore.kernel.org/all/4c4d04ba.6c12b.19c039b69e6.Coremail.k=
aiyanm@hust.edu.cn/
> Signed-off-by: Feng Yang <yangfeng@kylinos.cn>

Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>

With the proviso that we likely ought to follow up with a clean-up
that introduces a separate skb_classify_flow LSM hook that returns
void so we don't awkwardly ignore errors below and defer handling to
the individual security module.

> ---
>  security/security.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/security/security.c b/security/security.c
> index 67af9228c4e9..198f650070da 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -4991,10 +4991,7 @@ int security_xfrm_decode_session(struct sk_buff *s=
kb, u32 *secid)
>
>  void security_skb_classify_flow(struct sk_buff *skb, struct flowi_common=
 *flic)
>  {
> -       int rc =3D call_int_hook(xfrm_decode_session, skb, &flic->flowic_=
secid,
> -                              0);
> -
> -       BUG_ON(rc);
> +       call_int_hook(xfrm_decode_session, skb, &flic->flowic_secid, 0);
>  }
>  EXPORT_SYMBOL(security_skb_classify_flow);
>  #endif /* CONFIG_SECURITY_NETWORK_XFRM */
> --
> 2.43.0
>
>
