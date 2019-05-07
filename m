Return-Path: <SRS0=FAtl=TH=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB103C004C9
	for <linux-security-module@archiver.kernel.org>; Tue,  7 May 2019 15:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72D3F20578
	for <linux-security-module@archiver.kernel.org>; Tue,  7 May 2019 15:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G6fAQDux"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725859AbfEGPB6 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 7 May 2019 11:01:58 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:37718 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfEGPB5 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 7 May 2019 11:01:57 -0400
Received: by mail-yw1-f66.google.com with SMTP id 186so4629085ywo.4
        for <linux-security-module@vger.kernel.org>; Tue, 07 May 2019 08:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q1Ao0EL3fzpGzqcCZlr3ThSCXnnAEEIb4lmU9IoewpI=;
        b=G6fAQDuxMpK+OeVsOqAr1qNZe9jkjPK3uV1Hj05ckhGeLhvANSPstZR9eb/Dmn45tm
         l6Q55CFOYkqmvAdlBf+5BWbXKbKgqM2h6PNVNa3qOyq80UURuA2YKpZmyYQUd+qouCo7
         QuZh2iX6cm3b/sym/vd9Go17bCcVh76S4J1zc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q1Ao0EL3fzpGzqcCZlr3ThSCXnnAEEIb4lmU9IoewpI=;
        b=s/PUVaMf/gcePsFGA7gtKGi2xSILpw7Zc/3VHiSPJ3CMN4aU7cjjaJh32GwHnZ1QFm
         +Kqq1e/FdAsXlovfh7J81H4msacqtsejr9aCueK6pxHPAhcvUkfVTz+zrdP39KGt3/2E
         htnmOlutLOV+9YbfY1ljNAqn1rifcbD8Vh7T/NRqtPjX/ukLV1l6VDcrqZxb9yahpd6B
         ZwzVVEaiBjceXCwkWVMrENIuZ4tFvMzmf+/xWQDX2JQfI47gpoQDiyeeZZX2OU0rN4yS
         DLamP7NeeomR/r9BI28aykienEvG6nKoSSKuT83oMXzRXxcHGdMXg5GZ/61SgnrBY8xp
         wkFg==
X-Gm-Message-State: APjAAAXuUXgeDLzxPMka17m/Ziwo0YhQO4rDWsTy80b/AzZg2BZO1HlT
        Up+6P8ANtCbuUhHZuvc8EnpOlzy6qJDpNaF8ankO0A==
X-Google-Smtp-Source: APXvYqzF9pbBmck1zz64hXqDC0n1j+p27UDTWKIobjmyxl1zfaGFG/dQRi0adD2Ft/xdvRIeTFWT+OCPryqpw0vuAIo=
X-Received: by 2002:a81:3ac5:: with SMTP id h188mr1342701ywa.322.1557241316248;
 Tue, 07 May 2019 08:01:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190410165548.211254-1-mortonm@chromium.org> <CAGXu5jK0GpT3MJfbNB=1bGGEGCah65v37_QXxOfhLOU0GM=Bwg@mail.gmail.com>
In-Reply-To: <CAGXu5jK0GpT3MJfbNB=1bGGEGCah65v37_QXxOfhLOU0GM=Bwg@mail.gmail.com>
From:   Micah Morton <mortonm@chromium.org>
Date:   Tue, 7 May 2019 08:01:45 -0700
Message-ID: <CAJ-EccOkOC0OzVOX23bsTME+U9LmC7tj2bo4r55ZDyz4itbeJg@mail.gmail.com>
Subject: Re: [PATCH 05/10] LSM: SafeSetID: refactor policy parsing
To:     Kees Cook <keescook@chromium.org>
Cc:     James Morris <jmorris@namei.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Ready for merge.

