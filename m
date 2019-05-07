Return-Path: <SRS0=FAtl=TH=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF46C004C9
	for <linux-security-module@archiver.kernel.org>; Tue,  7 May 2019 15:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E657420578
	for <linux-security-module@archiver.kernel.org>; Tue,  7 May 2019 15:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YPbeejg0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbfEGPDK (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 7 May 2019 11:03:10 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:44901 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfEGPDK (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 7 May 2019 11:03:10 -0400
Received: by mail-yw1-f67.google.com with SMTP id j4so13448357ywk.11
        for <linux-security-module@vger.kernel.org>; Tue, 07 May 2019 08:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vcquQ8KpyHNzV9lOEeoiw8Gijgq90M/iDgWN18VKHTA=;
        b=YPbeejg08/oxmzMkHu41qupm8xE+lwQt3ZLJhTzn4gEDLhpE5LZj8Faiwu1OEFKuLi
         RDimnKVHDGnPO7jBPy2OuBiX0cQnpesnQZI41Gxyf+lHfDoZ5e4xA64CJ7jBaMKb2n2U
         aPDXn59agCeIHqXK9/wGi7gV+YX4bHgrFv5/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vcquQ8KpyHNzV9lOEeoiw8Gijgq90M/iDgWN18VKHTA=;
        b=lpeJ/zuv2ZCvOAveEvKvVFp+0qH0hUP/lwhQRk4T6Kfcb/2oEcm2bofB1YOSq+Evf+
         46tylSR+cwwIJuGzzlFfMvPXY49A906ZU25qXmdo5hoLyDeCUkreQXXo05VMOEx59z81
         QdpZVaW5kkgeEQv/uzxeTPSPjEgvfSpFd1gFid+l4Ge5kEdG456DG3kbn0LKQBoWuK9z
         wr8TKtq6i1jpyMltvoe3KqOYMtg01OhaQOUu+1Tys/oq+bGz44Hc7lrAyFlYuK3mGm4q
         ky5tgd6PrE+x2DDz336G8f6a7+vrqHSR06ToyXLkgZX0Pu4iTTstCwWbEGG0d38VNzO6
         SaMA==
X-Gm-Message-State: APjAAAW2Pkr5RXRs2RxNjjjdnN9VYj/ySlR3MiaxOY71azXSTuTyMYYo
        FlZO/zPkRO87W/7BLWn41gafIv6khVr0w3qE955MCuPpSno=
X-Google-Smtp-Source: APXvYqzyveg6GXCU8cYxqwFn7TH6nTnN+dB770MEVaMQcEmLJCsEjoLaIEmJB7vNdYW0DEUECyCNo/bAA4E569rEbT8=
X-Received: by 2002:a81:7085:: with SMTP id l127mr22507023ywc.167.1557241389003;
 Tue, 07 May 2019 08:03:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190411201154.167617-1-mortonm@chromium.org> <CAGXu5j+B0RcNVJXOyn4FZ8NsGR-RgqDbnL+4Ws-8RBOtaAHg=w@mail.gmail.com>
In-Reply-To: <CAGXu5j+B0RcNVJXOyn4FZ8NsGR-RgqDbnL+4Ws-8RBOtaAHg=w@mail.gmail.com>
From:   Micah Morton <mortonm@chromium.org>
Date:   Tue, 7 May 2019 08:02:58 -0700
Message-ID: <CAJ-EccNZQYQ7ciOJs2WU+3VbMPU7o+WpSkXQ=O2BSEuZVw3OPQ@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] LSM: SafeSetID: add read handler
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

On Thu, Apr 11, 2019 at 1:38 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Apr 11, 2019 at 1:12 PM Micah Morton <mortonm@chromium.org> wrote:
> >
> > From: Jann Horn <jannh@google.com>
> >
> > For debugging a running system, it is very helpful to be able to see what
> > policy the system is using. Add a read handler that can dump out a copy of
> > the loaded policy.
> >
> > Signed-off-by: Jann Horn <jannh@google.com>
> > Signed-off-by: Micah Morton <mortonm@chromium.org>
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> -Kees
>
> > ---
> > Changes since the last patch set: Instead of doing refcounting, change
> > policy_update_lock to a mutex and hold the mutex across the policy read.
> >  security/safesetid/lsm.h        |  1 +
> >  security/safesetid/securityfs.c | 35 +++++++++++++++++++++++++++++----
> >  2 files changed, 32 insertions(+), 4 deletions(-)
> >
> > diff --git a/security/safesetid/lsm.h b/security/safesetid/lsm.h
> > index 4a34f558d964..db6d16e6bbc3 100644
> > --- a/security/safesetid/lsm.h
> > +++ b/security/safesetid/lsm.h
> > @@ -41,6 +41,7 @@ struct setuid_rule {
> >
> >  struct setuid_ruleset {
> >         DECLARE_HASHTABLE(rules, SETID_HASH_BITS);
> > +       char *policy_str;
> >         struct rcu_head rcu;
> >  };
> >
> > diff --git a/security/safesetid/securityfs.c b/security/safesetid/securityfs.c
> > index 250d59e046c1..997b403c6255 100644
> > --- a/security/safesetid/securityfs.c
> > +++ b/security/safesetid/securityfs.c
> > @@ -19,7 +19,7 @@
> >
> >  #include "lsm.h"
> >
> > -static DEFINE_SPINLOCK(policy_update_lock);
> > +static DEFINE_MUTEX(policy_update_lock);
> >
> >  /*
> >   * In the case the input buffer contains one or more invalid UIDs, the kuid_t
> > @@ -67,6 +67,7 @@ static void __release_ruleset(struct rcu_head *rcu)
> >
> >         hash_for_each_safe(pol->rules, bucket, tmp, rule, next)
> >                 kfree(rule);
> > +       kfree(pol->policy_str);
> >         kfree(pol);
> >  }
> >
> > @@ -85,6 +86,7 @@ static ssize_t handle_policy_update(struct file *file,
> >         pol = kmalloc(sizeof(struct setuid_ruleset), GFP_KERNEL);
> >         if (!pol)
> >                 return -ENOMEM;
> > +       pol->policy_str = NULL;
> >         hash_init(pol->rules);
> >
> >         p = buf = memdup_user_nul(ubuf, len);
> > @@ -92,6 +94,11 @@ static ssize_t handle_policy_update(struct file *file,
> >                 err = PTR_ERR(buf);
> >                 goto out_free_pol;
> >         }
> > +       pol->policy_str = kstrdup(buf, GFP_KERNEL);
> > +       if (pol->policy_str == NULL) {
> > +               err = -ENOMEM;
> > +               goto out_free_buf;
> > +       }
> >
> >         /* policy lines, including the last one, end with \n */
> >         while (*p != '\0') {
> > @@ -135,10 +142,10 @@ static ssize_t handle_policy_update(struct file *file,
> >          * What we really want here is an xchg() wrapper for RCU, but since that
> >          * doesn't currently exist, just use a spinlock for now.
> >          */
> > -       spin_lock(&policy_update_lock);
> > +       mutex_lock(&policy_update_lock);
> >         rcu_swap_protected(safesetid_setuid_rules, pol,
> >                            lockdep_is_held(&policy_update_lock));
> > -       spin_unlock(&policy_update_lock);
> > +       mutex_unlock(&policy_update_lock);
> >         err = len;
> >
> >  out_free_buf:
> > @@ -162,7 +169,27 @@ static ssize_t safesetid_file_write(struct file *file,
> >         return handle_policy_update(file, buf, len);
> >  }
> >
> > +static ssize_t safesetid_file_read(struct file *file, char __user *buf,
> > +                                  size_t len, loff_t *ppos)
> > +{
> > +       ssize_t res = 0;
> > +       struct setuid_ruleset *pol;
> > +       const char *kbuf;
> > +
> > +       mutex_lock(&policy_update_lock);
> > +       pol = rcu_dereference_protected(safesetid_setuid_rules,
> > +                                       lockdep_is_held(&policy_update_lock));
> > +       if (pol) {
> > +               kbuf = pol->policy_str;
> > +               res = simple_read_from_buffer(buf, len, ppos,
> > +                                             kbuf, strlen(kbuf));
> > +       }
> > +       mutex_unlock(&policy_update_lock);
> > +       return res;
> > +}
> > +
> >  static const struct file_operations safesetid_file_fops = {
> > +       .read = safesetid_file_read,
> >         .write = safesetid_file_write,
> >  };
> >
> > @@ -181,7 +208,7 @@ static int __init safesetid_init_securityfs(void)
> >                 goto error;
> >         }
> >
> > -       policy_file = securityfs_create_file("whitelist_policy", 0200,
> > +       policy_file = securityfs_create_file("whitelist_policy", 0600,
> >                         policy_dir, NULL, &safesetid_file_fops);
> >         if (IS_ERR(policy_file)) {
> >                 ret = PTR_ERR(policy_file);
> > --
> > 2.21.0.392.gf8f6787159e-goog
>
>
>
> --
> Kees Cook
