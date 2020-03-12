Return-Path: <SRS0=85Tz=45=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 406A0C10DCE
	for <linux-security-module@archiver.kernel.org>; Thu, 12 Mar 2020 18:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1340220716
	for <linux-security-module@archiver.kernel.org>; Thu, 12 Mar 2020 18:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584036597;
	bh=gqepVeIwCF0UnQcCLUhwVj6VtQvoDpMlDk1gq0Zm52Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=RF2exTtX2paQID7QjMyQE8syY6zL3EHskovLiikG7M5ZO/ZP2zuNjUmd0o6A9MPja
	 5knCL+innimButc2RK55fl5bXCAJf0w+ONIUxshKwgASew2ZjwZfzYHWEF+H4Gtems
	 tea03wjlGnaqrjx4a8f3PVk3USBrbw9xrED4uCbo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgCLSJ4 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 12 Mar 2020 14:09:56 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40650 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbgCLSJ4 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 12 Mar 2020 14:09:56 -0400
Received: by mail-lf1-f65.google.com with SMTP id j17so5620666lfe.7
        for <linux-security-module@vger.kernel.org>; Thu, 12 Mar 2020 11:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sQ3QfTDDyb5UoBIAiFsjVBE1W68/HsNyhrkWTB/fuO8=;
        b=MXoIPfUgy938dwO+4Ke7cFDpDrSyBbOMidOjN6VWqwOeAMyfFqF2Y4Ay/rwdS0BizU
         Kppg6HhZcnXQd15+19gbWj60YmAsYBKe5dgNHxhDdmce+HxBvnO/FxXNECxZgBF0nuD7
         +Ow57KwOsRb33vqxZnMj9GjOtkrhmMbMIdqZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sQ3QfTDDyb5UoBIAiFsjVBE1W68/HsNyhrkWTB/fuO8=;
        b=aS9lvLAflzqcmPEUQrDX+ZLR1spA0Wb/X8YAO+ZSNHY2PJqHNHVqZWYrADysyfAj0E
         JHYyX26o8hQ4nzvcXLMCUHwnsf1T6mBhmbpu6uPpfWT5vgy0VDuCqanJCTRVwOze5eke
         AnuH0VLtrl6ioBT2Db5IPlVaPSxlWhaQ3ewmBq6k+O+LUIIaxb6E9hGitHmn2ZOKHONG
         BZBv7lwLuEJdBV5P+1XbTjN5vMdb5h0O6huvlL6nq4Vz/4mccJBMn9Vqug1irbM9OOwB
         W/TdTTiDvosyISrbx+HUWhEyft5I/4GWDVrp288dqyAcpGLSZq/lESdExAwi7VW1HgaI
         VNyA==
X-Gm-Message-State: ANhLgQ1et6MfJCoWatZo0OfELUIbG8XB+uIksFow1tTRbd5wHWnspJod
        G+tnFLrRuKu1DPCg0J2UiCS6GqQOz8U=
X-Google-Smtp-Source: ADFU+vuATmucsYY9Ey40GKZMlzGeytWOmAaHsBEb6bmntYRyYyptcyVou6/QHl606f7qvN7RXxEcNg==
X-Received: by 2002:ac2:4c18:: with SMTP id t24mr6034440lfq.54.1584036592684;
        Thu, 12 Mar 2020 11:09:52 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id z5sm2496293lfq.71.2020.03.12.11.09.51
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2020 11:09:52 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id e18so7526556ljn.12
        for <linux-security-module@vger.kernel.org>; Thu, 12 Mar 2020 11:09:51 -0700 (PDT)
X-Received: by 2002:a05:651c:230:: with SMTP id z16mr5976976ljn.201.1584036591344;
 Thu, 12 Mar 2020 11:09:51 -0700 (PDT)
