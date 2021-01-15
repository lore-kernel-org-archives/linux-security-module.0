Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A1CC433E6
	for <linux-security-module@archiver.kernel.org>; Fri, 15 Jan 2021 06:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0932323A23
	for <linux-security-module@archiver.kernel.org>; Fri, 15 Jan 2021 06:03:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbhAOGD1 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 15 Jan 2021 01:03:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbhAOGDZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 15 Jan 2021 01:03:25 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FECEC061575
        for <linux-security-module@vger.kernel.org>; Thu, 14 Jan 2021 22:02:45 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id u21so9176800lja.0
        for <linux-security-module@vger.kernel.org>; Thu, 14 Jan 2021 22:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MDmlV62xy2dTAa7jUaW4qdfTp5nhVCOQRSmVDFfq7CU=;
        b=P3f/TC0N21PLslxgUMkEFSMq6IEjaNybcJJZ9sGTGnSYNOG2usJJTVflhsSmi4hqHR
         KN06JeUoyNa7d3JQCTiClZLNTEcyDizNR63bHhj/nr66vJLqBVq0wsG6z/M0+ht2q9QW
         aGskVR2SNoz2AmO8Ad2lStOC76v9OnGDq/QyQ+wISQgNLdZx7kcJkH+Uz2V+JXLJ78mW
         BXRHu0W6VcWo1rVP/TqK9xCMkJE3QIgdaDSJqdhEcf7YqGQkxJ7SH9gRjTFEy9FslFfb
         /4ZCr3zhKywmBqS6j721detK5gmAfBUoyFS5OZt72xdBTeJ81NKxZ0c6BjI9gc+8hXCC
         1/QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MDmlV62xy2dTAa7jUaW4qdfTp5nhVCOQRSmVDFfq7CU=;
        b=Wt+5VaeVwYHBqo4Wus1c639NCE8gbS9Cbii7buBb8UqBf3lO/AdOz2xy9kl8JZOlWl
         zWgjrsALbQnNoA1wd3bwzn7aSj7auVVJ5M9OURRWM82dpF610/62l3hVnaTGTOU+cL9J
         6Pp5S82sKq2vLu9gXmCNwrsHIIHeEodF1bZGqv+b+UQbXRopbRjAnrJ/tH9rSbduJ5rS
         6j0SOaue2o4hxpl9BYmJJNy2ddOxRVpA/jcTXnAeXMKsdpdmTws087K5xs1+X0pw34ZP
         LqwL7L65rR5X7hli50ePZRFLrGVdEuFSb3SxB0EhwlyyvyRp8IXxhFI6uaksHxhzMhqm
         FJFA==
X-Gm-Message-State: AOAM531WdPRkg0uDIc2rdF/V4HH7ReEXmIDY7KoO1Hmr4bPYs7e5F2sU
        3WRLTOw/nPlX4VD7qvs2yB8ewQpHWFOJTILlVfTy6g==
X-Google-Smtp-Source: ABdhPJx95UKtrbv3RMWAwaHdwARhnz6c9CWvdsRsZhfDyk0HF1CL0Rx8irqQzcSP9Qi0gnaJ8BTByLuHRW09qLnJd7M=
X-Received: by 2002:a2e:2242:: with SMTP id i63mr4467220lji.343.1610690563696;
 Thu, 14 Jan 2021 22:02:43 -0800 (PST)
MIME-Version: 1.0
References: <1604419306-26105-1-git-send-email-sumit.garg@linaro.org>
 <1604419306-26105-3-git-send-email-sumit.garg@linaro.org> <X/x+N0fgrzIZTeNi@kernel.org>
 <CAFA6WYOUvWAZtYfR4q8beZFkX-CtdxqwJaRQM+GHNMDfQiEWOA@mail.gmail.com> <X/+m6+m2/snYj9Vc@kernel.org>
