Return-Path: <SRS0=szIC=CC=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E1FC433E3
	for <linux-security-module@archiver.kernel.org>; Mon, 24 Aug 2020 20:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8261220656
	for <linux-security-module@archiver.kernel.org>; Mon, 24 Aug 2020 20:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aW1gbBVc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgHXUBf (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 24 Aug 2020 16:01:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24709 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725921AbgHXUBd (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 24 Aug 2020 16:01:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598299291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uscrMvCrVpuzBs8CCqTlviFEzNB9Ka9n9LSLMNlONOY=;
        b=aW1gbBVcqVCzvpcGarXB2wzf8AKhuqvkFcHVXgh1TlkEXhVWUCt4jBa8izb0etDlQBm5Qw
        CS5v+tzjnzDszkdSwLTtn5c3pbrWAYgBtMHg4pptJanvmdiXgagJIAyImT0QJ7EM8pGcwI
        Ti3eWQNT4gIQmPw9ezRLOl7lOuLWRjE=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-D8VQ60bMNfq_iOyMCQZbYg-1; Mon, 24 Aug 2020 16:01:29 -0400
X-MC-Unique: D8VQ60bMNfq_iOyMCQZbYg-1
Received: by mail-lj1-f198.google.com with SMTP id r11so3109524ljn.22
        for <linux-security-module@vger.kernel.org>; Mon, 24 Aug 2020 13:01:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uscrMvCrVpuzBs8CCqTlviFEzNB9Ka9n9LSLMNlONOY=;
        b=iQxoRauzAX+T9EaRYqf9J2Q38X9DZm2EkHKzry7ORMVrheY9STfgfN8kYfcvTGtM8I
         V8KcKLpn54F1VV8xGn191LAoCxsenJPteI6/vXPS0AHipSQDAPW1SXSNhx7Pu7aldbT5
         O3bVWjOTtHTXSKr/xF3Fai+P46XANoUW+BVW47by3R5pwGO3/T/dpeJglf5js20oUBIe
         7gW7aIdnPb05mMC2epFMvAPitiz73leVFZUFPXdSSfTci0E5nS5fVU67DvmBfA9Z9h1i
         wGVRmnCmuVjE9oGMXUgDff7Zld9s8MaDMsmyl7X+QLVgBVEETdDjInLAHOHeW91fulWt
         SC/w==
X-Gm-Message-State: AOAM530q6Dyb9D38lxQ6A3BzATsIbFKOP59UoFTo8TpYWKiCwTvfkR3j
        di4yElaPqaduuAL2sYVSaiJIfXAcAS0zmDQhy3/7r0Pi5nD7F1PfpOLRV39AiqsvxNNJicoXVPF
        cbOJKd/exCXCXz+eK2Gv00spsBfrKJzjq2lqw+usRXQiS22t/+/o5
X-Received: by 2002:a2e:7010:: with SMTP id l16mr3180387ljc.38.1598299288320;
        Mon, 24 Aug 2020 13:01:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzlH+auARhq7SWPbHEI59342ZMN+shTt3ocQ8lwjHmShhNGjby6clQhLnKc2Mg8F5+NM25k106HjhZgrKaoXJ0=
X-Received: by 2002:a2e:7010:: with SMTP id l16mr3180369ljc.38.1598299288036;
 Mon, 24 Aug 2020 13:01:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200822010018.19453-1-nramas@linux.microsoft.com>
 <CAEjxPJ5Kok-TBfS=XQ+NUC5tuaZRkyLBOawG4UDky51_bsMnGw@mail.gmail.com>
 <418618c4-a0c6-6b28-6718-2726a29b83c5@linux.microsoft.com> <CAEjxPJ6-8WnZRJnADsn=RVakzJiESjEjK-f8nSkscpT7dnricQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ6-8WnZRJnADsn=RVakzJiESjEjK-f8nSkscpT7dnricQ@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 24 Aug 2020 22:01:17 +0200
Message-ID: <CAFqZXNvVQ5U6Ea3gT32Z0hfWbu7GPR-mTF2z6-JZZJT57Heuuw@mail.gmail.com>
Subject: Re: [PATCH] SELinux: Measure state and hash of policy using IMA
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        tusharsu@linux.microsoft.com, Sasha Levin <sashal@kernel.org>,
        James Morris <jmorris@namei.org>,
        linux-integrity@vger.kernel.org,
        SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=omosnace@redhat.com
X-Mimecast-Spam-Score: 0.004
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Aug 24, 2020 at 9:30 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Mon, Aug 24, 2020 at 2:13 PM Lakshmi Ramasubramanian
> <nramas@linux.microsoft.com> wrote:
> >
> > On 8/24/20 7:00 AM, Stephen Smalley wrote:
> >
> > >> +int security_read_policy_kernel(struct selinux_state *state,
> > >> +                               void **data, size_t *len)
> > >> +{
> > >> +       int rc;
> > >> +
> > >> +       rc = security_read_policy_len(state, len);
> > >> +       if (rc)
> > >> +               return rc;
> > >> +
> > >> +       *data = vmalloc(*len);
> > >> +       if (!*data)
> > >> +               return -ENOMEM;
> > >>
> > >> +       return security_read_selinux_policy(state, data, len);
> > >>   }
> > >
> > > See the discussion here:
> > > https://lore.kernel.org/selinux/20200824113015.1375857-1-omosnace@redhat.com/T/#t
> > >
> > > In order for this to be safe, you need to ensure that all callers of
> > > security_read_policy_kernel() have taken fsi->mutex in selinuxfs and
> > > any use of security_read_policy_len() occurs while holding the mutex.
> > > Otherwise, the length can change between security_read_policy_len()
> > > and security_read_selinux_policy() if policy is reloaded.
> > >
> >
> > "struct selinux_fs_info" is available when calling
> > security_read_policy_kernel() - currently in measure.c.
> > Only "struct selinux_state" is.
> >
> > Is Ondrej's re-try approach I need to use to workaround policy reload issue?
>
> No, I think perhaps we should move the mutex to selinux_state instead
> of selinux_fs_info.  selinux_fs_info has a pointer to selinux_state so
> it can then use it indirectly.  Note that your patches are going to
> conflict with other ongoing work in the selinux next branch that is
> refactoring policy load and converting the policy rwlock to RCU.

Yeah, and I'm experimenting with a patch on top of Stephen's RCU work
that would allow you to do this in a straightforward way without even
messing with the fsi->mutex. My patch may or may not be eventually
committed, but either way I'd recommend holding off on this for a
while until the dust settles around the RCU conversion.

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

