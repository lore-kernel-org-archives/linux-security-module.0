Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1647C4332F
	for <linux-security-module@archiver.kernel.org>; Fri, 10 Nov 2023 21:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjKJVhN (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 10 Nov 2023 16:37:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjKJVhN (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 10 Nov 2023 16:37:13 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D634229
        for <linux-security-module@vger.kernel.org>; Fri, 10 Nov 2023 13:37:07 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-daf2eda7efaso841446276.0
        for <linux-security-module@vger.kernel.org>; Fri, 10 Nov 2023 13:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1699652227; x=1700257027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EK5KZJbX0KbAZTwqVt/Wc/I4RWhJOChSq/SaWjfJwig=;
        b=AklQlihVAALFrjusgorrKweLtVNF+dIHAxhVJGj8LxBq3P5rqDsN1DhzMoV3fmyg/Y
         yZ2qYGf7gNPx9SD82ecqPlXw15s7oC1tIsXf4ZCUhSsmnyccLhBt5aJuCidIufIo6hnv
         ohSJV3VVPSDUhJ87khnRyC/+Oid7NBlalEt9p35PoXUuTCRoWC5rKaY3GfviS5BoaXGO
         BJWJyn/O+06cI53V4yPGHSXIyq2EvpXfP/0kq9OVscjP/1nVnGZhM8EsSTdo3OHzT1XP
         +DqE+ybVADU6oFXLJOKS+C5XB74e0156+bZin/l1xupOC5iaLXe/wY8ZJshUhQLv1C1I
         wXYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699652227; x=1700257027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EK5KZJbX0KbAZTwqVt/Wc/I4RWhJOChSq/SaWjfJwig=;
        b=sY5CY9IVeJAuEvcpyiQir5LrC5vaUBJe0avdRQZF476Nie8lkOLVV9fvBvUf6UvRWI
         gjSDOg78dOWiEM4urlJCu5pcN2kdSWU7lucBwulevIjn6KqeTL0oiBq8ZhdkBJKQYh9p
         VQYf+pCQdSl8EoNTl/Q+DWi0ETNOqA09VK8oli29GiR6uIRexBlAVmY4csgJpG/5sFI1
         MEPpiHFPqPJa7YiN/zDLYmT2Ss2E8FqtfEPGBbF5mSuu7FBCLiqTSz3SYQ3jvi0wRNC8
         r4yYyCzXrS5zYUoDu+eBV+SxLWvZAnAdIeSELkPT5XLk/1/1FE6qEZyZQhxfqH+haV7Q
         Ul8w==
X-Gm-Message-State: AOJu0YwxcH6s3cicbaYI+6CwmtS9nWfzzlkRBUFnoJJCu73yOJrXpWyW
        e042tLa2l2X5rmpNc807tpxfrBJn4n25FKsVIklKHyh+gz2aKBM=
X-Google-Smtp-Source: AGHT+IFMlSarcL5KAxEisJv0DZQMJ5iBnbrXUYuXN2/6EyvVg/0icWzZGNHv7xUft+hzP7PLxD7N5q0DvScqDtSJz4c=
X-Received: by 2002:a25:e689:0:b0:da0:cded:62f8 with SMTP id
 d131-20020a25e689000000b00da0cded62f8mr318077ybh.28.1699652226705; Fri, 10
 Nov 2023 13:37:06 -0800 (PST)
MIME-Version: 1.0
References: <20231110173427.79275-2-paul@paul-moore.com> <b32a3279-5c2f-4ddb-b400-09681276cf1d@schaufler-ca.com>
In-Reply-To: <b32a3279-5c2f-4ddb-b400-09681276cf1d@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 10 Nov 2023 16:36:55 -0500
Message-ID: <CAHC9VhSdC-=vDK8ezhMe=ymL4vjNB1NPxi2pCAG5Uo1P0Z5fjA@mail.gmail.com>
Subject: Re: [PATCH] lsm: mark the lsm_id variables are marked as static
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Nov 10, 2023 at 3:23=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
>
> On 11/10/2023 9:34 AM, Paul Moore wrote:
> > As the kernel test robot helpfully reminded us, all of the lsm_id
> > instances defined inside the various LSMs should be marked as static.
> > The one exception is Landlock which uses its lsm_id variable across
> > multiple source files with an extern declaration in a header file.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Suggested-by: Casey Schaufler <casey@schaufler-ca.com>
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
>
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>

Thanks Casey, I've gone ahead and merge this into lsm/dev-staging.

--=20
paul-moore.com
