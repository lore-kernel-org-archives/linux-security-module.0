Return-Path: <SRS0=l7tI=NN=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4F8C32789
	for <linux-security-module@archiver.kernel.org>; Fri,  2 Nov 2018 16:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B65EC20657
	for <linux-security-module@archiver.kernel.org>; Fri,  2 Nov 2018 16:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="IKwy5MIy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B65EC20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbeKCBMx (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 2 Nov 2018 21:12:53 -0400
Received: from sonic309-20.consmr.mail.bf2.yahoo.com ([74.6.129.194]:37288
        "EHLO sonic309-20.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726085AbeKCBMx (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 2 Nov 2018 21:12:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1541174716; bh=DKUO1UyLJItZgA4DNDtKVP7w/5Y6r++l/+CUvZTz5Bs=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=IKwy5MIy7Z58Ossjy8WnUJPK/prgPItY25f4vVXVOG8IhPerW70Yt4D898IV7elSxNzaMZ6ZniHcNjRKPXOQrsmaEYFW9/Mm3y80gTLwSUSKNOOePMw1PkdBKwKnfrD0SKtvN6v/E/BysjOVJ4UTmrXq91B8BR1cQpbXGAcEC9kk434nIhLGfJ42XHAYnnuQ/g8J0hEycWWe000NqBzuVFjdfl30S1ZlH3vnWgQO4Ry1mL79z2hKsQgdHE+Pbwtv3C3KoxMYLlO+aCSeJVlY5Bv/NCHXpf8UUFvWXaQTpVx5PwFY62mW4gMotPCj4tv+uoXkXRmJLFUU/JnQLm5KrQ==
X-YMail-OSG: .v5OdvsVM1nytShP55M_51o0u0UZips.HUHz3oaXAo51ZXAngB3pSx4L6ZwJ.sm
 Imp0AsEMvnlPQ5D5A4rmTKWcDC71A6_twravucPca2OjlU8jorArg9_qDdLJXnvRHbKgRPxyj6C6
 UFlfAEK0eESIo_1178cvPSJd0RDyFLO6GbC5_.qHxSjes9ReVYXMpSzLo253Bccn76LsJoVvwTLR
 YRF2wb7_mXLQTRjBwd.Q0g8B7OAstRuoXDGtY9_6m9Cc2XYE6lMkxD6tf52eRcD5bTGsohNMacKR
 JGz1jgLo958AMfZolPpPxp.RkZsJE2IAgqKBu__m8zTEtPSEs1_DC_Pv96jQ7c_QNbWtJgI6_oqh
 ANrnq6KcB0LefhVNVEg1BXS6zHf7hjIrBrfKBnBy273kwHiogTTwj1JlDWVG1t5zIC8_nBiErzY5
 eI4uCcslRt0sYdzaXeDFzS0F6oBxPhk0u_nnAHbmidXBCuVudAfwY7_4OFruKoWQ8exO5.NxMGey
 aRemYPfgUzu.dltzgdFHl97e0tkEHA..kPZnH1VOjJk6tDx4joaTf2r5JTb2FECAOTLGeuDNG4NZ
 Tn1QBUN37p8GBstfoJzP_orcqPegAll6WwOWrSyQEoc3OBvmt2ITSBzZSGZ5_16Q8nRhklf4Kj7I
 fj7zzsqsKKd0rnj449jQ2s5AfbpRMMwngErd16AyJsPgRcaTW4i_BSoMWpEGGC0KzinJ3XGQ0gGd
 7pQ41extz1JORmr9zANItV_R.WOtrfsgsg9iLVpY_YxbGGaOnVFextJfxWBxXv6jYWe7gDMx.usE
 BFdmSCGuFZIyhJPOGnWq2m0rO_JOeYHFa48onTYcsmSaC.0j0OYd32SwWHLTdYtxsZKyaxXjZu8_
 GCYQMX6teO1_uTBO0e.1N8iKQAtEsM7AHSNpMPdC3QBoVjit.4Gu0yNwhLItGpv7SY8CjbLT377S
 MaA3jGi8DqroalBTILn5RsQ1MDodvEe5.siHvWp9MvbeHFyC8tPmV6JgvOOrPRSyO2haM7Lg7oiI
 usZv2bKqW9JjmQJI0gvtItS4dpPTOJ114eI74zjWXt5giz.x9sdwadwskcgfNxZCUyLjtnEr_ZQm
 iTT3vYw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.bf2.yahoo.com with HTTP; Fri, 2 Nov 2018 16:05:16 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([67.169.65.224])
          by smtp409.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID a4673539ec72baede98236c3d266c75b;
          Fri, 02 Nov 2018 16:05:15 +0000 (UTC)
Subject: Re: [PATCH] LSM: add SafeSetID module that gates setid calls
To:     Micah Morton <mortonm@chromium.org>
Cc:     serge@hallyn.com, jmorris@namei.org,
        Kees Cook <keescook@chromium.org>,
        linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20181031152846.234791-1-mortonm@chromium.org>
 <20181031210245.GA3537@mail.hallyn.com>
 <20181101060737.GA7132@mail.hallyn.com>
 <CAJ-EccMaAu+g55Nuh1nZqt3Ld-YEgDiT_ewdQzGtFGmzRgXckw@mail.gmail.com>
 <41daea64-03c0-0970-c405-d1a5ae134181@schaufler-ca.com>
 <CAJ-EccNO8DeER3VUyyxO-CD_qBmzasMvZuUsbdWgcfiAjRcsFw@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <3a3231b3-44b3-b330-2cda-d4246bca35be@schaufler-ca.com>
Date:   Fri, 2 Nov 2018 09:05:12 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAJ-EccNO8DeER3VUyyxO-CD_qBmzasMvZuUsbdWgcfiAjRcsFw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 11/1/2018 12:52 PM, Micah Morton wrote:
> On Thu, Nov 1, 2018 at 10:08 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 11/1/2018 9:11 AM, Micah Morton wrote:
>>> On Wed, Oct 31, 2018 at 11:07 PM Serge E. Hallyn <serge@hallyn.com> wrote:
>>>> On Wed, Oct 31, 2018 at 09:02:45PM +0000, Serge E. Hallyn wrote:
>>>>> Quoting mortonm@chromium.org (mortonm@chromium.org):
>>>>>> From: Micah Morton <mortonm@chromium.org>
>>>>>>
>>>>>> SafeSetID gates the setid family of syscalls to restrict UID/GID
>>>>>> transitions from a given UID/GID to only those approved by a
>>>>>> system-wide whitelist. These restrictions also prohibit the given
>>>>>> UIDs/GIDs from obtaining auxiliary privileges associated with
>>>>>> CAP_SET{U/G}ID, such as allowing a user to set up user namespace UID
>>>>>> mappings. For now, only gating the set*uid family of syscalls is
>>>>>> supported, with support for set*gid coming in a future patch set.
>>>>>>
>>>>>> Signed-off-by: Micah Morton <mortonm@chromium.org>
>>>>>> ---
>>>>>>
>>>>>> NOTE: See the TODO above setuid_syscall() in lsm.c for an aspect of this
>>>>>> code that likely needs improvement before being an acceptable approach.
>>>>>> I'm specifically interested to see if there are better ideas for how
>>>>>> this could be done.
>>>>>>
>>>>>>  Documentation/admin-guide/LSM/SafeSetID.rst |  94 ++++++
>>>>>>  Documentation/admin-guide/LSM/index.rst     |   1 +
>>>>>>  arch/Kconfig                                |   5 +
>>>>>>  arch/arm/Kconfig                            |   1 +
>>>>>>  arch/arm64/Kconfig                          |   1 +
>>>>>>  arch/x86/Kconfig                            |   1 +
>>>>>>  security/Kconfig                            |   1 +
>>>>>>  security/Makefile                           |   2 +
>>>>>>  security/safesetid/Kconfig                  |  13 +
>>>>>>  security/safesetid/Makefile                 |   7 +
>>>>>>  security/safesetid/lsm.c                    | 334 ++++++++++++++++++++
>>>>>>  security/safesetid/lsm.h                    |  30 ++
>>>>>>  security/safesetid/securityfs.c             | 189 +++++++++++
>>>>>>  13 files changed, 679 insertions(+)
>>>>>>  create mode 100644 Documentation/admin-guide/LSM/SafeSetID.rst
>>>>>>  create mode 100644 security/safesetid/Kconfig
>>>>>>  create mode 100644 security/safesetid/Makefile
>>>>>>  create mode 100644 security/safesetid/lsm.c
>>>>>>  create mode 100644 security/safesetid/lsm.h
>>>>>>  create mode 100644 security/safesetid/securityfs.c
>>>>>>
>>>>>> diff --git a/Documentation/admin-guide/LSM/SafeSetID.rst b/Documentation/admin-guide/LSM/SafeSetID.rst
>>>>>> new file mode 100644
>>>>>> index 000000000000..e7d072124424
>>>>>> --- /dev/null
>>>>>> +++ b/Documentation/admin-guide/LSM/SafeSetID.rst
>>>>>> @@ -0,0 +1,94 @@
>>>>>> +=========
>>>>>> +SafeSetID
>>>>>> +=========
>>>>>> +SafeSetID is an LSM module that gates the setid family of syscalls to restrict
>>>>>> +UID/GID transitions from a given UID/GID to only those approved by a
>>>>>> +system-wide whitelist. These restrictions also prohibit the given UIDs/GIDs
>>>>>> +from obtaining auxiliary privileges associated with CAP_SET{U/G}ID, such as
>>>>>> +allowing a user to set up user namespace UID mappings.
>>>>>> +
>>>>>> +
>>>>>> +Background
>>>>>> +==========
>>>>>> +In absence of file capabilities, processes spawned on a Linux system that need
>>>>>> +to switch to a different user must be spawned with CAP_SETUID privileges.
>>>>>> +CAP_SETUID is granted to programs running as root or those running as a non-root
>>>>>> +user that have been explicitly given the CAP_SETUID runtime capability. It is
>>>>>> +often preferable to use Linux runtime capabilities rather than file
>>>>>> +capabilities, since using file capabilities to run a program with elevated
>>>>>> +privileges opens up possible security holes since any user with access to the
>>>>>> +file can exec() that program to gain the elevated privileges.
>>>>> Not true, see inheritable capabilities.  You also might look at ambient
>>>>> capabilities.
>>>> So for example with pam_cap.so you could have your N uids each be given
>>>> the desired pI, and assign the corrsponding fIs to the files they should
>>>> be able to exec with privilege.  No other uids will run those files with
>>>> privilege.  *1
>>> Sorry, what are "pl" and "fls" here? "Privilege level" and "files"?
>>>
>>>> Can you give some more details about exactly how you see SafeSetID being
>>>> used?
>>> Sure. The main use case for this LSM is to allow a non-root program to
>>> transition to other untrusted uids without full blown CAP_SETUID
>>> capabilities. The non-root program would still need CAP_SETUID to do
>>> any kind of transition, but the additional restrictions imposed by
>>> this LSM would mean it is a "safer" version of CAP_SETUID since the
>>> non-root program cannot take advantage of CAP_SETUID to do any
>>> unapproved actions (i.e. setuid to uid 0 or create/enter new user
>>> namespace). The higher level goal is to allow for uid-based sandboxing
>>> of system services without having to give out CAP_SETUID all over the
>>> place just so that non-root programs can drop to
>>> even-further-non-privileged uids. This is especially relevant when one
>>> non-root daemon on the system should be allowed to spawn other
>>> processes as different uids, but its undesirable to give the daemon a
>>> basically-root-equivalent CAP_SETUID.
>> I don't want to sound stupid(er than usual), but it sounds like
>> you could do all this using setuid bits prudently. Based on this
>> description, I don't see that anything new is needed.
> There are situations where setuid bits don't get the job done, as
> there are many situations where a program just wants to call setuid as
> part of its execution (or fork + setuid without exec), instead of
> fork/exec'ing a setuid binary.

Yes, I understand that.

> Take the following scenario for
> example: init script (as root) spawns a network manager program as uid
> 1000

So far, so good.

> and then the network manager spawns OpenVPN. The common mode of
> operation for OpenVPN is to start running as the uid it was spawned
> with (1000) at startup, but then drop to a lesser-privileged uid (e.g.
> 2000) after initialization/setup by calling setuid.

OK. That's an operation that does and ought to require privilege.

> This is something
> setuid bits wouldn't help with, without refactoring OpenVPN.

You're correct.

> So one
> option here is to give the network manager CAP_SETUID, which will be
> inherited by OpenVPN, and then OpenVPN drops to uid 2000 and drops
> CAP_SETUID (would probably require patching OpenVPN for the capability
> dropping).

Or, you put CAP_SETUID on the file capabilities for OpenVPN,
which is the way the P1003.1e DRAFT specification would have
you accomplish this. Unfortunately, with all the changes made
to capabilities for namespaces and all I'm not 100% sure I
could say exactly how to set that.

> The problem here is that if the network manager itself is
> untrusted and exploitable, then giving it unrestricted CAP_SETUID is a
> big security risk.

Right. That's why you set the file capabilities on OpenVPN.

> Even just sticking with the network manager / VPN
> example, strongSwan VPN also uses the same drop-to-user-through-setuid
> setup, as do other Linux applications.

Same solution.

> Refactoring these applications
> to fork/exec setuid binaries instead of simply calling setuid is often
> infeasible. So a direct call to setuid is often necessary/expected,
> and setuid bits don't help here.

What is it with kids these days, that they are so
afraid of fixing code that needs fixing? But that's
not necessary in this example.

> Also, use of setuid bits precludes the use of the no_new_privs bit,
> which is usually at least a nice-to-have (if not need-to-have) for
> sandboxed processes on the system.

But you've already said that you *want* to change the security state,
"drop to a lesser-privileged uid", so you're already mucking with the
sandbox. If you're going to say that changing UIDs doesn't count for
sandboxing I'll point out that you brought up the notion of a
lesser-privileged UID.

