Return-Path: <SRS0=nGf1=PW=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8977C43387
	for <linux-security-module@archiver.kernel.org>; Mon, 14 Jan 2019 09:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3C1220663
	for <linux-security-module@archiver.kernel.org>; Mon, 14 Jan 2019 09:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfANJB5 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 14 Jan 2019 04:01:57 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37732 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbfANJB4 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 14 Jan 2019 04:01:56 -0500
Received: by mail-oi1-f193.google.com with SMTP id y23so17259266oia.4
        for <linux-security-module@vger.kernel.org>; Mon, 14 Jan 2019 01:01:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4L7YKxYVWqwprFECJP1sFs2eqEAPQyOIpMOgGfIBeSE=;
        b=KVsTOaliCGB01eX/Wy1RkoqCfCEaVvOwTtV8slKZnSBRn0IvVqofAodW3uEbMrlr7U
         yBBzYil+a8BzQjzwCcKaFZCqG268N1eZPRzmj8YcSa1D4liTDRBEtBXGZfVPwvb6E3Sx
         XsdRu1o1E3d2lduEHq3ZVKcisXmdM+T4X5NsCl9AZTj3Z47RfG8x2fNA54okdJZC7c8N
         DNdl+f9akxHItNteOROYHichgDdYMx5r4LsjQKET+zIrrfupjTNMBGJgO73Gedr30mzi
         uj4kiJzI3VAxFeJNEoHUs4tr0qzM84zaIhe2GhooMAGyR1HiVWKywHiDa/PvCi0vRyIL
         /rAg==
X-Gm-Message-State: AJcUukdBC6VaECr56WnyY7o2SaihyYhnYCODvPpjjr/yCabAde9HE6Kx
        6MfaZ05hYFZLlT2eVc4GRp1OnTt2TnWlLlYk+92Uwg==
X-Google-Smtp-Source: ALg8bN4rrQemI5i2XtRRbXxqJ+hvEkMXrPnncmSQWKbyY1yAAKNvgTVMiAquroI83QE+gt18RZ/3gPCye6fkIR7Mgas=
X-Received: by 2002:aca:cdd0:: with SMTP id d199mr16143188oig.266.1547456515214;
 Mon, 14 Jan 2019 01:01:55 -0800 (PST)
MIME-Version: 1.0
References: <20190109162830.8309-1-omosnace@redhat.com> <fbdcf8ef-1587-18f2-3293-452d62305ab3@schaufler-ca.com>
 <f7312dd2-ea86-51ab-652d-2df39faf52c7@tycho.nsa.gov> <ef22910a-4922-5f66-b7c5-7a7c1dbad8e6@schaufler-ca.com>
 <93d310a7-0bce-dccd-8136-c659a460e084@tycho.nsa.gov> <1062e181-16fa-66b8-a48c-786edcb9deb7@schaufler-ca.com>
 <2612c523-084a-7652-58ca-9e062b80138e@tycho.nsa.gov> <CAHC9VhRWfaju_pL8US=gyTn-qu+iF1Nc_71OqGMiJSY6bOwg5Q@mail.gmail.com>
In-Reply-To: <CAHC9VhRWfaju_pL8US=gyTn-qu+iF1Nc_71OqGMiJSY6bOwg5Q@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 14 Jan 2019 10:01:44 +0100
Message-ID: <CAFqZXNtqp=UGJyL=E4q3i5MWRP689+MWef0QxvTbe9csBtDG7Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Allow initializing the kernfs node's secctx based
 on its parent
To:     Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Casey Schaufler <casey@schaufler-ca.com>,
        selinux@vger.kernel.org,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Jan 11, 2019 at 3:44 AM Paul Moore <paul@paul-moore.com> wrote:
> [...]
>
> Ondrej, a gentle reminder that it would be nice to have a simple
> selinux-testsuite test to make sure we are labeling
> kernfs-based/cgroup files correctly.

OK, I'll see if I can adapt the reproducer from the last patch into
the testsuite.



--
Ondrej Mosnacek <omosnace at redhat dot com>
Associate Software Engineer, Security Technologies
Red Hat, Inc.
