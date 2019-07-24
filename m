Return-Path: <SRS0=855y=VV=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2483BC7618F
	for <linux-security-module@archiver.kernel.org>; Wed, 24 Jul 2019 20:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E896120665
	for <linux-security-module@archiver.kernel.org>; Wed, 24 Jul 2019 20:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="nQoXBHll"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388229AbfGXUM7 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 24 Jul 2019 16:12:59 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44797 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391880AbfGXUM7 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 24 Jul 2019 16:12:59 -0400
Received: by mail-lj1-f195.google.com with SMTP id k18so45702561ljc.11
        for <linux-security-module@vger.kernel.org>; Wed, 24 Jul 2019 13:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kisMchQo2oHhdTIxcH9XSKD/zYBJKoYjmf6vSY0JLV4=;
        b=nQoXBHllVh1hkR16djdjN6mKO+up50XvaKD8vRl8eOO2nfmMBK3GIk6QXVYBXwxja4
         MRJr07+0qRitn1IJXNptOH60o5ugB7/H6bJkqf+0dgUzLDGTSKHOgSt+fwA7h0LrTavX
         T7Ws9yEfDKSp1cAU7cyAD50DWQmZzjRIZue5x5w/BMfRnbvNyDSadOF0imm02jHYWA/v
         xgJTEEW+5CKLJF/Jd3b0Pgb4rWUK9xzdIIAHvWfKlKOSqoxI5c5x7rLw9qn03MUpHadR
         32z5Sz6Hdk+QXsNBdQWT9Bsoe1b1Nz5ILT0qr76We4f7/fX08KvgaEV4W0NKmykPnQYw
         BZ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kisMchQo2oHhdTIxcH9XSKD/zYBJKoYjmf6vSY0JLV4=;
        b=W3BovlzCwXunmif4fmyjhpkZynJGpp+XllGqAmP4f0GSvKqiqJi/1DHRHX0EgYNPZx
         8TnCS6odWGpRBcUXg65PTxkytu2c8p4Dlxq8gQot/GaSur905t6682gKtmnXhx0DTBuU
         AwjSyicowUsHtpPTaNiLiNp2RMMiNv1u6uBa2zDviHzg61cYLYR18+3yPZpFKtLIac/m
         IasZQrYK3JM8QiNirCnUSSKt/Lwq5bpo0uSu2rHJVIZkw9EmfuOdWye2g8A8qF94J91G
         NWrFdpYwG4Fq4nNbzhNc5pvQ4Jz65A6c6Cu6w93710o0Z/IWkdVQpxx9c5Ys4h3j4DAf
         sRcg==
X-Gm-Message-State: APjAAAVzRi8zdkaz7geiOl9szGVOLursMKiAUNT7KY4WthEwPD9LzN3C
        ZsZdofdCqxLcFclbFY72KJIsyratuEe69JGcvQ==
X-Google-Smtp-Source: APXvYqwWEfmpKY3zZxeTsoz+9b5Jxvnpbh9dnWAZcqVKkxXPpQ0hgEwCHFDLoJG43bykGRg1PVpucFSrgarbTRepG30=
X-Received: by 2002:a2e:86c3:: with SMTP id n3mr1139828ljj.129.1563999176699;
 Wed, 24 Jul 2019 13:12:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190712173404.14417-1-nhfran2@tycho.nsa.gov> <680c35a8-1ee5-725d-b33c-7bdced39763c@schaufler-ca.com>
 <e8de4a1c-7e18-fc20-e372-67bbaa93fd42@tycho.nsa.gov>
In-Reply-To: <e8de4a1c-7e18-fc20-e372-67bbaa93fd42@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 24 Jul 2019 16:12:45 -0400
Message-ID: <CAHC9VhT0qQMTv-9MC12OvKNOF=TAEsk670A7=GZxgPk3qhCmaA@mail.gmail.com>
Subject: Re: [RFC PATCH] security, capability: pass object information to security_capable
To:     Stephen Smalley <sds@tycho.nsa.gov>,
        Nicholas Franck <nhfran2@tycho.nsa.gov>
Cc:     Casey Schaufler <casey@schaufler-ca.com>, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, luto@amacapital.net,
        James Morris <jmorris@namei.org>, keescook@chromium.org,
        Serge Hallyn <serge@hallyn.com>, john.johansen@canonical.com,
        mortonm@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Jul 12, 2019 at 2:25 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> That is part of what we want, but not the entire picture.  But with
> respect to audit, the problem today is that one sees SELinux
> dac_read_search, dac_override, etc denials with no indication as to the
> particular file, which is unfortunate both from a security auditing
> perspective and from a policy development perspective.  The only option
> today to gain that information is by enabling system call audit and
> setting at least one audit filter so that the audit framework will
> collect that information and include it in the audit records that are
> emitted upon syscall exit after any such AVC denial.

It might be worth looking into adding some functionality to allow the
LSMs to have some control about when/where to enable auditing.  While
selectively adding records once the denial is triggered isn't going to
be possible (it's too late to collect some of the information we would
want, e.g. file information), it should be possible to allow the LSM
to trigger per-process audit record collection without too much
trouble.  We could potentially take it a step further and on those
processes which have had auditing enabled by the LSM we could allow
the LSM to select when these additional records would be emitted (e.g.
on access denial); you would still incur the collection overhead, but
the logs would be much less.

> And even when one can enable
> syscall audit, one must correlate the syscall audit record to the
> associated AVC record to identify the object rather than having the
> information directly included in the same record.

We've been doing a lot of work to associate related records so that
you don't have to deal with the problem you're describing.  If you are
still seeing problematic records on a modern kernel I would like to
hear about it.

-- 
paul moore
www.paul-moore.com
