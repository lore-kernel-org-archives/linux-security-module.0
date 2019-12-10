Return-Path: <SRS0=PCLm=2A=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD09C2D0BF
	for <linux-security-module@archiver.kernel.org>; Tue, 10 Dec 2019 11:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1A5A20726
	for <linux-security-module@archiver.kernel.org>; Tue, 10 Dec 2019 11:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PXjKkgMX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbfLJL1t (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 10 Dec 2019 06:27:49 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54706 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727199AbfLJL1t (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 10 Dec 2019 06:27:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575977267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bOFmsAtNbW8RFKiaUWBj7E1wR8cw0Z5ta8Z04trWaPw=;
        b=PXjKkgMX3jYCeIPg7CvNbgQcfKlCzSa6KQ3TXAnyXFRbfULZpZU0zE6ChXj5cbpGlC/uvE
        HXWAg6IGeIFxo6SaGIGbN0pyyiC0eCzagU+cepVrf5S7HHY1yEvplrrMxvOxSUsFDFN/Pv
        4bq8OIZ2BEkoWlkxE5uKRVAO4mmqycQ=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-EQuJAairM4CsRZzcCb6jzQ-1; Tue, 10 Dec 2019 06:27:46 -0500
Received: by mail-oi1-f200.google.com with SMTP id u125so6081573oia.20
        for <linux-security-module@vger.kernel.org>; Tue, 10 Dec 2019 03:27:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bOFmsAtNbW8RFKiaUWBj7E1wR8cw0Z5ta8Z04trWaPw=;
        b=dTdL/3KdQ4gPfOuCijTSPXDad9Te5jFoI7RSJF4XA3dHPlj0VWuz7d9ML3keu/xwjL
         +MXRz9laaS/SECg6X4vIOqpOjR+VweNGZ4DQzViTYj6Cgn9OLAvjxPxAjHnbyIFZ/qRd
         3pvBLgjCOaaROpDI0Q8/BoyHhI3CsmSavPiwJ/aPFIE+Ph1Tc8WSYbnzMjkiCf30oaZJ
         2hUQh74nj1j+crX1W2iD8h2ayuSLxEziZT9vzqd7y+oCTzvLTOQeASxCq0OhqUzdaRlD
         +g3hy+G38TZo9A83yqL2gCnUagodX2yK5BKtevijrDieMMHHTm/ENEUz4kUcPdpLAjqj
         EJ1A==
X-Gm-Message-State: APjAAAVM8hjm7gap9w6um+EPYaNXY4sk5YSjQqEJhXs+x4FKPK2f56fN
        ZPAwmnvONEzcd3plzim1IY/gkP5d8WRswFd664idyEOB2i9ZCXJcJiSGtsI+fEhPDCrOV7KfnXZ
        ar40t+BhpC/0oBLVE0bG5ZlpAdaiIMKmItWLukkaqJn+2U+iemRaX
X-Received: by 2002:a9d:338:: with SMTP id 53mr15586615otv.197.1575977265343;
        Tue, 10 Dec 2019 03:27:45 -0800 (PST)
X-Google-Smtp-Source: APXvYqxoDNawE1RIKWv2izZYOAI/uCL0+cRnKFQ76pSJpz1S/34x+nbOWHlmWHvZ46sRQuTiYSTwxrUg3G5EtMrNof8=
X-Received: by 2002:a9d:338:: with SMTP id 53mr15586596otv.197.1575977265026;
 Tue, 10 Dec 2019 03:27:45 -0800 (PST)
MIME-Version: 1.0
References: <20191209075756.123157-1-omosnace@redhat.com> <23671223-f841-564c-6ae8-0401bce0fa20@tycho.nsa.gov>
 <ecfd3846-b38f-4b85-4568-d64625c490ac@tycho.nsa.gov> <2fadcd3d-96d2-82bf-f221-a7961853be50@schaufler-ca.com>
In-Reply-To: <2fadcd3d-96d2-82bf-f221-a7961853be50@schaufler-ca.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 10 Dec 2019 12:27:34 +0100
Message-ID: <CAFqZXNsZTRveUYBdsXC2iM2MU+nWPz0xL9eLRFwFYMnti-Ww-g@mail.gmail.com>
Subject: Re: [PATCH] selinux: reorder hooks to make runtime disable less broken
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        LSM <linux-security-module@vger.kernel.org>
X-MC-Unique: EQuJAairM4CsRZzcCb6jzQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Dec 9, 2019 at 6:20 PM Casey Schaufler <casey@schaufler-ca.com> wro=
te:
> On 12/9/2019 5:58 AM, Stephen Smalley wrote:
> > On 12/9/19 8:21 AM, Stephen Smalley wrote:
> >> On 12/9/19 2:57 AM, Ondrej Mosnacek wrote:
> >>> Commit b1d9e6b0646d ("LSM: Switch to lists of hooks") switched the LS=
M
> >>> infrastructure to use per-hook lists, which meant that removing the
> >>> hooks for a given module was no longer atomic. Even though the commit
> >>> clearly documents that modules implementing runtime revmoval of hooks
> >>> (only SELinux attempts this madness) need to take special precautions=
 to
> >>> avoid race conditions, SELinux has never addressed this.
> >>>
> >>> By inserting an artificial delay between the loop iterations of
> >>> security_delete_hooks() (I used 100 ms), booting to a state where
> >>> SELinux is enabled, but policy is not yet loaded, and running these
> >>> commands:
> >>>
> >>>      while true; do ping -c 1 <some IP>; done &
> >>>      echo -n 1 >/sys/fs/selinux/disable
> >>>      kill %1
> >>>      wait
> >>>
> >>> ...I was able to trigger NULL pointer dereferences in various places.=
 I
> >>> also have a report of someone getting panics on a stock RHEL-8 kernel
> >>> after setting SELINUX=3Ddisabled in /etc/selinux/config and rebooting
> >>> (without adding "selinux=3D0" to kernel command-line).
> >>>
> >>> Reordering the SELinux hooks such that those that allocate structures
> >>> are removed last seems to prevent these panics. It is very much possi=
ble
> >>> that this doesn't make the runtime disable completely race-free, but =
at
> >>> least it makes the operation much less fragile.
> >>>
> >>> An alternative (and safer) solution would be to add NULL checks to ea=
ch
> >>> hook, but doing this just to support the runtime disable hack doesn't
> >>> seem to be worth the effort...
> >>
> >> Personally, I would prefer to just get rid of runtime disable altogeth=
er; it also precludes making the hooks read-only after initialization.  IMH=
O, selinux=3D0 is the proper way to disable SELinux if necessary.  I believ=
e there is an open bugzilla on Fedora related to this issue, since runtime =
disable was originally introduced for Fedora.
> >
> > Also, if we have to retain this support, it seems like this ought to be=
 fixed in the LSM framework especially since it was a change there that bro=
ke the SELinux implementation.
>
> Agreed, mostly. Deleting an LSM is fundamentally something the infrastruc=
ture
> should handle *if* we allow it. Should we decide at some point to allow l=
oadable
> modules, as Tetsuo has advocated from time to time, we would need a gener=
al
> solution. We don't have a general solution now because only SELinux wants=
 it.
> The previous implementation was under #ifdef for SELinux. At the time I u=
nderstood
> that there was no interest in investing in it. The implementation passed =
tests
> at the time.
>
> I propose that until such time as someone decides to seriously investigat=
e
> loadable security modules* the sole user of the deletion mechanism is
> welcome to invest whatever they like in their special case, and I will be
> happy to lend whatever assistance I can.

On my way to lunch I came up with another relatively simple solution
that should address this problem at the infrastructure level. Let me
try to write it up into a patch, hopefully it will work...

>
> ---
> * I do not plan to propose an implementation of loadable modules.
>   I leave that as an exercise for the next generation.
>
>

--=20
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

