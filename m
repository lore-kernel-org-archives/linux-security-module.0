Return-Path: <SRS0=N7Ha=T7=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B310EC04AB6
	for <linux-security-module@archiver.kernel.org>; Fri, 31 May 2019 18:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D5CF26D9E
	for <linux-security-module@archiver.kernel.org>; Fri, 31 May 2019 18:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XSfRpR2t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfEaSDc (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 31 May 2019 14:03:32 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46031 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbfEaSDb (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 31 May 2019 14:03:31 -0400
Received: by mail-lf1-f66.google.com with SMTP id u10so1592650lfm.12
        for <linux-security-module@vger.kernel.org>; Fri, 31 May 2019 11:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Te9nW14r9oz600HemwX1PmP5UfiH0eDOXlPAanGjnDs=;
        b=XSfRpR2tO/BuTcazDlkiBewUCbPn0tL4l/aNQHFAX2+7RPe0p71r/h84aaLhjLI/nI
         anB5omipRVYMmFmVkPtXSsmYU8GE34D/nGaKQw0VdVu3ciu5gglCK30rOGq5pdEMGBQp
         rg4wzQBI7wl5JqqCvsaxxLrXLH10mFZzikcq18MI90GCv0DC5ZW9nq44BnM6wWAHMnE7
         siGh/86QBqzG7pkatKqoiErX4m/Y9F1G9moDMbXfSuQJtN8BgqBA1SnZ1fDhNciI/Cpz
         To8cL2ZZGK9RH4fClo3mlKn/Dkm3EAcNTdWlxm4h0Fs/tobJfMIAOfJP3x6IB4bdZLzg
         dQOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Te9nW14r9oz600HemwX1PmP5UfiH0eDOXlPAanGjnDs=;
        b=PJSvz42UcBcVkRh4zv4+Uw+jKQ7t7xtqt417T7wMPmxK5awCZz38TdxPuhMj+7RXVl
         3kkWb9AJ/JyRqrFtVe3rirgnbT8MXTQZ3IBfJISonh0n2faO0DtXOGeIuG5eMO0AxcQX
         S0L5pVx9Ol5CJC+9xTBFQgp6SfzepPPntA7Y1DfkGFwyyWVFwexBgf39QAgKeOL7q/eX
         PgeDQ+vijS6cMr5Yf6tTrx+7Z0dcDU7oyW07ThEcUwZCn9EQSfAaCnnql1lkIRw97cWC
         EaAWQXOOJDcf4nLOVhOUL6T/uEyj/isQhHKYgAhDJJzJoVpvgxaeZEyleMQU7OjyEl2A
         1hPQ==
X-Gm-Message-State: APjAAAU/l13qGUYtSCvEauWnXzm18oCzTPVWlt0Rg/felU7zho8mC5jm
        nBZzYfk8sPBx2BpMuYVmKSzCSW31TCFXc03xFEBfSA==
X-Google-Smtp-Source: APXvYqx2YTvJsIKuSTpbAn4IyqRskLt8Gxt9pLJOMzVIcwRpPIYpOtokEJH/meHamcRY6VCzyDlDsyYJGM5IbtnLBDs=
X-Received: by 2002:a19:ca02:: with SMTP id a2mr4358970lfg.88.1559325809340;
 Fri, 31 May 2019 11:03:29 -0700 (PDT)
MIME-Version: 1.0
References: <73fac64c-fe49-4738-49a4-0afe668eed94@canonical.com>
 <201905310740.522B3A7C1@keescook> <c80362bd-1dec-3e4f-c3e8-1c58d3a33070@canonical.com>
In-Reply-To: <c80362bd-1dec-3e4f-c3e8-1c58d3a33070@canonical.com>
From:   Ke Wu <mikewu@google.com>
Date:   Fri, 31 May 2019 11:03:17 -0700
Message-ID: <CANRnR9Q4AY1nyTebWgkVM-wUfZv7kKNLnsrchWPBH4HPbB-X6Q@mail.gmail.com>
Subject: Re: security/loadpin: Allow to exclude specific file types
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Kees Cook <keescook@chromium.org>,
        James Morris <jamorris@linux.microsoft.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

I think Coverity is correct. Note that it's the size of
kernel_read_file_str (rather than exclude_read_files) doesn't equal to
ignore_read_file_id.

This is because READING_MAX_ID is also an element in
kernel_read_file_str, which makes the size of kernel_read_file_str to
be READING_MAX_ID+1. I will send a new patch to fix the issue. Thanks
for the  analysis!


On Fri, May 31, 2019 at 7:49 AM Colin Ian King <colin.king@canonical.com> wrote:
>
> On 31/05/2019 15:44, Kees Cook wrote:
> > On Fri, May 31, 2019 at 11:46:29AM +0100, Colin Ian King wrote:
> >> Hi,
> >>
> >> Static analysis with Coverity on linux-next has found a potential issue
> >> with the following commit:
> >>
> >> commit 1633a4f04cc171fc638deb5c95af96032d3c591b
> >> Author: Ke Wu <mikewu@google.com>
> >> Date:   Thu May 30 12:22:08 2019 -0700
> >>
> >>     security/loadpin: Allow to exclude specific file types
> >>
> >>
> >> 209                for (j = 0; j < ARRAY_SIZE(kernel_read_file_str); j++) {
> >> 210                        if (strcmp(cur, kernel_read_file_str[j]) == 0) {
> >> 211                                pr_info("excluding: %s\n",
> >> 212                                        kernel_read_file_str[j]);
> >>
> >> CID 81977 (#1 of 1): Out-of-bounds write
> >> overrun-local: Overrunning array ignore_read_file_id of 8 4-byte
> >> elements at element index 8 (byte offset 35) using index j (which
> >> evaluates to 8).
> >>
> >> 213                                ignore_read_file_id[j] = 1;
> >>
> >> According to Coverity ignore_read_file_id is an array of 8 integers.
> >> However, ARRAY_SIZE(kernel_read_file_str) is 9, so we have an out of
> >> bounds write on ignore_read_file[j] when j is 8.
> >
> > What am I missing? This doesn't fail the build:
> >
> > +       BUILD_BUG_ON(ARRAY_SIZE(exclude_read_files) !=
> > +                    ARRAY_SIZE(ignore_read_file_id));
> >
> > They have the same number of elements.
> >
>
> Yep, that's very true. I'll discuss this with Coverity as this seems
> like a weird false positive.
>
> Apologies for the noise.
>
> Colin



-- 
Ke Wu | Software Engineer | mikewu@google.com | Google Inc.
