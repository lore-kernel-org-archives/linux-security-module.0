Return-Path: <SRS0=wBbN=CR=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7FFBC433E2
	for <linux-security-module@archiver.kernel.org>; Tue,  8 Sep 2020 14:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80966229EF
	for <linux-security-module@archiver.kernel.org>; Tue,  8 Sep 2020 14:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UVj/plKG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729851AbgIHOpi (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 8 Sep 2020 10:45:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26361 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729876AbgIHO0K (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 8 Sep 2020 10:26:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599575163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ye2KsuXoN2NlEMK5q8mCuzDzXGcGuNydsz7J1oYHs44=;
        b=UVj/plKG6DRifmHMZTlUgfPoWrlDhO5hOcL37nFebFZBjBM2JajOpeMRZwFLK+9BMikk/E
        5xOawuMqdp4K0Kvxlk6KUe90Wou8YCbVFBJto0jBU9M58+ZkDLwBXaDZobqWA2E/hG1gpA
        gfUCoROtvep9rDbQpy5FpHT/R5xDupI=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-wjknBRVPOIKDwi3iE9BzAQ-1; Tue, 08 Sep 2020 09:03:15 -0400
X-MC-Unique: wjknBRVPOIKDwi3iE9BzAQ-1
Received: by mail-lf1-f72.google.com with SMTP id v128so969061lfa.5
        for <linux-security-module@vger.kernel.org>; Tue, 08 Sep 2020 06:03:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ye2KsuXoN2NlEMK5q8mCuzDzXGcGuNydsz7J1oYHs44=;
        b=V9zI50Hk6pOqH5ohEGQ8a2HbFfNVslnTbRCT/EUEj61Ebwo6OoOYlpp0Rwy9z7bZWz
         G9iJXjXchRTbLjiRXShXRPUxLP+8Nqxp1c2LOIWKIq944Sq7vFnIolVYj8Xd4QcUc3RG
         3rgQcFE0MZX2AugtbG7vAtUUqtp3raDwx+se/ibU9ybEHcuMraTnJM/XxFNzdT2tYImp
         659/ERz5JbqsEIZ7TCAIAWOszogMSuxQLMwUYC57yLyXNhsNSKqxJ1o1K8BDuITPNeEu
         wZg6HCghA2j2sMK31ydJ6AVw0bscbj9B1T5uUlGnUOMNdix7+lhMFEGvOot++6Jtdw2u
         DKTw==
X-Gm-Message-State: AOAM533KJHOpidziWj3MhlKHSNFe/mIzyeoJcB8Vw29env4FhDJTwC1a
        8xJEDxg9ZVgzIIFvGQm8dCu0Xk+cSR6T+TNt1To/9LPt+F3D6FGBEpwLMVcJzml0phmQJPIXrpk
        7oy4h7I+QQijt6x79ftULl8+Ub8UXKd0kMgxmzYRFC8w1s4fA068s
X-Received: by 2002:a05:651c:134a:: with SMTP id j10mr11002421ljb.337.1599570193914;
        Tue, 08 Sep 2020 06:03:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzp3OiZVrw0QoBLOoEdLIlQNVVb0O6eJMGa3bo/IK9ijWF8Ck46zu6UhG+8IzfVZdlckAAhTWm3SSIT9nd2q7U=
X-Received: by 2002:a05:651c:134a:: with SMTP id j10mr11002409ljb.337.1599570193556;
 Tue, 08 Sep 2020 06:03:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200907213855.3572-1-nramas@linux.microsoft.com> <CAEjxPJ4Swgi2Jewzja8MRiVdYn8H1-OkDy5BR7Vv4A4LaLWZ+Q@mail.gmail.com>
In-Reply-To: <CAEjxPJ4Swgi2Jewzja8MRiVdYn8H1-OkDy5BR7Vv4A4LaLWZ+Q@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 8 Sep 2020 15:03:02 +0200
Message-ID: <CAFqZXNtEywSumid=FHLysV8jaSPXDO--3YJC6DfuGwRRZLQ58g@mail.gmail.com>
Subject: Re: [PATCH] SELinux: Measure state and hash of policy using IMA
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Paul Moore <paul@paul-moore.com>,
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
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Sep 8, 2020 at 2:37 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Mon, Sep 7, 2020 at 5:39 PM Lakshmi Ramasubramanian
> <nramas@linux.microsoft.com> wrote:
<snip>
> > diff --git a/security/selinux/measure.c b/security/selinux/measure.c
> > new file mode 100644
> > index 000000000000..caf9107937d9
> > --- /dev/null
> > +++ b/security/selinux/measure.c
> <snip>
> > +static int read_selinux_state(char **state_str, int *state_str_len,
> > +                             struct selinux_state *state)
> > +{
> > +       char *buf, *str_fmt = "%s=%d;";
> > +       int i, buf_len, curr;
> <snip>
> > +       for (i = 0; i < __POLICYDB_CAPABILITY_MAX; i++) {
> > +               buf_len += snprintf(NULL, 0, str_fmt,
> > +                                   selinux_policycap_names[i],
> > +                                   state->policycap[i]);
> > +       }
>
> This will need to be converted to use
> security_policycap_supported(state, i) rather than state->policycap[i]
> since the latter is going to be removed by Ondrej's patches I think.

Based on my testing so far, even with just moving the array under
struct selinux_policy, the RCU accessing still brings a significant
overhead (relative to the whole syscalls it is probably negligible,
but relative to the rest of the simpler hooks it is about 30%), so I
don't think it is necessary to adapt other patches to it yet. It will
be my responsibility to adapt to the newly added code when/if I rebase
and respin my patch.

>
> > +       for (i = 0; i < __POLICYDB_CAPABILITY_MAX; i++) {
> > +               curr += snprintf((buf + curr), (buf_len - curr), str_fmt,
> > +                                selinux_policycap_names[i],
> > +                                state->policycap[i]);
>
> Ditto.
>

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

