Return-Path: <SRS0=iZqy=5M=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCCA3C2D0E5
	for <linux-security-module@archiver.kernel.org>; Fri, 27 Mar 2020 16:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CBC020675
	for <linux-security-module@archiver.kernel.org>; Fri, 27 Mar 2020 16:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="CQMXX77U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbgC0QQk (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 27 Mar 2020 12:16:40 -0400
Received: from sonic313-14.consmr.mail.ne1.yahoo.com ([66.163.185.37]:46834
        "EHLO sonic313-14.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727720AbgC0QQk (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 27 Mar 2020 12:16:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1585325796; bh=HFuI13PEQtQ9MgZ0ugnvvIZY2dLA/TTsyBTrO9Bs3p4=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=CQMXX77UUYf44ZM9T7oDVovTXs96mHYyWRAIrHWEQVG7lX12ckE4hldEb/9jifHCMd/DSFqP7xCDhZJTlvAQDtWgQtNxmnlPj4uIxfcCxIjCXRqISD/gYGNx+s7n71kaRdQZpdyrLS6+aNzmHEqZWIUgw+ONge48pzd1wC8fLf29I6T4qrpI72BPyB0X2L96pMItSQO1yPC/3ai97yaduuztnrGoXMmQ113JIttIejSHkNpFZ8UM7oPxwQirDL8CFLyBcVoPnndkeBwDhulAl8vL9AxFpRGleL0xYILMsE9GsWUQpThsr52pvWLqKkDnlnLgrv0i001d/rQzDcs/vg==
X-YMail-OSG: W_nM40AVM1nqLq_myrPgIs5ocDZiJN_Rk1hFKuFmnEw4BmOEr0o9.4L0vE7.lrb
 5kWSyaDR8twuwlYKIh0r0CBkyqFlwMfls97pQ6w_egfFy0i9wKGuWzEtwumWnBgBr3CFEUOTU12k
 OBMnFjZGmOl4MqHK3959QGWjxsMtSxURtmdHRi.dFHpPaf9ciNiIpt.htttYCzZd0tquFujMZcVB
 Mv9Aku6h_RbPSyTzA4BDG2kENDrV7vHZMV8wpSV0PwcRaRtnKMdd3hTV2BfB1amW259zZCX4I5lz
 r2oPWWK2OqfaZAglj5ugz9PULT3iDTl7z7BmLoaJxcbLCASFIxoGOUdHj1GZ3Y1ZYo.f8PX5hetE
 xonGkZ8sOF_ptz2CZ8kR7fVnzNAp79t59fwcLfy6guW4rFwm2VRb4L1mEHhqXjcaza0gWOPfKmYX
 hQEpzGZMhcM0Cx2Mj0hT9oAj7noPVzfm8glP.YIYvPf9SWoEO_e3ptVaj5oTAHML63veTzvH5xiV
 xL3zlupHr3LOgUhrHdE3aPCJC1HeSIp6WGqyw8kjYUAR0J69qfWduBM24rNNHZFjfDv8dA0EhgTv
 J3uuoEscsrtqwNhwHqo1ez1lOJIa3mkTsn7zydKcjRhJehHgzfevBUOZmcV2JgDlNboLUsOnFvhZ
 aA2ZHrsO9WaNpaGyZElxgJq0cjrlWtde4qfzBzwYsgSPBrGPDXpWDu_OslNbAMT5qJFU9ZL._VXa
 nRKsqmVUag.NcwqbJkvNapNQEXmjirzu8fmW450srPtQGFWkIcKEgsaxjUqQoai6x1O3LbqloHe_
 QVyLWsNBbpsKBbQ21KzCCilO_jIgROs1PElKt4QrD7FCGB793Yu6q7zD.5_.Fqb0OZoKkHv6r84j
 sziA5RI7uq17Ut699A4wTGXaRan7.dwWMwn2acq66hXkIub8cX3olAYha8mIDso3TT4sTBz3xmpZ
 _XI7Zj8vv_2pa17pkjuSxp.LF86jq9bDiblyoAJrdYdv5fabVQ8XGS6LN54lGe6V5FCWKqqkX7NK
 ahetcYaE374DERQKxZL5q8w2b.7WoKVQc5jxf1wry1hkpTmEJJz3adn3_DRMxhFBQSNe5onl_nH2
 GAxS41ichUP1qgJePG5FJYEMS7zU6CTKxHHEs7ejl1d2KfDXBtD2u4LOWslZKkWmXVqi1KqQYkjW
 mK7nhlMI9aMaNj_aMvwc7TH61641ynUmC81vRnl3AOzq_DeFMlApjW19MXDwyz8FlUHt_AZfnnro
 I_AixOpcK_aZBa6EIhhh9JcCnZzWj7u8JAuECx6xWrPpe3FtEHrPepfBi5drcgjeYWQdvGwhWVEj
 MW_PQ4jyM6M4vxc4ZmrHcFA.qAngbEyeN_Wesi64HzruIsdNkscgf0iUrueY6Hd1BDSd04kuIYgT
 vDIJIuC8w6UB1fYyvLZcMcugnCQ3bwggk15ZinHDTx.nBPJ3Idyq1gXRD8ucuyYun2EMWMBoyypO
 C2JQK
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Fri, 27 Mar 2020 16:16:36 +0000
Received: by smtp407.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 1cdc08af1c55cd698ab5e0e0ebf0caea;
          Fri, 27 Mar 2020 16:16:31 +0000 (UTC)
Subject: Re: KASAN: slab-out-of-bounds Read in vsscanf
To:     Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+bfdd4a2f07be52351350@syzkaller.appspotmail.com>
Cc:     jmorris@namei.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20200327082738.9012-1-hdanton@sina.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 mQINBFzV9HABEAC/mmv3jeJyF7lR7QhILYg1+PeBLIMZv7KCzBSc/4ZZipoWdmr77Lel/RxQ
 1PrNx0UaM5r6Hj9lJmJ9eg4s/TUBSP67mTx+tsZ1RhG78/WFf9aBe8MSXxY5cu7IUwo0J/CG
 vdSqACKyYPV5eoTJmnMxalu8/oVUHyPnKF3eMGgE0mKOFBUMsb2pLS/enE4QyxhcZ26jeeS6
 3BaqDl1aTXGowM5BHyn7s9LEU38x/y2ffdqBjd3au2YOlvZ+XUkzoclSVfSR29bomZVVyhMB
 h1jTmX4Ac9QjpwsxihT8KNGvOM5CeCjQyWcW/g8LfWTzOVF9lzbx6IfEZDDoDem4+ZiPsAXC
 SWKBKil3npdbgb8MARPes2DpuhVm8yfkJEQQmuLYv8GPiJbwHQVLZGQAPBZSAc7IidD2zbf9
 XAw1/SJGe1poxOMfuSBsfKxv9ba2i8hUR+PH7gWwkMQaQ97B1yXYxVEkpG8Y4MfE5Vd3bjJU
 kvQ/tOBUCw5zwyIRC9+7zr1zYi/3hk+OG8OryZ5kpILBNCo+aePeAJ44znrySarUqS69tuXd
 a3lMPHUJJpUpIwSKQ5UuYYkWlWwENEWSefpakFAIwY4YIBkzoJ/t+XJHE1HTaJnRk6SWpeDf
 CreF3+LouP4njyeLEjVIMzaEpwROsw++BX5i5vTXJB+4UApTAQARAQABtChDYXNleSBTY2hh
 dWZsZXIgPGNhc2V5QHNjaGF1Zmxlci1jYS5jb20+iQJUBBMBCAA+FiEEC+9tH1YyUwIQzUIe
 OKUVfIxDyBEFAlzV9HACGwMFCRLMAwAFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQOKUV
 fIxDyBG6ag/6AiRl8yof47YOEVHlrmewbpnlBTaYNfJ5cZflNRKRX6t4bp1B2YV1whlDTpiL
 vNOwFkh+ZE0eI5M4x8Gw2Oiok+4Q5liA9PHTozQYF+Ia+qdL5EehfbLGoEBqklpGvG3h8JsO
 7SvONJuFDgvab/U/UriDYycJwzwKZuhVtK9EMpnTtUDyP3DY+Q8h7MWsniNBLVXnh4yBIEJg
 SSgDn3COpZoFTPGKE+rIzioo/GJe8CTa2g+ZggJiY/myWTS3quG0FMvwvNYvZ4I2g6uxSl7n
 bZVqAZgqwoTAv1HSXIAn9muwZUJL03qo25PFi2gQmX15BgJKQcV5RL0GHFHRThDS3IyadOgK
 P2j78P8SddTN73EmsG5OoyzwZAxXfck9A512BfVESqapHurRu2qvMoUkQaW/2yCeRQwGTsFj
 /rr0lnOBkyC6wCmPSKXe3dT2mnD5KnCkjn7KxLqexKt4itGjJz4/ynD/qh+gL7IPbifrQtVH
 JI7cr0fI6Tl8V6efurk5RjtELsAlSR6fKV7hClfeDEgLpigHXGyVOsynXLr59uE+g/+InVic
 jKueTq7LzFd0BiduXGO5HbGyRKw4MG5DNQvC//85EWmFUnDlD3WHz7Hicg95D+2IjD2ZVXJy
 x3LTfKWdC8bU8am1fi+d6tVEFAe/KbUfe+stXkgmfB7pxqW5Ag0EXNX0cAEQAPIEYtPebJzT
 wHpKLu1/j4jQcke06Kmu5RNuj1pEje7kX5IKzQSs+CPH0NbSNGvrA4dNGcuDUTNHgb5Be9hF
 zVqRCEvF2j7BFbrGe9jqMBWHuWheQM8RRoa2UMwQ704mRvKr4sNPh01nKT52ASbWpBPYG3/t
 WbYaqfgtRmCxBnqdOx5mBJIBh9Q38i63DjQgdNcsTx2qS7HFuFyNef5LCf3jogcbmZGxG/b7
 yF4OwmGsVc8ufvlKo5A9Wm+tnRjLr/9Mn9vl5Xa/tQDoPxz26+aWz7j1in7UFzAarcvqzsdM
 Em6S7uT+qy5jcqyuipuenDKYF/yNOVSNnsiFyQTFqCPCpFihOnuaWqfmdeUOQHCSo8fD4aRF
 emsuxqcsq0Jp2ODq73DOTsdFxX2ESXYoFt3Oy7QmIxeEgiHBzdKU2bruIB5OVaZ4zWF+jusM
 Uh+jh+44w9DZkDNjxRAA5CxPlmBIn1OOYt1tsphrHg1cH1fDLK/pDjsJZkiH8EIjhckOtGSb
 aoUUMMJ85nVhN1EbU/A3DkWCVFEA//Vu1+BckbSbJKE7Hl6WdW19BXOZ7v3jo1q6lWwcFYth
 esJfk3ZPPJXuBokrFH8kqnEQ9W2QgrjDX3et2WwZFLOoOCItWxT0/1QO4ikcef/E7HXQf/ij
 Dxf9HG2o5hOlMIAkJq/uLNMvABEBAAGJAjwEGAEIACYWIQQL720fVjJTAhDNQh44pRV8jEPI
 EQUCXNX0cAIbDAUJEswDAAAKCRA4pRV8jEPIEWkzEACKFUnpp+wIVHpckMfBqN8BE5dUbWJc
 GyQ7wXWajLtlPdw1nNw0Wrv+ob2RCT7qQlUo6GRLcvj9Fn5tR4hBvR6D3m8aR0AGHbcC62cq
 I7LjaSDP5j/em4oVL2SMgNTrXgE2w33JMGjAx9oBzkxmKUqprhJomPwmfDHMJ0t7y39Da724
 oLPTkQDpJL1kuraM9TC5NyLe1+MyIxqM/8NujoJbWeQUgGjn9uxQAil7o/xSCjrWCP3kZDID
 vd5ZaHpdl8e1mTExQoKr4EWgaMjmD/a3hZ/j3KfTVNpM2cLfD/QwTMaC2fkK8ExMsz+rUl1H
 icmcmpptCwOSgwSpPY1Zfio6HvEJp7gmDwMgozMfwQuT9oxyFTxn1X3rn1IoYQF3P8gsziY5
 qtTxy2RrgqQFm/hr8gM78RhP54UPltIE96VywviFzDZehMvuwzW//fxysIoK97Y/KBZZOQs+
 /T+Bw80Pwk/dqQ8UmIt2ffHEgwCTbkSm711BejapWCfklxkMZDp16mkxSt2qZovboVjXnfuq
 wQ1QL4o4t1hviM7LyoflsCLnQFJh6RSBhBpKQinMJl/z0A6NYDkQi6vEGMDBWX/M2vk9Jvwa
 v0cEBfY3Z5oFgkh7BUORsu1V+Hn0fR/Lqq/Pyq+nTR26WzGDkolLsDr3IH0TiAVH5ZuPxyz6
 abzjfg==
Message-ID: <56d250eb-bf3b-849e-9173-137c92c915d4@schaufler-ca.com>
Date:   Fri, 27 Mar 2020 09:16:29 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200327082738.9012-1-hdanton@sina.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.15518 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_242)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 3/27/2020 1:27 AM, Hillf Danton wrote:
> On Thu, 26 Mar 2020 18:20:14 -0700
>> syzbot found the following crash on:
>>
>> HEAD commit:    1b649e0b Merge git://git.kernel.org/pub/scm/linux/kernel/g..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=11044405e00000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=4ac76c43beddbd9
>> dashboard link: https://syzkaller.appspot.com/bug?extid=bfdd4a2f07be52351350
>> compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13819303e00000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13eaed4be00000
>>
>> Bisection is inconclusive: the bug happens on the oldest tested release.
>>
>> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=150e6ac5e00000
>> final crash:    https://syzkaller.appspot.com/x/report.txt?x=170e6ac5e00000
>> console output: https://syzkaller.appspot.com/x/log.txt?x=130e6ac5e00000
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+bfdd4a2f07be52351350@syzkaller.appspotmail.com
>>
>> ==================================================================
>> BUG: KASAN: slab-out-of-bounds in vsscanf+0x2666/0x2ef0 lib/vsprintf.c:3275
>> Read of size 1 at addr ffff888093622f42 by task syz-executor055/7117
>>
>> CPU: 1 PID: 7117 Comm: syz-executor055 Not tainted 5.6.0-rc7-syzkaller #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
>> Call Trace:
>>  __dump_stack lib/dump_stack.c:77 [inline]
>>  dump_stack+0x1e9/0x30e lib/dump_stack.c:118
>>  print_address_description+0x74/0x5c0 mm/kasan/report.c:374
>>  __kasan_report+0x14b/0x1c0 mm/kasan/report.c:506
>>  kasan_report+0x25/0x50 mm/kasan/common.c:641
>>  vsscanf+0x2666/0x2ef0 lib/vsprintf.c:3275
>>  sscanf+0x6c/0x90 lib/vsprintf.c:3481
>>  smk_set_cipso+0x1ac/0x6a0 security/smack/smackfs.c:881
>>  __vfs_write+0xa7/0x710 fs/read_write.c:494
>>  vfs_write+0x271/0x570 fs/read_write.c:558
>>  ksys_write+0x115/0x220 fs/read_write.c:611
>>  do_syscall_64+0xf3/0x1b0 arch/x86/entry/common.c:294
>>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>> RIP: 0033:0x4401b9
>> Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
>> RSP: 002b:00007ffd20456888 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
>> RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 00000000004401b9
>> RDX: 0000000000000001 RSI: 00000000200005c0 RDI: 0000000000000003
>> RBP: 00000000006ca018 R08: 00000000004002c8 R09: 00000000004002c8
>> R10: 00000000004002c8 R11: 0000000000000246 R12: 0000000000401a40
>> R13: 0000000000401ad0 R14: 0000000000000000 R15: 0000000000000000
>>
>> Allocated by task 7117:
>>  save_stack mm/kasan/common.c:72 [inline]
>>  set_track mm/kasan/common.c:80 [inline]
>>  __kasan_kmalloc+0x118/0x1c0 mm/kasan/common.c:515
>>  __do_kmalloc mm/slab.c:3656 [inline]
>>  __kmalloc_track_caller+0x249/0x320 mm/slab.c:3671
>>  memdup_user_nul+0x26/0xf0 mm/util.c:259
>>  smk_set_cipso+0xff/0x6a0 security/smack/smackfs.c:859
>>  __vfs_write+0xa7/0x710 fs/read_write.c:494
>>  vfs_write+0x271/0x570 fs/read_write.c:558
>>  ksys_write+0x115/0x220 fs/read_write.c:611
>>  do_syscall_64+0xf3/0x1b0 arch/x86/entry/common.c:294
>>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>>
>> Freed by task 1:
>>  save_stack mm/kasan/common.c:72 [inline]
>>  set_track mm/kasan/common.c:80 [inline]
>>  kasan_set_free_info mm/kasan/common.c:337 [inline]
>>  __kasan_slab_free+0x12e/0x1e0 mm/kasan/common.c:476
>>  __cache_free mm/slab.c:3426 [inline]
>>  kfree+0x10a/0x220 mm/slab.c:3757
>>  tomoyo_path_perm+0x59b/0x740 security/tomoyo/file.c:842
>>  security_inode_getattr+0xc0/0x140 security/security.c:1254
>>  vfs_getattr+0x27/0x6e0 fs/stat.c:117
>>  vfs_statx fs/stat.c:201 [inline]
>>  vfs_lstat include/linux/fs.h:3277 [inline]
>>  __do_sys_newlstat fs/stat.c:364 [inline]
>>  __se_sys_newlstat+0x85/0x140 fs/stat.c:358
>>  do_syscall_64+0xf3/0x1b0 arch/x86/entry/common.c:294
>>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>>
>> The buggy address belongs to the object at ffff888093622f40
>>  which belongs to the cache kmalloc-32 of size 32
>> The buggy address is located 2 bytes inside of
>>  32-byte region [ffff888093622f40, ffff888093622f60)
>> The buggy address belongs to the page:
>> page:ffffea00024d8880 refcount:1 mapcount:0 mapping:ffff8880aa4001c0 index:0xffff888093622fc1
>> flags: 0xfffe0000000200(slab)
>> raw: 00fffe0000000200 ffffea000271b988 ffffea00028ae488 ffff8880aa4001c0
>> raw: ffff888093622fc1 ffff888093622000 0000000100000039 0000000000000000
>> page dumped because: kasan: bad access detected
>>
>> Memory state around the buggy address:
>>  ffff888093622e00: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
>>  ffff888093622e80: fb fb fb fb fc fc fc fc 00 00 01 fc fc fc fc fc
>>> ffff888093622f00: fb fb fb fb fc fc fc fc 02 fc fc fc fc fc fc fc
>>                                            ^
>>  ffff888093622f80: fb fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc
>>  ffff888093623000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> ==================================================================
>
> Add barrier to soob.
>
> --- a/security/smack/smackfs.c
> +++ b/security/smack/smackfs.c
> @@ -878,11 +878,21 @@ static ssize_t smk_set_cipso(struct file
>  	else
>  		rule += strlen(skp->smk_known) + 1;
>  
> +	if (rule > data + count) {
> +		rc = -EOVERFLOW;
> +		goto out;
> +	}
> +
>  	ret = sscanf(rule, "%d", &maplevel);
>  	if (ret != 1 || maplevel > SMACK_CIPSO_MAXLEVEL)
>  		goto out;
>  
>  	rule += SMK_DIGITLEN;
> +	if (rule > data + count) {
> +		rc = -EOVERFLOW;
> +		goto out;
> +	}
> +
>  	ret = sscanf(rule, "%d", &catlen);
>  	if (ret != 1 || catlen > SMACK_CIPSO_MAXCATNUM)
>  		goto out;

Thank you.

