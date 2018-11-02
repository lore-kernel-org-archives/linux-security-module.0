Return-Path: <SRS0=l7tI=NN=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6893C32789
	for <linux-security-module@archiver.kernel.org>; Fri,  2 Nov 2018 18:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B620A2081B
	for <linux-security-module@archiver.kernel.org>; Fri,  2 Nov 2018 18:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VJOibp+n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B620A2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbeKCDhS (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:37:18 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46887 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728164AbeKCDhR (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 2 Nov 2018 23:37:17 -0400
Received: by mail-lf1-f67.google.com with SMTP id o2-v6so1947077lfl.13
        for <linux-security-module@vger.kernel.org>; Fri, 02 Nov 2018 11:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iaIwNjBE+rDKni9amWBasY1LkRgPcQYr40JqDmsjOEI=;
        b=VJOibp+noxy+lHfw7qrbpRLJ1B5cSnp3puF46qov6VVL3pliJscNto2rF7QqrDEEav
         dC6cbvSjy5iD6qZ433J5PQUeKo1v6ADryXlSG0f1w0RqAaP1pKu8w/i0IWZz+AfdHrqo
         fYHmGRsGXyhWXqQKjvhtOQFPU6U+17vSxJHSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iaIwNjBE+rDKni9amWBasY1LkRgPcQYr40JqDmsjOEI=;
        b=eIA+aiHScK5lJgQoyRVbNTX55eoM5hhfw2NLl97KY0oyctzlKM8RBY0l0Z7ReF1ncp
         W54tmLsBZABNuKd4YfPWSOYAzPVQmDEYXchnQX5dJn5SiQOieXtA/IE1hzMjGWZ7hQNk
         nS4NFE9yu/8I54XmGCLItfdDOSlVzpdE+mWHT6p6eVRp2ZExaNHLuAHQZWlmzhZL8CXh
         9xdSMU2TK5yGekouvmgOG5ZZCAH2XFqTfOLxX5eNNPWpq5Q+EXjvJQ6Rm3O6wbxzpoxr
         aOsk3r3KOztupCGldvpNqk4DwPozPufnHFCIR8xJ4b1tw9fJSqE8EWOYhKIzfaXgVpC3
         ITFw==
X-Gm-Message-State: AGRZ1gIiR0IPzFS/dNXdNXgc3p0WQLjBuqP76R/+RQtC7jAF0rfOi3Yp
        Kgvm2rxRV6MhNWrxeUj0AjwMwXwdTdmpLQ==
X-Google-Smtp-Source: AJdET5fZ+ym78AyMhBV/f5xNxBjBGyu/Be4E6rekdAWox7J2H7gMSH2TtTd+Lb4Oykm/w5mcHqANBA==
X-Received: by 2002:a19:6719:: with SMTP id b25mr6993159lfc.38.1541183346914;
        Fri, 02 Nov 2018 11:29:06 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id e4-v6sm5238790ljk.92.2018.11.02.11.29.06
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 11:29:06 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id t22-v6so2553837lji.7
        for <linux-security-module@vger.kernel.org>; Fri, 02 Nov 2018 11:29:06 -0700 (PDT)
X-Received: by 2002:a2e:9983:: with SMTP id w3-v6mr9012045lji.133.1541183345442;
 Fri, 02 Nov 2018 11:29:05 -0700 (PDT)
MIME-Version: 1.0
References: <db97d76a-fad0-2a26-297a-06dbf8f8380b@canonical.com>
In-Reply-To: <db97d76a-fad0-2a26-297a-06dbf8f8380b@canonical.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 2 Nov 2018 11:28:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjOO_hJ1SL2jGVg3jGuPaGiuroxJa=-c=3LaJZBwME6VQ@mail.gmail.com>
Message-ID: <CAHk-=wjOO_hJ1SL2jGVg3jGuPaGiuroxJa=-c=3LaJZBwME6VQ@mail.gmail.com>
Subject: Re: [GIT PULL] apparmor updates for v4.20
To:     john.johansen@canonical.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Nov 1, 2018 at 11:22 PM John Johansen
<john.johansen@canonical.com> wrote:
>
> Please pull these apparmor changes for v4.20.

Pulled. Although I really wish these had come in earlier (like the
other security layer pulls did)

                   Linus
