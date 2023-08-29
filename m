Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC74C71153
	for <linux-security-module@archiver.kernel.org>; Tue, 29 Aug 2023 19:35:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233238AbjH2Teu (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 29 Aug 2023 15:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240488AbjH2Ter (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 29 Aug 2023 15:34:47 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45EAE53
        for <linux-security-module@vger.kernel.org>; Tue, 29 Aug 2023 12:34:22 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-58cd9d9dbf5so2059207b3.0
        for <linux-security-module@vger.kernel.org>; Tue, 29 Aug 2023 12:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1693337662; x=1693942462; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dku1evb9mZQ/UCmFfdo5JZbpZalq24cWTcGsSAzwTxo=;
        b=GUB7STxbWkUDF/NQn4wyEXkioEA8oNZKQtrONNhVa0DSjs2gac/DbSU+cmA34mWhJu
         S5Jfx0XYrmZ9UXoEZ+6Tz83IoUA1zQbHcft7aea2fFU2JLW0Y3b+mw1azRDMyidjeU1i
         /3x0xaCloJjPcZFYekmBIXsXCxUp2T+5IEn+vfT3inx9jWYzm492gnde76XSCC70EKXo
         6Yjx1eM25U1w1GVLLCXklc79qS+7qD039HZWOaMJPOdqs3Xneht97JkTc5iVmM0dztpw
         bybWHvA5pTXuVrxRrKtAFZA3VzC1h95pkWFSSWddhSwQDS1hF+uJXbsJEMGbQNaoOaVG
         Du5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693337662; x=1693942462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dku1evb9mZQ/UCmFfdo5JZbpZalq24cWTcGsSAzwTxo=;
        b=SHIrvuiCLLkSyB0zSCVZCJprWIiBBshgCkqLb8awWgAHHGa0zYBDmk+EMPQxGKGhX4
         zaXJ457Pd81YnyCmmGQa343oaLnIx13LCRgZuTz4SKYKeHxciv30zNZqJymbvDd7Dx8B
         OUmEFuuwVpNChKxOyGIDnW0mJN8iEMRo0jC2IEcMz5Gzym+bav59TuXw1I1NR6NUcxj4
         F1zaPQqEHea2kga4mJGEACPh65qykgJUF2MSESlmXZcuGpCnI2CJw6Hyd7rf2w3n2yur
         wdU45S60uNc5ZsZdmCm5m/Bdg8MGzzA3R6G3ot1cO1WZ6miXhuG2wqy25CwrZB+Lp1O0
         8NuA==
X-Gm-Message-State: AOJu0YytH7JZIF4UJghCJcubmi651mCL1rGugH88xm9E9Q3ntZMQkYcf
        zvvWMZuprQTOxaXH53J2Na4lJqnIYqpDQ2vwSAkY
X-Google-Smtp-Source: AGHT+IFet3rs4lSa6SdyUYuNhduFXChT/c/u2XD2EuWbmN/GXJdqeDdKGD9HS33EBu3hJQ+LAmlIEUXeaAC+annspfI=
X-Received: by 2002:a81:4e10:0:b0:586:a680:250 with SMTP id
 c16-20020a814e10000000b00586a6800250mr179637ywb.5.1693337661845; Tue, 29 Aug
 2023 12:34:21 -0700 (PDT)
MIME-Version: 1.0
References: <c5737141-7827-1c83-ab38-0119dcfea485@linux.microsoft.com>
 <277db5491460d5fd607785f2bcc733de39022a35.camel@linux.ibm.com>
 <bf794136-703a-0d33-e245-7e723007b5c0@linux.microsoft.com>
 <0e1511e8819b24ab8a34a7b15821f06eff688f29.camel@linux.ibm.com>
 <8bc0f024-fc12-cb32-7af0-e500948cc6db@linux.microsoft.com> <7e32afa2596b9d8cfdc275614575b2023cd1d673.camel@linux.ibm.com>
In-Reply-To: <7e32afa2596b9d8cfdc275614575b2023cd1d673.camel@linux.ibm.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 29 Aug 2023 15:34:10 -0400
Message-ID: <CAHC9VhSVO9t=9e9JmniXKoqqvMv42E4dVeYtQTWZ4Eih3Sfr0Q@mail.gmail.com>
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

On Mon, Aug 21, 2023 at 7:08=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> wr=
ote:
> On Mon, 2023-08-21 at 15:05 -0700, Sush Shringarputale wrote:
> > On 8/14/2023 3:02 PM, Mimi Zohar wrote:
> > > On Mon, 2023-08-14 at 14:42 -0700, Sush Shringarputale wrote:
> > >>> This design seems overly complex and requires synchronization betwe=
en
> > >>> the "snapshot" record and exporting the records from the measuremen=
t
> > >>> list.  None of this would be necessary if the measurements were cop=
ied
> > >>> from kernel memory to a backing file (e.g. tmpfs), as described in =
[1].
> > Even if the Kernel maintains the link between a tmpfs exported and an
> > in-memory IMA log - it still has to copy the tmpfs portion to the
> > Kernel memory during kexec soft boot.  tmpfs is cleared during kexec,
> > so this copying of tmpfs back to kernel memory is necessary to preserve
> > the integrity of the log during kexec.  But the copying would add back
> > the memory pressure on the node during kexec (which may result in
> > out-of-memory), defeating the purpose of the overall effort/feature.
> > Copying to a regular *persistent* protected file seems a cleaner
> > approach, compared to tmpfs.
>
> From a kernel perspective, it doesn't make a difference if userspace
> provides a tmpfs or persistent file.  As per the discussion
> https://lore.kernel.org/linux-integrity/CAOQ4uxj4Pv2Wr1wgvBCDR-tnA5dsZT3r=
vdDzKgAH1aEV_-r9Qg@mail.gmail.com/#t
> , userspace provides the kernel with the file descriptor of the opened
> file.
>
> > We prototyped this solution, however it
> > does not seem to be a common pattern within the Kernel to write state
> > directly to files on disk file systems.  We considered two potential
> > options:
>
> If no file descriptor is provided, then the measurements aren't copied
> and removed from the securityfs file.  If there are write errors, the
> measurements aren't removed from the securityfs file until the write
> errors are resolved.

It sounds like this approach would require the file/filesystem to be
continuously available for the life of the system once the log was
snapshotted/overflowed to persistent storage, yes?  Assuming that is
the case, what happens if the file/filesystem becomes inaccessible at
some point and an attestation client attempts to read the entire log?

--=20
paul-moore.com
