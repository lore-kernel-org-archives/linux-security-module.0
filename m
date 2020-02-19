Return-Path: <SRS0=QiiV=4H=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 694A3C34047
	for <linux-security-module@archiver.kernel.org>; Wed, 19 Feb 2020 15:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F1BC2465D
	for <linux-security-module@archiver.kernel.org>; Wed, 19 Feb 2020 15:54:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hCbOktmi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgBSPyQ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 19 Feb 2020 10:54:16 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37275 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgBSPyP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 19 Feb 2020 10:54:15 -0500
Received: by mail-ot1-f65.google.com with SMTP id w23so590672otj.4
        for <linux-security-module@vger.kernel.org>; Wed, 19 Feb 2020 07:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lxARnBor1U+6So+HrMWf9Gk7N+daPrHbJnbZhnhwrnE=;
        b=hCbOktmi3YliRq0ScBXSNUesHyAqvCL12c5uWO6XJNi9n/y2ahYy8f6c/hN9HhkUp6
         NtGyeKNDq17KU1oflZcGFavHZ0yak7eV3txHutBNLTY+fhuz//0QGxRkoWIV07omcEfA
         pV2jnT0owxB53J3tC25KDX6npdI6rpYslOVlEcpoDIMBKSsQQwz65+OTQrTbhk+C91KH
         1egcT0uxQa4IR7ZPjdBFsZarSM4W8MpTmZQCyLXSB+NtwqZcQBCMtj55+3PKd8Ts8PoK
         t5d3X57H5eosvrejeqcBMmaMblxiDL8WOSJRKe0vQsPwInYir9WHgpdZ7zxw5ZYJrLkr
         SE7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lxARnBor1U+6So+HrMWf9Gk7N+daPrHbJnbZhnhwrnE=;
        b=avD1Iw5KFAianbLe8bkUB+Dz/VHqmWW2KxtLKI7Qf/2pcyRTYVoLhmQujnG2tCzJzf
         lZ0LIVIgldxeo3uw7D0dZbD0duiQShjC0v1vgjlGYXc4+5cex+XnILWVoVP7VdlYkFbz
         ibXvIDgoeNA0k2U747y+y/sy4zP9AfsGadXPnlgFMAk9jsZiXgl/wi3AfHMKVNEMo3Ld
         SmmPE6LXydh13JFrwDFhFyyjddUsUrD6I1EussZ39HlZhfyTxONtD5S5HZu7m/hm8qGT
         35tvKaN2BiwTzQDFAFKQVr3Mk2InQgwmKnvtl4I4oIZkWQlg8Uoq4E9m5yrCAbnurzDU
         zWmQ==
X-Gm-Message-State: APjAAAWxpY4R7imDcqad9mPftL1GAjfSNK121jRz6STE8+JjUsQjIIPB
        NGWp/cyRbNoVGmFTm2yYZjF2kyM88/H82eh9CzlY+g==
X-Google-Smtp-Source: APXvYqxMNt0Da4orYoVxsQsRxu5xNkMkw0G1x6vghAKafmTT/NokCPoqIr/ZB8PYTJmUP6i//FyBRvrO9SGFwmyS5SI=
X-Received: by 2002:a05:6830:13c3:: with SMTP id e3mr5336055otq.180.1582127653521;
 Wed, 19 Feb 2020 07:54:13 -0800 (PST)
MIME-Version: 1.0
References: <20200218143411.2389182-1-christian.brauner@ubuntu.com> <20200218143411.2389182-20-christian.brauner@ubuntu.com>
In-Reply-To: <20200218143411.2389182-20-christian.brauner@ubuntu.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 19 Feb 2020 16:53:47 +0100
Message-ID: <CAG48ez2ikuZQTctjR0RAXYUFrSsJdyn98cKGn5hGEhYjzWfO8g@mail.gmail.com>
Subject: Re: [PATCH v3 19/25] commoncap: handle fsid mappings with vfs caps
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Stephen Barber <smbarber@chromium.org>,
        Seth Forshee <seth.forshee@canonical.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Serge Hallyn <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Phil Estes <estesp@gmail.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Feb 18, 2020 at 3:35 PM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
> Switch vfs cap helpers to lookup fsids in the fsid mappings. If no fsid
> mappings are setup the behavior is unchanged, i.e. fsids are looked up in the
> id mappings.
[...]
> diff --git a/security/commoncap.c b/security/commoncap.c
[...]
> @@ -328,7 +328,7 @@ static bool rootid_owns_currentns(kuid_t kroot)
>                 return false;
>
>         for (ns = current_user_ns(); ; ns = ns->parent) {
> -               if (from_kuid(ns, kroot) == 0)
> +               if (from_kfsuid(ns, kroot) == 0)
>                         return true;
>                 if (ns == &init_user_ns)
>                         break;

Nit: Maybe change the name of this function to something that makes it
clear that this operates in the fsuid mapping domain.
