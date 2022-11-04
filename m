Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E61E3C4332F
	for <linux-security-module@archiver.kernel.org>; Fri,  4 Nov 2022 18:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbiKDSfc (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 4 Nov 2022 14:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbiKDSfb (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 4 Nov 2022 14:35:31 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A0C4AF2D
        for <linux-security-module@vger.kernel.org>; Fri,  4 Nov 2022 11:35:29 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id o7so5254386pjj.1
        for <linux-security-module@vger.kernel.org>; Fri, 04 Nov 2022 11:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VI9dLZqr4phcLu/et/iVRa9n3ErWpwIc+07/b50LvBM=;
        b=eSmCdWYUo+MFol9rpoHIO4A3jWbVg5gjgrxdtvSvXcxpFOvgpn9xN9wC+fN6yyl1vV
         ppeLBE/m++6rQfxfGFY1nnD319PbUjzI6Wz6hFJdD+qIqtWg5GNX5WtM/tNVzdJqRF/a
         bVPGV4ssXA6he9ggcTxi1eOvdJjniUyQ3m9xo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VI9dLZqr4phcLu/et/iVRa9n3ErWpwIc+07/b50LvBM=;
        b=U0obd2IB4ZOkF9U7pfFadD4ruIvTAiWikSwuN5vVsRTOICedipxqkBmF+7hICkEWtH
         HI0F+XPmSOVy2mO6fByJgwJcnfnMQCePbSPSZzGAShphJWnSRr8Z6XhZ1Mju3H+Q8oTr
         Z3kMZWG8Nj4GnsuzQKGFz822ZFxCfhozT59aGzXCV4p6zZN9p6mlHOg3HxEY7epFUZjO
         zzR/+0eJwHvYqhoN152uJRVwWbMZ1S1a56w2c2fR0rdmr3EBXYJe4j+rPJzfdM4ikz2C
         /wcGbEbulrHFw7UBOMJ8IUgnVILprJzHhVpjyHZHxbNq9DkgRUCfizeKaf0kukutXWo7
         WluA==
X-Gm-Message-State: ACrzQf0mYBEiGXR1Mjsrc90zSh1I9Jz9wKUVbANbyF87BX83pyYVZzQI
        z909I3Ldfc1fjrxFOhtLMjbWhg==
X-Google-Smtp-Source: AMsMyM6fb+TEh9BarhrBk28d3mb/yd1nmOCqWa0q+90fvf1SgZpDv75w3DFTiADbQBgXSzOJalHd2A==
X-Received: by 2002:a17:90b:3b4a:b0:213:589d:d300 with SMTP id ot10-20020a17090b3b4a00b00213589dd300mr37724237pjb.139.1667586929205;
        Fri, 04 Nov 2022 11:35:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id jf9-20020a170903268900b001868bf6a7b8sm81457plb.146.2022.11.04.11.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 11:35:28 -0700 (PDT)
Date:   Fri, 4 Nov 2022 11:35:28 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Evan Green <evgreen@chromium.org>
Cc:     linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-pm@vger.kernel.org, rjw@rjwysocki.net, gwendal@chromium.org,
        apronin@chromium.org, Pavel Machek <pavel@ucw.cz>,
        Matthew Garrett <mgarrett@aurora.tech>,
        linux-integrity@vger.kernel.org, jejb@linux.ibm.com,
        zohar@linux.ibm.com, dlunev@google.com,
        Eric Biggers <ebiggers@kernel.org>,
        Ben Boeckel <me@benboeckel.net>, jarkko@kernel.org,
        Matthew Garrett <mjg59@google.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E. Hallyn" <serge@hallyn.com>, axelj <axelj@axis.com>,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v4 06/11] security: keys: trusted: Verify creation data
Message-ID: <202211041135.0B18C14@keescook>
References: <20221103180120.752659-1-evgreen@chromium.org>
 <20221103105558.v4.6.I6cdb522cb5ea28fcd1e35b4cd92cbd067f99269a@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103105558.v4.6.I6cdb522cb5ea28fcd1e35b4cd92cbd067f99269a@changeid>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Nov 03, 2022 at 11:01:14AM -0700, Evan Green wrote:
> If a loaded key contains creation data, ask the TPM to verify that
> creation data. This allows users like encrypted hibernate to know that
> the loaded and parsed creation data has not been tampered with.
> 
> Suggested-by: Matthew Garrett <mjg59@google.com>
> Signed-off-by: Evan Green <evgreen@chromium.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
