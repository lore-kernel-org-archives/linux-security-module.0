Return-Path: <SRS0=s2IT=QZ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92CD6C43381
	for <linux-security-module@archiver.kernel.org>; Mon, 18 Feb 2019 03:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 562F7218D3
	for <linux-security-module@archiver.kernel.org>; Mon, 18 Feb 2019 03:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lPFHHgru"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbfBRD5q (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 17 Feb 2019 22:57:46 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:34885 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbfBRD5q (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 17 Feb 2019 22:57:46 -0500
Received: by mail-ua1-f68.google.com with SMTP id k5so579840uao.2
        for <linux-security-module@vger.kernel.org>; Sun, 17 Feb 2019 19:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UOsM3VCVgb9jvwPmcWRSvBagRCh9VlWAv72+Ih2qte0=;
        b=lPFHHgruNQsGLwdT6TH5+K5HkaAvs54hgg8I+9lpT8zJJT90R+8fGdQhpnSnLdoT/1
         /zu/zyHI3Oqk8te3MqN0NvqNRNOFQVN8eM0Z03NZ62Uq5DZ7cuCZg6PzAXI2L+6bAd6c
         +pi/uIn8MrUihRld/jD2bcWL1eBT1XuclwbFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UOsM3VCVgb9jvwPmcWRSvBagRCh9VlWAv72+Ih2qte0=;
        b=IWroZBJYl9x9uqOvAgtnnS9cOYzyIHZXt2WRK7xNVn8/2zgk0dDX4Qv/e+85X8lQ4X
         kU9ynFLKwPJ6w2sM83Qug+f3ycl8gAzhLFKuqjT9OisPzNpYltaSZ+tvGvy/vvZvJK5f
         6TqxkrgZFaeQdan363Qr8dkbundrEl3IZKPWM7oO5Nd2WnjlDOfmND07aV/gWx4RMTnj
         QmFrUlJhwKhO/WBfgQb/U4G4kggBvG9EkL44X1twN1U736nv67DYpG8qY0fAFATlXRDo
         zQY7sCjXmXc9bk4lujLDrvYbblF6uq1JzWgzoKtJys7JHk+R4g8KcklG/FSG2/YENi3k
         aExA==
X-Gm-Message-State: AHQUAuadkqhQHGjNy1nJu/rZciS4D4J+SSbhhqaYh6p3z3XOHMhm0waj
        9lpk2aryV/KYwQvJ+Nh1/M28eSTO79g=
X-Google-Smtp-Source: AHgI3IaBxiIPT6Pj1S+csYN0MnKO41ImQfcOEbeBNSl0zhyfFr8VPPLZg39rEskA/db3vECj8jZ5BQ==
X-Received: by 2002:ab0:30ba:: with SMTP id b26mr10694008uam.137.1550462264684;
        Sun, 17 Feb 2019 19:57:44 -0800 (PST)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id a30sm5962138uaf.18.2019.02.17.19.57.42
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 19:57:43 -0800 (PST)
Received: by mail-vs1-f43.google.com with SMTP id t13so8859133vsk.3
        for <linux-security-module@vger.kernel.org>; Sun, 17 Feb 2019 19:57:42 -0800 (PST)
X-Received: by 2002:a67:6f44:: with SMTP id k65mr10275404vsc.222.1550462262332;
 Sun, 17 Feb 2019 19:57:42 -0800 (PST)
MIME-Version: 1.0
References: <20190212182318.GA16669@beast> <5260689d-9016-bdf4-6070-13d2c88ac8a8@schaufler-ca.com>
 <4ed50852-abfb-773b-01e4-b4ac83e32ed3@I-love.SAKURA.ne.jp> <CAHC9VhSy8iVUtN1Wt+cy-2RmJQhy34=0zKrUj+RQNEvNuD7y0w@mail.gmail.com>
In-Reply-To: <CAHC9VhSy8iVUtN1Wt+cy-2RmJQhy34=0zKrUj+RQNEvNuD7y0w@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Sun, 17 Feb 2019 19:57:28 -0800
X-Gmail-Original-Message-ID: <CAGXu5j+_Xd_On1WsMV18dbjGEg6NGBcSAj4RSp=LX2ALisuXPw@mail.gmail.com>
Message-ID: <CAGXu5j+_Xd_On1WsMV18dbjGEg6NGBcSAj4RSp=LX2ALisuXPw@mail.gmail.com>
Subject: Re: [PATCH v2] LSM: Ignore "security=" when "lsm=" is specified
To:     Paul Moore <paul@paul-moore.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        SELinux <selinux@vger.kernel.org>,
        Ubuntu Kernel Team <kernel-team@lists.ubuntu.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sun, Feb 17, 2019 at 6:46 PM Paul Moore <paul@paul-moore.com> wrote:
> My main concern is that "selinux={0|1}" continues to work as it has
> for years.  It doesn't look like this affects that, but I can't say
> I've dug into these changes very far.

Yup, no worries; it does. :)

-- 
Kees Cook
