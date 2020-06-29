Return-Path: <SRS0=lc+5=AK=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF99C433E1
	for <linux-security-module@archiver.kernel.org>; Mon, 29 Jun 2020 20:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E023206A1
	for <linux-security-module@archiver.kernel.org>; Mon, 29 Jun 2020 20:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388558AbgF2UCG (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:02:06 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:34140 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731899AbgF2UCE (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 29 Jun 2020 16:02:04 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jpzyc-0002sK-UK; Mon, 29 Jun 2020 14:02:03 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jpzyZ-0003Ux-3x; Mon, 29 Jun 2020 14:02:02 -0600
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
Date:   Mon, 29 Jun 2020 14:57:28 -0500
In-Reply-To: <87bll17ili.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Mon, 29 Jun 2020 14:55:05 -0500")
Message-ID: <87tuyt63x3.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jpzyZ-0003Ux-3x;;;mid=<87tuyt63x3.fsf_-_@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18RpE6R/pGcowgvRUQ2NRyV2B5nU+ocdog=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH v2 03/15] umh: Rename the user mode driver helpers for clarity
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


Now that the functionality of umh_setup_pipe and
umh_clean_and_save_pid has changed their names are too specific and
don't make much sense.  Instead name them  umd_setup and umd_cleanup
for the functional role in setting up user mode drivers.

Link: https://lkml.kernel.org/r/875zbegf82.fsf_-_@x220.int.ebiederm.org
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/umh.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/umh.c b/kernel/umh.c
index e6b9d6636850..26c3d493f168 100644
--- a/kernel/umh.c
+++ b/kernel/umh.c
@@ -429,7 +429,7 @@ struct subprocess_info *call_usermodehelper_setup_file(struct file *file,
 	return sub_info;
 }
 
-static int umh_pipe_setup(struct subprocess_info *info, struct cred *new)
+static int umd_setup(struct subprocess_info *info, struct cred *new)
 {
 	struct umh_info *umh_info = info->data;
 	struct file *from_umh[2];
@@ -470,11 +470,11 @@ static int umh_pipe_setup(struct subprocess_info *info, struct cred *new)
 	return 0;
 }
 
-static void umh_clean_and_save_pid(struct subprocess_info *info)
+static void umd_cleanup(struct subprocess_info *info)
 {
 	struct umh_info *umh_info = info->data;
 
-	/* cleanup if umh_pipe_setup() was successful but exec failed */
+	/* cleanup if umh_setup() was successful but exec failed */
 	if (info->retval) {
 		fput(umh_info->pipe_to_umh);
 		fput(umh_info->pipe_from_umh);
@@ -520,8 +520,8 @@ int fork_usermode_blob(void *data, size_t len, struct umh_info *info)
 	}
 
 	err = -ENOMEM;
-	sub_info = call_usermodehelper_setup_file(file, umh_pipe_setup,
-						  umh_clean_and_save_pid, info);
+	sub_info = call_usermodehelper_setup_file(file, umd_setup, umd_cleanup,
+						  info);
 	if (!sub_info)
 		goto out;
 
-- 
2.25.0

