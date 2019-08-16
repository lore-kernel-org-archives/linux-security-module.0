Return-Path: <SRS0=Rr8+=WM=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89735C3A59E
	for <linux-security-module@archiver.kernel.org>; Fri, 16 Aug 2019 16:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6157D2171F
	for <linux-security-module@archiver.kernel.org>; Fri, 16 Aug 2019 16:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="H5BhUsEH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfHPQg1 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 16 Aug 2019 12:36:27 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34577 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbfHPQg1 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 16 Aug 2019 12:36:27 -0400
Received: by mail-lf1-f66.google.com with SMTP id b29so4480753lfq.1
        for <linux-security-module@vger.kernel.org>; Fri, 16 Aug 2019 09:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5lHpPSdCyT7Kyd9IXcFuqji9CoKFwycWngQ6LfdZfg0=;
        b=H5BhUsEHdQ5FzU5Gk3d5ZM8xImwWXVoWJAWrdM3kLZsOeJoUZ3avKESAh1tSeDZ6Ea
         hVTCFxGqXCkimDn7bP6MI3lVwNGcCDuB/i2EoTFkLFImYFh2pLggPXya/lJAbgxTYXXK
         J+qeWHgEB4zdRQtaHTstos5ShRNZY3RSuKs+rajrXYDjswCt179GXtFpHvriHjbNkpOm
         5rLot+GwHZvcR7cSBNSaOFe73ujrtrfrczpr7b24A0jQYXFechzoNzamh/kRq+4MtIk5
         5N3sYJi9TrrpnqevluuW3pQzGMuLqeZQcnwKjhPSXQlE/pM7kSShuu9j8krYJfDsnjgm
         yoiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5lHpPSdCyT7Kyd9IXcFuqji9CoKFwycWngQ6LfdZfg0=;
        b=BtICW3kFrm+TWZjgD7WjmXqdFlOdrbWCw5/LdCMAwd+EfmiDESVEOOP+iVcZ77Bem6
         W/n0OFAeV5ZdSd+I146hwAbt1DOD2nwvmRd0RgXzaEjRuxui4VCVcTJqMcf2ynHpyfTV
         K1OPxPqqELCAlRJDVhVYA2mL78Jt1zXIvk0xXlpinWe2rnGbrjDy95X7tZlA4Hz+Pc9i
         sAxgSMNC9Iw8dG9eBXd684ZcrS1k0V+v8s+5eWK0XpPBlww9jte//jFHRXkodn3wOmP+
         Qllo7YIbdI64MR0jQGh05A+ZWdGB9QczYgosTEDenQwXkYNnq9u7PcMMJbeHUqIk4o6Y
         3EPg==
X-Gm-Message-State: APjAAAVLMbxcDnmGuxAtU/gwDfg1d97m0/y+oVpQiRSBP7RAVz0d7d4n
        Wr6Ktewt6CYntYR/OVLd4e+seAcb/ULW6JNFHBy9
X-Google-Smtp-Source: APXvYqzYbBGmvFQFm936ktOk3rwIm65aWylGP4lmnHHLscikOOcm/+ByQtnYFkBaH0Iqli70i/v+iW3RlhqE02ViCts=
X-Received: by 2002:ac2:5225:: with SMTP id i5mr4589867lfl.13.1565973385355;
 Fri, 16 Aug 2019 09:36:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190815202357.4238-1-acgoide@tycho.nsa.gov> <alpine.LRH.2.21.1908160817300.22623@namei.org>
 <cebacde0-5c53-c414-8f27-8d81ed928dfd@tycho.nsa.gov>
In-Reply-To: <cebacde0-5c53-c414-8f27-8d81ed928dfd@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 16 Aug 2019 12:36:13 -0400
Message-ID: <CAHC9VhRLnUO_iiz31z=7wiHf2sNihC7mmi3FhaPCqmW=xt+tRw@mail.gmail.com>
Subject: Re: [RFC PATCH v3] security, capability: pass object information to security_capable
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     James Morris <jmorris@namei.org>,
        Aaron Goidel <acgoide@tycho.nsa.gov>, rgb@redhat.com,
        mortonm@chromium.org, john.johansen@canonical.com,
        selinux@vger.kernel.org, luto@amacapital.net,
        linux-security-module@vger.kernel.org, linux-audit@redhat.com,
        nhfran2@tycho.nsa.gov, Serge Hallyn <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Aug 16, 2019 at 10:57 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 8/15/19 6:32 PM, James Morris wrote:
> > On Thu, 15 Aug 2019, Aaron Goidel wrote:
> >
> >> In SELinux this new information is leveraged here to perform an
> >> additional inode based check for capabilities relevant to inodes. Since
> >> the inode provided to capable_wrt_inode_uidgid() is a const argument,
> >> this also required propagating const down to dump_common_audit_data() and
> >> dropping the use of d_find_alias() to find an alias for the inode. This
> >> was sketchy to begin with and should be obsoleted by a separate change
> >> that will allow LSMs to trigger audit collection for all file-related
> >> information.
> >
> > Will the audit logs look the same once the 2nd patch is applied? We need
> > to be careful about breaking existing userland.
>
> It was already the case that the name= field in the AVC audit record was
> not guaranteed to be emitted in this case, since d_find_alias could
> return NULL.  And it was only a hint, since that name might have nothing
> to do with the name used to look up the inode in the first place. So I
> don't believe userland could have ever relied upon it being present
> here.  Removing it also fixes a problem with AVC audit generation under
> RCU walk; we should be able to drop the code that skips audit generation
> in that case with this d_find_alias call gone IIUC.
>
> With the ability for an LSM to enable collection and generation of
> AUDIT_PATH and other AUDIT_* records (which is made possible via the
> other patch), we will get more complete and relevant information in the
> audit log.  It won't look exactly the same (there will be separate AVC,
> PATH, ... records that can be correlated based on timestamp/serial and
> ausearch does this automatically for you).

Regardless of if it is The Right Thing, changes like this should
probably be put into a separate, unrelated patch.

I think there are a few things in dump_common_audit_data() that should
have been done differently, but unfortunately the audit records (and
IMHO the many stupid design decisions that went into them) are
effectively part of the kernel API and need to be treated with care.

-- 
paul moore
www.paul-moore.com
