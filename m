Return-Path: <SRS0=m0b+=VP=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4227FC7618F
	for <linux-security-module@archiver.kernel.org>; Thu, 18 Jul 2019 15:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03C092080D
	for <linux-security-module@archiver.kernel.org>; Thu, 18 Jul 2019 15:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oxNtKWum"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390574AbfGRPBO (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 18 Jul 2019 11:01:14 -0400
Received: from mail-io1-f46.google.com ([209.85.166.46]:38537 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727848AbfGRPBO (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 18 Jul 2019 11:01:14 -0400
Received: by mail-io1-f46.google.com with SMTP id j6so19622667ioa.5
        for <linux-security-module@vger.kernel.org>; Thu, 18 Jul 2019 08:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OBmUwDWJtxKaQ2kK4Trm9YwZFgLnP5TQrP9kx19PbaI=;
        b=oxNtKWumWz1UN+oF8bN/ei+aEsBc5aWyv4Ru8sOxXpS16PAbGY5ugEcUmbAwIWcO5x
         NBf4eQe64L/EfsolWnf0v6N5PleSw3e6CqLFTCXv31RumxNEGXr/FElWuQY0MIaEZeI/
         9EHcINljXQV+/2cJEQBEMC8CIbcy2TprDxsQpacpHNaGx55OLpdMknh5fKkITENY1d04
         v2clDeqgHM6C84jhF54I0so0JlrdvkQuQVOjdtcwWV125KUUNwiXy7mgy9FqlU94kmTT
         trIjdSQyGJ5HEKxH/APKYSsqbok/ir1iOTdI9F5S8sPgmuTfLqX4UxbhhV24Iiq0yh2A
         tsQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OBmUwDWJtxKaQ2kK4Trm9YwZFgLnP5TQrP9kx19PbaI=;
        b=YNU3Lq8UnDt9Lb6koyk2YYnVrRNR7Xt9F60RDH3/48n/p5KzlimORMsrqgdFMJVH/K
         Q2q0ZqXkPJFn0GJCxgwHa1Lw4eSYlk1VkN4jQOEBEreG2P+sPKporkDJpeJjqUKxqp1F
         WninPR6sJqMMhYF/hDeOMVTkVNq23SRUzrhdJGgDZ/lNVAIgEhzAc3mlM6rSwPhrLAxm
         EVG66xz6cPr+UddBxF0Hi6oVso4GMkQrrO2S6zyCojfXWpbA6vGM8NC8dZ6o8gjrUUWx
         5zi2qXGZiIzc44UTDK0axkNWycjVHWz0TP+1LBF3XD1EIYye75QZzEkiCBJ0Cr6gjQvQ
         GEHA==
X-Gm-Message-State: APjAAAW1rmppTTnh86VaFJ/svaCTSb83ycRIktvfbsWxuNn2HctZ08qQ
        kq9OAHGhAceZMiOZitaJq1IL9sU2iv1UMBjmC7PBL6Gi
X-Google-Smtp-Source: APXvYqz+GK8QHgGGMsBzhjzqQAyXoW1X5OplWauMURAoTz/329460v+kUxeIGu53rLR+mk7V/lxMvEqGma7qyF0+ohA=
X-Received: by 2002:a5e:c70c:: with SMTP id f12mr45640884iop.293.1563462073437;
 Thu, 18 Jul 2019 08:01:13 -0700 (PDT)
MIME-Version: 1.0
References: <f824828c-5c9d-b91e-5cec-70ee7a45e760@schaufler-ca.com>
 <c993f63a-7c2d-c6c8-cfa6-3cfba410770d@schaufler-ca.com> <CAHC9VhSTwvueKcK2yhckwayh9YGou7gt2Gny36DOTaNkrck+Mg@mail.gmail.com>
 <2477603.130G60v5SE@x2> <d1a237d3-4b72-48b0-27d6-fb168354ad31@schaufler-ca.com>
 <CAHC9VhTQLihNQ1iGjJB=LAn=C6BQokFsjsRcj8O_O9AjqQ7HBg@mail.gmail.com>
In-Reply-To: <CAHC9VhTQLihNQ1iGjJB=LAn=C6BQokFsjsRcj8O_O9AjqQ7HBg@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Thu, 18 Jul 2019 10:01:01 -0500
Message-ID: <CAFftDdrX2Y9Lr7Wi7jvrADTYNup6djc+1EFMHjFJzO0VSJ_Yeg@mail.gmail.com>
Subject: Re: Preferred subj= with multiple LSMs
To:     Paul Moore <paul@paul-moore.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        "linux-audit@redhat.com" <linux-audit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

<snip>

> > >>>> the following (something between option #2 and #3):
> > >>>>   subj1_lsm=smack subj1=<smack_label> subj2_lsm=selinux
> > >>>>
> > >>>> subj2=<selinux_label> ...
> > >>> If it's not a subj= field why use the indirection?
> > >>>
> > >>>         subj_smack=<smack_label> subj_selinux=<selinux_label>

FWIW +1 on this approach.

<snip>
