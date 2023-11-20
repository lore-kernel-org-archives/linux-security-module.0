Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5897BC197A0
	for <linux-security-module@archiver.kernel.org>; Mon, 20 Nov 2023 22:52:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjKTWxB (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 20 Nov 2023 17:53:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjKTWxA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 20 Nov 2023 17:53:00 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F9CC4
        for <linux-security-module@vger.kernel.org>; Mon, 20 Nov 2023 14:52:56 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-da30fd994fdso4735022276.1
        for <linux-security-module@vger.kernel.org>; Mon, 20 Nov 2023 14:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1700520776; x=1701125576; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2lsMvLDY4ljtrx25hKr++WIvxk12ha+p48G+6QGEW0=;
        b=SszIUC96Nb8PZQUb1f4kf892nc18aPuVcgzjLXipIHbsfQjkp0dhtA9isycgeW/uUZ
         YP/+EJ0fN8qhOKMfO9qXLzkzIjWoKroAanSOCdRKLCjdfPyRRwGOwkXAp6baUnyBbg3U
         I8w/7n9baeDyDY69xwGvjgaejgRGD52SQlAw8dDp6Sv2PZzBPcNB2r53ugXwXHCbByTG
         wxj+ig17bUuytoqYxKXjKONJLqiyt+IN9jetF9dp2ZvoWD6cEFOqAQVWlgYzRH5IbAxa
         s3m7TPkm+kj5SBnAIpFcJ1q+oXPK16Xn9DLiYy9FAh1Jk4T/CV0qFCytn7LzMo9c3YHR
         V6mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700520776; x=1701125576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C2lsMvLDY4ljtrx25hKr++WIvxk12ha+p48G+6QGEW0=;
        b=aMRChunptEjO0/u7xW3sA/hbmzM1iOaEIt6mmBdCMVz0YWKv+DWZutdB3ZPrEZGmaF
         KdVgQzgvfCQJzt0r/GfZ8eJrrx+GVw2BZISxu3KtWjHhd0tgQfpyHLuhZWM1nzJt6qq9
         Uw//u+H36ISGIO0caxewLvdag+zSShTa3TKe2k/0xVwanjkwBi6aZCKrd4VH3X4xMTJR
         nzQ7VLEf1MRO3g5/wbwAvYBsTcG9z6cuvDSYi4poyTflrrBTXcJLttmAYy5NjLP92jk1
         1tcz6hPw5y3qzOoJlGhTZEEwaFtOrBDSUWH1N/6Y1M4bbOa9CzpzsBHnMHvFaqQmsCX6
         KhSA==
X-Gm-Message-State: AOJu0YyEknfox+yvGyn9zesjC0ESCi1d7S9z86ObL31ByHm1tvHL8VOl
        IwOIRZGJuvhXpkLnneQbvzwXSKiR6u6UhkSKNWgf
X-Google-Smtp-Source: AGHT+IGHGKNVwKDhX53SClAiCjkrZ6qsf/LB1PPJ8WE5H9+dd/xZBgKvhmpJf+YIQ1gnAdG/+V+ElCkxebGxerlQJYk=
X-Received: by 2002:a25:9a84:0:b0:da0:3ec1:f3f with SMTP id
 s4-20020a259a84000000b00da03ec10f3fmr1099463ybo.3.1700520775796; Mon, 20 Nov
 2023 14:52:55 -0800 (PST)
MIME-Version: 1.0
References: <93b5e861-c1ec-417c-b21e-56d0c4a3ae79@I-love.SAKURA.ne.jp>
In-Reply-To: <93b5e861-c1ec-417c-b21e-56d0c4a3ae79@I-love.SAKURA.ne.jp>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 20 Nov 2023 17:52:44 -0500
Message-ID: <CAHC9VhRbak9Mij=uKQ-Drod0tQu1+Z+JaahUzH5uj9JUf7ZTuA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/4] LSM: Officially support appending LSM hooks
 after boot.
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-security-module <linux-security-module@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, KP Singh <kpsingh@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>, song@kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>, renauld@google.com,
        Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Nov 20, 2023 at 8:28=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> This functionality will be used by TOMOYO security module.
>
> In order to officially use an LSM module, that LSM module has to be
> built into vmlinux. This limitation has been a big barrier for allowing
> distribution kernel users to use LSM modules which the organization who
> builds that distribution kernel cannot afford supporting [1]. Therefore,
> I've been asking for ability to append LSM hooks from LKM-based LSMs so
> that distribution kernel users can use LSMs which the organization who
> builds that distribution kernel cannot afford supporting.

It doesn't really matter for this discussion, but based on my days
working for a Linux distro company I would be very surprised if a
commercial distro would support a system running unapproved
third-party kernel modules.

We've talked a lot about this core problem and I maintain that it is
still a disto problem and not something I'm really concerned about
upstream.

--=20
paul-moore.com
