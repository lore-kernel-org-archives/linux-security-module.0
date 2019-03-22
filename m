Return-Path: <SRS0=snF/=RZ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C83C43381
	for <linux-security-module@archiver.kernel.org>; Fri, 22 Mar 2019 18:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44AFA218FE
	for <linux-security-module@archiver.kernel.org>; Fri, 22 Mar 2019 18:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553278847;
	bh=1kWctT+kE5evAeNibbLsh26YhCyp/R9wPRN6xPGJ6RQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=CR8Dtr+CCncU99LuUjYKI4zsDIA/UbpnHd+E/yBGtAhvqxD0XGv+uCy/znzyjMQCp
	 CYxMh0Dr7La5UUdulbbGDYAlPY5ePJzH84Soac59A1mpJsI6GtQ/P2Hzpye2j4sfVb
	 tP9ewSdsP+5WRm7Datei2YZ5/Ja+yWcw/fUjehNM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbfCVSUq (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 22 Mar 2019 14:20:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:55660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726056AbfCVSUq (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 22 Mar 2019 14:20:46 -0400
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0097A2192B
        for <linux-security-module@vger.kernel.org>; Fri, 22 Mar 2019 18:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553278845;
        bh=1kWctT+kE5evAeNibbLsh26YhCyp/R9wPRN6xPGJ6RQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AjSSoydS+GOAFfF6W0dmD6LM/02k1qG8MK+VbVU2A5NW8RsJtuuV3wd8em1I6dBw1
         G/FMOERsmw4+/T9uziIGbtsvX1jAeiibKK9Pad1P3jW78Ds9U0msFLC8fo52R26VYt
         tJz3aTno/tkbslX/3oCvXFlut92QpGPIUXMH9WVE=
Received: by mail-wm1-f42.google.com with SMTP id z11so3123627wmi.0
        for <linux-security-module@vger.kernel.org>; Fri, 22 Mar 2019 11:20:44 -0700 (PDT)
X-Gm-Message-State: APjAAAXJx0435xUZRe4nUljtBaR1qXs+qLW3DwZb4e6DxcUHC166RR44
        MBwZ//2w6yDX9h+NuJaPKLFHxqcS3+H2kBhMcKtUNQ==
X-Google-Smtp-Source: APXvYqy2I1uslvP3FiFGfyDUKj1iCdva2ck5rAWUz5OQB/IcpxoXuOmb1NCFUiPP6ho3FC3uGpp9/Zjux5Wvmv22uow=
X-Received: by 2002:a7b:c257:: with SMTP id b23mr3828467wmj.83.1553278841796;
 Fri, 22 Mar 2019 11:20:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190317211456.13927-1-jarkko.sakkinen@linux.intel.com>
 <20190317211456.13927-18-jarkko.sakkinen@linux.intel.com> <CALCETrXQ0x2TD5GnaHhmF6SExk0C8+L0AwfnH-Krqwttfvwz2A@mail.gmail.com>
 <20190322112938.GJ3122@linux.intel.com> <20190322114325.GA10165@linux.intel.com>
In-Reply-To: <20190322114325.GA10165@linux.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 22 Mar 2019 11:20:30 -0700
X-Gmail-Original-Message-ID: <CALCETrW=Fr8EdVq+5FLbmdL__i82FC0ONHd=hBXjxpLcsv9M0Q@mail.gmail.com>
Message-ID: <CALCETrW=Fr8EdVq+5FLbmdL__i82FC0ONHd=hBXjxpLcsv9M0Q@mail.gmail.com>
Subject: Re: [PATCH v19 17/27] x86/sgx: Add provisioning
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        linux-sgx@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        nhorman@redhat.com, npmccallum@redhat.com,
        "Ayoun, Serge" <serge.ayoun@intel.com>,
        "Katz-zamir, Shay" <shay.katz-zamir@intel.com>,
        "Huang, Haitao" <haitao.huang@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Svahn, Kai" <kai.svahn@intel.com>, Borislav Petkov <bp@alien8.de>,
        Josh Triplett <josh@joshtriplett.org>,
        "Huang, Kai" <kai.huang@intel.com>,
        David Rientjes <rientjes@google.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Mar 22, 2019 at 4:43 AM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Fri, Mar 22, 2019 at 01:29:38PM +0200, Jarkko Sakkinen wrote:
> > On Thu, Mar 21, 2019 at 09:50:41AM -0700, Andy Lutomirski wrote:
> > > On Sun, Mar 17, 2019 at 2:18 PM Jarkko Sakkinen
> > > <jarkko.sakkinen@linux.intel.com> wrote:
> > > >
> > > > In order to provide a mechanism for devilering provisoning rights:
> > > >
> > > > 1. Add a new file to the securityfs file called sgx/provision that works
> > > >    as a token for allowing an enclave to have the provisioning privileges.
> > > > 2. Add a new ioctl called SGX_IOC_ENCLAVE_SET_ATTRIBUTE that accepts the
> > > >    following data structure:
> > > >
> > > >    struct sgx_enclave_set_attribute {
> > > >            __u64 addr;
> > > >            __u64 token_fd;
> > > >    };
> > >
> > > Here's a potential issue:
> > >
> > > For container use, is it reasonable for a container manager to
> > > bind-mount a file into securityfs?  Or would something in /dev make
> > > this easier?
> >
> > I guess that is a valid point given that the securityfs contains the LSM
> > (e.g. SELinux or AppArmor) policy. So yeah, I think your are right what
> > you say.
> >
> > I propose that we create /dev/sgx/enclave to act as the enclave manager
> > and /dev/sgx/provision for provisioning. Is this sustainable for you?
>
> Hmm.. on 2nd thought the LSM policy or even DAC policy  would restrict
> that the container manager can only access specific files inside
> securityfs. With this conclusion I still think it is probably the best
> place for seurity policy like things even for SGX. It is meant for that
> anyway.
>

LSM or DAC policy can certainly *restrict* it, but I suspect that most
container runtimes don't mount securityfs at all.  OTOH, the runtime
definitely needs to have a way to pass /dev/sgx/enclave (or whatever
it's called) through, so using another device node will definitely
work.
