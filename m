Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B050C433DB
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Mar 2021 18:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48BB364FB3
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Mar 2021 18:18:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbhCJSSF (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 10 Mar 2021 13:18:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233556AbhCJSRl (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 10 Mar 2021 13:17:41 -0500
Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch [IPv6:2001:1600:4:17::bc08])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF16EC061760
        for <linux-security-module@vger.kernel.org>; Wed, 10 Mar 2021 10:17:40 -0800 (PST)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4DwgKZ4KcbzMq2Nt;
        Wed, 10 Mar 2021 19:17:38 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4DwgKY3DgCzlh8v8;
        Wed, 10 Mar 2021 19:17:37 +0100 (CET)
Subject: Re: [PATCH v1 0/1] Unprivileged chroot
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Serge Hallyn <serge@hallyn.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@lst.de>,
        David Howells <dhowells@redhat.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Eric Biederman <ebiederm@xmission.com>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        kernel-hardening@lists.openwall.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
References: <20210310161000.382796-1-mic@digikod.net>
 <4b9a1bb3-94f0-72af-f8f6-27f1ca2b43a2@schaufler-ca.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <e0b03cf2-8e37-6a41-5132-b74566a8f269@digikod.net>
Date:   Wed, 10 Mar 2021 19:17:36 +0100
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <4b9a1bb3-94f0-72af-f8f6-27f1ca2b43a2@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


On 10/03/2021 18:22, Casey Schaufler wrote:
> On 3/10/2021 8:09 AM, Mickaël Salaün wrote:
>> Hi,
>>
>> The chroot system call is currently limited to be used by processes with
>> the CAP_SYS_CHROOT capability.  This protects against malicious
>> procesess willing to trick SUID-like binaries.  The following patch
>> allows unprivileged users to safely use chroot(2).
> 
> Mount namespaces have pretty well obsoleted chroot(). CAP_SYS_CHROOT is
> one of the few fine grained capabilities. We're still finding edge cases
> (e.g. ptrace) where no_new_privs is imperfect. I doesn't seem that there
> is a compelling reason to remove the privilege requirement on chroot().

What is the link between chroot and ptrace?
What is interesting with CAP_SYS_CHROOT?

> 
>>
>> This patch is a follow-up of a previous one sent by Andy Lutomirski some
>> time ago:
>> https://lore.kernel.org/lkml/0e2f0f54e19bff53a3739ecfddb4ffa9a6dbde4d.1327858005.git.luto@amacapital.net/
>>
>> This patch can be applied on top of v5.12-rc2 .  I would really
>> appreciate constructive reviews.
>>
>> Regards,
>>
>> Mickaël Salaün (1):
>>   fs: Allow no_new_privs tasks to call chroot(2)
>>
>>  fs/open.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++++---
>>  1 file changed, 61 insertions(+), 3 deletions(-)
>>
>>
>> base-commit: a38fd8748464831584a19438cbb3082b5a2dab15
> 
