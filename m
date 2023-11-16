Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFDFFC197A0
	for <linux-security-module@archiver.kernel.org>; Thu, 16 Nov 2023 22:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjKPWHc (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 16 Nov 2023 17:07:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKPWHb (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 16 Nov 2023 17:07:31 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663C218B
        for <linux-security-module@vger.kernel.org>; Thu, 16 Nov 2023 14:07:28 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-da30fd994fdso2142951276.1
        for <linux-security-module@vger.kernel.org>; Thu, 16 Nov 2023 14:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1700172447; x=1700777247; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=McWLK0Erh20b4c0w4AHhfY135hMZXUKuEa1U628p59w=;
        b=I+ByHDZl7O1bS5T23yOnMkTOUF2NjpW7FPshYmiaOFgk4A08f/GZ9oFYW6S5vl6mpd
         PmnoXxXTSNN0jKugKGAYviuziey8wqaKAP2gwxip2eet8ObO4a/Wyal3bOOTJVkpXLU5
         ms9JvZtSHZKqMIs/Y+AVP7ribP2k2xr0x6OdHEkR7+s7SjlMVAa9tE3G0h64gCeX3eMF
         fHsYvIAaAdTq2LgLyxb2NGDX8E1/K9inFVwBIWStjFVS3GLb/5K6JY4fz2/5cAyssSKo
         xT7luT0bpyudmG+mM9IoC4+8CPCAhAeXkeZHTRKQaWLljd8TrH/tSMCjCthfy5kJpp6w
         J1WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700172447; x=1700777247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=McWLK0Erh20b4c0w4AHhfY135hMZXUKuEa1U628p59w=;
        b=QijGA4WQJ2D5/lLPJ//oZhSJg8MxkxtfxcIC57Xw4xDo+VxhiVOfVr+hE2cp2dQ5B5
         E8JuE2xLGPpTYxi5rzEQk5LgwmzBGPuTkOrU7VtOsncJMn1MhjkLU2OWyCyy8rXDVnq1
         3kLb2iq3KAvnK1rktQIIJuCVSRnAtGTOpAGZCQFI8WgRqgEo8Mx6RwJek/SprZP6hLpJ
         4qFgsdpXE/VZ3q1Xv0dP6MNCHyOMDjCO36VlFt12eGuAaSKWSL2+2oNcFQuMa2Bp/ZQk
         GbyHYYUMfkPuTPLfL4FRw26yNeYyj86XUY3WhIw6LlqID7dnHiMFM1NyQPQIzEeLlmYQ
         rKVQ==
X-Gm-Message-State: AOJu0YyHcx8w6Kd5vmaHiIETNHr4eTXckYoXTfMGS4VoIL/hdZiqUsav
        W07OvDu8TJIEtcckhuitquVRg2rYHnT2QCoxr3Hz
X-Google-Smtp-Source: AGHT+IHED5b06hwidP35hDGIWSIQ9u3imhXraRogqXkH7N0Totrcom3GLJDKwPINv/bKKOTrKwcA+sef6an7q3F/l3w=
X-Received: by 2002:a25:74cb:0:b0:daf:1ab5:e454 with SMTP id
 p194-20020a2574cb000000b00daf1ab5e454mr2458374ybc.7.1700172447508; Thu, 16
 Nov 2023 14:07:27 -0800 (PST)
MIME-Version: 1.0
References: <6c0c32d5-e636-2a0e-5bdf-538c904ceea3@linux.microsoft.com>
 <53db2f31-e383-445f-b746-961958a619bd@linux.ibm.com> <5dfcb0d6-8cbf-428e-b8c1-30333fc668b5@linux.microsoft.com>
 <ce2e6de7-4289-442e-8209-fb7c01f51e14@linux.ibm.com>
In-Reply-To: <ce2e6de7-4289-442e-8209-fb7c01f51e14@linux.ibm.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 16 Nov 2023 17:07:16 -0500
Message-ID: <CAHC9VhQ2ZGxAyB0Zy=BQAyJe7ofknaXaAgsgtt5G-ENExdHA=A@mail.gmail.com>
Subject: Re: [RFC V2] IMA Log Snapshotting Design Proposal
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Sush Shringarputale <sushring@linux.microsoft.com>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        peterhuewe@gmx.de, Jarkko Sakkinen <jarkko@kernel.org>,
        jgg@ziepe.ca, Ken Goldman <kgold@linux.ibm.com>, bhe@redhat.com,
        vgoyal@redhat.com, Dave Young <dyoung@redhat.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        jmorris@namei.org, serge@hallyn.com,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-security-module@vger.kernel.org,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Nov 14, 2023 at 1:58=E2=80=AFPM Stefan Berger <stefanb@linux.ibm.co=
m> wrote:
> On 11/14/23 13:36, Sush Shringarputale wrote:
> > On 11/13/2023 10:59 AM, Stefan Berger wrote:
> >> On 10/19/23 14:49, Tushar Sugandhi wrote:
> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>> | Introduction |
> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>> This document provides a detailed overview of the proposed Kernel
> >>> feature IMA log snapshotting.  It describes the motivation behind the
> >>> proposal, the problem to be solved, a detailed solution design with
> >>> examples, and describes the changes to be made in the clients/service=
s
> >>> which are part of remote-attestation system.  This is the 2nd version
> >>> of the proposal.  The first version is present here[1].
> >>>
> >>> Table of Contents:
> >>> ------------------
> >>> A. Motivation and Background
> >>> B. Goals and Non-Goals
> >>>      B.1 Goals
> >>>      B.2 Non-Goals
> >>> C. Proposed Solution
> >>>      C.1 Solution Summary
> >>>      C.2 High-level Work-flow
> >>> D. Detailed Design
> >>>      D.1 Snapshot Aggregate Event
> >>>      D.2 Snapshot Triggering Mechanism
> >>>      D.3 Choosing A Persistent Storage Location For Snapshots
> >>>      D.4 Remote-Attestation Client/Service-side Changes
> >>>          D.4.a Client-side Changes
> >>>          D.4.b Service-side Changes
> >>> E. Example Walk-through
> >>> F. Other Design Considerations
> >>> G. References
> >>>
> >>
> >> Userspace applications will have to know
> >> a) where are the shard files?
> > We describe the file storage location choices in section D.3, but user
> > applications will have to query the well-known location described there=
.
> >> b) how do I read the shard files while locking out the producer of the
> >> shard files?
> >>
> >> IMO, this will require a well known config file and a locking method
> >> (flock) so that user space applications can work together in this new
> >> environment. The lock could be defined in the config file or just be
> >> the config file itself.
> > The flock is a good idea for co-ordination between UM clients. While
> > the Kernel cannot enforce any access in this way, any UM process that
> > is planning on triggering the snapshot mechanism should follow that
> > protocol.  We will ensure we document that as the best-practices in
> > the patch series.
>
> It's more than 'best practices'. You need a well-known config file with
> well-known config options in it.
>
> All clients that were previously just trying to read new bytes from the
> IMA log cannot do this anymore in the presence of a log shard producer
> but have to also learn that a new log shard has been produced so they
> need to figure out the new position in the log where to read from. So
> maybe a counter in a config file should indicate to the log readers that
> a new log has been produced -- otherwise they would have to monitor all
> the log shard files or the log shard file's size.

If a counter is needed, I would suggest placing it somewhere other
than the config file so that we can enforce limited write access to
the config file.

Regardless, I imagine there are a few ways one could synchronize
various userspace applications such that they see a consistent view of
the decomposed log state, and the good news is that the approach
described here is opt-in from a userspace perspective.  If the
userspace does not fully support IMA log snapshotting then it never
needs to trigger it and the system behaves as it does today; on the
other hand, if the userspace has been updated it can make use of the
new functionality to better manage the size of the IMA measurement
log.

--=20
paul-moore.com
