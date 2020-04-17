Return-Path: <SRS0=4quM=6B=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A949C38A2B
	for <linux-security-module@archiver.kernel.org>; Fri, 17 Apr 2020 22:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77BA52223C
	for <linux-security-module@archiver.kernel.org>; Fri, 17 Apr 2020 22:22:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="H3DfPMz9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbgDQWWO (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 17 Apr 2020 18:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728470AbgDQWWO (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 17 Apr 2020 18:22:14 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91883C061A0F
        for <linux-security-module@vger.kernel.org>; Fri, 17 Apr 2020 15:22:11 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id r7so2619904edo.11
        for <linux-security-module@vger.kernel.org>; Fri, 17 Apr 2020 15:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w/f6Gl9VweQh9zLrWdi52uB3NRZA6g/9Wq4OQPDCCok=;
        b=H3DfPMz9QpW/RVs87ATxAd0SsMbtWuVycfBc1ONf/oUQsagHrI9Ke4p+W5O7Gk7ehP
         /4vhZItQbyiiB+ZS1/PiPBFH+ll43T9adO+5wKFGdXabapt/1a49KshpnQDTilurOcnK
         +HgG7JSS7DHU62PKRqDiT9WdfeBrO5U8uy/sZRMvebc6erkJmjWqejiPzlne/2Vlm+FI
         pQ9l/UJKmKKSJ3uWMEuql9J6KxKK1xwY3F4/VXODWIcouK5uG1Vc3isY3JOIoue/+KyZ
         jLaLsrmWqfe60UaEdzerikzKxI+Ou4QgvvkpFDu1KsRFQtSow+A+sUZ9l32zClua8+Pw
         +vbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w/f6Gl9VweQh9zLrWdi52uB3NRZA6g/9Wq4OQPDCCok=;
        b=Sg4u6gXlMigOf5UPr2guyiq0hNzlUvX/Y24JujBbAcwe7YlR/ll59z9zsuA99WfjMs
         DzjnWeY8oZRZGGiSFAzZm0TX1H8o+ftS+dPx67uTJ6sOT62svZTWt/rcb2xnVJDK/yk3
         SjOJTfnuqQy3zLGZh4CpNJLzoQf5sz4EHgKi2OjscA84O9WALtrdOBmMS2jOS1E2dSdm
         uZeQ9OtYIxF0Y7gJycZg6srZw/Ie/g/+QKsc6qg0NTn0NOtYadT5uMlXQHJx0Bnr71d8
         f8Mp/gsF6T8Lws/b89dK5mngYvZd2nJO1vtj2lGcfBea2LX+KGSyeaPWTfjVHwgMlRNn
         7/oQ==
X-Gm-Message-State: AGi0PuZExKZ4hWltGt/I4xofNseo4jKGKJPzBtt3Zy4xXQ4R24pHQifJ
        3DP/HCYgP9JKJHmtAIBih5kjGALaEVJI0ize6/kC
X-Google-Smtp-Source: APiQypJsbxCVHQN8UqEDhRhDcXP36MYF6Zp4aTeC61C3FS6fTD07E25L1PXAFJR2/Y6qCsXxV7ziDl/GtGSB95wAMiE=
X-Received: by 2002:a05:6402:1215:: with SMTP id c21mr5347669edw.128.1587162129901;
 Fri, 17 Apr 2020 15:22:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200402141319.28714-1-vdronov@redhat.com> <2d7174b1-115f-b86f-8054-a5caef4b69ff@schaufler-ca.com>
 <1800109401.20260657.1585845081366.JavaMail.zimbra@redhat.com> <20200409215056.qa5uso6rr57y4joo@madcap2.tricolour.ca>
In-Reply-To: <20200409215056.qa5uso6rr57y4joo@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 17 Apr 2020 18:21:59 -0400
Message-ID: <CAHC9VhRG-W5ni6jPbtDFbZ=bgSEaoweMrf0ZMJJi_3-sC+u4QQ@mail.gmail.com>
Subject: Re: [PATCH ghak96] audit: set cwd in audit context for file-related
 LSM audit records
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Vladis Dronov <vdronov@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Eric Paris <eparis@redhat.com>, linux-audit@redhat.com,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Apr 9, 2020 at 5:51 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2020-04-02 12:31, Vladis Dronov wrote:
> > Hello, Casey, all,
> >
> > ----- Original Message -----
> > > From: "Casey Schaufler" <casey@schaufler-ca.com>
> > > Subject: Re: [PATCH ghak96] audit: set cwd in audit context for file-related LSM audit records
> > >
> > > On 4/2/2020 7:13 AM, Vladis Dronov wrote:
> > > > Set a current working directory in an audit context for the following
> > > > record
> > > > types in dump_common_audit_data(): LSM_AUDIT_DATA_PATH,
> > > > LSM_AUDIT_DATA_FILE,
> > > > LSM_AUDIT_DATA_IOCTL_OP, LSM_AUDIT_DATA_DENTRY, LSM_AUDIT_DATA_INODE so a
> > > > separate CWD record is emitted later.
> > > >
> > > > Link: https://github.com/linux-audit/audit-kernel/issues/96
> > >
> > > I don't have a problem with the patch, but it sure would be nice
> > > if you explained why these events "could use a CWD record".
> >
> > (adding Richard Guy Briggs <rgb@redhat.com> which I should have been done earlier)
> >
> > I would agree, adding "cwd=" field in the LSM record itself is simpler to me.
>
> We already have a CWD record to record this information.  It usually
> accompanies an AUDIT_PATH record, but the intent is that it accompanies
> any event that has filesystem pathnames in path= or name= fields in
> records to help understand the command's context relative to the
> filesystem.

Yes, I think the right thing to do here is simply generate a CWD
record in these cases.

-- 
paul moore
www.paul-moore.com
