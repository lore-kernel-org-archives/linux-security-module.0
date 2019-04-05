Return-Path: <SRS0=2koH=SH=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E8AC4360F
	for <linux-security-module@archiver.kernel.org>; Fri,  5 Apr 2019 13:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0934C2184B
	for <linux-security-module@archiver.kernel.org>; Fri,  5 Apr 2019 13:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554472454;
	bh=rOVanrb9Muwv6AuI+K5tqQY+dLtvA2hY7Xel2iIEh1U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=2WLsZPSH2xsk0GsTVi65FQW4wlePyPoEAO9noazBxdE+eODvqMPK1bDNw4Wzv3/9n
	 0rkXD3qq8G1vqYlJlB4tqJeHwJYQ1PumvmIBu4RVQ3b8n06sX97UASFqZFfkLzsZEl
	 FYo9r3Bff73F5ZvboPSkeXnQE9nWYaogtxAwM2IY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730283AbfDENyN (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 5 Apr 2019 09:54:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:42430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbfDENyN (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 5 Apr 2019 09:54:13 -0400
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D72502186A
        for <linux-security-module@vger.kernel.org>; Fri,  5 Apr 2019 13:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554472452;
        bh=rOVanrb9Muwv6AuI+K5tqQY+dLtvA2hY7Xel2iIEh1U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=e9I24nN5oUIsVrtlym6aLUZp85x3Ffon0SS+EAJn+vHdHuX+fanbim5a3gw3amk13
         ZiyOS2nzc+WZ/w6U1Z2R9HN0HdX4QGQ9OGoZHkLv6fycjwaGqmGSrDE+idYrN1jZT6
         J13Fv0nE9CO9DIlVdpnugEEV5XkMMuR1XKFl/psU=
Received: by mail-wr1-f43.google.com with SMTP id s15so8077083wra.12
        for <linux-security-module@vger.kernel.org>; Fri, 05 Apr 2019 06:54:11 -0700 (PDT)
X-Gm-Message-State: APjAAAXz8y4z30IRXmHn1oq08ynKLs4UHmAyEroNy2l+qEsiY0fnTp8T
        PGp6Ga17NgvoF967ph+GtKortFkrb3zbs4VuTxiS2g==
X-Google-Smtp-Source: APXvYqyuQcwyUs8wVj8FyzfSITaHiBv7ubwx4o6Of/MfYUKemGRkVmjyAkzM0OphvXJ/ovBLvUvvmNdIBUeo42E4klQ=
X-Received: by 2002:adf:eb84:: with SMTP id t4mr2116241wrn.43.1554472448707;
 Fri, 05 Apr 2019 06:54:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190317211456.13927-1-jarkko.sakkinen@linux.intel.com>
 <20190317211456.13927-18-jarkko.sakkinen@linux.intel.com> <CALCETrXQ0x2TD5GnaHhmF6SExk0C8+L0AwfnH-Krqwttfvwz2A@mail.gmail.com>
 <20190322112938.GJ3122@linux.intel.com> <20190322114325.GA10165@linux.intel.com>
 <CALCETrW=Fr8EdVq+5FLbmdL__i82FC0ONHd=hBXjxpLcsv9M0Q@mail.gmail.com>
 <20190325145503.GB29989@linux.intel.com> <20190405101817.GA9816@linux.intel.com>
In-Reply-To: <20190405101817.GA9816@linux.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 5 Apr 2019 06:53:57 -0700
X-Gmail-Original-Message-ID: <CALCETrWEhcx+Uak+Rmh5F4DvY6=G3nYcMhsN3o1XvdxrGNtsqA@mail.gmail.com>
Message-ID: <CALCETrWEhcx+Uak+Rmh5F4DvY6=G3nYcMhsN3o1XvdxrGNtsqA@mail.gmail.com>
Subject: Re: [PATCH v19 17/27] x86/sgx: Add provisioning
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>
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

On Fri, Apr 5, 2019 at 3:18 AM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Mon, Mar 25, 2019 at 04:55:03PM +0200, Jarkko Sakkinen wrote:
> > > > Hmm.. on 2nd thought the LSM policy or even DAC policy  would restrict
> > > > that the container manager can only access specific files inside
> > > > securityfs. With this conclusion I still think it is probably the best
> > > > place for seurity policy like things even for SGX. It is meant for that
> > > > anyway.
> > > >
> > >
> > > LSM or DAC policy can certainly *restrict* it, but I suspect that most
> > > container runtimes don't mount securityfs at all.  OTOH, the runtime
> > > definitely needs to have a way to pass /dev/sgx/enclave (or whatever
> > > it's called) through, so using another device node will definitely
> > > work.
> >
> > OK, I can cope with this argument. I go with the device names above for
> > v20.
>
> In v20 the refactoring would be with corresponding modes:
>
> /dev/sgx 0755
> /dev/sgx/enclave 0666
> /dev/sgx/provision 0600
>
> The problem that I'm facing is that with devnode callback of struct
> device_type I can easily give the defaut mode for any of the files but
> not for the /dev/sgx directory itself. How do I get the appropriate
> mode for it?
>

Hi Greg-

Do you know this one?
