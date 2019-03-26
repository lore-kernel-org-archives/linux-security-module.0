Return-Path: <SRS0=+HMg=R5=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D8D6C10F05
	for <linux-security-module@archiver.kernel.org>; Tue, 26 Mar 2019 23:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDC422087C
	for <linux-security-module@archiver.kernel.org>; Tue, 26 Mar 2019 23:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="N5HmmzPn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731668AbfCZX6S (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 26 Mar 2019 19:58:18 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36379 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731644AbfCZX6S (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 26 Mar 2019 19:58:18 -0400
Received: by mail-lf1-f67.google.com with SMTP id d18so10004742lfn.3
        for <linux-security-module@vger.kernel.org>; Tue, 26 Mar 2019 16:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ez1d3rtd8Gt8vuFoJP9w9DkDqXFe0a1YWxYHhu4clFw=;
        b=N5HmmzPn0hULnXUW4lDNN21MJvD8WMEPM2wOsUThimg2sDXJjQ6roao5w6pT26ID4E
         NYVYIrxycc3GhxGDe4F6Mk2bsMcP1wGCl/XErj2Zvr5saafq4+Ob6GypXcmW4v3z/i84
         6c3KGX5JzcfbF9u7VByAdCssHoslA5c5tNhYEnp1WmHepKUXpOblyGpz80pcojQcYZ1B
         VgCueCyJm9qk4RRwhzDt5mI+De5gB4XKhEKpQA9VHWEs2Tk7U1/6nqNJhH0hnRRGrZPu
         KLrgk7gTb3aE+hsJRzZKfj1h8tu19jLlQ1bMPFDkasE+ebbvrJPZrx+osulQBsviLzJU
         yLrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ez1d3rtd8Gt8vuFoJP9w9DkDqXFe0a1YWxYHhu4clFw=;
        b=hrewJSDtLIBJHXOvkHWJDmYCasSXdT8KOeGIHPYwmURbeEtoZDtZTbEuFq7VgknSKa
         nJk7HedUp7JpAQn5OY0Z9SG6pAYFCglt6HcM7pa/KUjO7a35K9Al7euR6utrxTaFyDlD
         QGX9x+kQWxdsi+lW942SJcC+L95R3bfRBUqIlZ71Kl8ckuLGUXzquxILG3gtlmJgAo0z
         HQ12ROTXmhM4pafV6E8qrwIO6f/bnhrRFRH1vyj1mPkta2obFoQtrFqY2Q4QEaV+TFHx
         ibXqXL+QphbDZF1cdC6577YmTDtBcbTgBwa6E6l2m120gYE+FoseoIUUBXInzIMP5XjM
         i1rw==
X-Gm-Message-State: APjAAAUQud6YHIk+yf+xQrhvQT1U2y69dQxTkdAk2SniY0BkJkinyRCw
        F/q/vyZr1bjkfRmxsSDF02LnagER+10I6yjf0Vta
X-Google-Smtp-Source: APXvYqyxOpHELsEvSXgPj9t1atfmpfIvCzC11isrk/ZTRlidtk+1B2J/M6Q5j9udDDNXvJ9X5VzIDgnUfzRMKh82nRM=
X-Received: by 2002:a19:4f44:: with SMTP id a4mr16785603lfk.72.1553644696033;
 Tue, 26 Mar 2019 16:58:16 -0700 (PDT)
MIME-Version: 1.0
References: <087489b21e50bcda65c6af3e038394d5bfe09e00.1553626080.git.rgb@redhat.com>
 <1553632830.4233.3.camel@linux.ibm.com>
In-Reply-To: <1553632830.4233.3.camel@linux.ibm.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 26 Mar 2019 19:58:04 -0400
Message-ID: <CAHC9VhS1e0+1t=ZUsKoJcFvO+JdewL4uqwO4dqw=tOOZdJbLYA@mail.gmail.com>
Subject: Re: [PATCH ghak109 V2] audit: link integrity evm_write_xattrs record
 to syscall event
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Richard Guy Briggs <rgb@redhat.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, sgrubb@redhat.com,
        omosnace@redhat.com, Eric Paris <eparis@parisplace.org>,
        Serge Hallyn <serge@hallyn.com>, mjg59@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Mar 26, 2019 at 4:40 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> Hi Richard, Paul,
>
> On Tue, 2019-03-26 at 14:49 -0400, Richard Guy Briggs wrote:
> > In commit fa516b66a1bf ("EVM: Allow runtime modification of the set of
> > verified xattrs"), the call to audit_log_start() is missing a context to
> > link it to an audit event. Since this event is in user context, add
> > the process' syscall context to the record.
> >
> > In addition, the orphaned keyword "locked" appears in the record.
> > Normalize this by changing it to logging the locking string "." as any
> > other user input in the "xattr=" field.
> >
> > Please see the github issue
> > https://github.com/linux-audit/audit-kernel/issues/109
> >
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
>
> Acked-by: Mimi Zohar <zohar@linux.ibm.com>
>
> Paul, were you planning on upstreaming this patch?

Yep, unless you would rather do it?  If you pull it into the IMA tree,
please add my ACK; otherwise let me know and I'll merge it into
audit/next.

Acked-by: Paul Moore <paul@paul-moore.com>

-- 
paul moore
www.paul-moore.com