On Wed, Apr 10, 2019 at 10:15 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Apr 10, 2019 at 9:55 AM Micah Morton <mortonm@chromium.org> wrote:
> >
> > From: Jann Horn <jannh@google.com>
> >
> > In preparation for changing the policy parsing logic, refactor the line
> > parsing logic to be less verbose and move it into a separate function.
> >
> > Signed-off-by: Jann Horn <jannh@google.com>
> > Signed-off-by: Micah Morton <mortonm@chromium.org>
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> -Kees
>
> > ---
> > I made a minor change to Jann's original patch to use u32 instead of
> > s32 for the 'parsed_parent' and 'parsed_child' variables.
> >
> >  security/safesetid/securityfs.c | 84 +++++++++++++--------------------
> >  1 file changed, 33 insertions(+), 51 deletions(-)
> >
> > diff --git a/security/safesetid/securityfs.c b/security/safesetid/securityfs.c
> > index 2c6c829be044..90784a8d950a 100644
> > --- a/security/safesetid/securityfs.c
> > +++ b/security/safesetid/securityfs.c
> > @@ -33,68 +33,50 @@ static struct safesetid_file_entry safesetid_files[] = {
> >
> >  /*
> >   * In the case the input buffer contains one or more invalid UIDs, the kuid_t
> > - * variables pointed to by 'parent' and 'child' will get updated but this
> > + * variables pointed to by @parent and @child will get updated but this
> >   * function will return an error.
> > + * Contents of @buf may be modified.
> >   */
> > -static int parse_safesetid_whitelist_policy(const char __user *buf,
> > -                                           size_t len,
> > -                                           kuid_t *parent,
> > -                                           kuid_t *child)
> > +static int parse_policy_line(
> > +       struct file *file, char *buf, kuid_t *parent, kuid_t *child)
> >  {
> > -       char *kern_buf;
> > -       char *parent_buf;
> > -       char *child_buf;
> > -       const char separator[] = ":";
> > +       char *child_str;
> >         int ret;
> > -       size_t first_substring_length;
> > -       long parsed_parent;
> > -       long parsed_child;
> > +       u32 parsed_parent, parsed_child;
> >
> > -       /* Duplicate string from user memory and NULL-terminate */
> > -       kern_buf = memdup_user_nul(buf, len);
> > -       if (IS_ERR(kern_buf))
> > -               return PTR_ERR(kern_buf);
> > -
> > -       /*
> > -        * Format of |buf| string should be <UID>:<UID>.
> > -        * Find location of ":" in kern_buf (copied from |buf|).
> > -        */
> > -       first_substring_length = strcspn(kern_buf, separator);
> > -       if (first_substring_length == 0 || first_substring_length == len) {
> > -               ret = -EINVAL;
> > -               goto free_kern;
> > -       }
> > -
> > -       parent_buf = kmemdup_nul(kern_buf, first_substring_length, GFP_KERNEL);
> > -       if (!parent_buf) {
> > -               ret = -ENOMEM;
> > -               goto free_kern;
> > -       }
> > +       /* Format of |buf| string should be <UID>:<UID>. */
> > +       child_str = strchr(buf, ':');
> > +       if (child_str == NULL)
> > +               return -EINVAL;
> > +       *child_str = '\0';
> > +       child_str++;
> >
> > -       ret = kstrtol(parent_buf, 0, &parsed_parent);
> > +       ret = kstrtou32(buf, 0, &parsed_parent);
> >         if (ret)
> > -               goto free_both;
> > +               return ret;
> >
> > -       child_buf = kern_buf + first_substring_length + 1;
> > -       ret = kstrtol(child_buf, 0, &parsed_child);
> > +       ret = kstrtou32(child_str, 0, &parsed_child);
> >         if (ret)
> > -               goto free_both;
> > +               return ret;
> >
> >         *parent = make_kuid(current_user_ns(), parsed_parent);
> > -       if (!uid_valid(*parent)) {
> > -               ret = -EINVAL;
> > -               goto free_both;
> > -       }
> > -
> >         *child = make_kuid(current_user_ns(), parsed_child);
> > -       if (!uid_valid(*child)) {
> > -               ret = -EINVAL;
> > -               goto free_both;
> > -       }
> > +       if (!uid_valid(*parent) || !uid_valid(*child))
> > +               return -EINVAL;
> >
> > -free_both:
> > -       kfree(parent_buf);
> > -free_kern:
> > +       return 0;
> > +}
> > +
> > +static int parse_safesetid_whitelist_policy(
> > +       struct file *file, const char __user *buf, size_t len,
> > +       kuid_t *parent, kuid_t *child)
> > +{
> > +       char *kern_buf = memdup_user_nul(buf, len);
> > +       int ret;
> > +
> > +       if (IS_ERR(kern_buf))
> > +               return PTR_ERR(kern_buf);
> > +       ret = parse_policy_line(file, kern_buf, parent, child);
> >         kfree(kern_buf);
> >         return ret;
> >  }
> > @@ -121,8 +103,8 @@ static ssize_t safesetid_file_write(struct file *file,
> >                 flush_safesetid_whitelist_entries();
> >                 break;
> >         case SAFESETID_WHITELIST_ADD:
> > -               ret = parse_safesetid_whitelist_policy(buf, len, &parent,
> > -                                                                &child);
> > +               ret = parse_safesetid_whitelist_policy(file, buf, len,
> > +                                                      &parent, &child);
> >                 if (ret)
> >                         return ret;
> >
> > --
> > 2.21.0.392.gf8f6787159e-goog
> >
>
>
> --
> Kees Cook
