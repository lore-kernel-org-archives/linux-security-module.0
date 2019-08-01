Return-Path: <SRS0=AbGf=V5=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E306C433FF
	for <linux-security-module@archiver.kernel.org>; Thu,  1 Aug 2019 22:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6254E20838
	for <linux-security-module@archiver.kernel.org>; Thu,  1 Aug 2019 22:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="bfXgAeFC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389319AbfHAWCq (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 1 Aug 2019 18:02:46 -0400
Received: from mail-lf1-f50.google.com ([209.85.167.50]:46016 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389318AbfHAWCq (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 1 Aug 2019 18:02:46 -0400
Received: by mail-lf1-f50.google.com with SMTP id u10so12658772lfm.12
        for <linux-security-module@vger.kernel.org>; Thu, 01 Aug 2019 15:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PzgYLjc0DlH8R4/Bp3L3s/7baqBYRuLh++BLgTY5K6I=;
        b=bfXgAeFCx7SbQU55pHYa0+qyjg5O0iNcK+vjjFJNssv9L/GDxastw0rnwyTNrIP6xB
         PrYFfamTQdnKk+tbesPOX5J9We65zz9x7UPt1q23dq0U6xDJvvhd5wh5TCvMWHaIsiY3
         FAVfLqqa6Eamt4N703CkKzw0FS1/35yDiHVnXZcCkYmW1PigYxx4mDqXAQTsM80mH2Gx
         IOXcvKwb9ghfYF94gJ/ObqUW7DIN5tnvsvEZE3N2i001x0MxZZfYS+bYgqIw/Oqi4o1K
         bw78S4e3Ulls8gvfwYXDTHGg+6taHSrzWgjAx37QLgYvawipGGz0x/38bYNAVdu7LQs7
         zrtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PzgYLjc0DlH8R4/Bp3L3s/7baqBYRuLh++BLgTY5K6I=;
        b=ADOh53jJSX7FQNPmS195GU7DJzqf/PsMK9qtrinGD+b00cut5kcLkNXTOygkes5Txa
         DbrzrvKBeSgtD/G+L8z3E2pYW9YQgU+68QEwP/WbvJxVy6uJTP0G1+cpLOjXCqb+vxqT
         eXao2VAp8AD5nV7gN33IQbj86JUqM785+tVNd3uVQhQzd/RgiCDdo7OhE8ICz4F7vMcE
         o+YR0XcAHyFZyoymeM3dFW7f2Ph57K3Lj4QDJfwQFdH1uBRV4rseFSexQDBDCrxPud4e
         8RT8upVvis15QJhYMCxvsRFDKE0qDm1wh2Mmg+Dp8BFHfjQPMfAI3i7sfT5cCNAtRksl
         S4WQ==
X-Gm-Message-State: APjAAAW+UkASzNO0pKa17fwOk9G7rPwMPd1kF0gcO4F/DouXXofTx2lS
        Q2Ehc1DJY64mvKsteHtbkIZEKILTN97PHSXzQg==
X-Google-Smtp-Source: APXvYqzmq0uXfwJt7g/bBIxK05IIy7u3ZYdIDXtXkS+45JB5jOtl3Mi1LGyMsk7G9yx299JjIG2MwsqssmU7yB7cG7I=
X-Received: by 2002:a19:4349:: with SMTP id m9mr61702928lfj.64.1564696964070;
 Thu, 01 Aug 2019 15:02:44 -0700 (PDT)
MIME-Version: 1.0
References: <2d7f0c7e-a82a-5adb-df94-3ac4fa6b0dfe@schaufler-ca.com>
In-Reply-To: <2d7f0c7e-a82a-5adb-df94-3ac4fa6b0dfe@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 1 Aug 2019 18:02:32 -0400
Message-ID: <CAHC9VhQRUGbU70p8p+zoxqgAF-W92Zz=rOjFB68JsaitrfQt_g@mail.gmail.com>
Subject: Re: Security labeling in NFS4 - who owns it?
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     linux-nfs@vger.kernel.org,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SELinux <selinux@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Aug 1, 2019 at 3:39 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> As part of my work on LSM stacking I've encountered some issues with
> the Linux implementation of NFS4 security labels. For example, the LFS
> data is ignored, so even if the client and server are willing to identify
> the kind of information they are passing, the identity information isn't
> available. The code asks if attributes requested are mandatory access
> control attributes, but cannot differentiate between which of the possible
> security attribute the other end is providing.
>
> Is anyone actively owing the NFS labeling code? I'd like to bounce an
> idea or two around before committing too much time to my ideas of
> solutions.

I guess it all depends on what you mean by "own".  Historically it has
been a mix of the NFS and SELinux folks that have worked on it and
contributed patches, with code sprinkled between the two subsystems
(and possibly elsewhere too).

I suspect a better question would be: who should you work with to
discuss issues the labeled NFS code?  I don't want to assume too much,
but I think you know the answer to that one already ;)

-- 
paul moore
www.paul-moore.com
