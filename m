Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5855C71153
	for <linux-security-module@archiver.kernel.org>; Tue, 29 Aug 2023 21:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbjH2Vap (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 29 Aug 2023 17:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236153AbjH2Vag (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 29 Aug 2023 17:30:36 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC49139
        for <linux-security-module@vger.kernel.org>; Tue, 29 Aug 2023 14:30:32 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-58cd9d9dbf5so3478067b3.0
        for <linux-security-module@vger.kernel.org>; Tue, 29 Aug 2023 14:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1693344632; x=1693949432; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U1Auf0z5ADRpVwU3wK7GGqhDo3zcyVhDtiPzWKFvZWs=;
        b=DlnRikGsA0WfoZfxCOCxwrtq77Tbbp711BT30fMSRGziv8a3UMrB4Ymog8FhCnfagc
         4hJ+thH8zG0huxGU/ZCLhfXBouGm98XkJcmGVUIWVC9P+/7BNT20kufAbCICBpuC1bIs
         2bASr1LXh4LDw1nih2aZcxs68FyKyfj0K2nPqbHZ4q80YEnmbHoQ7u/O+2rbpnZkJ4PA
         IHhTNN2racnNFlU4Xp0E/IyG38fIeBvdQCjL0Xx507zp4tE0U/azqb4GnaG9mp5fyoJd
         DYdQ3xrYPw0Ls013IykoidEM6drYAoWS1rpEmO7ZhyBt8z95V9amyI/ALaGpLibplSBe
         fS1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693344632; x=1693949432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U1Auf0z5ADRpVwU3wK7GGqhDo3zcyVhDtiPzWKFvZWs=;
        b=fC1S7Xny1WXxL6GIRgUqyXSAsnCrQcdFGOwb7lz+5iPN8vZRlZKyPqDxZyQNSP/nAY
         M1YKVVQGQKqWWtUOMkFe3/EKV7PWES/sOOfIoaIBXDQXeesoQJ/MDxTSHzcY1OgrySSx
         IEIiNAVXsg9B5vGVUOH2UlammpIfr3UNV2pDJ5CMHUk+cKsaduoGbk6OM5hC4USe+sCj
         k/KYdu8RxXvaxalIjnwSFC4VD2rrsUn4oJo83BfeX4V3HtiRmATVHiONATT95wQ5AbLT
         QWhCzpexI/jAeoAWOOmpr3Pbccosn/qqTT64D4JOm889HKKdU3GZt/BlTL1agcaDV2jN
         eW/A==
X-Gm-Message-State: AOJu0YxXEnVo7keC2ikyn7i0kQvVhjsh7P4wlts6Qlt56HSH7nGB3bsO
        uCOlD3SW6oRPP3EkwX4aQM4UKFbH4Rk1rLtrMBo3
X-Google-Smtp-Source: AGHT+IGXqcjzp7lemLr4OmY53Af17gLzlozRvp7po60yla7AEvrLXybXNorUHfsQ6EENu4c0afLLI4QjLJWsNE9DJ/0=
X-Received: by 2002:a0d:db50:0:b0:595:6912:4706 with SMTP id
 d77-20020a0ddb50000000b0059569124706mr477272ywe.23.1693344631808; Tue, 29 Aug
 2023 14:30:31 -0700 (PDT)
MIME-Version: 1.0
References: <c5737141-7827-1c83-ab38-0119dcfea485@linux.microsoft.com>
 <277db5491460d5fd607785f2bcc733de39022a35.camel@linux.ibm.com>
 <bf794136-703a-0d33-e245-7e723007b5c0@linux.microsoft.com>
 <0e1511e8819b24ab8a34a7b15821f06eff688f29.camel@linux.ibm.com>
 <8bc0f024-fc12-cb32-7af0-e500948cc6db@linux.microsoft.com>
 <7e32afa2596b9d8cfdc275614575b2023cd1d673.camel@linux.ibm.com>
 <CAHC9VhSVO9t=9e9JmniXKoqqvMv42E4dVeYtQTWZ4Eih3Sfr0Q@mail.gmail.com> <ed16f899485cbd559f9e6d7fbe17fa0d92335c20.camel@linux.ibm.com>
In-Reply-To: <ed16f899485cbd559f9e6d7fbe17fa0d92335c20.camel@linux.ibm.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 29 Aug 2023 17:30:20 -0400
Message-ID: <CAHC9VhTjej-GFjvEQhnL-HWnnkvJKA_DuOA_Md1KkV24Tx5haA@mail.gmail.com>
Subject: Re: [RFC] IMA Log Snapshotting Design Proposal
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Sush Shringarputale <sushring@linux.microsoft.com>,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, kgold@linux.ibm.com,
        bhe@redhat.com, vgoyal@redhat.com, dyoung@redhat.com,
        kexec@lists.infradead.org, jmorris@namei.org, serge@hallyn.com,
        code@tyhicks.com, nramas@linux.microsoft.com,
        Tushar Sugandhi <tusharsu@linux.mic>,
        linux-security-module@vger.kernel.org,
        AmirGoldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Aug 29, 2023 at 5:05=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> wr=
ote:
> On Tue, 2023-08-29 at 15:34 -0400, Paul Moore wrote:
> > On Mon, Aug 21, 2023 at 7:08=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com=
> wrote:
> > > On Mon, 2023-08-21 at 15:05 -0700, Sush Shringarputale wrote:
> > > > On 8/14/2023 3:02 PM, Mimi Zohar wrote:
> > > > > On Mon, 2023-08-14 at 14:42 -0700, Sush Shringarputale wrote:
> > > > >>> This design seems overly complex and requires synchronization b=
etween
> > > > >>> the "snapshot" record and exporting the records from the measur=
ement
> > > > >>> list.  None of this would be necessary if the measurements were=
 copied
> > > > >>> from kernel memory to a backing file (e.g. tmpfs), as described=
 in [1].
> > > > Even if the Kernel maintains the link between a tmpfs exported and =
an
> > > > in-memory IMA log - it still has to copy the tmpfs portion to the
> > > > Kernel memory during kexec soft boot.  tmpfs is cleared during kexe=
c,
> > > > so this copying of tmpfs back to kernel memory is necessary to pres=
erve
> > > > the integrity of the log during kexec.  But the copying would add b=
ack
> > > > the memory pressure on the node during kexec (which may result in
> > > > out-of-memory), defeating the purpose of the overall effort/feature=
.
> > > > Copying to a regular *persistent* protected file seems a cleaner
> > > > approach, compared to tmpfs.
> > >
> > > From a kernel perspective, it doesn't make a difference if userspace
> > > provides a tmpfs or persistent file.  As per the discussion
> > > https://lore.kernel.org/linux-integrity/CAOQ4uxj4Pv2Wr1wgvBCDR-tnA5ds=
ZT3rvdDzKgAH1aEV_-r9Qg@mail.gmail.com/#t
> > > , userspace provides the kernel with the file descriptor of the opene=
d
> > > file.
> > >
> > > > We prototyped this solution, however it
> > > > does not seem to be a common pattern within the Kernel to write sta=
te
> > > > directly to files on disk file systems.  We considered two potentia=
l
> > > > options:
> > >
> > > If no file descriptor is provided, then the measurements aren't copie=
d
> > > and removed from the securityfs file.  If there are write errors, the
> > > measurements aren't removed from the securityfs file until the write
> > > errors are resolved.
> >
> > It sounds like this approach would require the file/filesystem to be
> > continuously available for the life of the system once the log was
> > snapshotted/overflowed to persistent storage, yes?  Assuming that is
> > the case, what happens if the file/filesystem becomes inaccessible at
> > some point and an attestation client attempts to read the entire log?
>
> The main purpose of the change is to addres kernel memory pressure.
> Two designs are being discussed: Sush's "snapshotting" design and
> Amir's original suggestion of continously exporting the measurement
> records to a tmpfs or regular file.  Both designs require verifying the
> initial attestation quote by walking the entire measurement list,
> calculating the expected TPM PCR value(s).  That doesn't change.

Sure, but my question is about what happens if portions of the
measurement list disappear due to file/filesystem problems?  How is
that handled?

--=20
paul-moore.com
