Return-Path: <SRS0=kUy5=MQ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1EEC00449
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Oct 2018 00:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A43F8213A2
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Oct 2018 00:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RTLjzHrG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A43F8213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbeJDGyg (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 4 Oct 2018 02:54:36 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:46567 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbeJDGyf (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 4 Oct 2018 02:54:35 -0400
Received: by mail-yw1-f66.google.com with SMTP id j202-v6so3055738ywa.13
        for <linux-security-module@vger.kernel.org>; Wed, 03 Oct 2018 17:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bmL0ZyPC0ChRPdmL9WJ4CMlC25RswfvQYlntOSokPnQ=;
        b=RTLjzHrG8qvsQTgyIVVQqV6vJZzXuH9f2wd/G/9lwZ40a33lEHc2JFkqQcRsDx61pZ
         xb8z/BZ77fd0a2XR90Ro6efOirtKv69bnQmAFOqXllOX+7gVRFWIVYf0Y49/r1ylogZF
         KT8RV2XSFIr4MH2wwUsb2+v7tttgoDzdaffzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bmL0ZyPC0ChRPdmL9WJ4CMlC25RswfvQYlntOSokPnQ=;
        b=CAy1wsGOIbVpRSp2ctYrhCcwbrDCopr6dGo85w/sTCtlzrFJyqfDHhTZMPA+U+DiCN
         0NqvaMX13whSalQNoawCtOMKyiFJSy1H+5SHL/BRp5tXoZfPe5zligtnyaXIkb1x9PJZ
         p4q7UhMlao/hc+hfMILgZe4t1KLED9bEeeYesFart33mcyqmJTyh1S44upRupMv+HGvl
         yNETdxx/KApZd/d/cnQKuUDqB9pBxzRMoMMZ9JjsLq9VlVwIxi3twPio0GeZPEPMjI/n
         03/BFMUeBKJO//7WbeIH1eMnxfh25d5OUzWjMANKwJJMXugOGewf+GBnbxey4t8lbV57
         Bpjg==
X-Gm-Message-State: ABuFfojWe8PtgHoYPifs/aQwxRlCIKj+IvCuyy+ID4dxfV26CUUWCICh
        d+7cosF6eQ6RGtL492oIYZsRKT+ZGQI=
X-Google-Smtp-Source: ACcGV60gMKr7yblCNg6L/7UcH3DaO67M+rpa9+yQ0eBrTPXCRha/XyPmXKqpcA4XlX6rVJEsMhVvTw==
X-Received: by 2002:a81:7407:: with SMTP id p7-v6mr2248208ywc.401.1538611436649;
        Wed, 03 Oct 2018 17:03:56 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id r12-v6sm1015421ywg.67.2018.10.03.17.03.55
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 17:03:55 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id 5-v6so3194485ybf.3
        for <linux-security-module@vger.kernel.org>; Wed, 03 Oct 2018 17:03:55 -0700 (PDT)
X-Received: by 2002:a25:640a:: with SMTP id y10-v6mr2344354ybb.421.1538611434689;
 Wed, 03 Oct 2018 17:03:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Wed, 3 Oct 2018 17:03:53 -0700 (PDT)
In-Reply-To: <6037a1f0-7af1-9847-91f6-6444f04f5b21@infradead.org>
References: <20181002005505.6112-1-keescook@chromium.org> <809f1cfd-077b-ee58-51ba-b22daf46d12b@tycho.nsa.gov>
 <QpdcE4QSCQKJqDmB2QBEGBlnlioHuRHlM0g5HF8KbHjU1zIUAOjnQ2r9EIMu3m0S2OWNR3_M_TSp_M6CVDqkp6kKuFPUvegsyDPNw1AGju4=@protonmail.ch>
 <CAGXu5jKqXNbEvPr1axQtGCCnWsGhDgjynW5u326mcx4vZ1oH8g@mail.gmail.com>
 <abe03d09-4dcb-2b02-4102-5e108d617a42@canonical.com> <CAGXu5jJtC1gkJ0ZKDFroL8UzvjiPfmC+6EsrzyB0j0oETdSQQg@mail.gmail.com>
 <alpine.LRH.2.21.1810030758460.23596@namei.org> <CAGXu5jLKgrdhah-5TtAXDL-odbLGeyAUH2=PkAU769AkEnZFfQ@mail.gmail.com>
 <5955f5ce-b803-4f58-8b07-54c291e33da5@canonical.com> <alpine.LRH.2.21.1810040416500.13517@namei.org>
 <CAGXu5j+oPR58oJ06-n7e96-Rmu+ywTW0hud5LhOZ_3UXG5s12w@mail.gmail.com>
 <alpine.LRH.2.21.1810040427550.13517@namei.org> <CAGXu5jJmVR4Wsdti=aFaDhCBaxsVu1KTJOdsJOtFvZOV1ZhdvQ@mail.gmail.com>
 <alpine.LRH.2.21.1810040723320.16168@namei.org> <CAGXu5jJDBhFrdCBHH4MZVDmG88mMxSaSx0w9anCcyx24YHLO5w@mail.gmail.com>
 <6037a1f0-7af1-9847-91f6-6444f04f5b21@infradead.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 3 Oct 2018 17:03:53 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKGtNYXkFQVxOM9M1fdgaZcki6NqfJAtE0_VsG75Ku=HQ@mail.gmail.com>
Message-ID: <CAGXu5jKGtNYXkFQVxOM9M1fdgaZcki6NqfJAtE0_VsG75Ku=HQ@mail.gmail.com>
Subject: Re: [PATCH security-next v4 23/32] selinux: Remove boot parameter
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     James Morris <jmorris@namei.org>,
        John Johansen <john.johansen@canonical.com>,
        Jordan Glover <Golden_Miller83@protonmail.ch>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Oct 3, 2018 at 4:59 PM, Randy Dunlap <rdunlap@infradead.org> wrote:
> To me, "security=selinux" means SELinux and nothing else, so I think that
> all of these params are inviting a lot of confusion.
>
> Sorry, I don't have a good answer for this.

This part, at least, has a pretty clear solution. :) The consensus is
to limit "security=" to what have been considered the "major" LSMs" so
it'll work in spirit the way it was designed. The goal of the new
options, though, is to find something that'll fit all the ways LSMs
are getting used: the majors, the minors, and the coming "medium"
LSMs. The precedent is pretty good here, since "security=" already
ignores the minor LSMs: Yama and LoadPin. So it'll just control the
enable/disable of the "major" LSMs, who will carry an internal marking
indicating that they're mediated by "security=" (and no new LSMs would
get this marking).

-Kees

-- 
Kees Cook
Pixel Security
