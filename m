Return-Path: <SRS0=SKQR=64=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F1ABC433DF
	for <linux-security-module@archiver.kernel.org>; Thu, 14 May 2020 15:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50B9B205CB
	for <linux-security-module@archiver.kernel.org>; Thu, 14 May 2020 15:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbgENPA2 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 14 May 2020 11:00:28 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:60264 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727991AbgENPA1 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 14 May 2020 11:00:27 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jZFLM-0008Eb-OC; Thu, 14 May 2020 09:00:16 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jZFLI-0002l2-0S; Thu, 14 May 2020 09:00:16 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>
References: <87eerszyim.fsf_-_@x220.int.ebiederm.org>
        <ee83587b-8a1c-3c4f-cc0f-7bc98afabae1@I-love.SAKURA.ne.jp>
        <CAHk-=wgQ2ovXMW=5ZHCpowkE1PwPQSL7oV4YXzBxd6eqNRXxnQ@mail.gmail.com>
        <87sgg6v8we.fsf@x220.int.ebiederm.org>
        <202005111428.B094E3B76A@keescook>
        <874kslq9jm.fsf@x220.int.ebiederm.org>
        <202005121218.ED0B728DA@keescook>
        <87lflwq4hu.fsf@x220.int.ebiederm.org>
        <202005121606.5575978B@keescook> <202005121625.20B35A3@keescook>
        <202005121649.4ED677068@keescook>
Date:   Thu, 14 May 2020 09:56:36 -0500
In-Reply-To: <202005121649.4ED677068@keescook> (Kees Cook's message of "Tue,
        12 May 2020 16:51:29 -0700")
Message-ID: <87sgg2ftuj.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jZFLI-0002l2-0S;;;mid=<87sgg2ftuj.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX184UonXunbqRpJTjGc7cdgy0PX4+YlZfjw=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 3/5] exec: Remove recursion from search_binary_handler
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Kees Cook <keescook@chromium.org> writes:

> On Tue, May 12, 2020 at 04:47:14PM -0700, Kees Cook wrote:
>> And now I wonder if qemu actually uses the resulting AT_EXECFD ...
>
> It does, though I'm not sure if this is to support crossing mount points,
> dropping privileges, or something else, since it does fall back to just
> trying to open the file.
>
>     execfd = qemu_getauxval(AT_EXECFD);
>     if (execfd == 0) {
>         execfd = open(filename, O_RDONLY);
>         if (execfd < 0) {
>             printf("Error while loading %s: %s\n", filename, strerror(errno));
>             _exit(EXIT_FAILURE);
>         }
>     }

My hunch is that the fallback exists from a time when the kernel did not
implement AT_EXECFD, or so that qemu can run on kernels that don't
implement AT_EXECFD.  It doesn't really matter unless the executable is
suid, or otherwise changes privileges.


I looked into this a bit to remind myself why exec works the way it
works, with changing privileges.

The classic attack is pointing a symlink at a #! script that is suid or
otherwise changes privileges.  The kernel will open the script and set
the privileges, read the interpreter from the first line, and proceed to
exec the interpreter.  The interpreter will then open the script using
the pathname supplied by the kernel.  The name of the symlink.
Before the interpreter reopens the script the attack would replace
the symlink with a script that does something else, but gets to run
with the privileges of the script.


Defending against that time of check vs time of use attack is why
bprm_fill_uid, and cap_bprm_set_creds use the credentials derived from
the interpreter instead of the credentials derived from the script.


The other defense is to replace the pathname of the executable that the
intepreter will open with /dev/fd/N.

All of this predates Linux entirely.  I do remember this was fixed at
some point in Linux but I don't remember the details.  I can just read
the solution that was picked in the code.



All of this makes me wonder how are the LSMs protected against this
attack.

Let's see the following LSMS implement brpm_set_creds:
tomoyo   - Abuses bprm_set_creds to call tomoyo_load_policy [ safe ]
smack    - Requires CAP_MAC_ADMIN to smack setxattrs        [ vulnerable? ]
           Uses those xattrs in smack_bprm_set_creds
apparmor - Everything is based on names so the symlink      [ safe? ]
           attack won't work as it has the wrong name.
           As long as the trusted names can't be renamed
           apparmor appears good.
selinux  - Appears to let anyone set selinux xattrs         [ safe? ]
           Requires permission for a sid transfer
           As the attack appears not to allow anything that
           would not be allowed anyway it looks like selinux
           is safe.

LSM folks, especially Casey am I reading this correctly?  Did I
correctly infer how your LSMs deal with the time of check to time of use
attack on the script name?

Eric

