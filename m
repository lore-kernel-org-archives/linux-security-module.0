Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D62D9C7EE24
	for <linux-security-module@archiver.kernel.org>; Tue, 30 May 2023 22:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbjE3Wzl (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 30 May 2023 18:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbjE3Wzl (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 30 May 2023 18:55:41 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F37E5
        for <linux-security-module@vger.kernel.org>; Tue, 30 May 2023 15:55:39 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-64d5b4c3ffeso3711401b3a.2
        for <linux-security-module@vger.kernel.org>; Tue, 30 May 2023 15:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685487339; x=1688079339;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BkBhxE3ytz2kF3tpYV9IN2L47NlunYx7yD1fvIugVDg=;
        b=JkL4TkmaBIayj5OCIMW991JmgQnj/gOpmqu0Jw8iYq3PMtBsrylqK5iciUUO1fhYgS
         2o7CARmlg2bDXlKcJclJ9S/L2d10IK4UribgkAI3rT5ddfJwfkzp232e3xf8cjAq3sQt
         imoZlKZvz+c0GKoP6pL6IeBJqKSiae+R/iNng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685487339; x=1688079339;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BkBhxE3ytz2kF3tpYV9IN2L47NlunYx7yD1fvIugVDg=;
        b=H3so5BUrXOXHbVeoRmdqqec9Ah6Q2syYsLRpXu95V4onTRT7RJ3XS8yCfmeVp7mFJs
         Q8Vleu4cbqN8N2UbzYiMjqXVvtuVznXirc6hX2J9y1Ak8XInGVFPMLM7WUq2W/MS6r1O
         omHrG5AwVV3oFRc8PYFX2ogQy13mvJWZm8RE81rZ+bLjg+cc/kGGLkcXtFILCviE0ZjR
         nxz/TdMHMdXcCyhGcycLYUoMu7bGXTwmtJHHOuc1K9sAfdX05P+J/88vvwPYzi/9VHQP
         wZ3lbeO9YbNSC4oVDHNff4LOt125mOc5Vh33iE90WtBmMxvsiSZq+n+qX9donD8qC4jL
         p68A==
X-Gm-Message-State: AC+VfDyH365K9ET9j5cXyr9VUetvdmDM3wdFIBdLSy3r8h2FkltqSW9y
        ZspDU4rkP1zp+8yiSQCTd8t+r9fxG8HNQLNshZY=
X-Google-Smtp-Source: ACHHUZ4QeCYlGPt+yRrQ988Mpa4bp68BlE3Y+Yn/n1L6hGlqQLXCt+xE8FWGrglyjI0IqtiDNi9FTQ==
X-Received: by 2002:a05:6a00:2e12:b0:640:defd:a6d5 with SMTP id fc18-20020a056a002e1200b00640defda6d5mr4441213pfb.12.1685487338720;
        Tue, 30 May 2023 15:55:38 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s22-20020a63dc16000000b005344b30d449sm9336232pgg.86.2023.05.30.15.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 15:55:38 -0700 (PDT)
Date:   Tue, 30 May 2023 15:55:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     John Johansen <john.johansen@canonical.com>
Cc:     "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, apparmor@lists.ubuntu.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] apparmor: aa_buffer: Convert 1-element array to flexible
 array
Message-ID: <202305301555.102E1890@keescook>
References: <20230511213441.never.401-kees@kernel.org>
 <7085879d-4d21-b90a-c08d-60450d1c7d38@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7085879d-4d21-b90a-c08d-60450d1c7d38@canonical.com>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, May 11, 2023 at 02:48:29PM -0700, John Johansen wrote:
> On 5/11/23 14:34, Kees Cook wrote:
> > In the ongoing effort to convert all fake flexible arrays to proper
> > flexible arrays, replace aa_buffer's 1-element "buffer" member with a
> > flexible array.
> > 
> > Cc: John Johansen <john.johansen@canonical.com>
> > Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
> > Cc: Paul Moore <paul@paul-moore.com>
> > Cc: James Morris <jmorris@namei.org>
> > Cc: "Serge E. Hallyn" <serge@hallyn.com>
> > Cc: apparmor@lists.ubuntu.com
> > Cc: linux-security-module@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Acked-by: John Johansen <john.johansen@canonical.com>
> 
> I have pulled this into my tree.

Just a quick ping: I haven't seen this show up in -next yet...

-- 
Kees Cook
