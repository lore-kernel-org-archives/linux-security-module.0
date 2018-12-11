Return-Path: <SRS0=nZhg=OU=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB35C6783B
	for <linux-security-module@archiver.kernel.org>; Tue, 11 Dec 2018 21:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C66B20851
	for <linux-security-module@archiver.kernel.org>; Tue, 11 Dec 2018 21:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W0znvO8V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C66B20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbeLKVTd (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 11 Dec 2018 16:19:33 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:36146 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbeLKVTc (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 11 Dec 2018 16:19:32 -0500
Received: by mail-yw1-f67.google.com with SMTP id y194so6061380ywg.3
        for <linux-security-module@vger.kernel.org>; Tue, 11 Dec 2018 13:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9xWaaxa58ld/0XY9eXbIfbQ6/2aD189NGyWhxpL68oA=;
        b=W0znvO8VZaxP3Om1dPhhcL8wqSLjMM4Tlqf9/SmIWK9K2fhQlt4w9bqrD29tqpYUF1
         jT7S4VAzuwcpT3xA06OtRiljTaqpcMbO7EewyNIsQq3bx3+IanoM5Gmja9qMTON2LWYD
         1WrvEHlk4xoj/YSjWyjyCq/3YekfNv9IcIDPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9xWaaxa58ld/0XY9eXbIfbQ6/2aD189NGyWhxpL68oA=;
        b=owsVjdOENt/+FS9Vk6G0Z1U7q1eRZjZei+zfFsaDT9DU9Fyl3ccy4pQUN8dG3sILfH
         QzwrV+lBjBqb3u2EIc7K2yV3JBCScvA8hMQy/xUeO8cS07b4wjvmsffPC8IFh4//DY7c
         QkgubVk6rSkIyG7YEd3IRSVvWCgkjWjFAvwDfGjydk8N5oNLd8l+QWQTIQznPjPh7k2V
         1Ll/JhmeRv2GC8cOMbY3hvX2cqx/o9BNdqFEkSOKumLT90K6Ztgjf2sxUDoHizuo5BRK
         kLvPMS0MQaQlHNKCL2tX+SU43+6rR+KO/i8EpQvbiEGNQzATyUVPL9zvVd8lqFqUFDhH
         tDFA==
X-Gm-Message-State: AA+aEWaRMA/2Q6LqO2tenfqPD4sGJSSs14GKYy//4xbW1TWAmL6fvIK+
        rxxCWx2cT1ZjvgIsFZX6mTab9PO+wB8=
X-Google-Smtp-Source: AFSGD/WiTv7Oh53vmNrGbpmCM6gzUqICY3ngKQ62OqkBzYLODrwFKcnKmeyqUGoao5bVSnBpalQTIA==
X-Received: by 2002:a81:8d14:: with SMTP id d20mr18749661ywg.150.1544563171062;
        Tue, 11 Dec 2018 13:19:31 -0800 (PST)
Received: from mail-yw1-f45.google.com (mail-yw1-f45.google.com. [209.85.161.45])
        by smtp.gmail.com with ESMTPSA id x132sm5915568ywx.27.2018.12.11.13.19.27
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 13:19:28 -0800 (PST)
Received: by mail-yw1-f45.google.com with SMTP id t13so6060559ywe.13
        for <linux-security-module@vger.kernel.org>; Tue, 11 Dec 2018 13:19:27 -0800 (PST)
X-Received: by 2002:a81:29cc:: with SMTP id p195mr18729229ywp.407.1544563167538;
 Tue, 11 Dec 2018 13:19:27 -0800 (PST)
MIME-Version: 1.0
References: <50db058a-7dde-441b-a7f9-f6837fe8b69f@schaufler-ca.com>
 <CAGXu5jLUJYM3nDDhFeBOKkTnyCR-tXAv-rteBJFMBn_J7kVkqA@mail.gmail.com> <alpine.LRH.2.21.1812120556040.11653@namei.org>
In-Reply-To: <alpine.LRH.2.21.1812120556040.11653@namei.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 11 Dec 2018 13:19:16 -0800
X-Gmail-Original-Message-ID: <CAGXu5j+bx7nJBMdFYigYnJFRyCvz0NAxfiWF8yP9EhRESLnn+Q@mail.gmail.com>
Message-ID: <CAGXu5j+bx7nJBMdFYigYnJFRyCvz0NAxfiWF8yP9EhRESLnn+Q@mail.gmail.com>
Subject: Re: [PATCH v5 00/38] LSM: Module stacking for SARA and Landlock
To:     James Morris <jmorris@namei.org>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        SE Linux <selinux@tycho.nsa.gov>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Dec 11, 2018 at 10:57 AM James Morris <jmorris@namei.org> wrote:
>
> On Tue, 4 Dec 2018, Kees Cook wrote:
>
> > On Mon, Nov 26, 2018 at 3:22 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> > > v5: Include Kees Cook's rework of the lsm command
> > >     line interface. Stacking is not conditional.
> >
> > Can you resend this series with corrected "From:" lines in the body, etc?
> >
> > Beyond that, I obviously like it. James, what's needed for this to move forward?
>
> If there are no outstanding issues, I plan to merge this for 4.21.

Yeah, it looks good to me. (Excepting getting the authorship sorted.)

Thanks!

-- 
Kees Cook
