Return-Path: <SRS0=OxMS=NM=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C6BC6786F
	for <linux-security-module@archiver.kernel.org>; Thu,  1 Nov 2018 17:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4350E2064C
	for <linux-security-module@archiver.kernel.org>; Thu,  1 Nov 2018 17:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="KnATvjLK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4350E2064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725982AbeKBCMC (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 1 Nov 2018 22:12:02 -0400
Received: from sonic313-20.consmr.mail.bf2.yahoo.com ([74.6.133.194]:35889
        "EHLO sonic313-20.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725843AbeKBCMB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 1 Nov 2018 22:12:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1541092090; bh=cddTr2SQuoHORY9rXtL/8OfeXEj9aeh21eLfKXF/MLo=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=KnATvjLKkhLDB6JLwwhPjtP7tWaUxy4hWTwVaNmT90SSW56wU/kQKJHsUD9dxJzPMZcegElyOXuijD6jcobknOYSgTnEO0GE3BQcEnR3i2CDqx1hc7L+sovw2PfBg9L3EN719c2ISdDdfJB3DJAt5WEX/qZb/dHjVjDq7hYrs64OTsdQKXrR3Gk713TXCcwZL3meDaSGtmYBuNlsk1yk1OJJTLjcpog/K2FwX+ywWsZvu5bbBh+WUZREco2AEcnGbUlcYLjsvNbt5w4w4QGaNVgv8m/oghXhs252MO2yVY0m55oeYlvLLEbxIH+nJ5zlfhE0Y6rN9W7cWdjbvg2jpg==
X-YMail-OSG: TKN7MNsVM1lVSqboizKAhC_jvGkm6NCh2tYJfwtd5h0iW6TgG3C24TuI2xQ3CnL
 Xtl5hIOYERU4UZecPAqCTVItrlb8QfQAHhprAutIJR9lHI4plQUHnKnGx0BbYlaQmdmOJV7_ASaT
 FMblylcGiEJZP6UxOztottjeW9WV8guu6MMQDV6BIbgngfkaHrnAK6r3fnnaaEBnrcSGFeEHxyiA
 kEYh.STAxOSyqB43s5vCIuAQLn9qEJ85ykZUS7Ka_9x8LTKnlLr00Ks0ssikLXGuvxKuv0gzT72I
 0u.u4H5mAnK7L3dq2e3KbOO9bAXJcLf526MXlJ97GaC8_aZEVcHqGzvFX3zb9NKWR6scVLufuAuN
 DVhmYWVE74ibZLkpwtW48AdyiD20lP3Kb.KEM.d4jNEEyLUgrC3_GTf2CCpCrh7ttIFgyb.wFwuQ
 Wt4P8DCldjSp4EN_xAQSnYoxH5lT10eHM93c43ETlyOXgx45WoQo.xlTs.av_kIDDC97H_zed0t8
 _y85ialCq1S12esTNzUHSPaLez7xJikHYm_k5eDyYIEIJ3rk72G9Ir0GzZ.ZGZYOts1oJcGnhU.p
 S6fYXlVEMiD9mOhellSCBN2P36_3UQdF03drCHrbDbZGx3yPoZ_k5aX2PrF7W_FBxd4HLXXrvLiX
 iPJXDUdX.upnMOHL2RIhU1Gg7yBfklFd8uuU7heafQX9cTyjQagbJbWs1VkVu7Bv.sCVyi3H0XWx
 KK9uuFeHV50BXpeZEOlFuSZTzn3hkH3hNh3jPJqhCig8iJiyFBeMk8Qxmckj66Oh5OETz1QgJWel
 J_pFGRtm2WzqzjDCDBCjTbthsMe63SkQKNEZgSn2OoDnBDt.42FZ.AO7iHM69Gh6U8TkVAIvhqqo
 tSb7pNIKdjvhQaZ1VnlD3fc9f0UPCatShDJEeH4luWPNaJoKX0aYyhJKCuAb.VYWg4TIv38FWjsi
 vNJ915p44BQu8K9ZjrArL7_gTLSREPLJkVCzDXUpLeQjseG41smGPM13BfpTOLkmYAp8GM9ZifQl
 _aaOYUPNoHnK0PdnHVQhvzRPIr0eWxEXDJQn_ceMUvUSw31jMhCxn4uT.8jE_eHGvVwoJQxxc262
 OwoO6U4qxlbbkZQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.bf2.yahoo.com with HTTP; Thu, 1 Nov 2018 17:08:10 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([67.169.65.224])
          by smtp402.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 0c067b43fd21191bc97fa5bf54ec0766;
          Thu, 01 Nov 2018 17:08:05 +0000 (UTC)
Subject: Re: [PATCH] LSM: add SafeSetID module that gates setid calls
To:     Micah Morton <mortonm@chromium.org>, serge@hallyn.com
Cc:     jmorris@namei.org, Kees Cook <keescook@chromium.org>,
        linux-security-module@vger.kernel.org
References: <20181031152846.234791-1-mortonm@chromium.org>
 <20181031210245.GA3537@mail.hallyn.com>
 <20181101060737.GA7132@mail.hallyn.com>
 <CAJ-EccMaAu+g55Nuh1nZqt3Ld-YEgDiT_ewdQzGtFGmzRgXckw@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <41daea64-03c0-0970-c405-d1a5ae134181@schaufler-ca.com>
Date:   Thu, 1 Nov 2018 10:08:03 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAJ-EccMaAu+g55Nuh1nZqt3Ld-YEgDiT_ewdQzGtFGmzRgXckw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 11/1/2018 9:11 AM, Micah Morton wrote:
> On Wed, Oct 31, 2018 at 11:07 PM Serge E. Hallyn <serge@hallyn.com> wrote:
>> On Wed, Oct 31, 2018 at 09:02:45PM +0000, Serge E. Hallyn wrote:
>>> Quoting mortonm@chromium.org (mortonm@chromium.org):
>>>> From: Micah Morton <mortonm@chromium.org>
>>>>
>>>> SafeSetID gates the setid family of syscalls to restrict UID/GID
>>>> transitions from a given UID/GID to only those approved by a
>>>> system-wide whitelist. These restrictions also prohibit the given
>>>> UIDs/GIDs from obtaining auxiliary privileges associated with
>>>> CAP_SET{U/G}ID, such as allowing a user to set up user namespace UID
>>>> mappings. For now, only gating the set*uid family of syscalls is
>>>> supported, with support for set*gid coming in a future patch set.
>>>>
>>>> Signed-off-by: Micah Morton <mortonm@chromium.org>
>>>> ---
>>>>
>>>> NOTE: See the TODO above setuid_syscall() in lsm.c for an aspect of this
>>>> code that likely needs improvement before being an acceptable approach.
>>>> I'm specifically interested to see if there are better ideas for how
>>>> this could be done.
>>>>
>>>>  Documentation/admin-guide/LSM/SafeSetID.rst |  94 ++++++
>>>>  Documentation/admin-guide/LSM/index.rst     |   1 +
>>>>  arch/Kconfig                                |   5 +
>>>>  arch/arm/Kconfig                            |   1 +
>>>>  arch/arm64/Kconfig                          |   1 +
>>>>  arch/x86/Kconfig                            |   1 +
>>>>  security/Kconfig                            |   1 +
>>>>  security/Makefile                           |   2 +
>>>>  security/safesetid/Kconfig                  |  13 +
>>>>  security/safesetid/Makefile                 |   7 +
>>>>  security/safesetid/lsm.c                    | 334 ++++++++++++++++++++
>>>>  security/safesetid/lsm.h                    |  30 ++
>>>>  security/safesetid/securityfs.c             | 189 +++++++++++
>>>>  13 files changed, 679 insertions(+)
>>>>  create mode 100644 Documentation/admin-guide/LSM/SafeSetID.rst
>>>>  create mode 100644 security/safesetid/Kconfig
>>>>  create mode 100644 security/safesetid/Makefile
>>>>  create mode 100644 security/safesetid/lsm.c
>>>>  create mode 100644 security/safesetid/lsm.h
>>>>  create mode 100644 security/safesetid/securityfs.c
>>>>
>>>> diff --git a/Documentation/admin-guide/LSM/SafeSetID.rst b/Documentation/admin-guide/LSM/SafeSetID.rst
>>>> new file mode 100644
>>>> index 000000000000..e7d072124424
>>>> --- /dev/null
>>>> +++ b/Documentation/admin-guide/LSM/SafeSetID.rst
>>>> @@ -0,0 +1,94 @@
>>>> +=========
>>>> +SafeSetID
>>>> +=========
>>>> +SafeSetID is an LSM module that gates the setid family of syscalls to restrict
>>>> +UID/GID transitions from a given UID/GID to only those approved by a
>>>> +system-wide whitelist. These restrictions also prohibit the given UIDs/GIDs
>>>> +from obtaining auxiliary privileges associated with CAP_SET{U/G}ID, such as
>>>> +allowing a user to set up user namespace UID mappings.
>>>> +
>>>> +
>>>> +Background
>>>> +==========
>>>> +In absence of file capabilities, processes spawned on a Linux system that need
>>>> +to switch to a different user must be spawned with CAP_SETUID privileges.
>>>> +CAP_SETUID is granted to programs running as root or those running as a non-root
>>>> +user that have been explicitly given the CAP_SETUID runtime capability. It is
>>>> +often preferable to use Linux runtime capabilities rather than file
>>>> +capabilities, since using file capabilities to run a program with elevated
>>>> +privileges opens up possible security holes since any user with access to the
>>>> +file can exec() that program to gain the elevated privileges.
>>> Not true, see inheritable capabilities.  You also might look at ambient
>>> capabilities.
>> So for example with pam_cap.so you could have your N uids each be given
>> the desired pI, and assign the corrsponding fIs to the files they should
>> be able to exec with privilege.  No other uids will run those files with
>> privilege.  *1
> Sorry, what are "pl" and "fls" here? "Privilege level" and "files"?
>
>> Can you give some more details about exactly how you see SafeSetID being
>> used?
> Sure. The main use case for this LSM is to allow a non-root program to
> transition to other untrusted uids without full blown CAP_SETUID
> capabilities. The non-root program would still need CAP_SETUID to do
> any kind of transition, but the additional restrictions imposed by
> this LSM would mean it is a "safer" version of CAP_SETUID since the
> non-root program cannot take advantage of CAP_SETUID to do any
> unapproved actions (i.e. setuid to uid 0 or create/enter new user
> namespace). The higher level goal is to allow for uid-based sandboxing
> of system services without having to give out CAP_SETUID all over the
> place just so that non-root programs can drop to
> even-further-non-privileged uids. This is especially relevant when one
> non-root daemon on the system should be allowed to spawn other
> processes as different uids, but its undesirable to give the daemon a
> basically-root-equivalent CAP_SETUID.

I don't want to sound stupid(er than usual), but it sounds like
you could do all this using setuid bits prudently. Based on this
description, I don't see that anything new is needed.

>> I'm still not quite clear on whether you want N completely unprivileged
>> uids to be used by some user (i.e. uid 1000), or whether one or more of
>> those should also have some privileged, or whether one of the uids might
>> or might not b uid 0.  Years ago I used to use N separate uids to
>> somewhat segragate workloads on my laptop, and I'd like my browser to
>> do something like that.  Is that the kind of uid switching you have
>> in mind?
> "N completely unprivileged uids to be used by some user (i.e. uid
> 1000)" is the closest description of what this LSM has in mind. For
> example, uid 123 is some system service that needs runtime
> capabilities X, Y and Z and a bunch of DBus permissions associated
> with uid 123, but also wants to spawn another program without any of
> these capabilities/permissions. In this case we would like to avoid
> giving the system service CAP_SETUID.
>
>> -serge
>>
>> *1 And maybe with one of the p9auth/factotem proposals out there you
>> could have a userspace daemon hand out the tokens for setuid, but that's
>> getting "out there" and probably derailing this conversation :)

