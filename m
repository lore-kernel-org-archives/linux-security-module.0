Return-Path: <SRS0=PFxj=WK=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1737C433FF
	for <linux-security-module@archiver.kernel.org>; Wed, 14 Aug 2019 19:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C76692084D
	for <linux-security-module@archiver.kernel.org>; Wed, 14 Aug 2019 19:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="Z8yewREr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbfHNT7m (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 14 Aug 2019 15:59:42 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43436 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbfHNT7m (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 14 Aug 2019 15:59:42 -0400
Received: by mail-lf1-f68.google.com with SMTP id c19so127524lfm.10
        for <linux-security-module@vger.kernel.org>; Wed, 14 Aug 2019 12:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hhMQ53DOHnRWCqXRthaYZzsTvg2w1ObZtlnXlUzu9gc=;
        b=Z8yewRErplhgJ9czrttVyZZtHSge3ebInSv/oC9XMy7hgEf3oaHUKN7t1ggFqIvndq
         dCjc/+ggVoW7BuJMr+Wrhi8sQwtL7oJb7PCSUv1i2dvR05Ytuu5GwBE9z7pwT7PqQBUP
         yQZZFQ/FBlGXp45qJTSn6WPtJcgFqPrkaewdX7+ljc/6nTwtSU41/Kpj6pIDkFxBmbes
         58oPKzLUsm2oNahxaXlwvK7HUH3T2wrRFsj4Heqy5JZvh+QxxboX/A3PYg5/Ni6+HY07
         jMq8nwDBBeoIG2ZtVZFbRnJl52UNk4yc2Lp9QKSwB6AYqysF73ittyflPaYMbZfzwJJp
         W9gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hhMQ53DOHnRWCqXRthaYZzsTvg2w1ObZtlnXlUzu9gc=;
        b=F12m372YtqRNmQOpJ5g+PW+x+JGsvnbRd6LoTbfHdFHwBSuMyZzO/doPNtsSPsbqch
         nVTU8Hdl0wp5//iq7AStr6WHpFJJT121b3kizRN02V9yFN2aoVgP9b77CVrRFmYruoO3
         8ua8wFNAn7qkowAONT+25Z4hj5tE3JmJO8vwg34IzYDCnT8p0tzkJ3bg7bDRbUsDkJ8n
         8XuOQmKynGD17GgIHA3/iexlCrf5FjcCXRq93rhhg1ZruR/ba5SAn/Q/RYexfrnjFQuq
         8RWPM4w9fPoY+y85Ko62uedXT6agnIr/KWAx5Rsf+BUlkrwgNoCUrzJ7aisCra+9EGUF
         zpOA==
X-Gm-Message-State: APjAAAUGk1ofvl4FFcRM7D8uzpcMfDn0ptoq9sD4wZLFxT1s5G0ehDp1
        mwWKeP9l+RUw7cTfLyVybvcBJHr7MfIbfApXCdM+to4=
X-Google-Smtp-Source: APXvYqwu+6akIA0KbPZkMVwMuPcltAW/OW135WdLFVo9hxq2LKrg32PKHWyvT80GlqJlgyGoGRZBJypgE8I46C3Gde8=
X-Received: by 2002:ac2:4948:: with SMTP id o8mr568546lfi.13.1565812778966;
 Wed, 14 Aug 2019 12:59:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190801144313.1014-1-acgoide@tycho.nsa.gov> <CAHC9VhTSWiz45vh+M+sgu+ePwgFPZ4Mr8GmRZQjsGWQSzkjbLg@mail.gmail.com>
 <b79617aa-2b40-40bf-9f35-0f5be8e34d3f@tycho.nsa.gov> <20190813212710.wimxgfunrijqwuqt@madcap2.tricolour.ca>
In-Reply-To: <20190813212710.wimxgfunrijqwuqt@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 14 Aug 2019 15:59:27 -0400
Message-ID: <CAHC9VhTWY4vtsmCn8X3TjR1HdsB1-wqBLs03vZVv0SmWQ-Ab2Q@mail.gmail.com>
Subject: Re: [Non-DoD Source] Re: [RFC PATCH v2] security, capability: pass
 object information to security_capable
To:     Richard Guy Briggs <rgb@redhat.com>,
        Aaron Goidel <acgoide@tycho.nsa.gov>
Cc:     mortonm@chromium.org, john.johansen@canonical.com,
        selinux@vger.kernel.org, James Morris <jmorris@namei.org>,
        luto@amacapital.net, linux-security-module@vger.kernel.org,
        linux-audit@redhat.com, Nicholas Franck <nhfran2@tycho.nsa.gov>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Serge Hallyn <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Aug 13, 2019 at 5:27 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2019-08-13 11:01, Aaron Goidel wrote:
