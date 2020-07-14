Return-Path: <SRS0=s2H2=AZ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 193A1C433E5
	for <linux-security-module@archiver.kernel.org>; Tue, 14 Jul 2020 16:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9E9F221FF
	for <linux-security-module@archiver.kernel.org>; Tue, 14 Jul 2020 16:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="vJzdSs0A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbgGNQV7 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 14 Jul 2020 12:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbgGNQV6 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 14 Jul 2020 12:21:58 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F821C061794
        for <linux-security-module@vger.kernel.org>; Tue, 14 Jul 2020 09:21:58 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id a1so22689449ejg.12
        for <linux-security-module@vger.kernel.org>; Tue, 14 Jul 2020 09:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ACm5zpgMUDOifP2JDPj0YWtTUIFVz5vD9URrggO/mAA=;
        b=vJzdSs0AJ9iteivKrdInoYBcRpUd/jIxJiB0Hwcg/a2jMkzKJ1xlMR6nSvXdSfyx8U
         jmGMG+y7DwbxuAOJLiEcyuYFSfW2Tk7rnQodJKt8qh3N0416Yajz3460gMQ0HaiHRh56
         0pI/bsIDLDowme126CdCrLPnipuYJRIzpVJABzTwqoZVkqPXsT+iyDqN5yxbpnlX+S+M
         cv5YPB2zV80wU01tywTsdtxxm5ni80SePS7mcdlEb6uG9EUSEDizIrawbSaUOZdvlNxU
         R2l9d9U9GAdKxrqpSqge0GxZqCod/9fEAeg5Qh+rjurhwHbOQs5y4dsJVM0P/iuGc96G
         QTlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ACm5zpgMUDOifP2JDPj0YWtTUIFVz5vD9URrggO/mAA=;
        b=ZbZgNLIrzoFML/+Ol6sM9/KS+1oAa5OClHea9pQvj+wS1rV6kO/lA2682KW3k7wOx4
         9Q5+lrdhxxDRrX0Izk7SmwRuD1GzBWPmx/ajlLAvrpfepn8xRY41LNAorYHRddL0NmNW
         vK2JdRnLI89km2Wp1be5vcLA0jyod2ahjF9yCyHbXt9KPRhjSBABThpZJFGgVz20HHWI
         jnKbIycsuPjwXkI05b5g2CGQCWU3Gb4Fw+k3fgeScCP2oLHRvPJnNA99bwfxFR1aFEFb
         JZgrk9phG28bMONIOEPDa8V/UGH2s3DNsLh3kyw/TJ796Fj6/GJawYojFxynMayzHOtQ
         QCMg==
X-Gm-Message-State: AOAM5333Qls/efh+tf9koBBUI4HlDpqJLnI7qdMwIy/BrXFailc3VqrE
        UOxbypWLTPqk/rXZdkWEeGXlChi+VyjVfrK6TGHG
X-Google-Smtp-Source: ABdhPJyF6gpCpooG9QJjzj45KHVvXALrktCkoyIJGGuND4vN4jg0OZvYslVqhQCNb/qWnHLybg6pA6hj4UKYnvztKaY=
X-Received: by 2002:a17:906:7d86:: with SMTP id v6mr5122113ejo.542.1594743716975;
 Tue, 14 Jul 2020 09:21:56 -0700 (PDT)
MIME-Version: 1.0
References: <6effbbd4574407d6af21162e57d9102d5f8b02ed.1594664015.git.rgb@redhat.com>
In-Reply-To: <6effbbd4574407d6af21162e57d9102d5f8b02ed.1594664015.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 14 Jul 2020 12:21:45 -0400
Message-ID: <CAHC9VhSyq7yKQqwvHL5syU9+TFki6-__WfCrvqewbnU3xpND4Q@mail.gmail.com>
Subject: Re: [PATCH ghak84 v4] audit: purge audit_log_string from the
 intra-kernel audit API
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Eric Paris <eparis@parisplace.org>, john.johansen@canonical.com
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jul 13, 2020 at 3:52 PM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> audit_log_string() was inteded to be an internal audit function and
> since there are only two internal uses, remove them.  Purge all external
> uses of it by restructuring code to use an existing audit_log_format()
> or using audit_log_format().
>
> Please see the upstream issue
> https://github.com/linux-audit/audit-kernel/issues/84
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
> Passes audit-testsuite.
>
> Changelog:
> v4
> - use double quotes in all replaced audit_log_string() calls
>
> v3
> - fix two warning: non-void function does not return a value in all control paths
>         Reported-by: kernel test robot <lkp@intel.com>
>
> v2
> - restructure to piggyback on existing audit_log_format() calls, checking quoting needs for each.
>
> v1 Vlad Dronov
> - https://github.com/nefigtut/audit-kernel/commit/dbbcba46335a002f44b05874153a85b9cc18aebf
>
>  include/linux/audit.h     |  5 -----
>  kernel/audit.c            |  4 ++--
>  security/apparmor/audit.c | 10 ++++------
>  security/apparmor/file.c  | 25 +++++++------------------
>  security/apparmor/ipc.c   | 46 +++++++++++++++++++++++-----------------------
>  security/apparmor/net.c   | 14 ++++++++------
>  security/lsm_audit.c      |  4 ++--
>  7 files changed, 46 insertions(+), 62 deletions(-)

Thanks for restoring the quotes, just one question below ...

> diff --git a/security/apparmor/ipc.c b/security/apparmor/ipc.c
> index 4ecedffbdd33..fe36d112aad9 100644
> --- a/security/apparmor/ipc.c
> +++ b/security/apparmor/ipc.c
> @@ -20,25 +20,23 @@
>
>  /**
>   * audit_ptrace_mask - convert mask to permission string
> - * @buffer: buffer to write string to (NOT NULL)
>   * @mask: permission mask to convert
> + *
> + * Returns: pointer to static string
>   */
> -static void audit_ptrace_mask(struct audit_buffer *ab, u32 mask)
> +static const char *audit_ptrace_mask(u32 mask)
>  {
>         switch (mask) {
>         case MAY_READ:
> -               audit_log_string(ab, "read");
> -               break;
> +               return "read";
>         case MAY_WRITE:
> -               audit_log_string(ab, "trace");
> -               break;
> +               return "trace";
>         case AA_MAY_BE_READ:
> -               audit_log_string(ab, "readby");
> -               break;
> +               return "readby";
>         case AA_MAY_BE_TRACED:
> -               audit_log_string(ab, "tracedby");
> -               break;
> +               return "tracedby";
>         }
> +       return "";

Are we okay with this returning an empty string ("") in this case?
Should it be a question mark ("?")?

My guess is that userspace parsing should be okay since it still has
quotes, I'm just not sure if we wanted to use a question mark as we do
in other cases where the field value is empty/unknown.

-- 
paul moore
www.paul-moore.com
