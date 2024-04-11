Received: from sonic301-38.consmr.mail.ne1.yahoo.com (sonic301-38.consmr.mail.ne1.yahoo.com [66.163.184.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50468524B8
	for <linux-security-module@vger.kernel.org>; Thu, 11 Apr 2024 18:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712859117; cv=none; b=aCe/ESFeBNWeeqMn75kL9Dm+twkqkf2pfcqM+VY7I+uOm1ripEpeKRmU3E5cLcDVv0XcHwbEMiEKxEKRlz+EheCftbtAHUjWkeNCKkoHr2YMTwH+7WKi/18huNy8AR+L1gIrZK9j5wzmekXWGjXUVOsRRnAUvv2e9k+iwHCcoKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712859117; c=relaxed/simple;
	bh=fxPGFgU/Gu2qIVD0v9icj6p4EvCNjr+aVsx0KWv6sUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QhPyr+GWMLcP2xCl/izlH+TstAoNT25aWkfgI6aChMQ9Vl/5Lt+rkqnyGtXcOPv69OEEkflKIM4+k6dI+EcVK1xSgUIqFx4UziXW+ZOHAw5bwXnjBlPDyurGqWPpV0BEQrrRK8BlDKaITYuuDYjlVcKT5PS7dewqFtJxnzeHypQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=mb+JV3Ot; arc=none smtp.client-ip=66.163.184.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="mb+JV3Ot"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1712859114; bh=AGUc3CpWvu4nY2pvBQl69xwBdaatN3iBx4KaC1OEhbw=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=mb+JV3OtpfxfJNfLl/xNACY+WGqqmbYMGejp43fznztQ/MKFzmdm21Q8vZK7blDgPFlF2Kyomb584th2piJTlQZ8fPc0ovyyv99fQ7EqWu22Xh8e4BSo4OhXa3WU3xTukBkNSOFtQ/J8ElQtdTD1GNS4Y6/iKayzDLVuHZz8iABolIeH8nVELMwtwJ417xZsOiXwxscNYLQtbMoZZK5HYGsArsRqzMa5RUClmT7Lv20GmyoWZgvHlLf1eTLyyoUq92cCCAtSdrscxYdgQ/rWDSAH9q7C/z7YYl/ClbOGAggR8Hvr4Xj8x05qwqZ58ERJCF0dFws+4qKW7x27L0HO5Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1712859114; bh=DFEjal08h3AzoF8gd2ZGOyDL8MNwD8hmafuV84aia58=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=S3MnOUfndoK7LfTT37NCTP47F92/dibJDqzHVCcgiO6P+wDR8QJYfbjXDIsjPdgC/cLp85wcR7EoqtGwniBGaUVxD5cvCgSrNdX/yBZO4hQmQxnqPE7I/QUTQOhUtQmiEvpDsJm7QXJ+WpU8vL7Rl4qewnTVZREVsaKndPKC5WBR1tfR2sgE3WL8V0aUBdKc25vp8dudSf+9KGL/x2u4elrSRxaIgoJqeWHXYth7qcrXI7ET6B2XAf/AFyt259Sys0FzPFqxvdWZCsWw1viyMz+3wwm/wxPfrNPz6ArPnJ4WXOWWIlQ/Ze/i1plhvPPnmf3PH5C8/BTqzEetZqmxZw==
X-YMail-OSG: 1NwZvv8VM1kGAtH3_9Rp_yc2ie9NwQxjEEHjxnClEOBT4YR0WAQtBAzygTjZ1J_
 .YYSWvzcUIkhF_9XFwMQKP9yPzjmnxKjt_cRn7itx_VbkCcMcYF63gSD6iD.PZU4RxV4xoz2DrJ_
 LsJq2o7X1V2Ie8rfpoPnjvvbjgjzunpf0dEfrH2RmkkXIMDp_fJgWH0CEWyNDdNTEZAdw3LXbkh4
 xjdLRUbjT5d5szUvv3GZ9ikORmMI2lakdOxdMAD.8FsD2Cbb1TrlBVoSM3rq5aZm.0CuUpDwLie7
 k0aa4EmaIEQNBajuZ7l3kL8pkHt5EK8OBYOZ7ZwivEedSsofud0tBKub0VTfuIYxZK9mMnm7c6j5
 Z6tIEuV3__yEzCLhXDdw1qL.tBTsTJyVwHfBtb1fkkd1WMCI9bYg5__CroN7D_2IZAyNaSXaFXow
 VOi7qE7puEFCp30y8odDnjQLLYtbyEbehg7D4.DfVTuuzzMHie7cylODFAHX.4rieex0MU6txvPJ
 Gn7mkeJ.2C1rs6q2id26lMoVcvJsDrtPt9YcftAnCgmkr780VDGVshY3sBt1OrAKKDIvdVOxax9C
 bxmQeaOq3O5M.XudO4ZGRnBhKuk23Iol7A63zkURin3rTcIk71XEBun0r0Jro2CNEkpcsL7zlUXf
 wVCauJJ1BJ49z6fT37BJbi3pnX.GwEgt_QPJWo6DNGyZHTRVo4hif26swB9y542oOPvuSDr9t4WP
 Lp.jCzfX5Z_MZWLbVzXfgVYjsIl2mhQREhkdYViptX_QTqJQBABUzlIgnhPCFUQWOsyk0m5Gd.6o
 PYdrdMAViu.oTkncMd2EwClfRpl.Pv6qb0WErlf2xS005MOWT1KYR0YvppjyYkJvzJ.yLCuphKnR
 NVcSrSSxmr_qTUC1PCM5DUJZ7zhLIBN4odgMMRfZPsRKDH_KsPnicxpTlBirLCafNWD3tMkBKR2i
 SFp4e7ZBdfjcNnUwo4Avzsyi2bL7LpY88QNVZLLlievyXN86oU17Tw0uiG5aS59NRLbjM5mGWkr8
 Png5rVzMUlfrhy4P4grEG61va4QkrxMTYnQbx0KsKZlWUTyj6kmNB6VP4Rb_poJalKMJJKPLz5WK
 ww7F_Jj75ZldUxcAAx884lo.cIbaa4MLo2q1ekUSRjl3lIERa1cOVWVb3wOUvOBmqZQ3HqSA.7Ki
 bZXtiD0gxv26vZk.5GBFrdBtStMRsNsnryDgYKFR_AgnqJsy0Zai9AzeU7XU6XZPnRWYQtpi2wfP
 n29fm5.5KxA2FT4U.vMKSWHu0B0iGn3S.UheS4nzMN5mtfWd689MhBXeOke6P66h9tx2oaD5O5sy
 z4xVBShoxIAA4kq897Mv02XmAaEpyzVJIcAE8ve.BL5hgawui9x.8mAfnyl1caZnzBJ9TAhFf7vg
 PJH5R_Fn95WzkvNDDgrXGaoxD_UkOz4h_qFoip2SEBGm0K1FOaKhyc58.iCCq.1nIWCxLRKXI863
 XdI4auymj8uQxCHQIDbit5OEsXq2BUGJ1BjvjBvbgyrkmTqc4zDMkbNSPLxu6Li13yqWefrU63eP
 5mlfLojEme62JbBmclToor8SVyN_wb1ZJWErtwOr82nS10jb88DgG3lrUrprStUX8vf1N.HD3OWR
 YsEEydrAblX_QzBDF1A.K6BcRyhU3vHXorLmZnJjpheT9qbnwGa6wd6S_kHyeO.3YoQGY0K_rWGs
 MZqQpcTjUE_CsXnk2OzcnWbGLRwPQeNBB708zOwF1cr0o1y8elsQ6izv48m9t4jwsN3T41UbTrMF
 d9Jwh_QD7SLzMtEi7sVT6Z8mCNqxVkuz3Ro9tG8BMOHZO5g.nmH4nrGBlWab2A79dkuHG.epgaOI
 Yr.k.1yWqT1kHOOzyAN_Ls8jS9LWU7LqShP85EgctevP8BCWVdbhAa4hPwO.olVjFi_XA9xDHB8.
 xwRnHz.l49JPHszdcSSIoaABXd9Q_BOv5psrmbW7zB9IFkAugQG.i3vL7HdQ3prJF8tHlnHyI83J
 3OVvuAaMTEyVO4pycRDl60WMm8f0BfANbPimZo7hfZlNfc1y0FgZu30scTQhq08v.spinpt6_Fdj
 0ZeI7hH07_7CZcDI2lv7UhLTobvkLP_YA6v3KmsMMlkxggsuThj_3UujjeJ947dN5ExPjvIekq_0
 utpj4cVCerxCkAfjrAnBGJMNCFpW_u3DaeXLJnHtaFd55UK5Eo4arSO43vuzY567IOxGRkEtzDoc
 tkxs_.zf72FKKfSJD8vxA5bzHK8mQ4p2hFjU3lx_RdHU4cc1i4Llgx1WzObz4qkPECdyO_gDannz
 RxwaOKfQ0OMo-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 495ae28c-051c-43fb-a631-2503446a3863
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Thu, 11 Apr 2024 18:11:54 +0000
Received: by hermes--production-gq1-5c57879fdf-p26ct (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 64e4e756082c99b2a120a94c12d83224;
          Thu, 11 Apr 2024 17:41:27 +0000 (UTC)
Message-ID: <a76d497c-5d87-4d00-a0f4-147b3f747bf5@schaufler-ca.com>
Date: Thu, 11 Apr 2024 10:41:24 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] netlabel: fix RCU annotation for IPv4 options on
 socket creation
To: Eric Dumazet <edumazet@google.com>, Davide Caratti <dcaratti@redhat.com>
Cc: Paul Moore <paul@paul-moore.com>, xmu@redhat.com,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-security-module@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <d1d6a20f5090829629df76809fc5d25d055be49a.1712849802.git.dcaratti@redhat.com>
 <CANn89iLyMv2JjEGRoAWb51TpxuMb5iCPb8dvTAmdJoZvx4=2LA@mail.gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CANn89iLyMv2JjEGRoAWb51TpxuMb5iCPb8dvTAmdJoZvx4=2LA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.22205 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 4/11/2024 8:56 AM, Eric Dumazet wrote:
> On Thu, Apr 11, 2024 at 5:44 PM Davide Caratti <dcaratti@redhat.com> wrote:
>> Xiumei reports the following splat when netlabel and TCP socket are used:
>>
>>  =============================
>>  WARNING: suspicious RCU usage
>>  6.9.0-rc2+ #637 Not tainted
>>  -----------------------------
>>  net/ipv4/cipso_ipv4.c:1880 suspicious rcu_dereference_protected() usage!
>>
>>  other info that might help us debug this:
>>
>>  rcu_scheduler_active = 2, debug_locks = 1
>>  1 lock held by ncat/23333:
>>   #0: ffffffff906030c0 (rcu_read_lock){....}-{1:2}, at: netlbl_sock_setattr+0x25/0x1b0
>>
>>  stack backtrace:
>>  CPU: 11 PID: 23333 Comm: ncat Kdump: loaded Not tainted 6.9.0-rc2+ #637
>>  Hardware name: Supermicro SYS-6027R-72RF/X9DRH-7TF/7F/iTF/iF, BIOS 3.0  07/26/2013
>>  Call Trace:
>>   <TASK>
>>   dump_stack_lvl+0xa9/0xc0
>>   lockdep_rcu_suspicious+0x117/0x190
>>   cipso_v4_sock_setattr+0x1ab/0x1b0
>>   netlbl_sock_setattr+0x13e/0x1b0
>>   selinux_netlbl_socket_post_create+0x3f/0x80
>>   selinux_socket_post_create+0x1a0/0x460
>>   security_socket_post_create+0x42/0x60
>>   __sock_create+0x342/0x3a0
>>   __sys_socket_create.part.22+0x42/0x70
>>   __sys_socket+0x37/0xb0
>>   __x64_sys_socket+0x16/0x20
>>   do_syscall_64+0x96/0x180
>>   ? do_user_addr_fault+0x68d/0xa30
>>   ? exc_page_fault+0x171/0x280
>>   ? asm_exc_page_fault+0x22/0x30
>>   entry_SYSCALL_64_after_hwframe+0x71/0x79
>>  RIP: 0033:0x7fbc0ca3fc1b
>>  Code: 73 01 c3 48 8b 0d 05 f2 1b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 29 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d5 f1 1b 00 f7 d8 64 89 01 48
>>  RSP: 002b:00007fff18635208 EFLAGS: 00000246 ORIG_RAX: 0000000000000029
>>  RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007fbc0ca3fc1b
>>  RDX: 0000000000000006 RSI: 0000000000000001 RDI: 0000000000000002
>>  RBP: 000055d24f80f8a0 R08: 0000000000000003 R09: 0000000000000001
>>  R10: 0000000000020000 R11: 0000000000000246 R12: 000055d24f80f8a0
>>  R13: 0000000000000000 R14: 000055d24f80fb88 R15: 0000000000000000
>>   </TASK>
>>
>> The current implementation of cipso_v4_sock_setattr() replaces IP options
>> under the assumption that the caller holds the socket lock; however, such
>> assumption is not true, nor needed, in selinux_socket_post_create() hook.
>>
>> Using rcu_dereference_check() instead of rcu_dereference_protected() will
>> avoid the reported splat for the netlbl_sock_setattr() case, and preserve
>> the legitimate check when the caller is netlbl_conn_setattr().
>>
>> Fixes: f6d8bd051c39 ("inet: add RCU protection to inet->opt")
>> Reported-by: Xiumei Mu <xmu@redhat.com>
>> Suggested-by: Paolo Abeni <pabeni@redhat.com>
>> Signed-off-by: Davide Caratti <dcaratti@redhat.com>

Please be sure to verify that this is appropriate for all users of netlabel.
SELinux is not the only user of netlabel.

>> ---
>>  net/ipv4/cipso_ipv4.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
>> index 8b17d83e5fde..1d0c2a905078 100644
>> --- a/net/ipv4/cipso_ipv4.c
>> +++ b/net/ipv4/cipso_ipv4.c
>> @@ -1876,8 +1876,10 @@ int cipso_v4_sock_setattr(struct sock *sk,
>>
>>         sk_inet = inet_sk(sk);
>>
>> -       old = rcu_dereference_protected(sk_inet->inet_opt,
>> -                                       lockdep_sock_is_held(sk));
>> +       /* caller either holds rcu_read_lock() (on socket creation)
>> +        * or socket lock (in all other cases). */
>> +       old = rcu_dereference_check(sk_inet->inet_opt,
>> +                                   lockdep_sock_is_held(sk));
>>         if (inet_test_bit(IS_ICSK, sk)) {
>>                 sk_conn = inet_csk(sk);
>>                 if (old)
>> --
>> 2.44.0
>>
> OK, but rcu_read_lock() being held (incidentally by the caller) here
> is not protecting the write operation,
> so this looks wrong IMO.
>
> Whenever we can not ensure a mutex/spinlock is held, we usually use
> rcu_dereference_protected(XXX, 1),
> and a comment might simply explain the reason we assert it is protected.
>
> (We also could add a new boolean parameter, set to true or false
> depending on the caller)
>
> old = rcu_dereference_protected(sk_inet->inet_opt, from_socket_creation ||
>
>             lockdep_sock_is_held(sk));
>
