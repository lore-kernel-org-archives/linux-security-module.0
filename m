Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E604BC4167B
	for <linux-security-module@archiver.kernel.org>; Tue, 14 Nov 2023 10:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjKNKPO (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 14 Nov 2023 05:15:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232278AbjKNKPJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 14 Nov 2023 05:15:09 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C4C199;
        Tue, 14 Nov 2023 02:15:04 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F2D3A1F88C;
        Tue, 14 Nov 2023 10:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1699956903; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SugAxX0AOOgxOm0z3CfXkaaUjnczUiytSEA5AFJbaNo=;
        b=XtB/PXaWGt6TJXW8BlOr8DnScCxjOryGtVmxEYV6/RCPj1aMl8zGxyMqZC79deHNzZlYFm
        75JAkKidjfjvpYcavjskYPCBYL3w/NfxmPEYJB7rRVImMNZIszLuaJn0aHpejjkPVQZtzG
        Wu4JGhKICPi1lFtguQfAkmywszjI5yI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D663513416;
        Tue, 14 Nov 2023 10:15:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OoNFMqZIU2VgKQAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 14 Nov 2023 10:15:02 +0000
Date:   Tue, 14 Nov 2023 11:15:02 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        akpm@linux-foundation.org, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        ligang.bdlg@bytedance.com
Subject: Re: [RFC PATCH -mm 0/4] mm, security, bpf: Fine-grained control over
 memory policy adjustments with lsm bpf
Message-ID: <ZVNIprbQU3NqwPi_@tiehlicka>
References: <20231112073424.4216-1-laoar.shao@gmail.com>
 <188dc90e-864f-4681-88a5-87401c655878@schaufler-ca.com>
 <CALOAHbD+_0tHcm72Q6TM=EXDoZFrVWAsi4AC8_xGqK3wGkEy3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbD+_0tHcm72Q6TM=EXDoZFrVWAsi4AC8_xGqK3wGkEy3g@mail.gmail.com>
Authentication-Results: smtp-out2.suse.de;
        none
X-Spamd-Result: default: False [-5.10 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCPT_COUNT_SEVEN(0.00)[10];
         FREEMAIL_TO(0.00)[gmail.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_NOT_FQDN(0.50)[];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon 13-11-23 11:15:06, Yafang Shao wrote:
> On Mon, Nov 13, 2023 at 12:45 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >
> > On 11/11/2023 11:34 PM, Yafang Shao wrote:
> > > Background
> > > ==========
> > >
> > > In our containerized environment, we've identified unexpected OOM events
> > > where the OOM-killer terminates tasks despite having ample free memory.
> > > This anomaly is traced back to tasks within a container using mbind(2) to
> > > bind memory to a specific NUMA node. When the allocated memory on this node
> > > is exhausted, the OOM-killer, prioritizing tasks based on oom_score,
> > > indiscriminately kills tasks. This becomes more critical with guaranteed
> > > tasks (oom_score_adj: -998) aggravating the issue.
> >
> > Is there some reason why you can't fix the callers of mbind(2)?
> > This looks like an user space configuration error rather than a
> > system security issue.
> 
> It appears my initial description may have caused confusion. In this
> scenario, the caller is an unprivileged user lacking any capabilities.
> While a privileged user, such as root, experiencing this issue might
> indicate a user space configuration error, the concerning aspect is
> the potential for an unprivileged user to disrupt the system easily.
> If this is perceived as a misconfiguration, the question arises: What
> is the correct configuration to prevent an unprivileged user from
> utilizing mbind(2)?"

How is this any different than a non NUMA (mbind) situation? You can
still have an unprivileged user to allocate just until the OOM triggers
and disrupt other workload consuming more memory. Sure the mempolicy
based OOM is less precise and it might select a victim with only a small
consumption on a target NUMA node but fundamentally the situation is
very similar. I do not think disallowing mbind specifically is solving a
real problem. 
-- 
Michal Hocko
SUSE Labs
