Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D7F5C197A0
	for <linux-security-module@archiver.kernel.org>; Thu, 16 Nov 2023 22:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjKPW4j (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 16 Nov 2023 17:56:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjKPW4i (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 16 Nov 2023 17:56:38 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8B9130
        for <linux-security-module@vger.kernel.org>; Thu, 16 Nov 2023 14:56:35 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so1374990276.1
        for <linux-security-module@vger.kernel.org>; Thu, 16 Nov 2023 14:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1700175394; x=1700780194; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IsOeDCVHbRtCHMfzzq1TAv9cQgSIrowc6ucZqtobrEU=;
        b=UvJAPGer1rLT37Nf/reICuJdhwXv/hWEvgAUoG0GMIpqN6WArmS0x4YngdV1zOMTj0
         518yhh8ErpZxO+C5qeIIdWYNWXT2BvVYUi5l2QPBpzc6MeioDLFi3t9zA+4fQvE6CXKW
         41qWksrCZbXayWK9FsHWjoYJfhOO8wjfvBLmbSJn9mgPRAGpamnzc8bznTvo/b9xR8Wp
         r8AIhnQBxMYpfznx60A6sORf8EsiNy3gysL2QNsfgyKu5YISfoydQgiYzJc1M/ri9nhb
         CWlIM/Im18S2rFhPkxFBKjxzOgCL16l4ylNp3Y4k3KAfC1h50U9oApNBYSez5SQ9GfKb
         hR8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700175394; x=1700780194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IsOeDCVHbRtCHMfzzq1TAv9cQgSIrowc6ucZqtobrEU=;
        b=dlvnlzLShyJ8ljadTcA+LMtUOVu9v5tZua8AseJb1+dLhKf1eg2GhaIxBqq2DZIxWG
         m4Qh4b8HlKUEniI6eMuMi1NRDmtxBNSqeN3Iusiv00T9fwnBh13bEis0kZsoKXvyJBGx
         H/Fr+zlQS/a1ZRZnUyDFQp4OoxELOP2T5Z27QldVPWIrjZbGhn1DG4LbRleGJHnjtpyl
         RV60zpLbfLfwE1xf4X4EKFRJYzzJ+VA7Z3540zB+3pvYMTkgPUV0+XaaT/5Lds+51hFF
         4gQ0B9raw6IccAq/h5y2D9sEVEw8Yd+UbUc/cNqkmejT1rpNWulCA3Nj+SCasalH86/N
         ISSw==
X-Gm-Message-State: AOJu0Yy7JaU/krYHQOeKZa6i7f3RJIZmaQD9wQxhCKWiYjRvojhN4nN1
        Q8jr0lFKhJ+humlnKu4IQkEQMvu9vCyzdO+86rvJ
X-Google-Smtp-Source: AGHT+IE2+AcN0WJvi0/kso4DZanSDDx6lgfXDUrfRsZwb16RGMyBmQlC1nbV8aw1RFcW/pXSAxD2p1WHO1Zi2XhSD08=
X-Received: by 2002:a25:d087:0:b0:d9b:6264:b79e with SMTP id
 h129-20020a25d087000000b00d9b6264b79emr15509359ybg.53.1700175394153; Thu, 16
 Nov 2023 14:56:34 -0800 (PST)
MIME-Version: 1.0
References: <6c0c32d5-e636-2a0e-5bdf-538c904ceea3@linux.microsoft.com>
 <53db2f31-e383-445f-b746-961958a619bd@linux.ibm.com> <5dfcb0d6-8cbf-428e-b8c1-30333fc668b5@linux.microsoft.com>
 <ce2e6de7-4289-442e-8209-fb7c01f51e14@linux.ibm.com> <CAHC9VhQ2ZGxAyB0Zy=BQAyJe7ofknaXaAgsgtt5G-ENExdHA=A@mail.gmail.com>
 <1ed2d72c-4cb2-48b3-bb0f-b0877fc1e9ca@linux.ibm.com>
In-Reply-To: <1ed2d72c-4cb2-48b3-bb0f-b0877fc1e9ca@linux.ibm.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 16 Nov 2023 17:56:23 -0500
Message-ID: <CAHC9VhTxQZ5+omZdjwtQwe7MJeAdaLAXP2d5GgyyABLRYkWkGw@mail.gmail.com>
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

On Thu, Nov 16, 2023 at 5:41=E2=80=AFPM Stefan Berger <stefanb@linux.ibm.co=
m> wrote:
> On 11/16/23 17:07, Paul Moore wrote:
> > On Tue, Nov 14, 2023 at 1:58=E2=80=AFPM Stefan Berger <stefanb@linux.ib=
m.com> wrote:
> >> On 11/14/23 13:36, Sush Shringarputale wrote:
> >>> On 11/13/2023 10:59 AM, Stefan Berger wrote:
> >>>> On 10/19/23 14:49, Tushar Sugandhi wrote:
> >>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>>> | Introduction |
> >>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>>> This document provides a detailed overview of the proposed Kernel
> >>>>> feature IMA log snapshotting.  It describes the motivation behind t=
he
> >>>>> proposal, the problem to be solved, a detailed solution design with
> >>>>> examples, and describes the changes to be made in the clients/servi=
ces
> >>>>> which are part of remote-attestation system.  This is the 2nd versi=
on
> >>>>> of the proposal.  The first version is present here[1].
> >>>>>
> >>>>> Table of Contents:
> >>>>> ------------------
> >>>>> A. Motivation and Background
> >>>>> B. Goals and Non-Goals
> >>>>>       B.1 Goals
> >>>>>       B.2 Non-Goals
> >>>>> C. Proposed Solution
> >>>>>       C.1 Solution Summary
> >>>>>       C.2 High-level Work-flow
> >>>>> D. Detailed Design
> >>>>>       D.1 Snapshot Aggregate Event
> >>>>>       D.2 Snapshot Triggering Mechanism
> >>>>>       D.3 Choosing A Persistent Storage Location For Snapshots
> >>>>>       D.4 Remote-Attestation Client/Service-side Changes
> >>>>>           D.4.a Client-side Changes
> >>>>>           D.4.b Service-side Changes
> >>>>> E. Example Walk-through
> >>>>> F. Other Design Considerations
> >>>>> G. References
> >>>>>
> >>>>
> >>>> Userspace applications will have to know
> >>>> a) where are the shard files?
> >>> We describe the file storage location choices in section D.3, but use=
r
> >>> applications will have to query the well-known location described the=
re.
> >>>> b) how do I read the shard files while locking out the producer of t=
he
> >>>> shard files?
> >>>>
> >>>> IMO, this will require a well known config file and a locking method
> >>>> (flock) so that user space applications can work together in this ne=
w
> >>>> environment. The lock could be defined in the config file or just be
> >>>> the config file itself.
> >>> The flock is a good idea for co-ordination between UM clients. While
> >>> the Kernel cannot enforce any access in this way, any UM process that
> >>> is planning on triggering the snapshot mechanism should follow that
> >>> protocol.  We will ensure we document that as the best-practices in
> >>> the patch series.
> >>
> >> It's more than 'best practices'. You need a well-known config file wit=
h
> >> well-known config options in it.
> >>
> >> All clients that were previously just trying to read new bytes from th=
e
> >> IMA log cannot do this anymore in the presence of a log shard producer
> >> but have to also learn that a new log shard has been produced so they
> >> need to figure out the new position in the log where to read from. So
> >> maybe a counter in a config file should indicate to the log readers th=
at
> >> a new log has been produced -- otherwise they would have to monitor al=
l
> >> the log shard files or the log shard file's size.
> >
> > If a counter is needed, I would suggest placing it somewhere other
> > than the config file so that we can enforce limited write access to
> > the config file.
> >
> > Regardless, I imagine there are a few ways one could synchronize
> > various userspace applications such that they see a consistent view of
> > the decomposed log state, and the good news is that the approach
> > described here is opt-in from a userspace perspective.  If the
>
> A FUSE filesystem that stitches together the log shards from one or
> multiple files + IMA log file(s) could make this approach transparent
> for as long as log shards are not thrown away. Presumably it (or root)
> could bind-mount its files over the two IMA log files.
>
> > userspace does not fully support IMA log snapshotting then it never
> > needs to trigger it and the system behaves as it does today; on the
>
> I don't think individual applications should trigger it , instead some
> dedicated background process running on a machine would do that every n
> log entries or so and possibly offer the FUSE filesystem at the same
> time. In either case, once any application triggers it, all either have
> to know how to deal with the shards or FUSE would make it completely
> transparent.

Yes, performing a snapshot is a privileged operation which I expect
would be done and managed by a dedicated daemon running on the system.

--=20
paul-moore.com