In-Reply-To: <X/+m6+m2/snYj9Vc@kernel.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 15 Jan 2021 11:32:31 +0530
Message-ID: <CAFA6WYNyirit_AFhoE+XR9PHw=OjRgEdXDqz1uanj_SN2NXeMw@mail.gmail.com>
Subject: Re: [PATCH v8 2/4] KEYS: trusted: Introduce TEE based Trusted Keys
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <jejb@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Janne Karhunen <janne.karhunen@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Markus Wamser <Markus.Wamser@mixed-mode.de>,
        Luke Hinds <lhinds@redhat.com>,
        "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        op-tee@lists.trustedfirmware.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, 14 Jan 2021 at 07:35, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> On Wed, Jan 13, 2021 at 04:47:00PM +0530, Sumit Garg wrote:
> > Hi Jarkko,
> >
> > On Mon, 11 Jan 2021 at 22:05, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > >
> > > On Tue, Nov 03, 2020 at 09:31:44PM +0530, Sumit Garg wrote:
> > > > Add support for TEE based trusted keys where TEE provides the functionality
> > > > to seal and unseal trusted keys using hardware unique key.
> > > >
> > > > Refer to Documentation/tee.txt for detailed information about TEE.
> > > >
> > > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > >
> > > I haven't yet got QEMU environment working with aarch64, this produces
> > > just a blank screen:
> > >
> > > ./output/host/usr/bin/qemu-system-aarch64 -M virt -cpu cortex-a53 -smp 1 -kernel output/images/Image -initrd output/images/rootfs.cpio -serial stdio
> > >
> > > My BuildRoot fork for TPM and keyring testing is located over here:
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/buildroot-tpmdd.git/
> > >
> > > The "ARM version" is at this point in aarch64 branch. Over time I will
> > > define tpmdd-x86_64 and tpmdd-aarch64 boards and everything will be then
> > > in the master branch.
> > >
> > > To create identical images you just need to
> > >
> > > $ make tpmdd_defconfig && make
> > >
> > > Can you check if you see anything obviously wrong? I'm eager to test this
> > > patch set, and in bigger picture I really need to have ready to run
> > > aarch64 environment available.
> >
> > I would rather suggest you to follow steps listed here [1] as to test
> > this feature on Qemu aarch64 we need to build firmwares such as TF-A,
> > OP-TEE, UEFI etc. which are all integrated into OP-TEE Qemu build
> > system [2]. And then it would be easier to migrate them to your
> > buildroot environment as well.
> >
> > [1] https://lists.trustedfirmware.org/pipermail/op-tee/2020-May/000027.html
> > [2] https://optee.readthedocs.io/en/latest/building/devices/qemu.html#qemu-v8
> >
> > -Sumit
>
> Can you provide 'keyctl_change'? Otherwise, the steps are easy to follow.
>

$ cat keyctl_change
diff --git a/common.mk b/common.mk
index aeb7b41..663e528 100644
--- a/common.mk
+++ b/common.mk
@@ -229,6 +229,7 @@ BR2_PACKAGE_OPTEE_TEST_SDK ?= $(OPTEE_OS_TA_DEV_KIT_DIR)
 BR2_PACKAGE_OPTEE_TEST_SITE ?= $(OPTEE_TEST_PATH)
 BR2_PACKAGE_STRACE ?= y
 BR2_TARGET_GENERIC_GETTY_PORT ?= $(if
$(CFG_NW_CONSOLE_UART),ttyAMA$(CFG_NW_CONSOLE_UART),ttyAMA0)
+BR2_PACKAGE_KEYUTILS := y

 # All BR2_* variables from the makefile or the environment are appended to
 # ../out-br/extra.conf. All values are quoted "..." except y and n.
diff --git a/kconfigs/qemu.conf b/kconfigs/qemu.conf
index 368c18a..832ab74 100644
--- a/kconfigs/qemu.conf
+++ b/kconfigs/qemu.conf
@@ -20,3 +20,5 @@ CONFIG_9P_FS=y
 CONFIG_9P_FS_POSIX_ACL=y
 CONFIG_HW_RANDOM=y
 CONFIG_HW_RANDOM_VIRTIO=y
+CONFIG_TRUSTED_KEYS=y
+CONFIG_ENCRYPTED_KEYS=y

> After I've successfully tested 2/4, I'd suggest that you roll out one more
> version and CC the documentation patch to Elaine and Mini, and clearly
> remark in the commit message that TEE is a standard, with a link to the
> specification.
>

Sure, I will roll out the next version after your testing.

-Sumit

> /Jarkko
