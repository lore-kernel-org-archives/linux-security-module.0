Return-Path: <SRS0=sdO6=QG=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 070C5C282D4
	for <linux-security-module@archiver.kernel.org>; Wed, 30 Jan 2019 07:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C47EF21848
	for <linux-security-module@archiver.kernel.org>; Wed, 30 Jan 2019 07:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IhVMf6lT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725820AbfA3HPV (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 30 Jan 2019 02:15:21 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:46498 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfA3HPU (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 30 Jan 2019 02:15:20 -0500
Received: by mail-ua1-f65.google.com with SMTP id v24so7745185uap.13
        for <linux-security-module@vger.kernel.org>; Tue, 29 Jan 2019 23:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o1OQAVE4f+e4vYpM9eFvpzmj3vcKVdsso4y2pAj6E+g=;
        b=IhVMf6lT+e4wucNHGKkQAULUFSnMAaLy+aNCJzwYWviF6dipqWX+bQf+bpwbt51LZH
         P55ShamcXbXEaNvlmPuONaEkH6M64rhEy2Vi8sG6pqURUqMvVvpdkwyr94aA8tBNO/IQ
         LYOnwU9eig8aCeqBgw8p5q4hiBxM081aXGoPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o1OQAVE4f+e4vYpM9eFvpzmj3vcKVdsso4y2pAj6E+g=;
        b=CiE0cLa4o1KNXIumnOKP4f+S3fyCL1wujAsrmNrYmxI3yRS2wA/eEJkx4ZEp7Bn+Ni
         SDvOtGvum9ZrnTggGoC60UuPNN1vKZu5bKyoPo6dRsVBKisyA7CjJy0cqO/KguhTPlch
         vmLAoSg5AGXZMmcsX49DnpWs53JPKuR8JLOzc7MENMlxTQB33J4YAcxSUZ3v9wHvyzzE
         5HJJvpGGlWoE5p6L4N6hYetLC2bHq44jtmyrPl1TUXR5OPf/clvm0GPklM345aYb/VCD
         FWuX9HxJybcwO3xtZgdXIAW9vSNqADIvz4nkzcROcL82ZDzCM3jZFuA4SsyUNtKJM7Yo
         +YEQ==
X-Gm-Message-State: AHQUAuYBMkpyEi6s2fsIg3e2jT5f5KXDUS7SzgDo4P33ymuUnL0rOGPj
        rzTX4U5XJE2P73tGf6vABRj5YUWWYfc=
X-Google-Smtp-Source: AHgI3IapP5lAWViWBCmZSehlcC4OCGGWh2ZC7/tD4KtBlX/CCzyzUBdt3gYXofYViGXBoF0D93Jojg==
X-Received: by 2002:ab0:310d:: with SMTP id e13mr1998582ual.63.1548832519444;
        Tue, 29 Jan 2019 23:15:19 -0800 (PST)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id y195sm816325vkd.0.2019.01.29.23.15.18
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 23:15:18 -0800 (PST)
Received: by mail-vs1-f49.google.com with SMTP id x64so13639464vsa.5
        for <linux-security-module@vger.kernel.org>; Tue, 29 Jan 2019 23:15:18 -0800 (PST)
X-Received: by 2002:a67:e15e:: with SMTP id o30mr12771046vsl.66.1548832517927;
 Tue, 29 Jan 2019 23:15:17 -0800 (PST)
MIME-Version: 1.0
References: <CAGXu5j+V61YOk7oAEw3Fm5rOxQAmy2-3QqOZaOP_FROLBUk2Qg@mail.gmail.com>
 <20190116154606.92331-1-mortonm@chromium.org> <alpine.LRH.2.21.1901260714380.27585@namei.org>
 <CAJ-EccMc3Xz0DZAm_u09VvTzWRzhrf9x0SpJKX=4FR6NYwqkpQ@mail.gmail.com>
 <CAJ-EccMAb-OX3R6mk4me0x6dS2bQw=yZrpKmF7JpzHDWSX5e4g@mail.gmail.com>
 <CAGXu5jKLdcadm30NwpquX1iGJRsjZY-A5grc65BC64B96RE_Eg@mail.gmail.com>
 <CAJ-EccM3BzUUS0CZuhAcj47+KR57JwvhLWiQoc86LWb87wWBcg@mail.gmail.com>
 <CAJ-EccPpb_544TgW3YtcT=ptGDwTxx=KOMBdLtqUNim7ynuCdQ@mail.gmail.com>
 <alpine.LRH.2.21.1901300424420.16638@namei.org> <CAJ-EccOp4zrVT2+RZQZn7j6RchVk5S7UxFjyOBF_6mpE-fHVPA@mail.gmail.com>
In-Reply-To: <CAJ-EccOp4zrVT2+RZQZn7j6RchVk5S7UxFjyOBF_6mpE-fHVPA@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 30 Jan 2019 20:15:05 +1300
X-Gmail-Original-Message-ID: <CAGXu5jJX5V9H5uWArV93eM9jFzaCO4s3rQPBa6rN0LbKtMj82Q@mail.gmail.com>
Message-ID: <CAGXu5jJX5V9H5uWArV93eM9jFzaCO4s3rQPBa6rN0LbKtMj82Q@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] LSM: add SafeSetID module that gates setid calls
To:     Micah Morton <mortonm@chromium.org>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Jan 30, 2019 at 10:14 AM Micah Morton <mortonm@chromium.org> wrote:
>
> testsuite meaning Linux Test Project / Autotest? We have a ChromeOS
> Autotest for this already
> (https://chromium.googlesource.com/chromiumos/third_party/autotest/+/master/client/site_tests/security_ProcessManagementPolicy/security_ProcessManagementPolicy.py)
> but it would at least need some adaptation for configuring/flushing
> policies during the test. Not sure how different Linux Autotests are
> from ChromeOS, if they are used at all.
>
> Also, could you point me at the directory that holds such test scripts
> in the kernel tree? Shouldn't be too difficult to port that ChromeOS
> autotest to a script if we want to go that route.

The common place is tools/testing/selftests/name-here (for example,
see the "seccomp/" directory).

-- 
Kees Cook
