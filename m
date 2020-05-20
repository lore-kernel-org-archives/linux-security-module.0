Return-Path: <SRS0=Q/5P=7C=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFBA9C433E0
	for <linux-security-module@archiver.kernel.org>; Wed, 20 May 2020 12:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE41420758
	for <linux-security-module@archiver.kernel.org>; Wed, 20 May 2020 12:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbgETMom (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 20 May 2020 08:44:42 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:55702 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbgETMom (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 20 May 2020 08:44:42 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jbO5F-0003RP-BL; Wed, 20 May 2020 06:44:29 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jbO5D-00014Z-VJ; Wed, 20 May 2020 06:44:29 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     James Morris <jmorris@namei.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
        <87sgga6ze4.fsf@x220.int.ebiederm.org>
        <87v9l4zyla.fsf_-_@x220.int.ebiederm.org>
        <877dx822er.fsf_-_@x220.int.ebiederm.org>
        <87o8qkzrxp.fsf_-_@x220.int.ebiederm.org>
        <alpine.LRH.2.21.2005200750490.30843@namei.org>
Date:   Wed, 20 May 2020 07:40:45 -0500
In-Reply-To: <alpine.LRH.2.21.2005200750490.30843@namei.org> (James Morris's
        message of "Wed, 20 May 2020 07:52:42 +1000 (AEST)")
Message-ID: <871rnen5iq.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jbO5D-00014Z-VJ;;;mid=<871rnen5iq.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18udNvJx+c1yIl5NydlUzC7C5ZchehH+PU=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v2 3/8] exec: Convert security_bprm_set_creds into security_bprm_repopulate_creds
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

James Morris <jmorris@namei.org> writes:

> On Mon, 18 May 2020, Eric W. Biederman wrote:
>
>> diff --git a/fs/exec.c b/fs/exec.c
>> index 9e70da47f8d9..8e3b93d51d31 100644
>> --- a/fs/exec.c
>> +++ b/fs/exec.c
>> @@ -1366,7 +1366,7 @@ int begin_new_exec(struct linux_binprm * bprm)
>>  	 * the final state of setuid/setgid/fscaps can be merged into the
>>  	 * secureexec flag.
>>  	 */
>> -	bprm->secureexec |= bprm->cap_elevated;
>> +	bprm->secureexec |= bprm->active_secureexec;
>
> Which kernel tree are these patches for? Seems like begin_new_exec() is 
> from a prerequisite patchset.

The base is:
git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git exec-next

I should have mentioned.  I am several round deep in cleaning up exec
already.

begin_new_exec is essentially forget_old_exec.

Eric


