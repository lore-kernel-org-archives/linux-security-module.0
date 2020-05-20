Return-Path: <SRS0=Q/5P=7C=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 757B9C433E0
	for <linux-security-module@archiver.kernel.org>; Wed, 20 May 2020 20:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4567C207E8
	for <linux-security-module@archiver.kernel.org>; Wed, 20 May 2020 20:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgETU02 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 20 May 2020 16:26:28 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:45686 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbgETU02 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 20 May 2020 16:26:28 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jbVIE-0002sC-AR; Wed, 20 May 2020 14:26:22 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jbVID-0004lz-BV; Wed, 20 May 2020 14:26:22 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
        <87sgga6ze4.fsf@x220.int.ebiederm.org>
        <87v9l4zyla.fsf_-_@x220.int.ebiederm.org>
        <877dx822er.fsf_-_@x220.int.ebiederm.org>
        <87o8qkzrxp.fsf_-_@x220.int.ebiederm.org>
        <202005191111.9B389D33@keescook>
        <875zcrpx1g.fsf@x220.int.ebiederm.org>
        <202005191211.97BCF9DA@keescook>
Date:   Wed, 20 May 2020 15:22:38 -0500
In-Reply-To: <202005191211.97BCF9DA@keescook> (Kees Cook's message of "Tue, 19
        May 2020 12:14:40 -0700")
Message-ID: <87wo56gxv5.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jbVID-0004lz-BV;;;mid=<87wo56gxv5.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18kgvN+Xbm23VQqCP+JxcT7Yj0OsUMkK+w=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v2 3/8] exec: Convert security_bprm_set_creds into security_bprm_repopulate_creds
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Kees Cook <keescook@chromium.org> writes:

> On Tue, May 19, 2020 at 02:03:23PM -0500, Eric W. Biederman wrote:
>> Kees Cook <keescook@chromium.org> writes:
>> 
>> > On Mon, May 18, 2020 at 07:31:14PM -0500, Eric W. Biederman wrote:
>> >> [...]
>> >> diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
>> >> index d1217fcdedea..8605ab4a0f89 100644
>> >> --- a/include/linux/binfmts.h
>> >> +++ b/include/linux/binfmts.h
>> >> @@ -27,10 +27,10 @@ struct linux_binprm {
>> >>  	unsigned long argmin; /* rlimit marker for copy_strings() */
>> >>  	unsigned int
>> >>  		/*
>> >> -		 * True if most recent call to cap_bprm_set_creds
>> >> +		 * True if most recent call to security_bprm_set_creds
>> >>  		 * resulted in elevated privileges.
>> >>  		 */
>> >> -		cap_elevated:1,
>> >> +		active_secureexec:1,
>> >
>> > Also, I'd like it if this comment could be made more verbose as well, for
>> > anyone trying to understand the binfmt execution flow for the first time.
>> > Perhaps:
>> >
>> > 		/*
>> > 		 * Must be set True during the any call to
>> > 		 * bprm_set_creds hook where the execution would
>> > 		 * reuslt in elevated privileges. (The hook can be
>> > 		 * called multiple times during nested interpreter
>> > 		 * resolution across binfmt_script, binfmt_misc, etc).
>> > 		 */
>> Well it is not during but after the call that it becomes true.
>> I think most recent covers the case of multiple calls.
>
> I'm thinking of an LSM writing reading these comments to decide what
> they need to do to the flags, so it's a direction to them to set it to
> true if they have determined that privilege was gained. (Though in
> theory, this is all moot since only the commoncap hook cares.)

The comments for an LSM writer are in include/linux/lsm_hooks.h

 * @bprm_repopulate_creds:
 *	Assuming that the relevant bits of @bprm->cred->security have been
 *	previously set, examine @bprm->file and regenerate them.  This is
 *	so that the credentials derived from the interpreter the code is
 *	actually going to run are used rather than credentials derived
 *	from a script.  This done because the interpreter binary needs to
 *	reopen script, and may end up opening something completely different.
 *	This hook may also optionally check permissions (e.g. for
 *	transitions between security domains).
 *	The hook must set @bprm->active_secureexec to 1 if AT_SECURE should be set to
 *	request libc enable secure mode.
 *	@bprm contains the linux_binprm structure.
 *	Return 0 if the hook is successful and permission is granted.

I hope that is detailed enough.

I will leave the rest of the comments for the maintainer of the code.

I really don't think we should duplicate the prescriptive comments in
multiple locations.

Eric
