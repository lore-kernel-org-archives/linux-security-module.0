Return-Path: <SRS0=lc+5=AK=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A742EC433E0
	for <linux-security-module@archiver.kernel.org>; Mon, 29 Jun 2020 20:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C76820675
	for <linux-security-module@archiver.kernel.org>; Mon, 29 Jun 2020 20:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731467AbgF2UNR (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:13:17 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:41870 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731185AbgF2UNQ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 29 Jun 2020 16:13:16 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jq09N-0006mI-1L; Mon, 29 Jun 2020 14:13:09 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jq09M-0004y7-3b; Mon, 29 Jun 2020 14:13:08 -0600
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
Date:   Mon, 29 Jun 2020 15:08:36 -0500
In-Reply-To: <87bll17ili.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Mon, 29 Jun 2020 14:55:05 -0500")
Message-ID: <87sged3a9n.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jq09M-0004y7-3b;;;mid=<87sged3a9n.fsf_-_@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+cqHAFjSvF5nxXSqbZnPcbIo/0ve3+EU8=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH v2 15/15] umd: Stop using split_argv
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


There is exactly one argument so there is nothing to split.  All
split_argv does now is cause confusion and avoid the need for a cast
when passing a "const char *" string to call_usermodehelper_setup.

So avoid confusion and the possibility of an odd driver name causing
problems by just using a fixed argv array with a cast in the call to
call_usermodehelper_setup.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/umd.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/kernel/umd.c b/kernel/umd.c
index 4188b71de267..ff79fb16d738 100644
--- a/kernel/umd.c
+++ b/kernel/umd.c
@@ -160,27 +160,21 @@ static void umd_cleanup(struct subprocess_info *info)
 int fork_usermode_driver(struct umd_info *info)
 {
 	struct subprocess_info *sub_info;
-	char **argv = NULL;
+	const char *argv[] = { info->driver_name, NULL };
 	int err;
 
 	if (WARN_ON_ONCE(info->tgid))
 		return -EBUSY;
 
 	err = -ENOMEM;
-	argv = argv_split(GFP_KERNEL, info->driver_name, NULL);
-	if (!argv)
-		goto out;
-
-	sub_info = call_usermodehelper_setup(info->driver_name, argv, NULL,
-					     GFP_KERNEL,
+	sub_info = call_usermodehelper_setup(info->driver_name,
+					     (char **)argv, NULL, GFP_KERNEL,
 					     umd_setup, umd_cleanup, info);
 	if (!sub_info)
 		goto out;
 
 	err = call_usermodehelper_exec(sub_info, UMH_WAIT_EXEC);
 out:
-	if (argv)
-		argv_free(argv);
 	return err;
 }
 EXPORT_SYMBOL_GPL(fork_usermode_driver);
-- 
2.25.0

