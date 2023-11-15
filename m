Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5093CC07548
	for <linux-security-module@archiver.kernel.org>; Wed, 15 Nov 2023 08:45:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234688AbjKOIpu (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 15 Nov 2023 03:45:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234651AbjKOIpt (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 15 Nov 2023 03:45:49 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36C1110;
        Wed, 15 Nov 2023 00:45:45 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4584B1F8B6;
        Wed, 15 Nov 2023 08:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1700037944; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2qCPQijTShxgcg0gL+zgK5uAUfEKbh1txCQLcbJEtBw=;
        b=WL5Q1yW/cBrq7z+9poSYWwAr+D/PwF1yVmcbuSLnr5HoMzIXYgLojKtrZf0Jgou1Vhz89q
        veqH1++uExZYsr253bu8SjfsO1JO2DcoVcrcE6EXBM3lZg1KB4WXmW63louBZCx2oD1G6r
        41SjeVe/MKaYK/zLEvr8qtHMyYSTGJk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2E3A413587;
        Wed, 15 Nov 2023 08:45:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OBLLBziFVGUDGQAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 15 Nov 2023 08:45:44 +0000
Date:   Wed, 15 Nov 2023 09:45:43 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        akpm@linux-foundation.org, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        ligang.bdlg@bytedance.com
Subject: Re: [RFC PATCH -mm 0/4] mm, security, bpf: Fine-grained control over
 memory policy adjustments with lsm bpf
Message-ID: <ZVSFNzf4QCbpLGyF@tiehlicka>
References: <20231112073424.4216-1-laoar.shao@gmail.com>
 <188dc90e-864f-4681-88a5-87401c655878@schaufler-ca.com>
 <CALOAHbD+_0tHcm72Q6TM=EXDoZFrVWAsi4AC8_xGqK3wGkEy3g@mail.gmail.com>
 <ZVNIprbQU3NqwPi_@tiehlicka>
 <CALOAHbDi_8ERHdtPB6sJdv=qewoAfGkheCfriW+QLoN0rLUQAw@mail.gmail.com>
 <b13050b3-54f8-431a-abcf-1323a9791199@schaufler-ca.com>
 <CALOAHbBKCsdmko_ugHZ_z6Zpgo-xJ8j46oPHkHj+gBGsRCR=eA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbBKCsdmko_ugHZ_z6Zpgo-xJ8j46oPHkHj+gBGsRCR=eA@mail.gmail.com>
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
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_NOT_FQDN(0.50)[];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed 15-11-23 09:52:38, Yafang Shao wrote:
> On Wed, Nov 15, 2023 at 12:58 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >
> > On 11/14/2023 3:59 AM, Yafang Shao wrote:
> > > On Tue, Nov 14, 2023 at 6:15 PM Michal Hocko <mhocko@suse.com> wrote:
> > >> On Mon 13-11-23 11:15:06, Yafang Shao wrote:
> > >>> On Mon, Nov 13, 2023 at 12:45 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
> > >>>> On 11/11/2023 11:34 PM, Yafang Shao wrote:
> > >>>>> Background
> > >>>>> ==========
> > >>>>>
> > >>>>> In our containerized environment, we've identified unexpected OOM events
> > >>>>> where the OOM-killer terminates tasks despite having ample free memory.
> > >>>>> This anomaly is traced back to tasks within a container using mbind(2) to
> > >>>>> bind memory to a specific NUMA node. When the allocated memory on this node
> > >>>>> is exhausted, the OOM-killer, prioritizing tasks based on oom_score,
> > >>>>> indiscriminately kills tasks. This becomes more critical with guaranteed
> > >>>>> tasks (oom_score_adj: -998) aggravating the issue.
> > >>>> Is there some reason why you can't fix the callers of mbind(2)?
> > >>>> This looks like an user space configuration error rather than a
> > >>>> system security issue.
> > >>> It appears my initial description may have caused confusion. In this
> > >>> scenario, the caller is an unprivileged user lacking any capabilities.
> > >>> While a privileged user, such as root, experiencing this issue might
> > >>> indicate a user space configuration error, the concerning aspect is
> > >>> the potential for an unprivileged user to disrupt the system easily.
> > >>> If this is perceived as a misconfiguration, the question arises: What
> > >>> is the correct configuration to prevent an unprivileged user from
> > >>> utilizing mbind(2)?"
> > >> How is this any different than a non NUMA (mbind) situation?
> > > In a UMA system, each gigabyte of memory carries the same cost.
> > > Conversely, in a NUMA architecture, opting to confine processes within
> > > a specific NUMA node incurs additional costs. In the worst-case
> > > scenario, if all containers opt to bind their memory exclusively to
> > > specific nodes, it will result in significant memory wastage.
> >
> > That still sounds like you've misconfigured your containers such
> > that they expect to get more memory than is available, and that
> > they have more control over it than they really do.
> 
> And again: What configuration method is suitable to limit user control
> over memory policy adjustments, besides the heavyweight seccomp
> approach?

This really depends on the workloads. What is the reason mbind is used
in the first place? Is it acceptable to partition the system so that
there is a numa node reserved for NUMA aware workloads? If not, have you
considered (already proposed numa=off)?
-- 
Michal Hocko
SUSE Labs
