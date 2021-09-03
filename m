Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D11C433FE
	for <linux-security-module@archiver.kernel.org>; Fri,  3 Sep 2021 15:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 440F26108E
	for <linux-security-module@archiver.kernel.org>; Fri,  3 Sep 2021 15:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235609AbhICPv7 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 3 Sep 2021 11:51:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55126 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235824AbhICPv6 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 3 Sep 2021 11:51:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630684256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MoQLQTqUY5yDM/Q0pchQHfi3iihhP0hcaHsviw39pb8=;
        b=bIzPqff02uJU3F917ZBPWIXiba4iwjlsCmg++d8QAWeg62buxo3KqJC7QZmM2fH5m4/iXH
        nUlID5rNBL4V/3NATYn2MIAAaNK7LUOjKsLredufjDzjnMC4QFCVFgak9sMkFA6Y8BB8w2
        BX+PhEPf0HJCLWwLgPccmVPkuOLrP50=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-FUOd6sjaMqKeiHyNtW4cCA-1; Fri, 03 Sep 2021 11:50:55 -0400
X-MC-Unique: FUOd6sjaMqKeiHyNtW4cCA-1
Received: by mail-io1-f70.google.com with SMTP id i78-20020a6b3b51000000b005b8dd0f9e76so4160090ioa.9
        for <linux-security-module@vger.kernel.org>; Fri, 03 Sep 2021 08:50:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MoQLQTqUY5yDM/Q0pchQHfi3iihhP0hcaHsviw39pb8=;
        b=IpwevbKCfhLehyH+aZ9u+Zym1QOcoOpA1dlEGAyiqjo4GZiO3H8DQqz/sgL0WRdIoM
         oLo84oR72Ty9e7k5a4xbdfnQFxCCWyEv/49uKw8lOfi118rMBCmUpktvqV6uKYlh1y5Q
         exS4EzgrLFiThkiVP/4ufc/5ouFF2bY0Qnt3o5N4vJsMdcPWCiaiwSq+nfHZrz0TG4jW
         COjUcq6uYF1OdIFY17Ap1nVtgWEYqjsQFj0sHw4ZJHsSSH8iFlUzpiFPRvYL+I57rU/z
         AsznG7uU+jiLpbxGmjqQe/Dl5Qy7iZszHo9IfDZUncE9oFXYRkBdmo8wgArhlRQkiElh
         rnVA==
X-Gm-Message-State: AOAM532+vomoCUV9KHz22BMn87sz4uYMQPSwCoF6+ja/oeVQY0/kesYJ
        1FL6VpCiEs3jqHplR4JJ8Dg/OXDaduUwQHovAY3XBYJEJBEYdGK7VYelemfe/r8fev0POjLKlkh
        ZX8m/4vv7eadWgPJ3j6W6EEGnVy2WSiCijCe6htwkqqQEzFPvMsJI
X-Received: by 2002:a92:1944:: with SMTP id e4mr3012470ilm.186.1630684254587;
        Fri, 03 Sep 2021 08:50:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxA5hXocfG238Br3Kxfn76guZ5oIlMhSVgOX7QM7jB7Qbl9LikvJuc4o8e5u68QJjhURVNmZgDTJj9VHCBUSvY=
X-Received: by 2002:a92:1944:: with SMTP id e4mr3012456ilm.186.1630684254354;
 Fri, 03 Sep 2021 08:50:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210902152228.665959-1-vgoyal@redhat.com> <YTDyE9wVQQBxS77r@redhat.com>
 <CAHc6FU4ytU5eo4bmJcL6MW+qJZAtYTX0=wTZnv4myhDBv-qZHQ@mail.gmail.com>
 <CAHc6FU5quZWQtZ3fRfM_ZseUsweEbJA0aAkZvQEF5u9MJhrqdQ@mail.gmail.com>
 <CAPL3RVH9MDoDAdiZ-nm3a4BgmRyZJUc_PV_MpsEWiuh6QPi+pA@mail.gmail.com> <YTJCjGH0V5yzMnQB@redhat.com>
In-Reply-To: <YTJCjGH0V5yzMnQB@redhat.com>
From:   Bruce Fields <bfields@redhat.com>
Date:   Fri, 3 Sep 2021 11:50:43 -0400
Message-ID: <CAPL3RVFB67-AqZrjjfxueQF1Jw=LmKWzCk3Ur94EjUotYMw0AA@mail.gmail.com>
Subject: Re: [PATCH 3/1] xfstests: generic/062: Do not run on newer kernels
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        fstests <fstests@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, virtio-fs@redhat.com,
        Daniel Walsh <dwalsh@redhat.com>,
        David Gilbert <dgilbert@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        LSM <linux-security-module@vger.kernel.org>,
        selinux@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        stephen.smalley.work@gmail.com, Dave Chinner <david@fromorbit.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=bfields@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Sep 3, 2021 at 11:43 AM Vivek Goyal <vgoyal@redhat.com> wrote:
> On Fri, Sep 03, 2021 at 10:42:34AM -0400, Bruce Fields wrote:
> > Well, we could also look at supporting trusted.* xattrs over NFS.  I
> > don't know much about them, but it looks like it wouldn't be a lot of
> > work to specify, especially now that we've already got user xattrs?
> > We'd just write a new internet draft that refers to the existing
> > user.* xattr draft for most of the details.
>
> Will be nice if we can support trusted.* xattrs on NFS.

Maybe I should start a separate thread for that.  Who would need to be
on it to be sure we get this right?

--b.

