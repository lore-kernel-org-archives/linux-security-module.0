Return-Path: <SRS0=B0YM=BO=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A961C433E0
	for <linux-security-module@archiver.kernel.org>; Tue,  4 Aug 2020 13:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBA2D208A9
	for <linux-security-module@archiver.kernel.org>; Tue,  4 Aug 2020 13:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="AEHps8rn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbgHDN45 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 4 Aug 2020 09:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728371AbgHDN4q (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 4 Aug 2020 09:56:46 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01C8C06174A
        for <linux-security-module@vger.kernel.org>; Tue,  4 Aug 2020 06:56:45 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id o18so42502362eje.7
        for <linux-security-module@vger.kernel.org>; Tue, 04 Aug 2020 06:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Nir289YmvLvB9cYHD+WrMlDkgzY7IXddotY7RZ5kJuw=;
        b=AEHps8rnJNYWjEsEPmsNrngg9TrZ3KWI5HcB4+HHRs9di0+/ESZLPa6/JKEXxXRDtU
         j0ZA7GgeP7mT12IX5LxV4n0BWV70/alU7ADPeaFlcj67EWL5F74zxF5tjSOVXXhgCu3N
         g/f2upIq2fhT1dR8LKBd75so90/Gkfjyd4Eik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Nir289YmvLvB9cYHD+WrMlDkgzY7IXddotY7RZ5kJuw=;
        b=InsOC1OeGlGeDYoYQuxcGbdKA0K9XeajHfHlZ2/HsFWl6TrlJ/IfD7sigFwEHG56PI
         KXu0eJi82jKjKqDY+jl3FqC5nFjMKn70XG5Y18Y136h94puIyh1dwX40kPERLWMP/pT1
         guTdzPkAK+jh9nxnJE60MlQWjVwIW3zVwWf4qh5x/3hIX79RqIbOcbnQkzYB9eVOIWnD
         tsmVznmyTsP+5DFzOJx94cSugApbAoYs8gQl1YItNAcDg6BdGkUdhRCLED19ftK3S1sY
         5UCm+Xrnq8cTEUTZ5DRK7IZsp3N+Uzssl5FAkFRl6GfwASh9mLaZSwEThqxebACHApqG
         7Yrw==
X-Gm-Message-State: AOAM533sd3kJt6JLajeLa6Nj5hH27ZkuF3rUX9LSob3Gb/wZR2zEYPZ+
        UaP/+3V400sqRrpmc5hl8YeT1A==
X-Google-Smtp-Source: ABdhPJyvdxPxUWj7x824NLh/G3TC6fG7Nwu5sJ/FqR59hOHVzeefde3nECyeC40mMapaTamORKbAkg==
X-Received: by 2002:a17:906:f905:: with SMTP id lc5mr20891718ejb.340.1596549404630;
        Tue, 04 Aug 2020 06:56:44 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id 4sm18404381ejn.84.2020.08.04.06.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 06:56:44 -0700 (PDT)
Date:   Tue, 4 Aug 2020 15:56:41 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, torvalds@linux-foundation.org,
        raven@themaw.net, mszeredi@redhat.com, christian@brauner.io,
        jannh@google.com, darrick.wong@oracle.com, kzak@redhat.com,
        jlayton@redhat.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/18] fsinfo: Provide notification overrun handling
 support [ver #21]
Message-ID: <20200804135641.GE32719@miu.piliscsaba.redhat.com>
References: <159646178122.1784947.11705396571718464082.stgit@warthog.procyon.org.uk>
 <159646187082.1784947.4293611877413578847.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159646187082.1784947.4293611877413578847.stgit@warthog.procyon.org.uk>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Aug 03, 2020 at 02:37:50PM +0100, David Howells wrote:
> Provide support for the handling of an overrun in a watch queue.  In the
> event that an overrun occurs, the watcher needs to be able to find out what
> it was that they missed.  To this end, previous patches added event
> counters to struct mount.

So this is optimizing the buffer overrun case?

Shoun't we just make sure that the likelyhood of overruns is low and if it
happens, just reinitialize everthing from scratch (shouldn't be *that*
expensive).

Trying to find out what was missed seems like just adding complexity for no good
reason.

