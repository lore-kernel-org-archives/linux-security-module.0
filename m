Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE59CDB465
	for <linux-security-module@archiver.kernel.org>; Mon, 16 Oct 2023 15:06:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbjJPPGv (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 16 Oct 2023 11:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233788AbjJPPGu (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 16 Oct 2023 11:06:50 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554FDE6
        for <linux-security-module@vger.kernel.org>; Mon, 16 Oct 2023 08:06:45 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d9ac31cb021so5163962276.1
        for <linux-security-module@vger.kernel.org>; Mon, 16 Oct 2023 08:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1697468804; x=1698073604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7JPLLbFfi+3DcdR4lMb9bxT1Efqz3WnKELubajvCf/8=;
        b=dagC2NQY29AS3Upuik35O6nqJ8zXL3qZIbhmlUeyEHTa5xsoWW8EXpxGWIC3jdlgvP
         5OIPBMdEQ5LjLZwJk5kr/40hLiHfRcWQS6iemI39AY6srmG0LKt2/ZYH9nVrMoVquag2
         uR9p6GEoOSN4mioIM/WN2CFSg+mB2od5Brd5GA9K/6UIHwqXwrNmQE0qqWiQnxIXrnXT
         2Igh9t/uvVwet52Yx/myMeYwqyGBo7aYH6hvhLg3ld6lq7SCU8NePOKh6bhRfebvW5mR
         Em++plsgl7iF0+7F7p5VBEbeN0Hrk5PZTp8P6m/fR5B/21Q8UeomsnXqGHCO+oMl/5N9
         Wmng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697468804; x=1698073604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7JPLLbFfi+3DcdR4lMb9bxT1Efqz3WnKELubajvCf/8=;
        b=p8VC5Z8MGj8AIWLaZo7Kh4T0n+5eLKv8OsIwHdcmL0r6RvpL3YykbtTTXPot6+RIGM
         emh1BcD68tGbDwW1TXnGEiDSoccra76IyI0C8nUU8pG3hdQugCsTzcqHuCj6UsksL+7i
         I3JGmBrx0P1AFYNqrDr4QYwTRmXqSDsrSg5fqoTfrMpkqsGLL4GOjljYRsSrOwPDYq6N
         aMYfA8mDISecUgUtAq1JSXHofB6q0TvSVgjLbNkl6tHG7K4I/d/Jcx8YwaeX0fm7rb46
         R5ENtc151Hn5juQq7MkcqyRHPxTk5oP4qzpF37kwXa4txM9xW5LR5sLjFl7PpzXen8Ib
         3vQg==
X-Gm-Message-State: AOJu0Yy7taqlv8URfNQlx08r7nkMFwqGHh+n1NMx8xA3SCb6Q2jEVJmx
        TNTZAWSK9y0mhTVHuvKzM8X6PdNhzGqYf3Z+tVpbzP7oI8OUINM=
X-Google-Smtp-Source: AGHT+IGDqKl7MND9wZqcX+N6HWeeMu6HHtgNjthMSWYuYqtbmsB/+9mEShdOg4gGou5EhGsCNoZVqcXb9rZceJuQ6gU=
X-Received: by 2002:a25:ae8b:0:b0:d9a:d20d:7d5a with SMTP id
 b11-20020a25ae8b000000b00d9ad20d7d5amr13002821ybj.1.1697468804361; Mon, 16
 Oct 2023 08:06:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230912205658.3432-1-casey.ref@schaufler-ca.com>
 <20230912205658.3432-1-casey@schaufler-ca.com> <CAHC9VhRcbp3iWQwL7FTUrcU1C3OsZ413Nbq+17oTwW7hZ7XvBw@mail.gmail.com>
 <CAHC9VhSqY5+DR-jXprrftb1=CzDvhTh0Ep66A16RMd4L7W7TYw@mail.gmail.com> <ae39864947debbc7c460db478b8abe1c147b7d5c.camel@huaweicloud.com>
In-Reply-To: <ae39864947debbc7c460db478b8abe1c147b7d5c.camel@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 16 Oct 2023 11:06:33 -0400
Message-ID: <CAHC9VhRQ7xpeSX7b3VZfzQ15noJ8mgauNMuHWo_n3hMgsYMAfQ@mail.gmail.com>
Subject: Re: [PATCH v15 00/11] LSM: Three basic syscalls
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Oct 16, 2023 at 8:05=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> Sorry, I just noticed LSM_ID_IMA. Since we have the 'integrity' LSM, I
> think it should be LSM_ID_INTEGRITY.
>
> Mimi, all, do you agree? If yes, I send a patch shortly.

I believe LSM_ID_IMA is the better option, despite "integrity" already
being present in Kconfig and possibly other areas.  "IMA" is a
specific thing/LSM whereas "integrity" is a property, principle, or
quality.  Especially as we move forward with promoting IMA as a full
and proper LSM, we should work towards referring to it as "IMA" and
not "integrity".

If anything we should be working to support "IMA" in places where we
currently have "integrity" so that we can eventually deprecate
"integrity".

--=20
paul-moore.com
