Return-Path: <SRS0=LdBn=BC=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE43C433E3
	for <linux-security-module@archiver.kernel.org>; Thu, 23 Jul 2020 05:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A6C8207F5
	for <linux-security-module@archiver.kernel.org>; Thu, 23 Jul 2020 05:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OTk0yzh3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgGWFS4 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 23 Jul 2020 01:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgGWFSz (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 23 Jul 2020 01:18:55 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F72C0619E1
        for <linux-security-module@vger.kernel.org>; Wed, 22 Jul 2020 22:18:55 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id y18so2572951lfh.11
        for <linux-security-module@vger.kernel.org>; Wed, 22 Jul 2020 22:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc;
        bh=8YDwrten24ogOJDmaXeZKAXksHr1/n5UE74JWklLE1o=;
        b=OTk0yzh3FE+7NblgnSQ/xKhrT6ZyLvv7r1TuVYXU8DRAHgrRUrJlH15ReR6iz+K/Fv
         F7OqqukglcxSd2S/ppfvNHh7K5v5j6s8X7jhYZ7s1/Z9xteDNoDetQ8Ya+Zam8O0f5Mj
         KyzUyc2wZWpv3ojnOuPU3hFcHglLazR3Ksmx2LTqLch7UsRKLLs7gfg8XxKRAubuMchT
         kmBTGQiW8wDZXMaqdQkI3yGB1c7CPVQbuTgdd30LdGwjnPcXmyJ4a2qtO2tu3zL+7uRH
         sJeN47g+YXzSIPNCSnaKdqrjWgq5/o04oNETJfILPFf1ssCZYr0zaj2FA3f5EKqrEnfj
         F1jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc;
        bh=8YDwrten24ogOJDmaXeZKAXksHr1/n5UE74JWklLE1o=;
        b=COL/+lxjVyN/k71spgKncDIC8b2Eait17P3aq+FDKpCytDpVS+s7UpnmVgjMAQrQmC
         iQDQClCr+wA/Zh7gWt8MILrItTnc86LzALOqP5QYZFDFS/XNEAEjl9TsX5wJ3WLGXWrv
         qlR457D5W+MS8REKb5D9779P7/1k0GhU3ZnasnXLy7J2V5GW2Sfp9z7T3EORt8HBkZpm
         Yc//23UsN0jGiwLManH/VMrPfXUshm6goDnPjaZtJRsMsFPjyd6wCPMxSkwud5jINOSi
         yuHT3WXYmUAkCiFYKX7D8c3PVKaUdd0EiUAU3gSt220q+BBgiroSYE6yoYvwxsJ4xtXy
         NWdw==
X-Gm-Message-State: AOAM53095sBdkXaZLhk5ia8ms7Z9yGIpQ0wmg/b1D8Ynbhlmhzaqi8fE
        Q5y4v5QVRc5tKcUYkUp9+IqkH3evrK/JYsLRMas=
X-Received: by 2002:a19:cc3:: with SMTP id 186mt838092lfm.134.1595481533644;
 Wed, 22 Jul 2020 22:18:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200722171409.102949-6-kpsingh@chromium.org> <202007230807.y1gfvekv%lkp@intel.com>
In-Reply-To: <202007230807.y1gfvekv%lkp@intel.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 22 Jul 2020 22:18:42 -0700
Message-ID: <CAADnVQK=m18hgfuRZvykQiJPk_c+z=FR6Dpg0aRVvtJn6-Ckrw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 5/7] bpf: Implement bpf_local_storage for inodes
Cc:     KP Singh <kpsingh@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Jul 22, 2020 at 5:22 PM kernel test robot <lkp@intel.com> wrote:
>

> All warnings (new ones prefixed by >>):
>
>    kernel/bpf/bpf_inode_storage.c: In function 'unlink_inode_storage':
> >> kernel/bpf/bpf_inode_storage.c:34:32: warning: variable 'smap' set but not used [-Wunused-but-set-variable]

KP,

feel free to resubmit as soon as you fix the build.
People typically ignore the patches when buildbot complains,
since they know that maintainers are not going to apply a set with
known build issue.
