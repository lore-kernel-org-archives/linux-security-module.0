Return-Path: <SRS0=lc+5=AK=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2308C433DF
	for <linux-security-module@archiver.kernel.org>; Mon, 29 Jun 2020 20:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD7BC207E8
	for <linux-security-module@archiver.kernel.org>; Mon, 29 Jun 2020 20:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbgF2UKG (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:10:06 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:37478 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727071AbgF2UKB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 29 Jun 2020 16:10:01 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jq06J-0003mh-VX; Mon, 29 Jun 2020 14:09:59 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jq06J-0004T6-4B; Mon, 29 Jun 2020 14:09:59 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-kernel@vger.kernel.org>
Cc:     David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <greg@kroah.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20200625095725.GA3303921@kroah.com>
        <778297d2-512a-8361-cf05-42d9379e6977@i-love.sakura.ne.jp>
        <20200625120725.GA3493334@kroah.com>
        <20200625.123437.2219826613137938086.davem@davemloft.net>
        <CAHk-=whuTwGHEPjvtbBvneHHXeqJC=q5S09mbPnqb=Q+MSPMag@mail.gmail.com>
        <87pn9mgfc2.fsf_-_@x220.int.ebiederm.org>
        <87y2oac50p.fsf@x220.int.ebiederm.org>
        <87bll17ili.fsf_-_@x220.int.ebiederm.org>
Date:   Mon, 29 Jun 2020 15:05:27 -0500
In-Reply-To: <87bll17ili.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Mon, 29 Jun 2020 14:55:05 -0500")
Message-ID: <87ftad4ozc.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jq06J-0004T6-4B;;;mid=<87ftad4ozc.fsf_-_@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19HJ+Q2cBtWz31Qjezuq/ZK7ROsAlPYjXo=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH v2 11/15] bpfilter: Move bpfilter_umh back into init data
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


To allow for restarts 61fbf5933d42 ("net: bpfilter: restart
bpfilter_umh when error occurred") moved the blob holding the
userspace binary out of the init sections.

Now that loading the blob into a filesystem is separate from executing
the blob the blob no longer needs to live .rodata to allow for restarting.
So move the blob back to .init.rodata.

Link: https://lkml.kernel.org/r/87sgeidlvq.fsf_-_@x220.int.ebiederm.org
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 net/bpfilter/bpfilter_umh_blob.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bpfilter/bpfilter_umh_blob.S b/net/bpfilter/bpfilter_umh_blob.S
index 9ea6100dca87..40311d10d2f2 100644
--- a/net/bpfilter/bpfilter_umh_blob.S
+++ b/net/bpfilter/bpfilter_umh_blob.S
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-	.section .rodata, "a"
+	.section .init.rodata, "a"
 	.global bpfilter_umh_start
 bpfilter_umh_start:
 	.incbin "net/bpfilter/bpfilter_umh"
-- 
2.25.0

