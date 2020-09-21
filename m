Return-Path: <SRS0=i+Ac=C6=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6FF5C43466
	for <linux-security-module@archiver.kernel.org>; Mon, 21 Sep 2020 14:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99B6020735
	for <linux-security-module@archiver.kernel.org>; Mon, 21 Sep 2020 14:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KV2uFtsW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbgIUOvz (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 21 Sep 2020 10:51:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39182 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726795AbgIUOvz (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 21 Sep 2020 10:51:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600699913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=fS4tEIUXzLiN1infPPE8WhHFvu+7kD6d4GBJkxQpXVA=;
        b=KV2uFtsWWSJdosHNJQuTLJumbPAuyvJoqzsgxIesY/hS1BeyprizTk8mauzmawV2SDJkT/
        53iolt05h6eTZohQqww9LziYi/UjnImBf/zlcHDgrCLHeXs10OKn5O42KAKT1sDJ113r3k
        KUBTtiSB76iZJFLHoIeYmSw0BTowXRI=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-y-N9BlbROxO1JtSqCu_sYw-1; Mon, 21 Sep 2020 10:51:48 -0400
X-MC-Unique: y-N9BlbROxO1JtSqCu_sYw-1
Received: by mail-lf1-f70.google.com with SMTP id z77so2514331lfc.2
        for <linux-security-module@vger.kernel.org>; Mon, 21 Sep 2020 07:51:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=fS4tEIUXzLiN1infPPE8WhHFvu+7kD6d4GBJkxQpXVA=;
        b=V80h3+cNWhZMVWy1jNKIwXSFu4TOhAeH0RStHXL9rFQlkiS1I7XxlvrJQdEdhFop1U
         OfQZrirg4etOvSK1ua2EMAtcY3CqdSzuyYlCHv51LcxIxhQpc+6yd5hgQv83vTmcBscS
         8XeMlrC4MEOsk1opgzKUiLRLKrbKNwvLGayVDoWAJp6y7ZaD7lNGXujvuBYV+xwz/0h9
         JNyxg/yVqeS+AQjjuNyij4zr6/54bb3O3qTtq8ZXIZq+xqipzyP5y5+SVABW35Nop8Mc
         oprkMJxue25+lbVICXr/HF/uePfvrJ/Ap2PNb6yNZVSBamHVz2z2N4FR0PRfSTah/vzw
         R6Rg==
X-Gm-Message-State: AOAM533QqljQGzwwKCU8OSET62uH1KCzO34FtqtBVM8GVoFn/JdgdLOl
        /j4Gyw/pdfjTl0yeYlzFCG2Qcvy7E2txKg1c/dE8KjPKPm2jjysWRHnbTZjsh7ks/XjwtSXCtfp
        1UXjXo0kDQCjThgOVYMHnu4ReGXSHHlL1eJJihp+cWoTXZsW4MUAj
X-Received: by 2002:a05:651c:38d:: with SMTP id e13mr45404ljp.38.1600699906825;
        Mon, 21 Sep 2020 07:51:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzWDA/v70U48siYhVA/gEo8+KsPOGYyZfPRgMFWmKODx4TZj6mRHbwGLf09leGYyYHOxCYCfm3AB2zLCE926Vk=
X-Received: by 2002:a05:651c:38d:: with SMTP id e13mr45395ljp.38.1600699906595;
 Mon, 21 Sep 2020 07:51:46 -0700 (PDT)
MIME-Version: 1.0
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 21 Sep 2020 16:51:35 +0200
Message-ID: <CAFqZXNsoXr1eA4C8==Nvujs5ONpRnuSqaOQQ0n78R=Dbm-EFGA@mail.gmail.com>
Subject: Commit 13c164b1a186 - regression for LSMs/SELinux?
To:     Christoph Hellwig <hch@lst.de>, Ian Kent <raven@themaw.net>
Cc:     autofs@vger.kernel.org,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Zdenek Pytela <zpytela@redhat.com>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=omosnace@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi folks,

It seems that after commit 13c164b1a186 ("autofs: switch to
kernel_write") there is now an extra LSM permission required (for the
current task to write to the automount pipe) for processes accessing
some yet-to-to-be mounted directory on which an autofs mount is set
up. The call chain is:
[...]
autofs_wait() ->
autofs_notify_daemon() ->
autofs_write() ->
kernel_write() ->
rw_verify_area() ->
security_file_permission()

The bug report that led me to this commit is at [1].

Technically, this is a regression for LSM users, since this is a
kernel-internal operation and an LSM permission for the current task
shouldn't be required. Can this patch be reverted? Perhaps
__kernel_{read|write}() could instead be renamed to kernel_*_nocheck()
so that the name is more descriptive?

Thanks,

[1] https://bugzilla.redhat.com/show_bug.cgi?id=1874338

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

