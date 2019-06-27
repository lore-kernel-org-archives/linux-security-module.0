Return-Path: <SRS0=lnE7=U2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15530C48BD7
	for <linux-security-module@archiver.kernel.org>; Thu, 27 Jun 2019 15:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE5C220B7C
	for <linux-security-module@archiver.kernel.org>; Thu, 27 Jun 2019 15:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gekKU/tG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfF0P2V (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 27 Jun 2019 11:28:21 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34566 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbfF0P2V (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 27 Jun 2019 11:28:21 -0400
Received: by mail-io1-f66.google.com with SMTP id k8so5689092iot.1
        for <linux-security-module@vger.kernel.org>; Thu, 27 Jun 2019 08:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g3RhI9DNvqsR2Iknx3LGGvk1u88PumHwEAJh9YfsKq4=;
        b=gekKU/tGlO7Mg0UGCOLXXY+Ire65Q4Z2qg5wd1h/tWU9dzP0OjY9RAukwLeQIBSiqO
         lOzOnp3OUJGMVLjCBBaxpYTOR7n0lu7pDCECDHHB+ew+MrRhPUsJ0/NzKMwdsdcqH0Ov
         7lUBWw8BNh134qpS92lj0nucRNsTHYxeobnt31H/hqDGy9ghty4FICuN8yjUcc9NWF/6
         905EiAC6mqg4SnIM0fMAjsXUMLsqln3Od29lkC8l+/yuWFoRGhklNh7wu6HdgobanftQ
         uCGE/qdCkvuTW0BOqRXIuGm5aMHPy5aZt2n/GNm5dIfAcnbAFzKIOR34tkMtJDQm0I8O
         xIiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g3RhI9DNvqsR2Iknx3LGGvk1u88PumHwEAJh9YfsKq4=;
        b=DHQmL3PIxcNSv8llxaorEOfr+q9trVklUN4kz7P68UpkUDV3Db2YSaiqW5dbRMDdN4
         8pZxBg3BEL2v6EBBomIiz+xEHR+7D9cm+wzPkN1vUjT1FHhclwkSDeXV+ePED9Z1G8Wu
         jzcCn6yLVHo1xPE3euf1tZ6/FDRg/vyg8Sp3tEl/pt5l651Sb6GCRJmAFz7AYGFd5x8G
         8dyG9wakj+ttDXRAWW6uOgBNBirGtYnazKx25oIgEJ2DwUKUPlIeZ2ccTlNA/y1GgGbw
         FxAOh0tDbOR7oSMfNBfBRiSfyqzJbRlJzi23AsDKHXIbDoo644BdJ24LDjeL9ml/YTs0
         ex/w==
X-Gm-Message-State: APjAAAURQT0X3GK2jdEbJ7Yg2zStnvHHKnMqOmEgVIZ4/6NvZ7VMV+j/
        GtZVnSPhf6AP3WXCuJCCT439hWBsi700ruHIi2ffakGiPPk=
X-Google-Smtp-Source: APXvYqxt+k0Ai9dyDn8LZuqnNMawxVvBOa3fPtlRblTKZbcATMFln2wqMn2SYedj7jJBGVi/ao2H/uL/Z68ruv8rRdU=
X-Received: by 2002:a5d:9d97:: with SMTP id 23mr5395263ion.204.1561649300148;
 Thu, 27 Jun 2019 08:28:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190622000358.19895-1-matthewgarrett@google.com>
 <20190622000358.19895-10-matthewgarrett@google.com> <alpine.LRH.2.21.1906271423070.16512@namei.org>
In-Reply-To: <alpine.LRH.2.21.1906271423070.16512@namei.org>
From:   Matthew Garrett <mjg59@google.com>
Date:   Thu, 27 Jun 2019 08:28:08 -0700
Message-ID: <CACdnJusJeCYPKVFHiu6yn+mfqQe5k0RqZhbCUZEkxtXx_shMmw@mail.gmail.com>
Subject: Re: [PATCH V34 09/29] kexec_file: Restrict at runtime if the kernel
 is locked down
To:     James Morris <jmorris@namei.org>
Cc:     LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Jiri Bohac <jbohac@suse.cz>,
        David Howells <dhowells@redhat.com>, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Jun 26, 2019 at 9:59 PM James Morris <jmorris@namei.org> wrote:
> This is not a criticism of the patch but a related issue which I haven't
> seen discussed (apologies if it has).
>
> If signed code is loaded into ring 0, verified by the kernel, then
> executed, you still lose your secure/trusted/verified boot state. If the
> currently running kernel has been runtime-compromised, any signature
> verification performed by the kernel cannot be trusted.
>
> This problem is out of scope for the lockdown threat model (which
> naturally cannot include a compromised kernel), but folk should be aware
> that signature-verified kexec does not provide equivalent assurance to a
> full reboot on a secure-boot system.

By that metric, on a secure boot system how do we determine that code
running in the firmware environment wasn't compromised before it
launched the initial signed kernel?
