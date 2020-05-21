Return-Path: <SRS0=9GoG=7D=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07F1C433DF
	for <linux-security-module@archiver.kernel.org>; Thu, 21 May 2020 11:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D197620756
	for <linux-security-module@archiver.kernel.org>; Thu, 21 May 2020 11:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbgEUL51 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 21 May 2020 07:57:27 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:47184 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729002AbgEUL51 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 21 May 2020 07:57:27 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jbjpB-0002UN-NE; Thu, 21 May 2020 05:57:21 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jbjpA-00053F-6i; Thu, 21 May 2020 05:57:21 -0600
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
        <87d06ygssl.fsf@x220.int.ebiederm.org>
        <202005201642.E1C6B4A457@keescook>
Date:   Thu, 21 May 2020 06:53:36 -0500
In-Reply-To: <202005201642.E1C6B4A457@keescook> (Kees Cook's message of "Wed,
        20 May 2020 16:43:28 -0700")
Message-ID: <875zcph5bz.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jbjpA-00053F-6i;;;mid=<875zcph5bz.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+oiz5qlPjrQa2T3u47CbOQrej8gssp24I=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v2 0/8] exec: Control flow simplifications
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Kees Cook <keescook@chromium.org> writes:

> On Wed, May 20, 2020 at 05:12:10PM -0500, Eric W. Biederman wrote:
>> 
>> I have pushed this out to:
>> 
>> git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git exec-next
>> 
>> I have collected up the acks and reviewed-by's, and fixed a couple of
>> typos but that is it.
>
> Awesome!
>
>> If we need comment fixes or additional cleanups we can apply that on top
>> of this series.   This way the code can sit in linux-next until the
>> merge window opens.
>> 
>> Before I pushed this out I also tested this with Kees new test of
>> binfmt_misc and did not find any problems.
>
> Did this mean to say binfmt_script? It'd be nice to get a binfmt_misc
> test too, though.

Yes.  Sorry.  I meant your binfmt_script test.

Eric
