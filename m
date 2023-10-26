Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C311C25B48
	for <linux-security-module@archiver.kernel.org>; Thu, 26 Oct 2023 05:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbjJZFNV (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 26 Oct 2023 01:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233175AbjJZFNU (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 26 Oct 2023 01:13:20 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EAA189
        for <linux-security-module@vger.kernel.org>; Wed, 25 Oct 2023 22:13:18 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c8a1541232so4101795ad.0
        for <linux-security-module@vger.kernel.org>; Wed, 25 Oct 2023 22:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698297198; x=1698901998; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uXO4N/XeBI5bwKQkWCT3uuchjAs5HEzvmOM9mACPP28=;
        b=OeLvceppW1/EYtdmtpQMQiTDp5zcEkeaPzeKtyxRWtDhXIpdajqkGnvaSgFDrqG1f4
         1ik1a6FthvUlQaA+OwwUDy1E9cqsL/ay101Brcfz0+YdcQcz1bmSVFJPmaPb6t2hAgPg
         9bXkPHpGO8l83fja5ApUP+ebWKIjs897wkogA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698297198; x=1698901998;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uXO4N/XeBI5bwKQkWCT3uuchjAs5HEzvmOM9mACPP28=;
        b=qzX1XdRT+JrtPICxYCUwVjJuH9GyFyjtcpeKjvi26Zsy8CKttmow53R+eggPoFLg4l
         I42qg+UP/Nw6zVaauKB/dLyzDcbDLIodo3FHRmtLJIaDVe4iVYG5Kc8W1fJrUHDCHJhv
         YnkJQvrYZKPxghEnGzCNR9wsNs4Cj2cOuDkTKsr8nsbZcWHttoN9lu/Prj6nFXkJMtnn
         zQB4F80mJ2llXpCkjsCsxJjLT2wNl6eTVF/Cd69yhO2gE8CxOenkhkcPEfQYcLwCMDi7
         YMDaoAa6R1xx0uCVpRJ/XTd01hOao4n+/naKkh7phaS2wOmV+Gc2OUuSEiPMc3wNg4o4
         fbYg==
X-Gm-Message-State: AOJu0Yyql/CP72Rpwy50r6XL65cgzNot+o7W5tQaDNxinXgon4Rv201Y
        eiQjrAYQ5Hl9zZ8q/Y/xbSGHLQ==
X-Google-Smtp-Source: AGHT+IEGALSo7AvdYoeTkOtEEN3dfVz6b/lMXoVOPaSvvwoMcA5k+EU/xafeM/XOaoEE+xZvgJNyCA==
X-Received: by 2002:a17:903:110c:b0:1c6:a0b:7b9a with SMTP id n12-20020a170903110c00b001c60a0b7b9amr20530216plh.3.1698297197671;
        Wed, 25 Oct 2023 22:13:17 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:f228:3a07:1e7f:b38f])
        by smtp.gmail.com with ESMTPSA id jj5-20020a170903048500b001ca21c8abf7sm10079659plb.188.2023.10.25.22.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 22:13:17 -0700 (PDT)
Date:   Thu, 26 Oct 2023 14:13:13 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     John Johansen <john.johansen@canonical.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Anil Altinay <aaltinay@google.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        LKLM <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tomasz Figa <tfiga@chromium.org>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v5 0/4] apparmor: cache buffers on percpu list if there
 is lock, contention
Message-ID: <20231026051313.GA15694@google.com>
References: <Y19GhTg8Q/3ym/VD@google.com>
 <dac1c2d5-367f-c8a7-c61e-c1774d98d602@canonical.com>
 <4595e7b4-ea31-5b01-f636-259e84737dfc@canonical.com>
 <Y+9aoFjrYkpFSvuE@linutronix.de>
 <f3fd5dd8-9d78-43be-fc5c-bf990ad3a64d@canonical.com>
 <CACCxZWOK6=mHNQrWEhjw4pC2i3qBKYdn9joiaaCNE7ge8FAz0A@mail.gmail.com>
 <CACCxZWO-+M-J_enENr7q1WDcu1U8vYFoytqJxAh=x-nuP268zA@mail.gmail.com>
 <31d6e8d6-0747-a282-746b-5c144a9970bb@canonical.com>
 <20231006041837.GA17924@google.com>
 <ffd13862-bc57-45ae-9fd0-454ee2d30fc2@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffd13862-bc57-45ae-9fd0-454ee2d30fc2@canonical.com>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On (23/10/17 02:21), John Johansen wrote:
> > > yeah, testing help is always much appreciated. I have a v4, and I am
> > > working on 3 alternate version to compare against, to help give a better
> > > sense if we can get away with simplifying or tweak the scaling.
> > > 
> > > I should be able to post them out some time tonight.
> > 
> > Hi John,
> > 
> > Did you get a chance to post v4? I may be able to give it some testing
> > on our real-life case.
> 
> sorry yes, how about a v5. That is simplified with 3 follow on patches
> that aren't strictly necessary, but some combination of them might be
> better than just the base patch, but splitting them out makes the
> individual changes easier to review.

Sorry for late reply. So I gave it a try but, apparently, our build
environment has changed quite significantly since the last time I
looked into it.

I don't see that many aa_get/put_buffer() anymore. apparmor buffer
functions are mostly called form the exec path:

	security_bprm_creds_for_exec()
	 apparmor_bprm_creds_for_exec()
	  make_vfsuid()
	   aa_get_buffer()

As for vfs_statx()->...->apparmor_inode_getattr()->aa_path_perm(),
that path is bpf_lsm_inode_getsecid() now.
