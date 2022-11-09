Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64499C4332F
	for <linux-security-module@archiver.kernel.org>; Wed,  9 Nov 2022 02:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiKICUp (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 8 Nov 2022 21:20:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbiKICUn (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 8 Nov 2022 21:20:43 -0500
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029466A695
        for <linux-security-module@vger.kernel.org>; Tue,  8 Nov 2022 18:20:38 -0800 (PST)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-13d9a3bb27aso17519492fac.11
        for <linux-security-module@vger.kernel.org>; Tue, 08 Nov 2022 18:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DuNXn1cOzuY2nKg/nqBcIj8YoCOvo5lp0PuOT3uZQDE=;
        b=l1ZU7FsXBxISQCjxvBcAsUxUUspvwFJjWNh1TQY0aVAR0o+eI5++Utr25+ZpJ6uYJ0
         7rFLIFiMRgoOOI3F9h/RfGTH/ymeM9ixYCeP99WuMMW9pOS+ZtmsrsHbhQq/Hy8EsVRg
         2ratMxktiFg6t7cjcOeUilfemvz0tLrzQvV45LlpqFpbATjgWDpi82wFkli6srx2+Mz4
         sf731uryUkym1cDky85KhL2qwJK09HpT03PsT34fhoiuTPE7Gg1gb3uVmNjHXD59qBEf
         RGI4iroxWW1Mb18oetlI/FnhgVMhO20Vo5+KUSXCL2BZ8e5BTS1URe/F3sKNkOdtG63S
         Ev1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DuNXn1cOzuY2nKg/nqBcIj8YoCOvo5lp0PuOT3uZQDE=;
        b=gGEtKhb3qItPtZDDBGvN1Xc8R1iUHAPEhLNIK1M06igNZjT/CyQrCRGFOCgcUM8J2k
         k1K8F+mnauk/+l4w1ekzzWxmj+podJBosBI/FG6jAQ7x5BLMw3EigG+sAFhPy9ELl7gs
         aMgJzjNskCWzMV99bkHRkwzg0yWUVbavY8EEY+F7jQqdrtAzwSS77bdbGYJFZY/COyZZ
         VCxxnqPcOYGaAgMWk7+nb3VvZzGFMT9QOckQ3ahz+pq/Z43E5KKMQDL8zWusVtbTPZjE
         wu6bBPr7D7WNId49MP1Vl5Z9buX9QmPgrPPjcWVIJ1DE7TY9z4jtR9FLfgPsvx5047zr
         mhyw==
X-Gm-Message-State: ACrzQf3XHk2QOMs7YEGrfNQOvoR8TcSNZXgOo5Jv/Nlqz/oHh5x+CkZw
        0lmUWrO2eAtsZDxjTnQ+/yPK75lFDGUHgOtk5H8BONtH6w==
X-Google-Smtp-Source: AMsMyM54DfGyCv8euWxG4rIMDOZWCdv6eGMMMXAVOcm3VbMNBaycONH3bfE0EmY2J1WZoVOwtvwbSXKGPjiJKDKxi8A=
X-Received: by 2002:a05:6870:f299:b0:13b:ad21:934d with SMTP id
 u25-20020a056870f29900b0013bad21934dmr34782038oap.172.1667960437296; Tue, 08
 Nov 2022 18:20:37 -0800 (PST)
MIME-Version: 1.0
References: <20221102171025.126961-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20221102171025.126961-4-penguin-kernel@I-love.SAKURA.ne.jp>
 <ef5fa206-4e7f-3c23-07d4-8591c4315d20@schaufler-ca.com> <20221105024345.GA15957@mail.hallyn.com>
 <5d31873f-f477-ef5a-591f-6f0195f258a8@I-love.SAKURA.ne.jp>
 <20221105234614.GA23523@mail.hallyn.com> <52fdbbe4-cad5-6cd0-9574-2e5efb88a478@I-love.SAKURA.ne.jp>
 <4ead148f-1629-22ec-91f3-44c71f70fce4@schaufler-ca.com> <133ffb84-551e-866d-5597-e62a5a39bc05@I-love.SAKURA.ne.jp>
In-Reply-To: <133ffb84-551e-866d-5597-e62a5a39bc05@I-love.SAKURA.ne.jp>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 8 Nov 2022 21:20:26 -0500
Message-ID: <CAHC9VhS9RQdeCipSpSH3_LZyFfb-BDry=EsSmkt4OLVk=OZnEg@mail.gmail.com>
Subject: Re: [PATCH 04/10] CaitSith: Add header file.
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <kees@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Nov 8, 2022 at 5:20 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> What I'm asking you are that:
>
>   Please don't lock out out-of-tree LSM modules (by requiring an LSM id integer value
>   which are assigned to only in-tree LSM modules) because we can't accept whatever LSM
>   modules as in-tree.
>
>   Please don't lock out loadable LSM modules (by using fixed sized array) because
>   locking out loadable LSM modules reduces the value of your LSM stacking work.
>
> Quite simple.

Tetsuo, at this point I think we all understand your concern and I
appreciate and respect the passion you have for your argument.
However, I think the rest of the developers, including myself, have
also made our points very clear.  While there may still be revisions
to the syscall patches, I believe identifying LSMs via a token value
as opposed to a string value is the better option for the upstream
Linux Kernel.  This alone should not prevent dynamically loadable LSMs
in the future, if we decide to pursue that, but I do recognize that it
will present more of a challenge for the long term maintenance of
out-of-tree LSMs.  I see no reason to trade off what I believe as a
better API choice (LSM ID tokens) for something that is explicitly not
supported by the Linux Kernel as a whole (out-of-tree kernel code).

Thank you for your comments, but I'm considering this settled.

-- 
paul-moore.com
