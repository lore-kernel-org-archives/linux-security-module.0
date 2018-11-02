Return-Path: <SRS0=l7tI=NN=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B5DBC32789
	for <linux-security-module@archiver.kernel.org>; Fri,  2 Nov 2018 19:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D93432082E
	for <linux-security-module@archiver.kernel.org>; Fri,  2 Nov 2018 19:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZNMK6omw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D93432082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbeKCEgj (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:36:39 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:37110 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbeKCEgj (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 3 Nov 2018 00:36:39 -0400
Received: by mail-yb1-f196.google.com with SMTP id d18-v6so1243103yba.4
        for <linux-security-module@vger.kernel.org>; Fri, 02 Nov 2018 12:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9H87Ewe2ZAc2IZKXz4MNpkmhtmr/U9Eta14Lr9O9J5Y=;
        b=ZNMK6omw7KkxiAjaBK74ikZplccSoQ5vkgrXLJJImNmRyxFULmA9IbRHnROLLntzGZ
         x14PZ7B+7lEvhdUqplke9737Va8LcnmJZFIOkQrCLGeKa67rCp6lLzBXlREXW5pG2kON
         DSc0YEskmUuafEyB6hMVLr78nezDEbX7px2DQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9H87Ewe2ZAc2IZKXz4MNpkmhtmr/U9Eta14Lr9O9J5Y=;
        b=Gq8MmN40NOu6Gmc0MxR5JOuiki7QU2N2RbF6d7An7JjPDvbfM8Ks17nUdzTI7zuOYp
         CiiLJ1Lom2HA4sbeGAyzjnoh6yWLaEa/heI5h42S7qH+HkDg8+HjlqZ6o18wkw7PiXSO
         lH2ky6RE2ErsxM/dqEIa05LmN5pi5tQHmBRkIgH4vuQqmwYUeKDaGAf1Vf8ruG685muF
         hv2A1LZl+KFQWkiZnvhfp7qV1Ay5qBw7mH66OfAOVVlh+LJrt7Orvoc1D6us8F8inCWe
         MT3croD234ZU7pxelsnMCFNl3baX5CTahnj17qGodIbREspCTtVbpO8U/MNr+4wF6wk1
         Nfzw==
X-Gm-Message-State: AGRZ1gJltcP767xXH3C8kaT6TlzDWmt3pEYf8bORKabolkh3WpEhh41c
        URHoL7P6SknWmAo3+GuHYgCrJ8cO9wuPQQvXWi5M8DaeROQ=
X-Google-Smtp-Source: AJdET5c5RJDvnprHCY/aiZ+qeCF88kL/BWQ6vT0hPZZlHzoiWvAAAuyugWydwgaTKxJyl0ztF4hqb1Ugd2kgf4agY4s=
X-Received: by 2002:a25:a2d0:: with SMTP id c16-v6mr12679452ybn.97.1541186893687;
 Fri, 02 Nov 2018 12:28:13 -0700 (PDT)
MIME-Version: 1.0
References: <20181031152846.234791-1-mortonm@chromium.org> <20181031210245.GA3537@mail.hallyn.com>
 <20181101060737.GA7132@mail.hallyn.com> <CAJ-EccMaAu+g55Nuh1nZqt3Ld-YEgDiT_ewdQzGtFGmzRgXckw@mail.gmail.com>
 <41daea64-03c0-0970-c405-d1a5ae134181@schaufler-ca.com> <CAJ-EccNO8DeER3VUyyxO-CD_qBmzasMvZuUsbdWgcfiAjRcsFw@mail.gmail.com>
 <3a3231b3-44b3-b330-2cda-d4246bca35be@schaufler-ca.com> <CAJ-EccMU9mtyA1qwXYEqHP9vXZEBiuCfdG3KTrAA-hQ+Y-CANg@mail.gmail.com>
 <5c7e1a80-c534-6adb-be19-58bb0d97084f@schaufler-ca.com>
In-Reply-To: <5c7e1a80-c534-6adb-be19-58bb0d97084f@schaufler-ca.com>
From:   Micah Morton <mortonm@chromium.org>
Date:   Fri, 2 Nov 2018 12:28:02 -0700
Message-ID: <CAJ-EccNvrM5GqiTN5Ke4DAsCjLbNTnD27n=XPAA7xniyD7C=FA@mail.gmail.com>
Subject: Re: [PATCH] LSM: add SafeSetID module that gates setid calls
To:     casey@schaufler-ca.com
Cc:     serge@hallyn.com, jmorris@namei.org,
        Kees Cook <keescook@chromium.org>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Nov 2, 2018 at 11:19 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> On 11/2/2018 10:12 AM, Micah Morton wrote:
> > On Fri, Nov 2, 2018 at 9:05 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >> On 11/1/2018 12:52 PM, Micah Morton wrote:
> >>> On Thu, Nov 1, 2018 at 10:08 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >>>> On 11/1/2018 9:11 AM, Micah Morton wrote:
> >>>>> On Wed, Oct 31, 2018 at 11:07 PM Serge E. Hallyn <serge@hallyn.com> wrote:
> >>>>>> On Wed, Oct 31, 2018 at 09:02:45PM +0000, Serge E. Hallyn wrote:
> >>>>>>> Quoting mortonm@chromium.org (mortonm@chromium.org):
> >>>>>>>> From: Micah Morton <mortonm@chromium.org>
> >>>>>>>>
> >>>>>>>> SafeSetID gates the setid family of syscalls to restrict UID/GID
> >>>>>>>> transitions from a given UID/GID to only those approved by a
> >>>>>>>> system-wide whitelist. These restrictions also prohibit the given
> >>>>>>>> UIDs/GIDs from obtaining auxiliary privileges associated with
> >>>>>>>> CAP_SET{U/G}ID, such as allowing a user to set up user namespace UID
> >>>>>>>> mappings. For now, only gating the set*uid family of syscalls is
> >>>>>>>> supported, with support for set*gid coming in a future patch set.
> >>>>>>>>
> >>>>>>>> Signed-off-by: Micah Morton <mortonm@chromium.org>
> >>>>>>>> ---
> >>>>>>>>
> >>>>>>>> NOTE: See the TODO above setuid_syscall() in lsm.c for an aspect of this
> >>>>>>>> code that likely needs improvement before being an acceptable approach.
> >>>>>>>> I'm specifically interested to see if there are better ideas for how
> >>>>>>>> this could be done.
> >>>>>>>>
> >>>>>>>>  Documentation/admin-guide/LSM/SafeSetID.rst |  94 ++++++
> >>>>>>>>  Documentation/admin-guide/LSM/index.rst     |   1 +
> >>>>>>>>  arch/Kconfig                                |   5 +
> >>>>>>>>  arch/arm/Kconfig                            |   1 +
> >>>>>>>>  arch/arm64/Kconfig                          |   1 +
> >>>>>>>>  arch/x86/Kconfig                            |   1 +
> >>>>>>>>  security/Kconfig                            |   1 +
> >>>>>>>>  security/Makefile                           |   2 +
> >>>>>>>>  security/safesetid/Kconfig                  |  13 +
> >>>>>>>>  security/safesetid/Makefile                 |   7 +
> >>>>>>>>  security/safesetid/lsm.c                    | 334 ++++++++++++++++++++
> >>>>>>>>  security/safesetid/lsm.h                    |  30 ++
> >>>>>>>>  security/safesetid/securityfs.c             | 189 +++++++++++
> >>>>>>>>  13 files changed, 679 insertions(+)
> >>>>>>>>  create mode 100644 Documentation/admin-guide/LSM/SafeSetID.rst
> >>>>>>>>  create mode 100644 security/safesetid/Kconfig
> >>>>>>>>  create mode 100644 security/safesetid/Makefile
> >>>>>>>>  create mode 100644 security/safesetid/lsm.c
> >>>>>>>>  create mode 100644 security/safesetid/lsm.h
> >>>>>>>>  create mode 100644 security/safesetid/securityfs.c
> >>>>>>>>
> >>>>>>>> diff --git a/Documentation/admin-guide/LSM/SafeSetID.rst b/Documentation/admin-guide/LSM/SafeSetID.rst
> >>>>>>>> new file mode 100644
> >>>>>>>> index 000000000000..e7d072124424
> >>>>>>>> --- /dev/null
> >>>>>>>> +++ b/Documentation/admin-guide/LSM/SafeSetID.rst
> >>>>>>>> @@ -0,0 +1,94 @@
> >>>>>>>> +=========
> >>>>>>>> +SafeSetID
> >>>>>>>> +=========
> >>>>>>>> +SafeSetID is an LSM module that gates the setid family of syscalls to restrict
> >>>>>>>> +UID/GID transitions from a given UID/GID to only those approved by a
> >>>>>>>> +system-wide whitelist. These restrictions also prohibit the given UIDs/GIDs
> >>>>>>>> +from obtaining auxiliary privileges associated with CAP_SET{U/G}ID, such as
> >>>>>>>> +allowing a user to set up user namespace UID mappings.
> >>>>>>>> +
> >>>>>>>> +
> >>>>>>>> +Background
> >>>>>>>> +==========
> >>>>>>>> +In absence of file capabilities, processes spawned on a Linux system that need
> >>>>>>>> +to switch to a different user must be spawned with CAP_SETUID privileges.
> >>>>>>>> +CAP_SETUID is granted to programs running as root or those running as a non-root
> >>>>>>>> +user that have been explicitly given the CAP_SETUID runtime capability. It is
> >>>>>>>> +often preferable to use Linux runtime capabilities rather than file
> >>>>>>>> +capabilities, since using file capabilities to run a program with elevated
> >>>>>>>> +privileges opens up possible security holes since any user with access to the
> >>>>>>>> +file can exec() that program to gain the elevated privileges.
> >>>>>>> Not true, see inheritable capabilities.  You also might look at ambient
> >>>>>>> capabilities.
> >>>>>> So for example with pam_cap.so you could have your N uids each be given
> >>>>>> the desired pI, and assign the corrsponding fIs to the files they should
> >>>>>> be able to exec with privilege.  No other uids will run those files with
> >>>>>> privilege.  *1
> >>>>> Sorry, what are "pl" and "fls" here? "Privilege level" and "files"?
> >>>>>
> >>>>>> Can you give some more details about exactly how you see SafeSetID being
> >>>>>> used?
> >>>>> Sure. The main use case for this LSM is to allow a non-root program to
> >>>>> transition to other untrusted uids without full blown CAP_SETUID
> >>>>> capabilities. The non-root program would still need CAP_SETUID to do
> >>>>> any kind of transition, but the additional restrictions imposed by
> >>>>> this LSM would mean it is a "safer" version of CAP_SETUID since the
> >>>>> non-root program cannot take advantage of CAP_SETUID to do any
> >>>>> unapproved actions (i.e. setuid to uid 0 or create/enter new user
> >>>>> namespace). The higher level goal is to allow for uid-based sandboxing
> >>>>> of system services without having to give out CAP_SETUID all over the
> >>>>> place just so that non-root programs can drop to
> >>>>> even-further-non-privileged uids. This is especially relevant when one
> >>>>> non-root daemon on the system should be allowed to spawn other
> >>>>> processes as different uids, but its undesirable to give the daemon a
> >>>>> basically-root-equivalent CAP_SETUID.
> >>>> I don't want to sound stupid(er than usual), but it sounds like
> >>>> you could do all this using setuid bits prudently. Based on this
> >>>> description, I don't see that anything new is needed.
> >>> There are situations where setuid bits don't get the job done, as
> >>> there are many situations where a program just wants to call setuid as
> >>> part of its execution (or fork + setuid without exec), instead of
> >>> fork/exec'ing a setuid binary.
> >> Yes, I understand that.
> >>
> >>> Take the following scenario for
> >>> example: init script (as root) spawns a network manager program as uid
> >>> 1000
> >> So far, so good.
> >>
> >>> and then the network manager spawns OpenVPN. The common mode of
> >>> operation for OpenVPN is to start running as the uid it was spawned
> >>> with (1000) at startup, but then drop to a lesser-privileged uid (e.g.
> >>> 2000) after initialization/setup by calling setuid.
> >> OK. That's an operation that does and ought to require privilege.
> > Sure, but the idea behind this LSM is that full CAP_SETUID
> > capabilities are a lot more privilege than is necessary in this
> > scenario.
>
> I'll start by pointing out that CAP_SETUID is about the finest grained
> capability there is. It's very precise in what it allows. I think that
> your concern is about the worst case scenario, which is setting the
> effective UID to 0, and hence gaining all privilege.

Yes, that plus the other powers granted by CAP_SETUID apart from
calling one of the set*uid functions:
https://elixir.bootlin.com/linux/latest/ident/CAP_SETUID (e.g. setting
up user ns mappings).

>
>
> >>> This is something
> >>> setuid bits wouldn't help with, without refactoring OpenVPN.
> >> You're correct.
> >>
> >>> So one
> >>> option here is to give the network manager CAP_SETUID, which will be
> >>> inherited by OpenVPN, and then OpenVPN drops to uid 2000 and drops
> >>> CAP_SETUID (would probably require patching OpenVPN for the capability
> >>> dropping).
> >> Or, you put CAP_SETUID on the file capabilities for OpenVPN,
> >> which is the way the P1003.1e DRAFT specification would have
> >> you accomplish this. Unfortunately, with all the changes made
> >> to capabilities for namespaces and all I'm not 100% sure I
> >> could say exactly how to set that.
> >>
> >>> The problem here is that if the network manager itself is
> >>> untrusted and exploitable, then giving it unrestricted CAP_SETUID is a
> >>> big security risk.
> >> Right. That's why you set the file capabilities on OpenVPN.
> > So it seems like you're suggesting that any time a program needs to
> > switch user by calling setuid,
>
> ... in a way that requires CAP_SETUID ...
>
> > that it should get full CAP_SETUID
> > capabilities (whether that's through setting file capabilities on the
> > binary or inheriting CAP_SETUID from a parent process or otherwise).
>
> Yup. That's correct. With all the duties and responsibilities associated
> with the dangers of UID management. Changing UIDs shouldn't be done
> lightly and needs to be done carefully.
>
> > But that brings us back to the basic problem this LSM is trying to
> > solve. Namely, we don't want to sprinkle unrestricted CAP_SETUID privs
> > all over the system for binaries that just want to switch to specific
> > uid[s] and don't need any of the root-equivalent privileges provided
> > by CAP_SETUID.
>
> I would see marking a program with a list of UIDs it can run with or
> that its children can run with as a better solution. You get much
> better locality of reference that way.

AFAICT in this scenario an exploited program could still be tricked
(e.g. command injection) into doing the unapproved actions.

>
> >>> Even just sticking with the network manager / VPN
> >>> example, strongSwan VPN also uses the same drop-to-user-through-setuid
> >>> setup, as do other Linux applications.
> >> Same solution.
> >>
> >>> Refactoring these applications
> >>> to fork/exec setuid binaries instead of simply calling setuid is often
> >>> infeasible. So a direct call to setuid is often necessary/expected,
> >>> and setuid bits don't help here.
> >> What is it with kids these days, that they are so
> >> afraid of fixing code that needs fixing? But that's
> >> not necessary in this example.
> >>
> >>> Also, use of setuid bits precludes the use of the no_new_privs bit,
> >>> which is usually at least a nice-to-have (if not need-to-have) for
> >>> sandboxed processes on the system.
> >> But you've already said that you *want* to change the security state,
> >> "drop to a lesser-privileged uid", so you're already mucking with the
> >> sandbox. If you're going to say that changing UIDs doesn't count for
> >> sandboxing I'll point out that you brought up the notion of a
> >> lesser-privileged UID.
> > There are plenty of ways that non-root processes further restrict
> > especially vulnerable parts of their code to even lesser-privileged
> > contexts. But its often easier to reason about the security of such
> > applications if the no_new_privs bit is set and file capabilities are
> > avoided, so the application can have full control of which privileges
> > are given to spawned processes without having to worry about which
> > privileges are attached to which files. Granted, the no_new_privs
> > issue is less central to the LSM being proposed here compared to the
> > discussion above.
>
> Let me suggest a change to the way your LSM works
> that would reduce my concerns. Rather than refusing to
> make a UID change that isn't on your whitelist, kill a
> process that makes a prohibited request. This mitigates
> the problem where a process doesn't check for an error
> return. Sure, your system will be harder to get running
> until your whitelist is complete, but you'll avoid a
> whole category of security bugs.

That's a valid point. ATM I can't think of any reason I'd be opposed to that.

>
