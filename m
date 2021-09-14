Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CCD5C433F5
	for <linux-security-module@archiver.kernel.org>; Tue, 14 Sep 2021 10:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 639A46112E
	for <linux-security-module@archiver.kernel.org>; Tue, 14 Sep 2021 10:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbhINKkk (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 14 Sep 2021 06:40:40 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:48904 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbhINKki (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 14 Sep 2021 06:40:38 -0400
Received: by mail-io1-f72.google.com with SMTP id z26-20020a05660200da00b005b86e36a1f4so16002440ioe.15
        for <linux-security-module@vger.kernel.org>; Tue, 14 Sep 2021 03:39:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=d+K/DZOWlylDTOK+FeJU8FsbbRqRUbkYTkMWd9k9EOQ=;
        b=BhP72W7wN3BsPGuj4fyDYQ0BKXJ+Yyz9GornpVX5nzvHSyeqAFW2E7DvXxekFH5Rac
         X74pG7cZms8cjqLSVsoGapN7skEV2eiAErtVcoe8tdAP1JXW5lRtfmD8H8P7xGgxaiku
         7p/dO3imxfteQ38AfWlrss+Y0M1lfnwDJX0TNmzhnFktffoiNnppe/wiRcSwwNY2Bn1e
         MMdhrDlE0t55HGZ50FWgRTAXWaWIFDgYavQvGQYlVpkXrcVZ3L70uvzXa4fQG4HcDGtG
         fJIpfYolPHU8MVsohtHGojmahBlirrvKoSTgj2nnGI5MPJo1iajDyNm0BFO8EbZMrIf1
         BzBQ==
X-Gm-Message-State: AOAM530aII/ohBUxvJaKhbjtj23HBNdsmtzb0Q+5zQw6y3O2ntz9r7X2
        3S9G3WUCWN0y6bOoupoaMaWS3JYdNHDN36YsfrMSixbDuklt
X-Google-Smtp-Source: ABdhPJyiSPRw9Faymwb4Xvjt8BfZoQWvGmFCB9bZHOGL2RB25E/cLIK6AfJPR/Qj9csYix5ohjJYgZ3wzCOr4Yh5Z3jc//mhqX8W
MIME-Version: 1.0
X-Received: by 2002:a6b:8d8a:: with SMTP id p132mr12670021iod.81.1631615961274;
 Tue, 14 Sep 2021 03:39:21 -0700 (PDT)
Date:   Tue, 14 Sep 2021 03:39:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c81e6305cbf2319c@google.com>
Subject: [syzbot] riscv/fixes boot error: BUG: unable to handle kernel NULL
 pointer dereference in corrupted
From:   syzbot <syzbot+2a1797e8845b57b4a3c2@syzkaller.appspotmail.com>
To:     jmorris@namei.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        penguin-kernel@I-love.SAKURA.ne.jp, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com, takedakn@nttdata.co.jp
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello,

syzbot found the following issue on:

HEAD commit:    7d2a07b76933 Linux 5.14
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=15cb131b300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f8211b06020972e8
dashboard link: https://syzkaller.appspot.com/bug?extid=2a1797e8845b57b4a3c2
compiler:       riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
userspace arch: riscv64

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2a1797e8845b57b4a3c2@syzkaller.appspotmail.com

Unable to handle kernel NULL pointer dereference at virtual address 0000000000000d48
Oops [#1]
Modules linked in:
CPU: 1 PID: 2924 Comm: kworker/u4:5 Not tainted 5.14.0-syzkaller #0
Hardware name: riscv-virtio,qemu (DT)
epc : slab_alloc_node mm/slub.c:2900 [inline]
epc : slab_alloc mm/slub.c:2967 [inline]
epc : __kmalloc+0xce/0x388 mm/slub.c:4111
 ra : slab_pre_alloc_hook mm/slab.h:494 [inline]
 ra : slab_alloc_node mm/slub.c:2880 [inline]
 ra : slab_alloc mm/slub.c:2967 [inline]
 ra : __kmalloc+0x6e/0x388 mm/slub.c:4111
epc : ffffffff803e3568 ra : ffffffff803e3508 sp : ffffffe008c6f780
 gp : ffffffff83f967d8 tp : ffffffe00b71df00 t0 : ffffffc400b37600
 t1 : 0000000000000001 t2 : 0000000000000000 s0 : ffffffe008c6f820
 s1 : ffffffe005601500 a0 : 0000000000000000 a1 : ffffffe008c6fb6c
 a2 : 1ffffffc016e3d07 a3 : 0000000000000d48 a4 : 0000000000000001
 a5 : ffffffff82e4b290 a6 : 0000000000f00000 a7 : ffffffff8038ca52
 s2 : ffffffff83f96adc s3 : 0000000000000d40 s4 : 0000000000000019
 s5 : ffffffff8080a860 s6 : ffffffff83f9a0d0 s7 : 0000000000000000
 s8 : 0000000000000d40 s9 : 0000000000000001 s10: ffffffe005aeb6e0
 s11: 000000000000002f t3 : 4f89673883b77f00 t4 : ffffffc40118df07
 t5 : ffffffc40118df09 t6 : ffffffe0059baffe
status: 0000000000000120 badaddr: 0000000000000d48 cause: 000000000000000d
[<ffffffff803e3568>] slab_alloc_node mm/slub.c:2900 [inline]
[<ffffffff803e3568>] slab_alloc mm/slub.c:2967 [inline]
[<ffffffff803e3568>] __kmalloc+0xce/0x388 mm/slub.c:4111
[<ffffffff8080a860>] kmalloc include/linux/slab.h:596 [inline]
[<ffffffff8080a860>] kzalloc include/linux/slab.h:721 [inline]
[<ffffffff8080a860>] tomoyo_encode2.part.0+0xf0/0x262 security/tomoyo/realpath.c:45
[<ffffffff8080abc2>] tomoyo_encode2 security/tomoyo/realpath.c:31 [inline]
[<ffffffff8080abc2>] tomoyo_encode security/tomoyo/realpath.c:80 [inline]
[<ffffffff8080abc2>] tomoyo_realpath_from_path+0x14c/0x3f4 security/tomoyo/realpath.c:288
[<ffffffff807f17e8>] tomoyo_init_log+0x7a2/0x13aa security/tomoyo/audit.c:263
[<ffffffff807f9c1e>] tomoyo_supervisor+0x1bc/0xb0c security/tomoyo/common.c:2097
[<ffffffff80801ca0>] tomoyo_audit_env_log security/tomoyo/environ.c:36 [inline]
[<ffffffff80801ca0>] tomoyo_env_perm+0x100/0x120 security/tomoyo/environ.c:63
[<ffffffff80801798>] tomoyo_environ security/tomoyo/domain.c:672 [inline]
[<ffffffff80801798>] tomoyo_find_next_domain+0xd24/0x109a security/tomoyo/domain.c:879
[<ffffffff8080c098>] tomoyo_bprm_check_security security/tomoyo/tomoyo.c:101 [inline]
[<ffffffff8080c098>] tomoyo_bprm_check_security+0xdc/0x136 security/tomoyo/tomoyo.c:91
[<ffffffff807e8b8e>] security_bprm_check+0x44/0x96 security/security.c:866
[<ffffffff80438242>] search_binary_handler fs/exec.c:1709 [inline]
[<ffffffff80438242>] exec_binprm fs/exec.c:1762 [inline]
[<ffffffff80438242>] bprm_execve fs/exec.c:1831 [inline]
[<ffffffff80438242>] bprm_execve+0x4ba/0x10a6 fs/exec.c:1793
[<ffffffff80439e7c>] kernel_execve+0x204/0x288 fs/exec.c:1974
[<ffffffff8005afec>] call_usermodehelper_exec_async+0x1bc/0x2d8 kernel/umh.c:112
[<ffffffff8000515e>] ret_from_exception+0x0/0x14
---[ end trace 77235688c0a8656b ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
