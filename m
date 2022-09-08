Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11EA8C6FA86
	for <linux-security-module@archiver.kernel.org>; Thu,  8 Sep 2022 15:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiIHP0J (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 8 Sep 2022 11:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232619AbiIHPZs (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 8 Sep 2022 11:25:48 -0400
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86C6AE879
        for <linux-security-module@vger.kernel.org>; Thu,  8 Sep 2022 08:25:38 -0700 (PDT)
Received: by mail-qk1-f175.google.com with SMTP id b2so13129688qkh.12
        for <linux-security-module@vger.kernel.org>; Thu, 08 Sep 2022 08:25:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=We7YdNWL+dA6SvrcsgfeWC+uhCMnz0P9xITf03yypx8=;
        b=z3k8UKhZTZSBIzbt+DHHMFWJY8KhLq6gzD6Iv7IQJhNwMLeGbg21FLafzjcYEKWt4A
         QGpn6SwN8wYXXfFX3jS4Gom3cUWPPTx+TUDg8ByhBc6N7KKzXzfrHr04+O3d/GD0XFLa
         1XB3qUWNbSowRv3ZJEGBI+VuHHOEoR69ZZUDsUzseW3a8EF0ZkJSTE5C4nz7HF4YWNvR
         kBjekPt5mvwRI1/51A14qIhdvm/f0D/ydVTSs/Nf91z5PEAe6GT58xAyLKx6aR+tZtEh
         jzMe6K29rQpXf3fe5Qdr9RflmUA/ZnHiAZ5Na0yB+08Pv/034nA0ki8hW87UFOQho8zW
         VZ8g==
X-Gm-Message-State: ACgBeo31i6sWaLOBK/OVVst88wsw+oS/M98y/Bp7ly60LdJOMAmE/nAf
        1c0atPVsPId4UnTeyRU5sL9m
X-Google-Smtp-Source: AA6agR786+XZqALGz47aUlYlRGU0gUHtl1jtiHS/dbi/BYJRHk2Rm8IwMyj9N3uQYj24nkxsh4cIdA==
X-Received: by 2002:a05:620a:2451:b0:6cb:b4db:a3ad with SMTP id h17-20020a05620a245100b006cbb4dba3admr5003410qkn.216.1662650737962;
        Thu, 08 Sep 2022 08:25:37 -0700 (PDT)
Received: from localhost (pool-68-160-173-162.bstnma.fios.verizon.net. [68.160.173.162])
        by smtp.gmail.com with ESMTPSA id s13-20020a05620a0bcd00b006bb82221013sm17379003qki.0.2022.09.08.08.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 08:25:37 -0700 (PDT)
Date:   Thu, 8 Sep 2022 11:25:36 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     agk@redhat.com, mka@chromium.org, dm-devel@redhat.com,
        dianders@chromium.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, sarthakkukreti@chromium.org
Subject: Re: dm: verity-loadpin: Only trust verity targets with enforcement
Message-ID: <YxoJcG5MN4OdaulL@redhat.com>
References: <20220907133055.1.Ic8a1dafe960dc0f8302e189642bc88ebb785d274@changeid>
 <166259004596.4128104.7200162640366282166.b4-ty@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166259004596.4128104.7200162640366282166.b4-ty@chromium.org>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Sep 07 2022 at  6:34P -0400,
Kees Cook <keescook@chromium.org> wrote:

> On Wed, 7 Sep 2022 13:30:58 -0700, Matthias Kaehlcke wrote:
> > Verity targets can be configured to ignore corrupted data blocks.
> > LoadPin must only trust verity targets that are configured to
> > perform some kind of enforcement when data corruption is detected,
> > like returning an error, restarting the system or triggering a
> > panic.
> > 
> > 
> > [...]
> 
> Applied to for-next/hardening, thanks!
> 
> [1/1] dm: verity-loadpin: Only trust verity targets with enforcement
>       https://git.kernel.org/kees/c/2e1875c05267

Does this mean you're intending to send this upstream?  I prefer to
take all DM changes unless there is an external dependency.

Thanks,
Mike
