Return-Path: <SRS0=m40R=BG=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3146CC433DF
	for <linux-security-module@archiver.kernel.org>; Mon, 27 Jul 2020 17:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D3EB20719
	for <linux-security-module@archiver.kernel.org>; Mon, 27 Jul 2020 17:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="g1l9SSzE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbgG0RjB (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 27 Jul 2020 13:39:01 -0400
Received: from sonic304-27.consmr.mail.ne1.yahoo.com ([66.163.191.153]:46447
        "EHLO sonic304-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728925AbgG0RjB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 27 Jul 2020 13:39:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1595871539; bh=LGa1jWK7SPBIAi5jJvHN6JgXuFi2frxeUddBdkcQo1I=; h=Subject:To:References:From:Date:In-Reply-To:From:Subject; b=g1l9SSzEqiN2JPWkV64MbFx8KtvzUvbq+oT0jY/PtD10DmTIbBmjZQ/LhaFKs/AQF4F9qN5pfgs8vl+qs9yzqfiV6X49aCj62CQgGhIH1ygNfU/uCDWCVu1ZanYGx01f2AnX3gUehcwIcUsOd9oMaiohG4WPkWpbFfYOMoZ/xESLUYw8wuZi95a/ImRLNZDOBX+D/uRgG1EQlssiCvV4DsteVdgCFI9Ee6Par1cDYr0PY8Y2DkGZYQu0MxWT9oz6yUpLAa6/ernqG6h/0DrqS6F5KcYrzmwXbb7KhQpKgWK2O8+qOlwSpJLsPMJqhPP4LJuBB2/OK7x9NFOpviVsdQ==
X-YMail-OSG: A18RaT4VM1nP8gb2HwQPW4pXgaqlT4PZaQp3HHq6Q_ynjj4HWmblTjSwUisBvhi
 22F1AYDA6GZu4Pv_3usp2ZH0IsizMytqyptlSq_DVBQ4oqLCU_NniBY2apMrhwHW5TlESUsH.VrN
 P5_Jja2SdwL0GZtkbq6QY01xKjvE6p94RHrPKHQZk8pLE4b08_135LNtqJNMm_wUrv635hkzonSC
 Zwd5EOccWAaJsOM66hBTWyBRt2eK7oiFuWvmzlfmIOYD3hTWwJZjNAeObzxXpewkBNKq6mU31QlD
 Tbfa0hQU_95ad.zfidy0OyP.q1JaQ3l3MaxZXJEQXotZTx7q6c_bE4lFcJ0bbi.r7IzOQ7V7YOuw
 Z3mXbzFq2oKtx9UHWPGdMdXdAmxgY1zn2HCB4tnBb.nfbVam.VljtTizSJMc.lmIbSgAi0S3TkN0
 uJ8SpXDF5tioD124huT.WiI5EY4yQkHaEBOFl9rCFtvf4u5ddtxHMYg6CrboYyft0TRKweC38K37
 P7azTgH_2wkv6Mb2c0nz..WSO7Aqn.8fAJWn4qxtlwt2LWFBu8U1Ld1SSEARgp5mis0UduoKtsIh
 1o_asE65mFOe4zSCD3B1NVFwlt0n5n0gTbMg2zQfD6E6XsTO3JTEQX7n0gH3Wq_HjVVV6kXc734i
 gzRcyGnf7tgWT3E0bVOO9WK.SkNavtJAf.jxGiOsDKAlilvHyUF0ghMkCeRk6C69yMagfouRmG5j
 L2fuOaO.4a4wga5.GCaU0JQjsWbxbQQLXTfcZdJNb.fTHQDqaghWouYU_GFSvqFeQ16fK5oEF2bO
 C.C0BHyryB8b4eaqou985kxfxQNXO8_zyv.3O5IzHKJ0Ud_fwvvmAAcQtyonm1K.1zOtwgrG5UW.
 N1iQok9zHj49_UBh_eteEX4Jy4qiC5hdqPTnvScSJz5XX8fXDNCBKAkOLyqCMWLA4POhJFRCNPcc
 PdDvvE2qeeS.0Q_hcJ7_zJQCezQtKV3XRUdQM2V7ic2wd6G1sH7Dt3.6Yzr2KmhUNbFIdKnEuQgO
 Xi68l4hPDujtWnsmCnLQjG4Gvzowxf_5gVJ9K7xpO_n8u4U7nTyFfTeMAOzsZgp8jmxTH41iYdUj
 KbRvw_deizZ13QoXB41_CrzdslAF3E8OP3GzYhW_S5r9D12Vo3Glr91bBpCYuBxBujsvbO8EUuVG
 Fr2ulehX0RkdwU3wE2vPm49gAtuzzIYM72SwQrZJtKAh8QQOiuDMnB_TR2GqJXIiJ_w8hO0TRBNU
 64tmwmpuM7dHhIMlNTuATgUta6UOv3HcCZ6MBiWuepyO35ZG1rk9XSdPv7L0G7x8SNbjWLnQKqPr
 SV8B5T.h6LTT6zdXWN6cqxg5D4G_9gMmAoiEx_iyTLUD2tZDJxlS.M4zdBfMvtwy7b0qd3zTsPQb
 oapsIVB0fcTo.Ft7k7JsZdwZwbwc-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Mon, 27 Jul 2020 17:38:59 +0000
Received: by smtp425.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 1e84a27df51e1e434534735c680d17c4;
          Mon, 27 Jul 2020 17:38:58 +0000 (UTC)
Subject: Re: [PATCH] smack: fix slab-out-of-bounds by checking for overflow
To:     B K Karthik <bkkarthik@pesu.pes.edu>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        skhan@linuxfoundation.org, syzkaller-bugs@googlegroups.com,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20200725125800.vahdiagxilinzoqw@pesu.pes.edu>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <cce0db29-cd6f-ed8b-c2d3-b35e774e358c@schaufler-ca.com>
Date:   Mon, 27 Jul 2020 10:38:58 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200725125800.vahdiagxilinzoqw@pesu.pes.edu>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.16271 hermes_yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.7)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 7/25/2020 5:58 AM, B K Karthik wrote:
> add a barrier to smk_set_cipso() to check for overflow

