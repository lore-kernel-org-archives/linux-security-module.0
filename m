Return-Path: <SRS0=nEb1=65=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D696BC433DF
	for <linux-security-module@archiver.kernel.org>; Fri, 15 May 2020 20:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC7D020709
	for <linux-security-module@archiver.kernel.org>; Fri, 15 May 2020 20:39:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbgEOUj7 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 15 May 2020 16:39:59 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:56812 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgEOUj6 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 15 May 2020 16:39:58 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jZh7a-0007OX-H5; Fri, 15 May 2020 14:39:54 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jZh7V-0007gL-4O; Fri, 15 May 2020 14:39:54 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        syzbot <syzbot+c1af344512918c61362c@syzkaller.appspotmail.com>,
        jmorris@namei.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org, linux-security-module@vger.kernel.org,
        serge@hallyn.com, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <0000000000002f0c7505a5b0e04c@google.com>
        <c3461e26-1407-2262-c709-dac0df3da2d0@i-love.sakura.ne.jp>
        <72cb7aea-92bd-d71b-2f8a-63881a35fad8@i-love.sakura.ne.jp>
        <20200515201357.GG23230@ZenIV.linux.org.uk>
Date:   Fri, 15 May 2020 15:36:13 -0500
In-Reply-To: <20200515201357.GG23230@ZenIV.linux.org.uk> (Al Viro's message of
        "Fri, 15 May 2020 21:13:57 +0100")
Message-ID: <87o8qpaqbm.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jZh7V-0007gL-4O;;;mid=<87o8qpaqbm.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/PGgvqQtmtGb1PoHqp2pZ/qQlUc5KbPks=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: linux-next boot error: general protection fault in tomoyo_get_local_path
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Al Viro <viro@zeniv.linux.org.uk> writes:

> On Sat, May 16, 2020 at 12:36:28AM +0900, Tetsuo Handa wrote:
>> On 2020/05/16 0:18, Tetsuo Handa wrote:
>> > This is
>> > 
>> >         if (sb->s_magic == PROC_SUPER_MAGIC && *pos == '/') {
>> >                 char *ep;
>> >                 const pid_t pid = (pid_t) simple_strtoul(pos + 1, &ep, 10);
>> >                 struct pid_namespace *proc_pidns = proc_pid_ns(d_inode(dentry)); // <= here
>> > 
>> >                 if (*ep == '/' && pid && pid ==
>> >                     task_tgid_nr_ns(current, proc_pidns)) {
>> > 
>> > which was added by commit c59f415a7cb6e1e1 ("Use proc_pid_ns() to get pid_namespace from the proc superblock").
>> > 
>> > @@ -161,9 +162,10 @@ static char *tomoyo_get_local_path(struct dentry *dentry, char * const buffer,
>> >         if (sb->s_magic == PROC_SUPER_MAGIC && *pos == '/') {
>> >                 char *ep;
>> >                 const pid_t pid = (pid_t) simple_strtoul(pos + 1, &ep, 10);
>> > +               struct pid_namespace *proc_pidns = proc_pid_ns(d_inode(dentry));
>> > 
>> >                 if (*ep == '/' && pid && pid ==
>> > -                   task_tgid_nr_ns(current, sb->s_fs_info)) {
>> > +                   task_tgid_nr_ns(current, proc_pidns)) {
>> >                         pos = ep - 5;
>> >                         if (pos < buffer)
>> >                                 goto out;
>> > 
>> > Alexey and Eric, any clue?
>> > 
>> 
>> A similar bug (racing inode destruction with open() on proc filesystem) was fixed as
>> commit 6f7c41374b62fd80 ("tomoyo: Don't use nifty names on sockets."). Then, it might
>> not be safe to replace dentry->d_sb->s_fs_info with dentry->d_inode->i_sb->s_fs_info .
>
> Could you explain why do you want to bother with d_inode() anyway?  Anything that
> does dentry->d_inode->i_sb can bloody well use dentry->d_sb.  And that's never
> changed over the struct dentry lifetime - ->d_sb is set on allocation and never
> modified afterwards.

Wanting to bother with d_inode is a bit strong.

It was just a matter of the helper function proc_pid_ns was built to
work against inodes.  And working with inodes looks reasonable as
in all of the places in proc where it was originally called it had
an inode, and did not have a dentry.

I don't think there was any strong design to it.

Before changing the s_fs_info in proc we found Tomoyo accessing it
without any helpers, and used the helper we had.  Which looked
reasonable.  Now we have discovered it wasn't.

It probably makes most sense just to have the helper go from the
super_block, and not worry about inodes or dentries.

Alexey Gladkov is already looking at fixing this.

Eric

