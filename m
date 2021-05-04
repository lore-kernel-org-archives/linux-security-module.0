Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6ED1C433B4
	for <linux-security-module@archiver.kernel.org>; Tue,  4 May 2021 11:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C52461185
	for <linux-security-module@archiver.kernel.org>; Tue,  4 May 2021 11:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbhEDLeN (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 4 May 2021 07:34:13 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:50708 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbhEDLeM (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 4 May 2021 07:34:12 -0400
Received: by mail-il1-f200.google.com with SMTP id t4-20020a92c0c40000b02901990d153bb9so6743782ilf.17
        for <linux-security-module@vger.kernel.org>; Tue, 04 May 2021 04:33:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=KkldCC8vnwDUsxXBBKnjsIMoaTF/A86bqTEGiJBZfMQ=;
        b=QjoeI38SZO6x+7DOllPHPlDBabDC2x7wn6j/xftEvcAiCEE1TQ6xg+tWMYf2G87VDv
         tRnscz4/6TQzlOHfV3dM5V8dMGWRVEUKpVRJrGPteOVLHvSNAUiR4sxMos46yfNoElwv
         +aoNBKwnHwsek93OeJ1CLto6wN6h3KI7oFpUWOcBZ5sJRg1/Ooc5viRu+R9S8OynBqbd
         jy+a4GTmwht+DPKOjlY0CoMirQk6Y/CCB0URuheIKDcRGq/7m30Bgvq4Q7mTLx6e0U3t
         IfLcdofC7FfTHIv0arl6zrEzfSvcb3IadOOTCUW13ccNi3dVKRV7gRnx/v7YM6yiKyDP
         O4iA==
X-Gm-Message-State: AOAM530zfhub1+GU0H677lfhiVkvWd5lieLxVnuajUgarzS7iMRrCSZk
        iKlAaZWnAYCOGx2X9pGVgJorIGhuCaKVjZ+K1udy772qmz+m
X-Google-Smtp-Source: ABdhPJx7mNrSDGEeKSQGY+okCJevU/2/0ktjrtdQ5tKKPW1LHT6TscRZcasLF83f+P8Cw1heSbvy+kRH1foI/yIjj3VOvxzTM2bD
MIME-Version: 1.0
X-Received: by 2002:a92:ce4e:: with SMTP id a14mr20104182ilr.211.1620127997107;
 Tue, 04 May 2021 04:33:17 -0700 (PDT)
Date:   Tue, 04 May 2021 04:33:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c224d005c17f7142@google.com>
Subject: [syzbot] KCSAN: data-race in assoc_array_apply_edit / search_nested_keyrings
From:   syzbot <syzbot+e4eb6db47eb0f80308c6@syzkaller.appspotmail.com>
To:     dhowells@redhat.com, jarkko@kernel.org, jmorris@namei.org,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello,

syzbot found the following issue on:

HEAD commit:    5e321ded Merge tag 'for-5.13/parisc' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=111cafb9d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4da2ebcb6e8f526
dashboard link: https://syzkaller.appspot.com/bug?extid=e4eb6db47eb0f80308c6
compiler:       Debian clang version 11.0.1-2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e4eb6db47eb0f80308c6@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in assoc_array_apply_edit / search_nested_keyrings

write to 0xffff8881065ffc10 of 8 bytes by task 30966 on cpu 1:
 assoc_array_apply_edit+0x3e/0x660 lib/assoc_array.c:1357
 __key_link+0x8a/0xc0 security/keys/keyring.c:1372
 __key_instantiate_and_link+0x15b/0x290 security/keys/key.c:459
 key_create_or_update+0x750/0x990 security/keys/key.c:941
 __do_sys_add_key security/keys/keyctl.c:134 [inline]
 __se_sys_add_key+0x26f/0x300 security/keys/keyctl.c:74
 __x64_sys_add_key+0x63/0x70 security/keys/keyctl.c:74
 do_syscall_64+0x4a/0x90 arch/x86/entry/common.c:47
 entry_SYSCALL_64_after_hwframe+0x44/0xae

read to 0xffff8881065ffc10 of 8 bytes by task 30971 on cpu 0:
 search_nested_keyrings+0x34f/0x920 security/keys/keyring.c:751
 keyring_search_rcu+0xf4/0x180 security/keys/keyring.c:922
 search_cred_keyrings_rcu+0x135/0x240 security/keys/process_keys.c:480
 search_process_keyrings_rcu security/keys/process_keys.c:544 [inline]
 lookup_user_key+0xab6/0xd40 security/keys/process_keys.c:762
 __do_sys_add_key security/keys/keyctl.c:126 [inline]
 __se_sys_add_key+0x23a/0x300 security/keys/keyctl.c:74
 __x64_sys_add_key+0x63/0x70 security/keys/keyctl.c:74
 do_syscall_64+0x4a/0x90 arch/x86/entry/common.c:47
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 30971 Comm: syz-executor.1 Not tainted 5.12.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
