Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED0DBC433DB
	for <linux-security-module@archiver.kernel.org>; Mon, 21 Dec 2020 19:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D95A22B37
	for <linux-security-module@archiver.kernel.org>; Mon, 21 Dec 2020 19:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbgLUTXE (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 21 Dec 2020 14:23:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbgLUTXD (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 21 Dec 2020 14:23:03 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F81C0613D6
        for <linux-security-module@vger.kernel.org>; Mon, 21 Dec 2020 11:22:23 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id s15so1695847plr.9
        for <linux-security-module@vger.kernel.org>; Mon, 21 Dec 2020 11:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mQuxZifZFxzpeN594Key2sZk1el1zNmvudPhlUZwW1Y=;
        b=HAw8yyznlZSsLKdR4TxeC2GmLvH+tCmepsnEmbIf8429rxzsFkb7UWCH2+NdC5jdWW
         iWiFJPva918WVXQRDL9nl9bMo3gHfFKV3E+VYxLA+NLINRTVaOYUG7i807F9SfWYTK26
         0y05aGJauYbJN2qftZGDwzMkp3zye5en7Sii2CiE/uRW0CXNVIHbzslGIE/IaX937y2c
         vhs9oR8JaeQ1+4do/4Oki4eE0+WPtukEjUfJp04YHQnXR2ajuGdfRf4jP9BDSEaSuvNo
         k1tcHB73LU6j3jRgMJUgzWlB98TNQP9MNpwSrm2RLp6hyVJqaU1Ud5X3F+PdNAcqAiXB
         sm4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mQuxZifZFxzpeN594Key2sZk1el1zNmvudPhlUZwW1Y=;
        b=U2VM+m8OlOMkfXCbBV/05tswJZ9WlyIQrwWcy93xanSH9/g+l80MrhOTqNwUKFcjPA
         GBriM/8xzJJ4dVmRRtqUmfxm4i24jOMlalZxItfIMrcPtuXBpawz2//JZ0zlpovCEJ1o
         grl4iCcsh5SO5tQlyj7yG/AGX2oQ14cc2I2OkjRRp+9BlL2pc1FCH50gX1rmrh54pqO9
         blznMDPdqStQBnwzGWUOGy2mLEk7yg9vUqAWd1s3S0MVvtSnRgyQK+RifNl1N1CmjgEV
         VgYsUxFCdzRINp3A+9ArZcKwS9dz0i5Qc1mTcikv+DXqNqn2ZoKDU+KKYwqCrR0BlcJX
         CC2w==
X-Gm-Message-State: AOAM533Bq7kNY+YdyMexrAmN0cw/ysplMxK4vZNEpGsmO1ps2+2Z2NfX
        CQq97jYp5l9rESbX21u+qZPOy+SbRJPiEl9UkpeUgw==
X-Google-Smtp-Source: ABdhPJzaJUkmOoVyJa+gFznS1BydKP8wi9477o9f2FqiWru2sqlb3r/PwiO0MKz6+7+dAOE1tE346XTDXtE6znuZKGo=
X-Received: by 2002:a17:90a:6ba4:: with SMTP id w33mr19113541pjj.32.1608578543011;
 Mon, 21 Dec 2020 11:22:23 -0800 (PST)
MIME-Version: 1.0
References: <20201004142422.5717-1-trix@redhat.com>
In-Reply-To: <20201004142422.5717-1-trix@redhat.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 21 Dec 2020 11:22:11 -0800
Message-ID: <CAKwvOdnjEDnReJ8+dK=S+FaQW29gR8q+9d5XSuUXrTrvWoiM5w@mail.gmail.com>
Subject: Re: [PATCH] apparmor: fix error check
To:     Tom Rix <trix@redhat.com>
Cc:     john.johansen@canonical.com, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-security-module@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sun, Oct 4, 2020 at 7:24 AM <trix@redhat.com> wrote:
>
> From: Tom Rix <trix@redhat.com>
>
> clang static analysis reports this representative problem:
>
> label.c:1463:16: warning: Assigned value is garbage or undefined
>         label->hname = name;
>                      ^ ~~~~

Right, so if aa_label_acntsxprint() fails, it won't assign to its
first param. In the caller, this means assigning uninitialized memory
(UB) when aa_label_acntsxprint() returns -ENOMEM for example.  Thanks
for the patch.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> In aa_update_label_name(), this the problem block of code
>
>         if (aa_label_acntsxprint(&name, ...) == -1)
>                 return res;
>
> On failure, aa_label_acntsxprint() has a more complicated return
> that just -1.  So check for a negative return.
>
> It was also noted that the aa_label_acntsxprint() main comment refers
> to a nonexistent parameter, so clean up the comment.
>
> Fixes: f1bd904175e8 ("apparmor: add the base fns() for domain labels")
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  security/apparmor/label.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/security/apparmor/label.c b/security/apparmor/label.c
> index e68bcedca976..6222fdfebe4e 100644
> --- a/security/apparmor/label.c
> +++ b/security/apparmor/label.c
> @@ -1454,7 +1454,7 @@ bool aa_update_label_name(struct aa_ns *ns, struct aa_label *label, gfp_t gfp)
>         if (label->hname || labels_ns(label) != ns)
>                 return res;
>
> -       if (aa_label_acntsxprint(&name, ns, label, FLAGS_NONE, gfp) == -1)
> +       if (aa_label_acntsxprint(&name, ns, label, FLAGS_NONE, gfp) < 0)
>                 return res;
>
>         ls = labels_set(label);
> @@ -1704,7 +1704,7 @@ int aa_label_asxprint(char **strp, struct aa_ns *ns, struct aa_label *label,
>
>  /**
>   * aa_label_acntsxprint - allocate a __counted string buffer and print label
> - * @strp: buffer to write to. (MAY BE NULL if @size == 0)
> + * @strp: buffer to write to.
>   * @ns: namespace profile is being viewed from
>   * @label: label to view (NOT NULL)
>   * @flags: flags controlling what label info is printed
> --
> 2.18.1
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20201004142422.5717-1-trix%40redhat.com.



-- 
Thanks,
~Nick Desaulniers
