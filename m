Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8694CC4332F
	for <linux-security-module@archiver.kernel.org>; Thu, 15 Dec 2022 20:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiLOUQS (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 15 Dec 2022 15:16:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiLOUQP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 15 Dec 2022 15:16:15 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CBC379D6
        for <linux-security-module@vger.kernel.org>; Thu, 15 Dec 2022 12:16:14 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 82so415962pgc.0
        for <linux-security-module@vger.kernel.org>; Thu, 15 Dec 2022 12:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E4naCWagDDNWcJfZ4giahWBUN8Tiu/D+CnkJXaoCn4I=;
        b=LjjqHVVBowUybQjG82rnjJe+F8hs1qicEYul58tnTyt23xDcn2E0r4inwVLRfydSHc
         C9a35wJ651tp7QQB6uOkFi1wXA3qIIVZsmH4XubLF9bUEItPe3bhh260zxE239dBYUsJ
         VHKmhzKdkZT134gwNk1FjGgMrA9+Ol2xZI9q/yijm65h4F8Tzhjn3bMpb9shazrkhK6+
         RiBLxadlYztFtdvqO918dlZwLjdUjkP8I5E6QfcmX1fFyJydKoh9WKRCVuRlnVpUXyeP
         SWfIb/hAmtfXHvdZQSJWQid0+pfH9b7T8KGxZP4h++RtfdqcnufOc9PpXDGUs2fuSPjy
         xFEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E4naCWagDDNWcJfZ4giahWBUN8Tiu/D+CnkJXaoCn4I=;
        b=kHbr6WEkPxKIPZ6oJ/92saI5kWInLT1GGHay+QtH86hOxfqhOTHOTfI0wNaAR/55uJ
         BInBpbQ91lVqwMbzbjHcfkfhQH5VyB3R33mNasLxW8rRxFYKe4tqYXYDB4B8xLWin2yr
         AHUI70pI5J9JMmUKDkZERgMmS0eWfWGJdzPTgXhD6/aBkdxfhHXF59fU4ZrhHk752oek
         KGihSSttH4aSymwQO2W4qjjbyl6YdOTxYpkneGteMDH8GK8WuvywcGjlJ4VFHjbMCJC4
         4TlSQhVWclBvDXKD3bDsq/4QBoycy3QNN5RNijYOiIMcHBJjNS6C8TwFio8O94kmhnW3
         Uu4Q==
X-Gm-Message-State: ANoB5pnmhrkKGhxORmkyCoaLgCqhfdwdYAMvWgmafq+i7EYnjR+RdZOz
        iXkN2N+F3x1KnaB67cNiLe0+uV9T1uhwTB8MI6RV
X-Google-Smtp-Source: AA0mqf5S7JAbYH8Ih4fAgPVXpRLUfWfQlEXzX7kbt3sla7bqd90TNHKutCodLt3485BYMP/dTMYGw8FGwkcr9dLI+2A=
X-Received: by 2002:a63:64c5:0:b0:479:2109:506 with SMTP id
 y188-20020a6364c5000000b0047921090506mr1313297pgb.92.1671135374221; Thu, 15
 Dec 2022 12:16:14 -0800 (PST)
MIME-Version: 1.0
References: <20221209195453.never.494-kees@kernel.org> <20221212211319.GA15511@mail.hallyn.com>
 <202212132006.F29BB81A@keescook>
In-Reply-To: <202212132006.F29BB81A@keescook>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 15 Dec 2022 15:16:03 -0500
Message-ID: <CAHC9VhQ7DWQWqiMqHXQO==axnHr3qaxzD22wbK4R78saJt=P2w@mail.gmail.com>
Subject: Re: [PATCH] LoadPin: Ignore the "contents" argument of the LSM hooks
To:     Kees Cook <keescook@chromium.org>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Dec 13, 2022 at 11:06 PM Kees Cook <keescook@chromium.org> wrote:
> On Mon, Dec 12, 2022 at 03:13:19PM -0600, Serge E. Hallyn wrote:
> > On Fri, Dec 09, 2022 at 11:54:57AM -0800, Kees Cook wrote:
> > > LoadPin only enforces the read-only origin of kernel file reads. Whether
> > > or not it was a partial read isn't important. Remove the overly
> > > conservative checks so that things like partial firmware reads will
> > > succeed (i.e. reading a firmware header).
> > >
> > > Fixes: 2039bda1fa8d ("LSM: Add "contents" flag to kernel_read_file hook")
> > > Cc: Paul Moore <paul@paul-moore.com>
> > > Cc: James Morris <jmorris@namei.org>
> > > Cc: "Serge E. Hallyn" <serge@hallyn.com>
> >
> > Acked-by: Serge Hallyn <serge@hallyn.com>
> >
> > Seems reasonable.
>
> Thanks!
>
> > So the patch which introduced this was
> > 2039bda1f: LSM: Add "contents" flag to kernel_read_file hook
> > It sounds like the usage of @contents which it added to ima still
> > makes sense.  But what about the selinux_kernel_read_file() one?
>
> I think those continue to make sense since those LSM may be sensitive to
> the _content_ (rather than the _origin_) of the file.

Agreed.  When @contents is false SELinux does a permission check
between the calling process and itself, but when @contents is true it
performs a check between the calling process and the file being read.

-- 
paul-moore.com
