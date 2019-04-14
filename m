Return-Path: <SRS0=76oK=SQ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13B7C10F13
	for <linux-security-module@archiver.kernel.org>; Sun, 14 Apr 2019 18:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A92AE20850
	for <linux-security-module@archiver.kernel.org>; Sun, 14 Apr 2019 18:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h68Bibhh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbfDNSvv (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 14 Apr 2019 14:51:51 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:38163 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbfDNSvv (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 14 Apr 2019 14:51:51 -0400
Received: by mail-yb1-f195.google.com with SMTP id w206so5595686ybg.5;
        Sun, 14 Apr 2019 11:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S040IzWzDI9wWALe4vrMiOheiJEootWgDSg5RM9s4QA=;
        b=h68BibhhFp7tY1Lgeayd+Dq0frPmiwS7YF4uAaUB8qvzFMbdF83gJywtI225O+Jiyi
         MeXr3tx8HQvBJZNrhrMaTNHXppVGUpkt7mOx8pkyB4B0ILDbqDByeGHfPm0QsJJfSuXL
         6wILELPAiFFl1fKXRI3BIm3wtTxJprTBFeoogom16bj1f9pJCsa4pwhQdR4GR720Dspa
         tAPk0gY/aH7VdBmWu1QC7Y26bUZOpgWZl0i+Pp+Mc+XOGoA+tyMY0kHU/YIVg9zaw7Rn
         40mx21xXK/gnG6E/2z1RrIUsB7kYSPZ44r7t5JHVBddd6z/T/g5gDqlsUnAPb+eY4iBX
         gZBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S040IzWzDI9wWALe4vrMiOheiJEootWgDSg5RM9s4QA=;
        b=qPBfWUiIEHXFVduvPhwngcWVz0jhR/fSWqEZbZN/2lZS/zeHxspLqtwE93SIvaAiSg
         NcwjucXMLJjNrYDrXMOjVasiBm5csE4X0Qt8DF7fH8vYWi8ELoI71yGViH4fckBl/sR2
         4zs9+7jBJv3L77rbNlh4Iay8FGtrQ3DlEnRIn5aNsfly1cl5Mem+XYN0wclkuUC9gq3o
         3/yE3aa+V/+vmB6KEDuLnGNW1Ynpf8tIHPqyuV4HN0/TNY9UGGFvlCb9Mughkkt0NYfZ
         rEss3AGVeCpgi28HgJf+IoNn3xRHZ6Y/7kEqc7sQa6mFBetcwoliOpvoImLUrMQVk8dI
         nObw==
X-Gm-Message-State: APjAAAVgHbWHWpLc/GIdkrSAUCeiv+3l3894BZ13hAIy0d4p6pn8cXS3
        PlOFmisMsrfMQh8fjsznHDXwG3XnLQa8iz0gW1c=
X-Google-Smtp-Source: APXvYqw/qPk+2v2CG4sjVF05bKKWQZQp6hMgMUM3s53XWPpO/Vu9++hjMIvTlUffszrcFSSJNwjZ8gfKyvbfPx1H+0M=
X-Received: by 2002:a25:65c5:: with SMTP id z188mr56517105ybb.217.1555267910125;
 Sun, 14 Apr 2019 11:51:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxgn=YNj8cJuccx2KqxEVGZy1z3DBVYXrD=Mc7Dc=Je+-w@mail.gmail.com>
 <20190414163950.GQ2217@ZenIV.linux.org.uk>
In-Reply-To: <20190414163950.GQ2217@ZenIV.linux.org.uk>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 14 Apr 2019 21:51:38 +0300
Message-ID: <CAOQ4uxg-NsccKfhzJbZnCnXhKA90VfVdV0_qLRt+8iVa53655g@mail.gmail.com>
Subject: Re: fanotify and LSM path hooks
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        John Johansen <john.johansen@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sun, Apr 14, 2019 at 7:40 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Sun, Apr 14, 2019 at 07:04:14PM +0300, Amir Goldstein wrote:
>
> > Another problem is that they seem to be bypassed by several subsystems.
> > cachefiles, ecryptfs, overlayfs and nfsd all call the vfs_rename() helper, but
> > only cachefiles bothers to call the security_path_rename() hook.
> > This is of course true for all other security_path_ hooks.
> > I think that is something that requires fixing regardless of the fanotify pre
> > modification hooks. I wonder if tomoyo and apparmor developers
> > (LSM that implement security_path_ hooks) are aware of those missing
> > hooks?
>
> First of all, _what_ path?  You do realize that there is no such thing
> as *the* pathname of dentry, right?

Yap.

> The same filesystem may be mounted
> in any number of places, some of which might be visible in a given
> namespace (including "none of them" - and you are not even guaranteed
> that they are visible in any namespace at all).
>
> It's not "bypassed", it's "inapplicable and deeply flawed in general".

I am assuming that you are referring to the security_path_ hooks in
general. I cannot speak on behalf of Tomoyo and Apparmor, but I think
I understand why you view path based security policy as flawed.

From fanotify POV, passing the path that was used to operate on
dentries to fanotify lets the users choose if they want to get events
for all operations on an inode, all operations on a specific filesystem or
all operations where the inode was accessed via a specific mount
(FAN_MARK_MOUNT).

When looking at userspace applications of kernel filesystem change
notifications, like https://facebook.github.io/watchman/
I believe what users really want is a subtree watch.
So for example, you may want to monitor your git workspace(s) for changes
on a large source tree(s) to save time on git index updates.
If you bind mount your git work tree and watch the mount for changes,
chances are nobody is messing with your source files from another
mount and that you do not have hardlinks pointing outside the git
workspace root.

But the truth is I would much rather that users have a way to mark
a subtree root and ask fanotify for events under that subtree.
As a matter of fact, I have some private POC patches that allow users to
setup a mark on a "subtree root" dentry, which really marks the super block
and keep a reference to the dentry. Than every event on that super block
is filtered with is_subdir() against the marked dentry.
I am just not convinced that is the most efficient way to implement a
subtree filter... another though I had was to filter not by subtree, but by
project id and let users worry about populating their subtrees of interest
with appropriate projids.

More comments about ideas that are deeply flawed are welcome.
Those comments would hopefully help me navigate towards the
mildly flawed ideas ;-)

Thanks,
Amir.
