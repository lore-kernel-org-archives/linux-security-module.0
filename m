Return-Path: <SRS0=76oK=SQ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE53C10F13
	for <linux-security-module@archiver.kernel.org>; Sun, 14 Apr 2019 16:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB5B72175B
	for <linux-security-module@archiver.kernel.org>; Sun, 14 Apr 2019 16:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kPgCTQY4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbfDNQE1 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 14 Apr 2019 12:04:27 -0400
Received: from mail-yw1-f54.google.com ([209.85.161.54]:46800 "EHLO
        mail-yw1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbfDNQE0 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 14 Apr 2019 12:04:26 -0400
Received: by mail-yw1-f54.google.com with SMTP id v127so5152016ywe.13;
        Sun, 14 Apr 2019 09:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=k6wc0LG5bpFRA/gt5+yYGsXzZLDKvB0Wf19XQX8FYio=;
        b=kPgCTQY44LGeDC0mu609B6kHfksAVQHf+3xPGBf8XjQk9lZQvxGmtE11oEKr+LTKPf
         qJ5rG06HvWjQcuakEIzer0T9Yew56hta7jj+iDzPvyQxRkZeolaEzbYIiKVVKTHj7ov5
         aYWjWjR7qbdxSANVuiS0c27C0HhyRjP3lri1GmuxGvgj1thCFXbd1AXaa5RpiD3deOu2
         fHIxbyQjmmAqGV9XH0i9v2G/2ELUkoecFFg3HZ3gwsq0T1K5Ngwy1nEoUurkiGhzJfbo
         i5Y30+r97Uk1Ypi8YGQ6PBRYJv4ZMI09tAI4Wq8qDJh/9kjE3+vyko0+XQq0eh6lnGLS
         DjkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=k6wc0LG5bpFRA/gt5+yYGsXzZLDKvB0Wf19XQX8FYio=;
        b=WxHjov9mvSsYloKb0fTM/fvcvyJWaEjqBT8I1seXvs2goowOU64uVIXmohcXtTtdNk
         o+963IwyA6sjRsPireeSAyT36bYBEEMFZDXf10fgq68nkq/aroXYrqOtSMtuyDVlRa9j
         25MXy6pFRi+9eohOjgTmscFHnoyrGfSqF5/FP+D2zz5djfUYSS2EsFBwNIIO0yOvS7d7
         XFBWE4+zKks260M9hBqH/+uU7wPU6UUNpvSycYIAIbht6tEcohWrt5MBYrbeqQ5hMT51
         5PNbCsJ+h2b0bnvOIGAOmiTJfTqD5K9tw0V8wBjwQWvzF6/76r44Tf8fy+jbN0ILtfYG
         hQ0A==
X-Gm-Message-State: APjAAAVDl18R0e6leLEz8fRRw9aalA3EDrq5hxSYAOQGJ3GE/9lIHoO4
        lab9cRYUgJPoToApXKVz9zX9waWo2b302ZUhAw0=
X-Google-Smtp-Source: APXvYqzSuVRzkHntb4KYSVAXUuN3ca/DGKX1eoUwUwfNQtgK5ONKiljURcEPOiQEZdgYsJEGO5P6RxBhJIx2XSJvqHU=
X-Received: by 2002:a0d:e942:: with SMTP id s63mr54481257ywe.235.1555257865853;
 Sun, 14 Apr 2019 09:04:25 -0700 (PDT)
MIME-Version: 1.0
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 14 Apr 2019 19:04:14 +0300
Message-ID: <CAOQ4uxgn=YNj8cJuccx2KqxEVGZy1z3DBVYXrD=Mc7Dc=Je+-w@mail.gmail.com>
Subject: fanotify and LSM path hooks
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        John Johansen <john.johansen@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Jan,

I started to look at directory pre-modification "permission" hooks
that were discussed on last year's LSFMM:
https://lwn.net/Articles/755277/

The two existing fanotify_perm() hooks are called
from security_file_permission() and security_file_open()
and depend on build time CONFIG_SECURITY.
If you look at how the fsnotify_perm() hooks are planted inside the
generic security hooks, one might wonder, why are fanotify permission
hooks getting a special treatment and are not registering as LSM hooks?

One benefit from an fanotify LSM, besides more generic code, would be
that fanotify permission hooks could be disabled with boot parameters.

I only bring this up because security hooks seems like the most natural
place to add pre-modify fanotify events for the purpose of maintaining
a filesystem change journal. It would be ugly to spray more fsnotify hooks
inside security hooks instead of registering an fanotify LSM, but maybe
there are downsides of registering fanotify as LSM that I am not aware of?

Another observation relates to the security_path_ hooks.
Let's take rename as an example.
LSM could implement security_path_rename() and/or security_inode_rename()
hooks and rename syscalls will end up calling both hooks.
The security_path_ hooks are more attractive for fanotify, because the path
information could be used to setup pre-modification permission mask on
mount marks and not only on filesystem/inode marks.

One problem with security_path_ hooks is that they require an extra
build time CONFIG_SECURITY_PATH.
Another problem is that they seem to be bypassed by several subsystems.
cachefiles, ecryptfs, overlayfs and nfsd all call the vfs_rename() helper, but
only cachefiles bothers to call the security_path_rename() hook.
This is of course true for all other security_path_ hooks.
I think that is something that requires fixing regardless of the fanotify pre
modification hooks. I wonder if tomoyo and apparmor developers
(LSM that implement security_path_ hooks) are aware of those missing
hooks?

Would love to get feedback about whether or not fanotify LSM sounds
like a good or bad idea and about the security_path_ hooks questions.

Thanks,
Amir.
