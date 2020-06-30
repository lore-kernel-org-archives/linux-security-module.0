Return-Path: <SRS0=UBGi=AL=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A74AC433E0
	for <linux-security-module@archiver.kernel.org>; Tue, 30 Jun 2020 12:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 393D720672
	for <linux-security-module@archiver.kernel.org>; Tue, 30 Jun 2020 12:34:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387558AbgF3MeP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 30 Jun 2020 08:34:15 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:40866 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732042AbgF3MeO (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 30 Jun 2020 08:34:14 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jqFSi-0001Uj-5e; Tue, 30 Jun 2020 06:34:08 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jqFSh-0004Zz-8C; Tue, 30 Jun 2020 06:34:07 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <greg@kroah.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
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
        <20200629221231.jjc2czk3ul2roxkw@ast-mbp.dhcp.thefacebook.com>
Date:   Tue, 30 Jun 2020 07:29:34 -0500
In-Reply-To: <20200629221231.jjc2czk3ul2roxkw@ast-mbp.dhcp.thefacebook.com>
        (Alexei Starovoitov's message of "Mon, 29 Jun 2020 15:12:31 -0700")
Message-ID: <87eepwzqhd.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jqFSh-0004Zz-8C;;;mid=<87eepwzqhd.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18taL0yKPCpx2MTSwFOdv2sl/sVvNIlmuU=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v2 00/15] Make the user mode driver code a better citizen
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

2> On Mon, Jun 29, 2020 at 02:55:05PM -0500, Eric W. Biederman wrote:
>> 
>> I have tested thes changes by booting with the code compiled in and
>> by killing "bpfilter_umh" and running iptables -vnL to restart
>> the userspace driver.
>> 
>> I have compiled tested each change with and without CONFIG_BPFILTER
>> enabled.
>
> With
> CONFIG_BPFILTER=y
> CONFIG_BPFILTER_UMH=m
> it doesn't build:
>
> ERROR: modpost: "kill_pid_info" [net/bpfilter/bpfilter.ko] undefined!
>
> I've added:
> +EXPORT_SYMBOL(kill_pid_info);
> to continue testing...

I am rather surprised I thought Tetsuo had already compile tested
modules.


> I suspect patch 13 is somehow responsible:
> +	if (tgid) {
> +		kill_pid_info(SIGKILL, SEND_SIG_PRIV, tgid);
> +		wait_event(tgid->wait_pidfd, !pid_task(tgid, PIDTYPE_TGID));
> +		bpfilter_umh_cleanup(info);
> +	}
>
> I cannot figure out why it hangs. Some sort of race ?
> Since adding short delay between kill and wait makes it work.

Having had a chance to sleep kill_pid_info was a thinko, as was
!pid_task.  It should have been !pid_has_task as that takes the proper
rcu locking.

I don't know if that is going to be enough to fix the wait_event
but those are obvious bugs that need to be fixed.

diff --git a/net/bpfilter/bpfilter_kern.c b/net/bpfilter/bpfilter_kern.c
index 91474884ddb7..3e1874030daa 100644
--- a/net/bpfilter/bpfilter_kern.c
+++ b/net/bpfilter/bpfilter_kern.c
@@ -19,8 +19,8 @@ static void shutdown_umh(void)
        struct pid *tgid = info->tgid;
 
        if (tgid) {
-               kill_pid_info(SIGKILL, SEND_SIG_PRIV, tgid);
-               wait_event(tgid->wait_pidfd, !pid_task(tgid, PIDTYPE_TGID));
+               kill_pid(tgid, SIGKILL, 1);
+               wait_event(tgid->wait_pidfd, !pid_has_task(tgid, PIDTYPE_TGID));
                bpfilter_umh_cleanup(info);
        }
 }

> And then did:
> while true; do iptables -L;rmmod bpfilter; done
>  
> Unfortunately sometimes 'rmmod bpfilter' hangs in wait_event().

Hmm.  The wake up happens just of tgid->wait_pidfd happens just before
release_task is called so there is a race.  As it is possible to wake
up and then go back to sleep before pid_has_task becomes false.

So I think I need a friendly helper that does:

bool task_has_exited(struct pid *tgid)
{
	bool exited = false;

	rcu_read_lock();
        tsk = pid_task(tgid, PIDTYPE_TGID);
        exited = !!tsk;
        if (tsk) {
        	exited = !!tsk->exit_state;
out:
	rcu_unlock();
	return exited;
}

There should be a sensible way to do that.

Eric


