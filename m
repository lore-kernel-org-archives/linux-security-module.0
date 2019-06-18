Return-Path: <SRS0=MF6I=UR=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F16C31E51
	for <linux-security-module@archiver.kernel.org>; Tue, 18 Jun 2019 07:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3653E20679
	for <linux-security-module@archiver.kernel.org>; Tue, 18 Jun 2019 07:20:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y3HKJITK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbfFRHUD (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 18 Jun 2019 03:20:03 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33367 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfFRHUD (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 18 Jun 2019 03:20:03 -0400
Received: by mail-oi1-f193.google.com with SMTP id q186so8331793oia.0
        for <linux-security-module@vger.kernel.org>; Tue, 18 Jun 2019 00:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KBk0vI4RQMrq25uWSdJ+2ep8omPhMVPkB3j/qaHLhoE=;
        b=Y3HKJITKouhlh1TaWa8IWuAVIdnIJ3wgmjU7crc90t1KDNlYYvSLwj18Z0zor9/CM7
         15NCMxEnt9WljXbe3UmAHttwdlrKLaCbiCPf0CFYydlVSL+a5h3Fnj5GWUqU2aBl0lft
         KhcoBYkCUzUb3OOk5cRxE9pLL16NEkLvSrj6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KBk0vI4RQMrq25uWSdJ+2ep8omPhMVPkB3j/qaHLhoE=;
        b=CdCLZAuyjVEMh41aEkT1A+cAKmfOIlx6ru9jbkQeEcbbzc1QwC11wgWhxdE3D04kHj
         rMFzPegMCHEeETMHfR8kBnMPATJPbUGukHYKE0t+jTM/hADaOgXG3T4N028RgETwf3Vw
         DPwxBC7ap77hGilj+c3DiQvux/HB4JmyLQGxKcc2Vg7iHC7vRwbsYe5x8kfF+NVAhG3g
         Ny3f6t4yA4c0e4/aSZ7QrlJD1jYnkvU/y64env+vRAJrklqxfOUZ7E7QKj8Au9Zkd6gd
         Gnl/8ybjJ+0PePEGvCgg5GRcLaWXDzls2iTLorAKfbktbAxNacsGJfdS6ItKW+gJ9iDW
         47Ng==
X-Gm-Message-State: APjAAAWKAUr2HfVREoJrA7ZbOPlNEa2hNdjJW39C4H+5/rzS80G3mD/o
        mFUgBM/gGi50JugpAK1cwnRXCZa3G8P4+w==
X-Google-Smtp-Source: APXvYqxsGDOAjuyeiUBQQfKlHRpkhzSzNh4pYCucZFBzZqr6L06keNW+FE4qiWVrESZjwyeODy5DBQ==
X-Received: by 2002:a63:1d1d:: with SMTP id d29mr956576pgd.259.1560835616920;
        Mon, 17 Jun 2019 22:26:56 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q198sm18025478pfq.155.2019.06.17.22.26.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Jun 2019 22:26:56 -0700 (PDT)
Date:   Mon, 17 Jun 2019 22:26:54 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Christoph Lameter <cl@linux.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Hocko <mhocko@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Sandeep Patil <sspatil@android.com>,
        Laura Abbott <labbott@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jann Horn <jannh@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marco Elver <elver@google.com>, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: Re: [PATCH v7 1/2] mm: security: introduce init_on_alloc=1 and
 init_on_free=1 boot options
Message-ID: <201906172225.4645462F1E@keescook>
References: <20190617151050.92663-1-glider@google.com>
 <20190617151050.92663-2-glider@google.com>
 <20190617151027.6422016d74a7dc4c7a562fc6@linux-foundation.org>
 <201906172157.8E88196@keescook>
 <20190617221932.7406c74b6a8114a406984b70@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617221932.7406c74b6a8114a406984b70@linux-foundation.org>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jun 17, 2019 at 10:19:32PM -0700, Andrew Morton wrote:
> On Mon, 17 Jun 2019 22:07:41 -0700 Kees Cook <keescook@chromium.org> wrote:
> 
> > This is expected to be on-by-default on Android and Chrome
> > OS. And it gives the opportunity for anyone else to use it under distros
> > too via the boot args. (The init_on_free feature is regularly requested
> > by folks where memory forensics is included in their thread models.)
> 
> Thanks.  I added the above to the changelog.  I assumed s/thread/threat/

Heh whoops, yes, "threat" was intended. Thanks! :)

-- 
Kees Cook
