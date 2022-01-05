Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15964C433F5
	for <linux-security-module@archiver.kernel.org>; Wed,  5 Jan 2022 11:43:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235465AbiAELng (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 5 Jan 2022 06:43:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:60236 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229622AbiAELnf (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 5 Jan 2022 06:43:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641383014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vZRqLCV1AQpi4/pbS4HKIi2vod3d/KjNFKlZbvvJOJw=;
        b=X9U2cg87dTsRuLmSQfs5zeMaKUKRrGFLJbae8habWycEyQcbOu6GgkPtYR9gKoRwue1tNO
        DoXfe9Vf0smS6/gTEDggm0YkIMRy9KnDiuqfTKoNp9qZP/K3cynn1YItdEowIljnHpQcI/
        Ljz6X3giB/M3RhCpB4J0tBspnjFNr58=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-367-NqDNCruhNq694xslHe42Qg-1; Wed, 05 Jan 2022 06:43:31 -0500
X-MC-Unique: NqDNCruhNq694xslHe42Qg-1
Received: by mail-wr1-f71.google.com with SMTP id s23-20020adf9797000000b001a24674f0f7so12498254wrb.9
        for <linux-security-module@vger.kernel.org>; Wed, 05 Jan 2022 03:43:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=vZRqLCV1AQpi4/pbS4HKIi2vod3d/KjNFKlZbvvJOJw=;
        b=lBiT61UlYk+pdsAItB2AYhpoKzwqBw49AzBJAdjml6dovgtLDJpnbbmlQ5GkumbM2H
         eCpd5kJ938LQZFmkI+7FouMdUKrv61wfZ3ROlppGkExOSbhlHJxj4wT9Sp7Bdu6FyEL5
         OyvmKvw5Wd1vhVLtId33CpAr9zzv2Wd6OSrv2QA1DkA0LJ4KG4HRPvOa34xGUv7PdNor
         G9OD+dxXOBRInMcDRQy4j+VvpCXAz2AO7g/X5ZXHIcTSR2ak1QtysxwfyuXKFw0vE8uM
         JkUS/IUre2Es6/FxrWkXweN35XpqJdVwC5lc7TAPmMTC3ZPZlIX6OG5LItWTtbsAEasy
         +nHA==
X-Gm-Message-State: AOAM530JZrucwDvWu4PNOSRZ1Q4Im+Go7U0y306ysEXRxDH+Qcwlg/ub
        xXs9kULe6VBTPawlx1I5m5lkSpbWC/GCZ47bULgSVhvodOE785eaSXVbHgfWrbTEGDgbAQsgl6x
        aIZQ0emsyenIBgdxt8dDgpuvRaz2hAIiOgO0V
X-Received: by 2002:a05:6000:10c4:: with SMTP id b4mr45047999wrx.514.1641383010396;
        Wed, 05 Jan 2022 03:43:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx0ND3sp1KAm9XvjE31Azjsac5utQcfs8uXXLrux4uumEKa2/x8xhMt+qfPbb1B2mJgzhIwuA==
X-Received: by 2002:a05:6000:10c4:: with SMTP id b4mr45047983wrx.514.1641383010177;
        Wed, 05 Jan 2022 03:43:30 -0800 (PST)
Received: from work-vm (cpc109025-salf6-2-0-cust480.10-2.cable.virginm.net. [82.30.61.225])
        by smtp.gmail.com with ESMTPSA id f8sm43265636wry.16.2022.01.05.03.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 03:43:29 -0800 (PST)
Date:   Wed, 5 Jan 2022 11:43:25 +0000
From:   "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To:     Borislav Petkov <bp@suse.de>
Cc:     Dov Murik <dovmurik@linux.ibm.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        linux-efi@vger.kernel.org, Ashish Kalra <ashish.kalra@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andi Kleen <ak@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Andrew Scull <ascull@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Jim Cadden <jcadden@ibm.com>,
        Daniele Buono <dbuono@linux.vnet.ibm.com>,
        linux-coco@lists.linux.dev, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/5] Allow guest access to EFI confidential computing
 secret area
Message-ID: <YdWEXRt7Ixm6/+Dq@work-vm>
References: <20211129114251.3741721-1-dovmurik@linux.ibm.com>
 <YdNHgtuVoLofL4cW@zn.tnic>
 <0280e20e-8459-dd35-0b7d-8dbc1e4a274a@linux.ibm.com>
 <YdSRWmqdNY7jRcer@zn.tnic>
MIME-Version: 1.0
In-Reply-To: <YdSRWmqdNY7jRcer@zn.tnic>
User-Agent: Mutt/2.1.3 (2021-09-10)
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

* Borislav Petkov (bp@suse.de) wrote:
> On Tue, Jan 04, 2022 at 09:02:03AM +0200, Dov Murik wrote:
> > If the Guest Owner chooses to inject secrets via scp, it needs
> > to be sure it is scp-ing to the correct VM - the one that has SEV
> > enabled and was measured at launch.
> 
> Hmm, I'd expect that to be part of the attestation dance. I admit,
> though, I have only listened about the whole attestation bla from the
> sidelines so I'm unclear whether that's part of that protocol. I guess
> Tom and Brijesh should have a better idea here.

There's more than one type of dance; this partially varies
depending on the system (SEV/TDX etc) and also depends on how you depend
to boot your VM (separate kernel or VM disk).   Also it's important to
note that when the dance happens varies - in SEV and SEV-ES this happens
before the guest executes any code.
So at the end of the dance, the guest owner hands over that secret - but
only then does the geust start booting; that secret has to go somewhere
to be used by something later.
For example, something might pull out that key and use it to decrypt a
disk that then has other secrets on it (e.g. your ssh key).

Dave

> > One way to achieve that would be to inject the guest's SSH private key
> 
> Well, is that "one way" or *the way*?
> 
> > using the proposed efi_secret mechanism.  This way the Guest Owner is
> > sure it is talking to the correct guest and not to some other VM that
> > was started by the untrusted cloud provider (say, with SEV disabled so
> > the cloud provider can steal its memory content).
> 
> Because we would need *some* way of verifying the owner is talking
> to the correct guest. And if so, this should be made part of the big
> picture of SEV guest attestation. Or is this part of that attestation
> dance?
> 
> I guess I'm wondering where in the big picture this fits into?
> 
> > Indeed this proposed efi_secret module is in use for enabling SEV
> > confidential containers using Kata containers [1], but there's nothing
> > specific in the current patch series about containers.  The patch series
> > just exposes the launch-injected SEV secrets to userspace as virtual files
> > (under securityfs).
> > 
> > [1] https://github.com/confidential-containers/attestation-agent/tree/main/src/kbc_modules/offline_sev_kbc
> 
> So one of the aspects for this is to use it in automated deployments.
> 
> > It boils down to: the confidential guest needs to have access to a
> > secret which the untrusted host can't read, and which is essential for
> > the normal operation of the guest.  This secret can be a decryption key,
> > an SSH private key, an API key to a Key Management system, etc.  If a
> > malicious cloud provider tries to start that VM without a secret (or
> > with the wrong one), the actual workload that the guest is supposed to
> > run will not execute meaningfully.
> > 
> > The proposed patch series exposes the SEV injected secrets as virtual
> > files, which can later be used as decryption keys (as done in the kata
> > confidential containers use-case), or SSH private keys, or any other
> > possible implementation.
> 
> Right, and is this going to be the proper way to authenticate SEV guests
> to their owners or is this just another technique for safely supplying
> secrets into the guest?
> 
> I hope I'm making some sense here...
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