> > On 8/8/19 12:30 PM, Paul Moore wrote:
> > > On Thu, Aug 1, 2019 at 10:43 AM Aaron Goidel <acgoide@tycho.nsa.gov> wrote:
> > > > From: Nicholas Franck <nhfran2@tycho.nsa.gov>
> > > >
> > > > At present security_capable does not pass any object information
> > > > and therefore can neither audit the particular object nor take it
> > > > into account. Augment the security_capable interface to support
> > > > passing supplementary data. Use this facility initially to convey
> > > > the inode for capability checks relevant to inodes. This only
> > > > addresses capable_wrt_inode_uidgid calls; other capability checks
> > > > relevant to inodes will be addressed in subsequent changes. In the
> > > > future, this will be further extended to pass object information for
> > > > other capability checks such as the target task for CAP_KILL.
> > > >
> > > > In SELinux this new information is leveraged here to include the inode
> > > > in the audit message. In the future, it could also be used to perform
> > > > a per inode capability checks.
> > > >
> > > > It would be possible to fold the existing opts argument into this new
> > > > supplementary data structure. This was omitted from this change to
> > > > minimize changes.
> > > >
> > > > Signed-off-by: Nicholas Franck <nhfran2@tycho.nsa.gov>
> > > > Signed-off-by: Aaron Goidel <acgoide@tycho.nsa.gov>
> > > > ---
> > > > v2:
> > > > - Changed order of audit prints so optional information comes second
> > > > ---
> > > >   include/linux/capability.h             |  7 ++++++
> > > >   include/linux/lsm_audit.h              |  5 +++-
> > > >   include/linux/lsm_hooks.h              |  3 ++-
> > > >   include/linux/security.h               | 23 +++++++++++++-----
> > > >   kernel/capability.c                    | 33 ++++++++++++++++++--------
> > > >   kernel/seccomp.c                       |  2 +-
> > > >   security/apparmor/capability.c         |  8 ++++---
> > > >   security/apparmor/include/capability.h |  4 +++-
> > > >   security/apparmor/ipc.c                |  2 +-
> > > >   security/apparmor/lsm.c                |  5 ++--
> > > >   security/apparmor/resource.c           |  2 +-
> > > >   security/commoncap.c                   | 11 +++++----
> > > >   security/lsm_audit.c                   | 21 ++++++++++++++--
> > > >   security/safesetid/lsm.c               |  3 ++-
> > > >   security/security.c                    |  5 ++--
> > > >   security/selinux/hooks.c               | 20 +++++++++-------
> > > >   security/smack/smack_access.c          |  2 +-
> > > >   17 files changed, 110 insertions(+), 46 deletions(-)
> > >
> > > You should CC the linux-audit list, I've added them on this mail.
> > >
> > > I had hoped to see some thought put into the idea of dynamically
> > > emitting the proper audit records as I mentioned in the previous patch
> > > set, but regardless there are some comments on this code as written
> > > ...
> > >
> > > > diff --git a/security/lsm_audit.c b/security/lsm_audit.c
> > > > index 33028c098ef3..18cc7c956b69 100644
> > > > --- a/security/lsm_audit.c
> > > > +++ b/security/lsm_audit.c
> > > > @@ -229,9 +229,26 @@ static void dump_common_audit_data(struct audit_buffer *ab,
> > > >          case LSM_AUDIT_DATA_IPC:
> > > >                  audit_log_format(ab, " key=%d ", a->u.ipc_id);
> > > >                  break;
> > > > -       case LSM_AUDIT_DATA_CAP:
> > > > -               audit_log_format(ab, " capability=%d ", a->u.cap);
> > > > +       case LSM_AUDIT_DATA_CAP: {
> > > > +               const struct inode *inode;
> > > > +
> > > > +               audit_log_format(ab, " capability=%d ", a->u.cap_struct.cap);
> > > > +               if (a->u.cap_struct.cad) {
> > > > +                       switch (a->u.cap_struct.cad->type) {
> > > > +                       case CAP_AUX_DATA_INODE: {
> > > > +                               inode = a->u.cap_struct.cad->u.inode;
> > > > +
> > > > +                               audit_log_format(ab, " dev=");
> > > > +                               audit_log_untrustedstring(ab,
> > > > +                                       inode->i_sb->s_id);
> > > > +                               audit_log_format(ab, " ino=%lu",
> > > > +                                       inode->i_ino);
> > > > +                               break;
> > > > +                       }
> > >
> > > Since you are declaring "inode" further up, there doesn't appear to be
> > > any need for the CAP_AUX_DATA_INODE braces, please remove them.
> > >
> > > The general recommended practice when it comes to "sometimes" fields
> > > in an audit record, is to always record them in the record, but use a
> > > value of "?" when there is nothing relevant to record.  For example,
> > > when *not* recording inode information you would do something like the
> > > following:
> > >
> > >    audit_log_format(ab, " dev=? ino=?");
> > >
> > The issue this brings up is what happens when this is expanded to more
> > cases? Assuming there will be a case here for logging audit data for task
> > based capabilities (CAP_AUX_DATA_TASK), what do we want to have happen if we
> > are recording *neither* inode information nor task information (say a PID)?
> > If we log something in the inode case, we presumably don't want to call
> > audit_log_format(ab, " dev=?, pid=?") as well. (And vice versa for when we
> > log a pid and no inode).
>
> Yup.  This record is already a mess due to that.
>
> The general solution is to either use a new record type for each
> variant, or to use an auxiliary record for each additional piece of
> information.  The long term solution that has been suggested it to move
> away from a text message format.

This is why I was suggesting that Aaron look into allowing the LSMs to
request generation of audit records in the earlier thread (and
mentioned it again at the top of my comments in this thread).

-- 
paul moore
www.paul-moore.com
