Return-Path: <SRS0=34bQ=6X=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2318C54E4A
	for <linux-security-module@archiver.kernel.org>; Sat,  9 May 2020 20:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE0FC20A8B
	for <linux-security-module@archiver.kernel.org>; Sat,  9 May 2020 20:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589055898;
	bh=6V1qJdRSgOyhSZnyoH+LPJ3fzToxauAOuUOEAPqdvlo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=DRJtgDAOISJui2G0vQu3EvRIM6Xmv1Kh/ebb8AaThvgomFtTuRVywZOtn9pqLHjcV
	 /OYwD5lPvbR0C8L+/JzdcXyd0I4e6ASJmAdJcnl1DFAF2NQ7bUOy34/010OzVQVwLa
	 xFOg0ryXOfMv6KOqLKnx+ZouQRFjzNZSV1lkV40A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbgEIUY6 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 9 May 2020 16:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbgEIUY6 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 9 May 2020 16:24:58 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A83C061A0C
        for <linux-security-module@vger.kernel.org>; Sat,  9 May 2020 13:24:57 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id g16so4346845eds.1
        for <linux-security-module@vger.kernel.org>; Sat, 09 May 2020 13:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rq3EROYQxDfNBT0wVZ0AqkaD6tlVAw2P3CKf/Rs8tQg=;
        b=Z96Q63QMe9Gpsp6AeXzJLinw3niN6+LUAC3oCMCbateqa07K/sPjLmTGDwByhw59b9
         UXCxV70CR0zudA48gJhwUKM8r72YcyACiVcdEj6M/nBu7IVXDtigWGZYpPDlWvyhkTlw
         m40LV53bx4dKUuBDMcU/qCxfUEgtlul3KpXxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rq3EROYQxDfNBT0wVZ0AqkaD6tlVAw2P3CKf/Rs8tQg=;
        b=gyGoPYpnYs09V8OZqLk22g0No7kTACLbILyEdlSxVD+Cnl/1louEjehBvHLHsVRZq9
         tm1skBHYH8XwuAkoldHUEnZG6Unpr90A2plyW0WkvA/8mV75ElPeWBQ5J8SgblSP58s4
         b39ChUOZfTrNJZ/RmUFv3nGhZrOr7y2A6xgugsHskfUXY2Av8smfRCXPqe54I+5o9Cou
         YL7+dODsFWiyj1PZ95NUJtdQoPVSIB0AWNQn7eA9sdUzXCaqPRK2KLErKMslBY1SoUwu
         2n6mEDdKXbYndm0tU1MuRe/RVkCVeHu3t1oVVdjICitqTlsjJBt1qOchWsGHlElyzafv
         v3xg==
X-Gm-Message-State: AGi0PuZnV4RjPqEQCtPVuqfJrHxsRGBg8rshHPlIyOXml9Eo1rJU0t8M
        bDyK/7YTnT/9vvF/WpSrvGJIRDQQ2Gk=
X-Google-Smtp-Source: APiQypKtTtnR8cFQVpEwxFRD83kKAWRUgnAdmmBdkTla5sKYUzPoV/RwZx3H1o4KXMHhjdHbyh929Q==
X-Received: by 2002:a50:a365:: with SMTP id 92mr7669741edn.220.1589055895948;
        Sat, 09 May 2020 13:24:55 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id m7sm644752edv.70.2020.05.09.13.24.55
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 May 2020 13:24:55 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id g13so5991200wrb.8
        for <linux-security-module@vger.kernel.org>; Sat, 09 May 2020 13:24:55 -0700 (PDT)
X-Received: by 2002:a2e:8512:: with SMTP id j18mr5604536lji.201.1589055429344;
 Sat, 09 May 2020 13:17:09 -0700 (PDT)
MIME-Version: 1.0
References: <87h7wujhmz.fsf@x220.int.ebiederm.org> <87sgga6ze4.fsf@x220.int.ebiederm.org>
 <87v9l4zyla.fsf_-_@x220.int.ebiederm.org> <87eerszyim.fsf_-_@x220.int.ebiederm.org>
In-Reply-To: <87eerszyim.fsf_-_@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 9 May 2020 13:16:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg=0nAA9qGAogiFjpf0oCDcjkQE-u6umWCW-PkhrC8jrQ@mail.gmail.com>
Message-ID: <CAHk-=wg=0nAA9qGAogiFjpf0oCDcjkQE-u6umWCW-PkhrC8jrQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] exec: Remove recursion from search_binary_handler
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sat, May 9, 2020 at 12:45 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Instead of recursing in search_binary_handler have the methods that
> would recurse return a positive value, and simply loop in exec_binprm.
>
> This is a trivial change as all of the methods that would recurse do
> so as effectively the last thing they do.   Making this a trivial code
> change.

Looks good.

I'd suggest doing that loop slightly differently:

> -       ret = search_binary_handler(bprm);
> +       do {
> +               depth++;
> +               ret = search_binary_handler(bprm);
> +               /* This allows 4 levels of binfmt rewrites before failing hard. */
> +               if ((ret > 0) && (depth > 5))
> +                       ret = -ELOOP;
> +       } while (ret > 0);
>          if (ret >= 0) {

That's really an odd way to write this.

So honestly, if "ret < 0", then we can just return directly.

So I think would make much more sense to do this loop something like

        for (depth = 0; depth < 5; depth++) {
                int ret;

                ret = search_binary_handler(bprm);
                if (ret < 0)
                        return ret;

                /* Continue searching for the next binary handler? */
                if (ret > 0)
                        continue;

                /* Success! */
                audit_bprm(bprm);
                trace_sched_process_exec(current, old_pid, bprm);
                ptrace_event(PTRACE_EVENT_EXEC, old_vpid);
                proc_exec_connector(current);
                return 0;
        }
        return -ELOOP;

(if I read the logic of exec_binprm() right - I might have missed something).

                Linus
