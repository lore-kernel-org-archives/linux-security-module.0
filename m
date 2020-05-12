Return-Path: <SRS0=p3Qd=62=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E514C54E8D
	for <linux-security-module@archiver.kernel.org>; Tue, 12 May 2020 00:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B9DD2078A
	for <linux-security-module@archiver.kernel.org>; Tue, 12 May 2020 00:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WTnl9KRJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbgELAMO (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 11 May 2020 20:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728357AbgELAMN (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 11 May 2020 20:12:13 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68376C061A0C
        for <linux-security-module@vger.kernel.org>; Mon, 11 May 2020 17:12:13 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id z1so6268057qvd.23
        for <linux-security-module@vger.kernel.org>; Mon, 11 May 2020 17:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=eMaf4xc8D2BTATY0do2dFv+4nFGdf/qS8KpJ23BpHA0=;
        b=WTnl9KRJI4BwzNnZvPbjEij1Gyw+15IRSe+l0FJ4S+5s+XJIWK78bOeswKixQoY+ns
         O6wXSLSIxB78mJmAfk7OuyqntA8WQVWnDj2DUWd5wKLRjvEbSVGmOvrSrjFYiE/BV1uk
         voa+EQAClkeYRlTT4viM5mPtGg7uU8SpXdrpmHxRrveN0lCyXXwqN23t+tHOQWl+cXeE
         DYAXRSmZSGzklhJAM997GHYslerGdc0Pv1dSqQbuXqXnlHN4OY+p65gusAJKVS8R+ugv
         nJNKo1ZA3/w/p5z2H1P6Z3Ip8+dzTSaCYdym+DAsT0gpcZNkn0m+c5/NqCFVLlZeQztC
         ac5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eMaf4xc8D2BTATY0do2dFv+4nFGdf/qS8KpJ23BpHA0=;
        b=DXlCFev4T2b2oXttwldkwuEc7eAjnwps/JywtGoeVj64LyPwIIw9Wg3ENQfVlHLmnb
         cnbMN6QwCnqTa9TAXoJxOmP4HNDPIxTgnR5U2VK08+dio3eUT0pT/ZneXPIgOurXKyDa
         Mo9M1gMBFvnfnDJdC0TfN5nNibzlPlxI7lcpUS7agYfOCU+xjG9cObYWhV04ickLn+iL
         845B3bBcyYh3cN+U13SNc4r72PMRAGBG51JSdkgagbhMQgD1d1sfJ7KvKfnoHyuHWjoV
         BSO/lGYgO/489Wu+iDqA8Xri2gXfW6u5BkmtQo0ABMn37ODCWvgGZcQMz/uHK0vAC9NJ
         Seiw==
X-Gm-Message-State: AGi0PuY2EGubujAfV4ZTC4oy/CHQtOsu32cX0zNiV4L5TbkEQI1CYuaO
        qQvD0mPqfMIf9zXjHVTRQlhMTaM=
X-Google-Smtp-Source: APiQypIOM3v0IvzYlBLoCseN6fNtA0BGMXPAe7n/8UDiFV3tUxZn65Tq/kITIfPvNITpZRmCY34ZI/U=
X-Received: by 2002:ad4:42c7:: with SMTP id f7mr18867291qvr.127.1589242332555;
 Mon, 11 May 2020 17:12:12 -0700 (PDT)
Date:   Mon, 11 May 2020 17:12:10 -0700
In-Reply-To: <20200508215340.41921-3-alexei.starovoitov@gmail.com>
Message-Id: <20200512001210.GA235661@google.com>
Mime-Version: 1.0
References: <20200508215340.41921-1-alexei.starovoitov@gmail.com> <20200508215340.41921-3-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH v5 bpf-next 2/3] bpf: implement CAP_BPF
From:   sdf@google.com
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     davem@davemloft.net, daniel@iogearbox.net, netdev@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com,
        linux-security-module@vger.kernel.org, acme@redhat.com,
        jamorris@linux.microsoft.com, jannh@google.com, kpsingh@google.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 05/08, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
[..]
> @@ -3932,7 +3977,7 @@ SYSCALL_DEFINE3(bpf, int, cmd, union bpf_attr  
> __user *, uattr, unsigned int, siz
>   	union bpf_attr attr;
>   	int err;

> -	if (sysctl_unprivileged_bpf_disabled && !capable(CAP_SYS_ADMIN))
> +	if (sysctl_unprivileged_bpf_disabled && !bpf_capable())
>   		return -EPERM;
This is awesome, thanks for reviving the effort!

One question I have about this particular snippet:
Does it make sense to drop bpf_capable checks for the operations
that work on a provided fd?

The use-case I have in mind is as follows:
* privileged (CAP_BPF) process loads the programs/maps and pins
   them at some known location
* unprivileged process opens up those pins and does the following:
   * prepares the maps (and will later on read them)
   * does SO_ATTACH_BPF/SO_ATTACH_REUSEPORT_EBPF which afaik don't
     require any capabilities

This essentially pushes some of the permission checks into a fs layer. So
whoever has a file descriptor (via unix sock or open) can do BPF operations
on the object that represents it.

Thoughts? Am I missing something important?
