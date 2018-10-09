Return-Path: <SRS0=78tV=MV=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E64C6787A
	for <linux-security-module@archiver.kernel.org>; Tue,  9 Oct 2018 01:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78DDA2075E
	for <linux-security-module@archiver.kernel.org>; Tue,  9 Oct 2018 01:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Cr7d8QAz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78DDA2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbeJIIyo (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 9 Oct 2018 04:54:44 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:38200 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbeJIIyl (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 9 Oct 2018 04:54:41 -0400
Received: by mail-yw1-f65.google.com with SMTP id d126-v6so8912099ywa.5
        for <linux-security-module@vger.kernel.org>; Mon, 08 Oct 2018 18:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7qA+dtOcdI9urqDaS/IIx7h3l7wueuGPmWbY8bS/3GU=;
        b=Cr7d8QAz0kukYdX0iBqB5KVdL/yUDjRmOJyD2dc6Vca6WvhfsP421Td/pzu5oqOyHg
         vWlxQnjXCC7v55mqc/rDdr5wc7MeIxqZ7muGiZA+v5x01nSspt/SnK8V1DwKWl6Gkwbm
         uO8CQq0kdGPN3kyueDJcm9Vjm72pamEF8xH0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7qA+dtOcdI9urqDaS/IIx7h3l7wueuGPmWbY8bS/3GU=;
        b=hvVr83vx/xqpGXx31UoaHR8DQzGIoND7iH0HTiRtg7g0QSVFoF85dbKO+lDDh2kO+O
         Fy0og42qUMgOCPbmKnA+XTB+X5BSMBY+idgTUmk99GzmUjC9ts16IyM9GFBtkiX8xCDC
         XZu5xnqcfXC5gAq4Ea6xd7EBsUvqRtAtnix01wiK96W9aLZwhdLY+tLDTLsPUQwukM9A
         vkTp0TAqTCRa5cySHftnayTz/YXAkXCRwnOaMqXTcok1XGEh9jHGNkyltRhZ0oajxpKL
         hoVGpzU4qo0bPEvbtWY8jSDmf5uOZIqSiRtLbFWMQ/TTWM8ha15+9+yAI9T0OFbx/Lz4
         GMdw==
X-Gm-Message-State: ABuFfoiY3pHGNGcEyEZnEo0JVwHZx0GwBtxk9/WAjrWeu4ICNPBce6kG
        LciM3QNIJGrL+TQfDANqayltZVn3JFw=
X-Google-Smtp-Source: ACcGV62gGQqqIFaGWbns4Cistzf3k+SkJhMblV22OEESSp4mf05HYbdqYwDp3q7OF/yYObRBirVrug==
X-Received: by 2002:a81:360b:: with SMTP id d11-v6mr14380398ywa.365.1539049210982;
        Mon, 08 Oct 2018 18:40:10 -0700 (PDT)
Received: from mail-yw1-f43.google.com (mail-yw1-f43.google.com. [209.85.161.43])
        by smtp.gmail.com with ESMTPSA id l30-v6sm24348607ywa.104.2018.10.08.18.40.09
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 18:40:09 -0700 (PDT)
Received: by mail-yw1-f43.google.com with SMTP id d126-v6so8912069ywa.5
        for <linux-security-module@vger.kernel.org>; Mon, 08 Oct 2018 18:40:09 -0700 (PDT)
X-Received: by 2002:a81:98cb:: with SMTP id p194-v6mr14391598ywg.353.1539049208850;
 Mon, 08 Oct 2018 18:40:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Mon, 8 Oct 2018 18:40:08 -0700 (PDT)
In-Reply-To: <c06eb47c-05d3-f51c-625b-9bfdd33a426a@infradead.org>
References: <c06eb47c-05d3-f51c-625b-9bfdd33a426a@infradead.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 8 Oct 2018 18:40:08 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+B82dt9KvO0UVMBLoFxZEZF76xic4Sz41HtVfKHWpwWQ@mail.gmail.com>
Message-ID: <CAGXu5j+B82dt9KvO0UVMBLoFxZEZF76xic4Sz41HtVfKHWpwWQ@mail.gmail.com>
Subject: Re: [PATCH] security: fix LSM description location
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Oct 8, 2018 at 5:46 PM, Randy Dunlap <rdunlap@infradead.org> wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
>
> Fix Documentation location reference for where LSM descriptions should
> be placed.
>
> Suggested-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: linux-security-module@vger.kernel.org

Thanks!

Acked-by: Kees Cook <keescook@chromium.org>

Jon, can you take this?

-Kees

> ---
>  Documentation/security/LSM.rst |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- lnx-419-rc7.orig/Documentation/security/LSM.rst
> +++ lnx-419-rc7/Documentation/security/LSM.rst
> @@ -5,7 +5,7 @@ Linux Security Module Development
>  Based on https://lkml.org/lkml/2007/10/26/215,
>  a new LSM is accepted into the kernel when its intent (a description of
>  what it tries to protect against and in what cases one would expect to
> -use it) has been appropriately documented in ``Documentation/security/LSM.rst``.
> +use it) has been appropriately documented in ``Documentation/admin-guide/LSM/``.
>  This allows an LSM's code to be easily compared to its goals, and so
>  that end users and distros can make a more informed decision about which
>  LSMs suit their requirements.
>
>



-- 
Kees Cook
Pixel Security
