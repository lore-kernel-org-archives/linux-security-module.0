Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E74C4332F
	for <linux-security-module@archiver.kernel.org>; Mon, 13 Nov 2023 04:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233088AbjKMEFX (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 12 Nov 2023 23:05:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233096AbjKMEFW (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 12 Nov 2023 23:05:22 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D894B19B4
        for <linux-security-module@vger.kernel.org>; Sun, 12 Nov 2023 20:05:19 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d9beb865a40so4072910276.1
        for <linux-security-module@vger.kernel.org>; Sun, 12 Nov 2023 20:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1699848319; x=1700453119; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/IimyzO8UeKvX2XarfS7G4frLJCjZBBrX6acVl4LG9w=;
        b=AkPxihpioVA82wEHEX90nnY/WUSAgbGy7PJWL2dOc8rYEFZSZ3bWiDDUF/udESbWMC
         pd9XdnPP2LKFyAFOjfX8mJzJPy2uMV/mN6eYSp+OEp1LlAbpVxZHzLWJ3HPLVTk/+bId
         ng0srh9w6Lwh8WnByriCfuCycn738NhBRFL9isW6AGsITeiCzAVPEBtbQBIgWLkIul1P
         qL0vuaPGfak/1HtZqvbTC+/0LdsBcYJZU9tVcfnlh2bPD835sMQt+gA3Xo1vvkJgbiMs
         tJlFRBWGcoAuGXwDmHP3/mqwOMij8WAwUkHCv1LRDdPTKNkOd78vsPI59ly7jRd4eTq2
         Wdkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699848319; x=1700453119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/IimyzO8UeKvX2XarfS7G4frLJCjZBBrX6acVl4LG9w=;
        b=EB0n5gW1OAa337iZfDYesCAQ+wSSX2qorfLaCswLcydNNTVTpmDNULBCZtiYoqBWrs
         xgfJdhNonXI6lu7MZuEjDxCdVQqpgjSOnVJ6IKK+FGkH2JZJZqKsPwtSajmePFfd1aSI
         5tnDXF4HI15sN3+6IsgVEY3vxaNLHjXVEyOjgXxDFzo5TRxe9RHvrvfRc2UMcF3YHWjJ
         SLe5LfscZdUXHnVMhKG/5tCPz/+3IJeArrqxy9Yh3SJuhU8fTNwdcF0hzkKJjhZzmsgy
         Mbsyv3MsKnYewdVy0kqyGWLwZ1JyTaRiEEagPS+sfrZZFMzpmUnHWaEIKE/yBQxAlh1F
         wgfA==
X-Gm-Message-State: AOJu0Yxelrstg0uB7hEH2S5wBl4uTYXfMZ8cmhuK9u/lQmJCcUJYNJSH
        VDXEoDjYan1FaZbsfFtQDh8pV63bNNB5nzMqHug5uw1YWQQgadA=
X-Google-Smtp-Source: AGHT+IGEyZHA7rI+VMJ2rL9izxu0ZEFsg+OznVAZQV0hri4IaLCd889s10yk891C+sneV3IvTIsLsO5GXwA5mkX6WMc=
X-Received: by 2002:a25:aa2c:0:b0:d9c:aa17:2ae3 with SMTP id
 s41-20020a25aa2c000000b00d9caa172ae3mr4966453ybi.64.1699848318843; Sun, 12
 Nov 2023 20:05:18 -0800 (PST)
MIME-Version: 1.0
References: <20231018215032.348429-2-paul@paul-moore.com>
In-Reply-To: <20231018215032.348429-2-paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 12 Nov 2023 23:05:07 -0500
Message-ID: <CAHC9VhRRU6UKGeMhNV0QfW50YtUED=KmzjEpswz_0KQasKxbqg@mail.gmail.com>
Subject: Re: [PATCH] lsm: drop LSM_ID_IMA
To:     linux-security-module@vger.kernel.org
Cc:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Oct 18, 2023 at 5:50=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> When IMA becomes a proper LSM we will reintroduce an appropriate
> LSM ID, but drop it from the userspace API for now in an effort
> to put an end to debates around the naming of the LSM ID macro.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  include/uapi/linux/lsm.h | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)

Merged into lsm/dev.

--=20
paul-moore.com