MIME-Version: 1.0
References: <158376244589.344135.12925590041630631412.stgit@warthog.procyon.org.uk>
 <158376245699.344135.7522994074747336376.stgit@warthog.procyon.org.uk>
 <20200310005549.adrn3yf4mbljc5f6@yavin> <CAHk-=wiEBNFJ0_riJnpuUXTO7+_HByVo-R3pGoB_84qv3LzHxA@mail.gmail.com>
 <580352.1583825105@warthog.procyon.org.uk> <CAHk-=wiaL6zznNtCHKg6+MJuCqDxO=yVfms3qR9A0czjKuSSiA@mail.gmail.com>
 <3d209e29-e73d-23a6-5c6f-0267b1e669b6@samba.org> <CAHk-=wgu3Wo_xcjXnwski7JZTwQFaMmKD0hoTZ=hqQv3-YojSg@mail.gmail.com>
 <1147628.1584032201@warthog.procyon.org.uk>
In-Reply-To: <1147628.1584032201@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 12 Mar 2020 11:09:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjXg8jpRHd-Dmis7a79fzkuFJwF0Le6WSG=M13=bTxYxQ@mail.gmail.com>
Message-ID: <CAHk-=wjXg8jpRHd-Dmis7a79fzkuFJwF0Le6WSG=M13=bTxYxQ@mail.gmail.com>
Subject: Re: [PATCH 01/14] VFS: Add additional RESOLVE_* flags [ver #18]
To:     David Howells <dhowells@redhat.com>
Cc:     Stefan Metzmacher <metze@samba.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Karel Zak <kzak@redhat.com>, jlayton@redhat.com,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Mar 12, 2020 at 9:56 AM David Howells <dhowells@redhat.com> wrote:
>
> Any thoughts on which set of flags should override the other?

Do we need to care? I don't think we actually have conflicts, because
the semantics aren't the same, and they are about independent issues.

>                  If we're making
> RESOLVE_* flags the new definitive interface, then I feel they should probably
> override the AT_* flags where there's a conflict, ie. RESOLVE_NO_SYMLINKS
> should override AT_SYMLINK_FOLLOW for example.

That's just for a linkat2() system call? I think the natural semantic
is the one that falls out directly: RESOLVE_NO_SYMLINKS will cause it
to fail with -ELOOP if it is a symlink.

NOTE! This isn't really a "conflict". It's actually two different and
independent things:

 - without AT_SYMLINK_FOLLOW, a linkat() simply won't even try to
follow the symlink, and will link to the symlink itself instead.

 - RESOLVE_NO_SYMLINKS says "never follow symlinks".

Note how one does *NOT* override the other, quite the reverse. They
are about different things. One is about the _behavior_ when the last
component is a symlink, and the other is about permission to follow
any symlinks.

So all combinations make sense:

 - no AT_SYMLINK_FOLLOW, no RESOLVE_NO_SYMLINKS: just link to the
target, whether it's a symlink or not

   This is obviously our historical link() behavior.

 - no AT_SYMLINK_FOLLOW, yes RESOLVE_NO_SYMLINKS: just link to the
target, whether it's a symlink or not, but if there's a symlink in the
middle, return -ELOOP

   Note how this case doesn't follow the last one, so
RESOLVE_NO_SYMLINKS isn't an issue for the last component, but _is_ an
issue for the components in the middle.

 - AT_SYMLINK_FOLLOW, no RESOLVE_NO_SYMLINKS: just link to the target,
following the symlink if it exists

   This is obviously the historical AT_SYMLINK_FOLLOW behavior

 - AT_SYMLINK_FOLLOW | RESOLVE_NO_SYMLINKS: just link to the target,
return -ELOOP if it's a symlink (of if there's a symlink on the way).

   This is the natural behavior for "refuse to follow any symlinks anywhere".

note how they are all completely sane versions, and in no case does
one flag really override the other.

If anything, we actually miss a third flag: the "don't allow linking
to a final symlink at all" (but allow intermediate symlinks). We've
never had that behavior, although I think POSIX makes that case
undefined (ie you're not guaranteed to be able to link to a symlink in
the first place in POSIX).

I guess that third case could be emulated with open(O_PATH) + fstat to
check it's not a symlink + linkat(fd,AT_EMPTY_PATH) if it turns
somebody would want something like that (and we decided that
AT_EMPTY_PATH is ok for linkat()).

I doubt anybody cares.

                 Linus