Thank you for your patch. Dan Carpenter <dan.carpenter@oracle.com>
has already submitted an identical patch.

>
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in vsscanf+0x2666/0x2ef0 lib/vsprintf.c:3321
> Read of size 1 at addr ffff888097d682b8 by task syz-executor980/6804
>
> CPU: 0 PID: 6804 Comm: syz-executor980 Not tainted 5.8.0-rc5-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1f0/0x31e lib/dump_stack.c:118
>  print_address_description+0x66/0x5a0 mm/kasan/report.c:383
>  __kasan_report mm/kasan/report.c:513 [inline]
>  kasan_report+0x132/0x1d0 mm/kasan/report.c:530
>  vsscanf+0x2666/0x2ef0 lib/vsprintf.c:3321
>  sscanf+0x6c/0x90 lib/vsprintf.c:3527
>  smk_set_cipso+0x374/0x6c0 security/smack/smackfs.c:908
>  vfs_write+0x2dd/0xc70 fs/read_write.c:576
>  ksys_write+0x11b/0x220 fs/read_write.c:631
>  do_syscall_64+0x73/0xe0 arch/x86/entry/common.c:384
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x4402d9
> Code: Bad RIP value.
> RSP: 002b:00007ffe89010db8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 00000000004402d9
> RDX: 0000000000000037 RSI: 0000000020000040 RDI: 0000000000000003
> RBP: 00000000006ca018 R08: 0000000000000014 R09: 00000000004002c8
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000401ae0
> R13: 0000000000401b70 R14: 0000000000000000 R15: 0000000000000000
>
> Allocated by task 6804:
>  save_stack mm/kasan/common.c:48 [inline]
>  set_track mm/kasan/common.c:56 [inline]
>  __kasan_kmalloc+0x103/0x140 mm/kasan/common.c:494
>  __do_kmalloc mm/slab.c:3656 [inline]
>  __kmalloc_track_caller+0x249/0x320 mm/slab.c:3671
>  memdup_user_nul+0x26/0xf0 mm/util.c:259
>  smk_set_cipso+0xff/0x6c0 security/smack/smackfs.c:859
>  vfs_write+0x2dd/0xc70 fs/read_write.c:576
>  ksys_write+0x11b/0x220 fs/read_write.c:631
>  do_syscall_64+0x73/0xe0 arch/x86/entry/common.c:384
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> Freed by task 4906:
>  save_stack mm/kasan/common.c:48 [inline]
>  set_track mm/kasan/common.c:56 [inline]
>  kasan_set_free_info mm/kasan/common.c:316 [inline]
>  __kasan_slab_free+0x114/0x170 mm/kasan/common.c:455
>  __cache_free mm/slab.c:3426 [inline]
>  kfree+0x10a/0x220 mm/slab.c:3757
>  tomoyo_path_number_perm+0x525/0x690 security/tomoyo/file.c:736
>  tomoyo_path_mknod+0x128/0x150 security/tomoyo/tomoyo.c:240
>  security_path_mknod+0xdc/0x160 security/security.c:1077
>  may_o_create fs/namei.c:2919 [inline]
>  lookup_open fs/namei.c:3060 [inline]
>  open_last_lookups fs/namei.c:3169 [inline]
>  path_openat+0xbe8/0x37f0 fs/namei.c:3357
>  do_filp_open+0x191/0x3a0 fs/namei.c:3387
>  do_sys_openat2+0x463/0x770 fs/open.c:1179
>  do_sys_open fs/open.c:1195 [inline]
>  ksys_open include/linux/syscalls.h:1388 [inline]
>  __do_sys_open fs/open.c:1201 [inline]
>  __se_sys_open fs/open.c:1199 [inline]
>  __x64_sys_open+0x1af/0x1e0 fs/open.c:1199
>  do_syscall_64+0x73/0xe0 arch/x86/entry/common.c:384
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> The buggy address belongs to the object at ffff888097d68280
>  which belongs to the cache kmalloc-64 of size 64
> The buggy address is located 56 bytes inside of
>  64-byte region [ffff888097d68280, ffff888097d682c0)
> The buggy address belongs to the page:
> page:ffffea00025f5a00 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff888097d68c80
> flags: 0xfffe0000000200(slab)
> raw: 00fffe0000000200 ffffea000288fe08 ffffea00026f38c8 ffff8880aa400380
> raw: ffff888097d68c80 ffff888097d68000 000000010000001e 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>  ffff888097d68180: 00 00 00 00 01 fc fc fc fc fc fc fc fc fc fc fc
>  ffff888097d68200: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>> ffff888097d68280: 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc
>                                         ^
>  ffff888097d68300: 00 00 00 00 01 fc fc fc fc fc fc fc fc fc fc fc
>  ffff888097d68380: 00 00 00 00 01 fc fc fc fc fc fc fc fc fc fc fc
> ==================================================================
>
> Reported-and-testedby: syzbot+a22c6092d003d6fe1122@syzkaller.appspotmail.com
> Signed-off-by: B K Karthik <bkkarthik@pesu.pes.edu>
> ---
>  security/smack/smackfs.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
> index 58d3f43cc8bb..17809310d046 100644
> --- a/security/smack/smackfs.c
> +++ b/security/smack/smackfs.c
> @@ -905,6 +905,11 @@ static ssize_t smk_set_cipso(struct file *file, const char __user *buf,
>  
>  	for (i = 0; i < catlen; i++) {
>  		rule += SMK_DIGITLEN;
> +		if (rule > data + count) {
> +			rc = -EOVERFLOW;
> +			goto out;
> +		}
> +
>  		ret = sscanf(rule, "%u", &cat);
>  		if (ret != 1 || cat > SMACK_CIPSO_MAXCATNUM)
>  			goto out;
