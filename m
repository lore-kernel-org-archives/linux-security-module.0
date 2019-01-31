Return-Path: <SRS0=hRTQ=QH=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 909F2C169C4
	for <linux-security-module@archiver.kernel.org>; Thu, 31 Jan 2019 21:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 555AA20881
	for <linux-security-module@archiver.kernel.org>; Thu, 31 Jan 2019 21:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bU54MRsW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725802AbfAaV0Z (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 31 Jan 2019 16:26:25 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:33600 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfAaV0Z (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 31 Jan 2019 16:26:25 -0500
Received: by mail-io1-f68.google.com with SMTP id t24so4022664ioi.0
        for <linux-security-module@vger.kernel.org>; Thu, 31 Jan 2019 13:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P4FPF0QNQYCyFs+NK8F5CiL19ODxqjaCckjuJqg3XCU=;
        b=bU54MRsW2WpAeufD9f8FKIE52aAWmQ8iEUUfEmCiifO9RJ/okb7iLOrUGEGngNAKhI
         vJeOA4Rqd6hfvUzjUKRpMsQ0GbB91EWTGA6D0qKWTrxnhrODdgbOqDeJwiYvC9NEZ5NF
         XOpie1QDU/k3MAcxCg4vyfIV2WTl7YXL687BKYQ94AX4CNebppFG1mfANO4iJ9k9LCr5
         UEchfzJ5CmgkNkEQbg0k7dHQ5lStAf457MLqgiFJ5HxbffX3ZnJRZz6EslbYo0X4GW/2
         MoWY6uwnUu4Bjj1VkVO+zvL6r2GHWu3lvmu2tvFMRyjNg+jSJzuuGLLoQ7SynMQn082C
         mA4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P4FPF0QNQYCyFs+NK8F5CiL19ODxqjaCckjuJqg3XCU=;
        b=HgKXHo6jFEvmvnQGrZBhFqkgTO8Xso/wrPTYwBDbAsaNpTrQbh8c2yHB3WmAchQkgg
         B0/FO+IGR472dmD3GoC/7RuznrJ79DIs2g3CqiugCpaqYg87bL17UOyFlgb0d44BvB87
         PP9U6EfRaJrmK4BKXtsWV6lm3OiZRQGfvMNNZzMIT5/UdT4MtsebDNyyAOgd+3LMCvDi
         1HfnxvlEdi3wcR+gV8p/zN+oCpbiUYWJDE0nKMoJmNJxO+p5Ykph+z3jt/4eR81hcz6y
         oWA87Wwyu9+tY4nOUSVVfoXmPheKiIyfezmP6PoXp+BokrtsOMFncVjJcHkgGS9INNnC
         drZw==
X-Gm-Message-State: AJcUukfb6MFxMHmsDdK4kJwbdKOfe5w4kyQqpvfbqGnoOi6Waq7I8Naw
        m1D0e4HpBxPNHvmPDMlI9nsSFHdH60kw7dU7/CuR1g==
X-Google-Smtp-Source: AHgI3IbQy40FlH9K6nTaHeYIz5qHmAyog3l+37dPtL/ixIL81I044gfCuauSfKiCzNbSplQrNUY0g/U5H+7mBx40uAs=
X-Received: by 2002:a6b:c386:: with SMTP id t128mr21574283iof.304.1548969984018;
 Thu, 31 Jan 2019 13:26:24 -0800 (PST)
MIME-Version: 1.0
References: <1548957686-534-1-git-send-email-zohar@linux.ibm.com>
In-Reply-To: <1548957686-534-1-git-send-email-zohar@linux.ibm.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Thu, 31 Jan 2019 13:26:13 -0800
Message-ID: <CACdnJuvJqk24-WeZ9WqC0Ad4rRQPv-u_rvFtAifN1RO=_sobxA@mail.gmail.com>
Subject: Re: [PATCH] ima: remove CREDS_CHECK fall through
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     LSM List <linux-security-module@vger.kernel.org>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Jan 31, 2019 at 10:02 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> This patch fixes the CREDS_CHECK fall through as annotated in the
>  "security mark expected switch fall-throughs" patch.
>
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> Cc: Gustavo A. R. Silva <gustavo@embeddedor.com>
> Cc: Matthew Garrett <mjg59@google.com>
Acked-by: Matthew Garrett <mjg59@google.com>
