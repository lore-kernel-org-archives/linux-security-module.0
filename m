Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C15C83F14
	for <linux-security-module@archiver.kernel.org>; Wed, 30 Aug 2023 21:02:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240717AbjH3VCo (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 30 Aug 2023 17:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240763AbjH3VCn (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 30 Aug 2023 17:02:43 -0400
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB87E47
        for <linux-security-module@vger.kernel.org>; Wed, 30 Aug 2023 14:02:07 -0700 (PDT)
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-56a55c0f8b1so191921a12.0
        for <linux-security-module@vger.kernel.org>; Wed, 30 Aug 2023 14:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1693429195; x=1694033995; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ssuGzZWwIiUWbDzTGLwSAE+t2YPIoJ48hSVHvjVyTrQ=;
        b=OJOLrxg2sJMMfeZj0gi7wb/gh8RcvZrEgXr9WWeBjQ7zSiKnAkWVg/lw2JhYUUZZ3M
         f1SZ4CnhIQD/ljKU97Fpj0569yVN8nnoFfdh/XLjROzRi1f/iSUJdXc8Lo3cy3Q1BgiD
         C7vJ5dtLWaQOAPs66H98fBwBmhWugltz8eWMRhHCCj+4roHMIr3oUHDKE486FLce5IsC
         psNui3lI7DE12tosc7OZFaaBaoSavXRpF8OKxSleZXAZ4e8OAiV9Cf0AkpzUAc7mWvx+
         bYb7MaQUnXkvh+r8LMlCcV6JQEiypCWpkFFv7078OWog6nAKNpebs+qsNC+0MHRbHTxf
         5e4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693429195; x=1694033995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ssuGzZWwIiUWbDzTGLwSAE+t2YPIoJ48hSVHvjVyTrQ=;
        b=l1hrrNmPfIOrlKHDSY5w7II+dRTREGFPkeJ0eWfTAEzGucokeGeVqz+xz2JZMZ/+25
         uFGN7J6ftj2h6hWIXfVxMU+y8t9Ge+a0jBzL7RtkCXYjQY10MVF5Fv10lIETw3gvb2Fe
         vYuaUK2zUGAaJ5OdTLV4X9AkDAY5y9xJaoSrRbscqGsiJSQ2o7CfJChLaqRb1nUPZh6L
         cfS20R5YXA743/WnVBPBGz8LKwp4J/RTsnVyv6v/mtP2+XG0PxHmeXpsIZVrCHPAiUMY
         22xjDHbbHod8E4vQgj+mC24Lr0yOSrCJKOSqiI/cFA4LsbbMJ5BDrNiS54cHjWEfTf3g
         AS6w==
X-Gm-Message-State: AOJu0YzASZ+B8CIj9JPi8XIbodfiZWA5ijRFQgVEe7tApGAKqphcKb5G
        YEb64mugZF2us/qGu2euTPThL+37zezTizRSN0xb2jP/8LPBi0Jz9g==
X-Google-Smtp-Source: AGHT+IHDRYogg+GkQ5vRG7NJp8ux1iBN2Yw6FJC8DSmoHEs6dPTAHHn7AHBZfxkPF4xTpQ/AfDZfr3Fo/8jD1GOCr/k=
X-Received: by 2002:a0d:f747:0:b0:595:80e4:907d with SMTP id
 h68-20020a0df747000000b0059580e4907dmr3028540ywf.32.1693428471675; Wed, 30
 Aug 2023 13:47:51 -0700 (PDT)
MIME-Version: 1.0
References: <c5737141-7827-1c83-ab38-0119dcfea485@linux.microsoft.com>
 <277db5491460d5fd607785f2bcc733de39022a35.camel@linux.ibm.com>
 <bf794136-703a-0d33-e245-7e723007b5c0@linux.microsoft.com>
 <0e1511e8819b24ab8a34a7b15821f06eff688f29.camel@linux.ibm.com>
 <8bc0f024-fc12-cb32-7af0-e500948cc6db@linux.microsoft.com>
 <7e32afa2596b9d8cfdc275614575b2023cd1d673.camel@linux.ibm.com>
 <CAHC9VhSVO9t=9e9JmniXKoqqvMv42E4dVeYtQTWZ4Eih3Sfr0Q@mail.gmail.com>
 <ed16f899485cbd559f9e6d7fbe17fa0d92335c20.camel@linux.ibm.com>
 <CAHC9VhTjej-GFjvEQhnL-HWnnkvJKA_DuOA_Md1KkV24Tx5haA@mail.gmail.com>
 <077249ac2bf2cb6d34347514e921720bb0f30b66.camel@linux.ibm.com>
 <CAHC9VhTvK=sJUgCUS0H9BWWXPnj3e0XkfE-4vB3-oxyt2_Wj9w@mail.gmail.com> <930e517c724fac27f7a1a4165af51dbc37cce4a0.camel@linux.ibm.com>
In-Reply-To: <930e517c724fac27f7a1a4165af51dbc37cce4a0.camel@linux.ibm.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 30 Aug 2023 16:47:40 -0400
Message-ID: <CAHC9VhStr3BAzb3tyHzHVPXzzuxyXjPQ4vmi+SrJqbTWio04+Q@mail.gmail.com>
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

On Wed, Aug 30, 2023 at 4:25=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> wr=
ote:
> Your initial question was "what happens if the file/filesystem becomes
> inaccessible at some point and an attestation client attempts to read
> the entire log?".  For what reason would it be inaccessible?  For the
> original single tmpfs file, what would make it inaccessible?

In your reply that I had responded to you had mentioned that the
kernel was simply being passed a fd and taking ownership of it, the fd
could either be a tmpfs backed file or some form of persistent storage
as both were discussed in this thread.  I imagine a tmpfs filesystem
could still be forcibly unmounted, resulting in problems, but I can't
say that for certain.  However, there are definitely cases where a fd
backed against an arbitrary filesystem could run into problems:
storage device issues for local filesystems, networking issues for
network filesystems, and good old fashioned user/admin intervention in
both cases.

> In the
> "snapshotting" design this problem becomes a userspace issue.

Yes, exactly.  Userspace is almost always going to have an easier time
recovering from these types of errors ... or at least I believe so,
perhaps you have a clever solution for how the kernel can handle the
file/filesystem disappearing from under the fd?

> The first sentence of the cover letter is "Depending on the IMA policy,
> the IMA log can consume a lot of Kernel memory on the device." ...

As I'm still looking for an answer to my question, let's stay focused
on that before we start worrying too much about the phrasing of the
design proposal that was submitted.

--=20
paul-moore.com
