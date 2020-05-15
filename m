Return-Path: <SRS0=nEb1=65=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D508C433E0
	for <linux-security-module@archiver.kernel.org>; Fri, 15 May 2020 18:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2669B20727
	for <linux-security-module@archiver.kernel.org>; Fri, 15 May 2020 18:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgEOSU6 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 15 May 2020 14:20:58 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:49858 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbgEOSU5 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 15 May 2020 14:20:57 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jZewv-0000TY-Jb; Fri, 15 May 2020 12:20:46 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jZewl-0004yB-GR; Fri, 15 May 2020 12:20:42 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Alexey Gladkov <gladkov.alexey@gmail.com>,
        syzbot <syzbot+c1af344512918c61362c@syzkaller.appspotmail.com>,
        jmorris@namei.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org, linux-security-module@vger.kernel.org,
        serge@hallyn.com, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <0000000000002f0c7505a5b0e04c@google.com>
        <c3461e26-1407-2262-c709-dac0df3da2d0@i-love.sakura.ne.jp>
Date:   Fri, 15 May 2020 13:16:59 -0500
In-Reply-To: <c3461e26-1407-2262-c709-dac0df3da2d0@i-love.sakura.ne.jp>
        (Tetsuo Handa's message of "Sat, 16 May 2020 00:18:00 +0900")
Message-ID: <87lfltcbc4.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jZewl-0004yB-GR;;;mid=<87lfltcbc4.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/5CZAGXdnSF9gJYpnj+DVwF9M3wdqkovE=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: linux-next boot error: general protection fault in tomoyo_get_local_path
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp> writes:

> This is
>
>         if (sb->s_magic == PROC_SUPER_MAGIC && *pos == '/') {
>                 char *ep;
>                 const pid_t pid = (pid_t) simple_strtoul(pos + 1, &ep, 10);
>                 struct pid_namespace *proc_pidns = proc_pid_ns(d_inode(dentry)); // <= here
>
>                 if (*ep == '/' && pid && pid ==
>                     task_tgid_nr_ns(current, proc_pidns)) {
>
> which was added by commit c59f415a7cb6e1e1 ("Use proc_pid_ns() to get pid_namespace from the proc superblock").
>
> @@ -161,9 +162,10 @@ static char *tomoyo_get_local_path(struct dentry *dentry, char * const buffer,
>         if (sb->s_magic == PROC_SUPER_MAGIC && *pos == '/') {
>                 char *ep;
>                 const pid_t pid = (pid_t) simple_strtoul(pos + 1, &ep, 10);
> +               struct pid_namespace *proc_pidns = proc_pid_ns(d_inode(dentry));
>
>                 if (*ep == '/' && pid && pid ==
> -                   task_tgid_nr_ns(current, sb->s_fs_info)) {
> +                   task_tgid_nr_ns(current, proc_pidns)) {
>                         pos = ep - 5;
>                         if (pos < buffer)
>                                 goto out;
>
> Alexey and Eric, any clue?

Looking at the stack backtrace this is happening as part of creating a
file or a device node.  The dentry that is passed in most likely
comes from d_alloc_parallel.  So we have d_inode == NULL.

I want to suggest doing the very simple fix:

-	if (sb->s_magic == PROC_SUPER_MAGIC && *pos == '/') {
+	if (sb->s_magic == PROC_SUPER_MAGIC && *pos == '/' && denty->d_inode) {

But I don't know if there are any other security hooks early in lookup,
that could be called for an already existing dentry.

So it looks like we need a version proc_pid_ns that works for a dentry,
or a superblock.

Alex do you think you can code up an patch against my proc-next branch
to fix this?

Eric
