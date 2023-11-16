Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8763EC5ACB3
	for <linux-security-module@archiver.kernel.org>; Thu, 16 Nov 2023 22:29:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjKPW3W (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 16 Nov 2023 17:29:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjKPW3V (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 16 Nov 2023 17:29:21 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8D1199B
        for <linux-security-module@vger.kernel.org>; Thu, 16 Nov 2023 14:28:47 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-da077db5145so1325526276.0
        for <linux-security-module@vger.kernel.org>; Thu, 16 Nov 2023 14:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1700173727; x=1700778527; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y93mqvQuQ3cyR5SUPkiKyzE0itYPgBxsZ6Yl8asHxJU=;
        b=fdxma8MjCmMEs/ZtWtaUYxH3dJzFMgDqZxXna5Sn2pljOdBqnK1HtZ4IOzDfgQe7cB
         JcPb6lw9agIaoZa9A7zcCKt7pB+5pcUjvYllVXyUtWRNnV1uLt5AAlsWvjtra5XWQVb4
         8OfJdcWPpTs1nnYO2G+DkmyND8gPVT7oi02+ELvqFp25P1H39Fc+2fzHHcd2WA2zczqn
         wDo+MAr55nHp994jlR6qGd5PqYycwBtEKWNQ+XnlfzUeJkl46UnxbIGCCQGi9uvgSP+1
         Iztr9mMPsbfYCRns6WbKD/IyT/C/0bAu0atWsOYi9yPGzICJJL3+hkipX6Bk2eVQsCR/
         KwNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700173727; x=1700778527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y93mqvQuQ3cyR5SUPkiKyzE0itYPgBxsZ6Yl8asHxJU=;
        b=Gru8fZZIGRs9rJuoHY+RaNcdxfCxO9dIKtRL/EeVCSRYBk1rc1Hu/KcUG7+U2l7/qd
         MVq5DkCHZgD8MLZVh1i1Tzis92sk13OtKB53Nznp6KqtTyrEkpf9wY6ehuaDDWnCuLwe
         GIAdJTzg37fNE8a1oFaxdM2z6w1JVf7LozSblA5RxF5a1Ke2zfXqw0CPlz62b95pSQQj
         pEdWR1W8ob1XV3xneRTPXP6PWHgbdt102uJn2xQgWLnQQmqg8jOrTYIrTMEWlyT0L50I
         E0fdUQ8MnKLGuuEbi552knh480OiYgWU4zHgTnyUQcOdLMeKgf7YK1LdPxfMrdmehCsn
         jezA==
X-Gm-Message-State: AOJu0YzzT/70aX2QVaqLUs993hoPKo1P5RQTFdv8vcNadlbWb9W2HSe3
        aeGlX3/OAoq4VhmGyp/Pqv/I3TenvdI2o0YIyHNs
X-Google-Smtp-Source: AGHT+IFH0V8fklGmPgdOyUiaO72Xq2JkkoI8N9fz5QX6EKc/JUzxtZpHmzPeAmVX3/H+pR3wMRJkHhEUa4N1n3bO95Q=
X-Received: by 2002:a25:2106:0:b0:da3:b466:1f73 with SMTP id
 h6-20020a252106000000b00da3b4661f73mr14599148ybh.24.1700173726615; Thu, 16
 Nov 2023 14:28:46 -0800 (PST)
MIME-Version: 1.0
References: <6c0c32d5-e636-2a0e-5bdf-538c904ceea3@linux.microsoft.com> <8bff2bf1a4629aacec7b6311d77f233cb75b2f8a.camel@linux.ibm.com>
In-Reply-To: <8bff2bf1a4629aacec7b6311d77f233cb75b2f8a.camel@linux.ibm.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 16 Nov 2023 17:28:35 -0500
Message-ID: <CAHC9VhRm9Tzz3C-VTdXS4s1_-kPQQ6RXMt8JGCS4jorJ0VURyQ@mail.gmail.com>
Subject: Re: [RFC V2] IMA Log Snapshotting Design Proposal
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de,
        Jarkko Sakkinen <jarkko@kernel.org>, jgg@ziepe.ca,
        Ken Goldman <kgold@linux.ibm.com>, bhe@redhat.com,
        vgoyal@redhat.com, Dave Young <dyoung@redhat.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        jmorris@namei.org, serge@hallyn.com,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-security-module@vger.kernel.org,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Sush Shringarputale <sushring@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Oct 31, 2023 at 3:15=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> wr=
ote:
> On Thu, 2023-10-19 at 11:49 -0700, Tushar Sugandhi wrote:
>
> [...]
> > -----------------------------------------------------------------------
> > | C.1 Solution Summary                                                |
> > -----------------------------------------------------------------------
> > To achieve the goals described in the section above, we propose the
> > following changes to the IMA subsystem.
> >
> >      a. The IMA log from Kernel memory will be offloaded to some
> >         persistent storage disk to keep the system running reliably
> >         without facing memory pressure.
> >         More details, alternate approaches considered etc. are present
> >         in section "D.3 Choices for Storing Snapshots" below.
> >
> >      b. The IMA log will be divided into multiple chunks (snapshots).
> >         Each snapshot would be a delta between the two instances when
> >         the log was offloaded from memory to the persistent storage
> >         disk.
> >
> >      c. Some UM process (like a remote-attestation-client) will be
> >         responsible for writing the IMA log snapshot to the disk.
> >
> >      d. The same UM process would be responsible for triggering the IMA
> >         log snapshot.
> >
> >      e. There will be a well-known location for storing the IMA log
> >         snapshots on the disk.  It will be non-trivial for UM processes
> >         to change that location after booting into the Kernel.
> >
> >      f. A new event, "snapshot_aggregate", will be computed and measure=
d
> >         in the IMA log as part of this feature.  It should help the
> >         remote-attestation client/service to benefit from the IMA log
> >         snapshot feature.
> >         The "snapshot_aggregate" event is described in more details in
> >         section "D.1 Snapshot Aggregate Event" below.
> >
> >      g. If the existing remote-attestation client/services do not chang=
e
> >         to benefit from this feature or do not trigger the snapshot,
> >         the Kernel will continue to have it's current functionality of
> >         maintaining an in-memory full IMA log.
> >
> > Additionally, the remote-attestation client/services need to be updated
> > to benefit from the IMA log snapshot feature.  These proposed changes
> >
> > are described in section "D.4 Remote-Attestation Client/Service Side
> > Changes" below, but their implementation is out of scope for this
> > proposal.
>
> As previously said on v1,
>    This design seems overly complex and requires synchronization between =
the
>    "snapshot" record and exporting the records from the measurement list.=
 [...]
>
>    Concerns:
>    - Pausing extending the measurement list.
>
> Nothing has changed in terms of the complexity or in terms of pausing
> the measurement list.   Pausing the measurement list is a non starter.

The measurement list would only need to be paused for the amount of
time it would require to generate the snapshot_aggregate entry, which
should be minimal and only occurs when a privileged userspace requests
a snapshot operation.  The snapshot remains opt-in functionality, and
even then there is the possibility that the kernel could reject the
snapshot request if generating the snapshot_aggregate entry was deemed
too costly (as determined by the kernel) at that point in time.

> Userspace can already export the IMA measurement list(s) via the
> securityfs {ascii,binary}_runtime_measurements file(s) and do whatever
> it wants with it.  All that is missing in the kernel is the ability to
> trim the measurement list, which doesn't seem all that complicated.

From my perspective what has been presented is basically just trimming
the in-memory measurement log, the additional complexity (which really
doesn't look that bad IMO) is there to ensure robustness in the face
of an unreliable userspace (processes die, get killed, etc.) and to
establish a new, transitive root of trust in the newly trimmed
in-memory log.

I suppose one could simplify things greatly by having a design where
userspace  captures the measurement log and then writes the number of
measurement records to trim from the start of the measurement log to a
sysfs file and the kernel acts on that.  You could do this with, or
without, the snapshot_aggregate entry concept; in fact that could be
something that was controlled by userspace, e.g. write the number of
lines and a flag to indicate if a snapshot_aggregate was desired to
the sysfs file.  I can't say I've thought it all the way through to
make sure there are no gotchas, but I'm guessing that is about as
simple as one can get.

If there is something else you had in mind, Mimi, please share the
details.  This is a very real problem we are facing and we want to
work to get a solution upstream.

--=20
paul-moore.com
