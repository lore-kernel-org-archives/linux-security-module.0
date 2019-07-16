Return-Path: <SRS0=8dNN=VN=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90580C7618F
	for <linux-security-module@archiver.kernel.org>; Tue, 16 Jul 2019 23:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E01220880
	for <linux-security-module@archiver.kernel.org>; Tue, 16 Jul 2019 23:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="gZG/61c8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbfGPXJj (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 16 Jul 2019 19:09:39 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44838 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728235AbfGPXJj (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 16 Jul 2019 19:09:39 -0400
Received: by mail-lf1-f67.google.com with SMTP id r15so10058656lfm.11
        for <linux-security-module@vger.kernel.org>; Tue, 16 Jul 2019 16:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=50E+D8RNg2pkL4Nfrd2jVn+hIK2jQ9NMYZfs4HmwmsQ=;
        b=gZG/61c8fdvJIPoSMDcxcVTzhmPQsGlidi7N/q0+vSVBaLuRW5ZCHcrUR+RIBbMj2w
         UOKTbakAuUN9yGKRZk12eXLUndlJh9l72lu5wT9NKXZ7uLPnp6678CMzNwzPON7HH+D+
         6NFcecb8L0nKT0aK7/5V4IhNB/YxSW/tR1jhUEbpcMIDnf+0aUM827kfdpInB+VSWUch
         2OdnHQd3RjpYnz+bfTJHxUY9JgGE7yPlrWuNBplJxwptDKNuGGNaKgJClqqqPPAvbFkv
         FuAljaKZvXDFrADCw0MN5moGHMZUacdGnsJJZSr62jfoZFNv4QuhwURKG3rsfzKwxFa6
         n+cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=50E+D8RNg2pkL4Nfrd2jVn+hIK2jQ9NMYZfs4HmwmsQ=;
        b=g4ZeNvV963c8fN/xyroIPn7t5klXTBLgAyFFA/11bmhxL/RHzYYjaTDt+DHQnp1SiN
         YAuYd1f3d1A4P3VKEXOEahDUODxJLKPwHTGmjAAAo7FmHns2jEq9/NL/fNCRqi/JZPHy
         Gh7ajiq9WORVicwrwBHkdjpbtLmPJocOIgnkHgjtsxz97muAj4OVkRe9oz6LGDcymw/g
         uDVJJZbcg1aJq/B5iCio6yyN6rnq6fFeQw/bJXsfLspvagLsBiq/tGVweK+YnHp8oJ1N
         tFtW7fLggO/HgdyeFrZ2DKgxNKJ77UppttQR03hNEKfGM6u8k5rJRmw+EIaddAI5+C02
         MhsQ==
X-Gm-Message-State: APjAAAX/VlCJAC+Ntxx+PY/K6OSnzkvR6nzfXCaK4F1/B6TJMfHJb613
        f1AqxHwrUcBGiO+QfiqdEshtyJ6Ua642ziFkQQ==
X-Google-Smtp-Source: APXvYqz7uiL5oXkYo6/dnSeDDSWZts2/zfZfVBjVpZciqcpZ3swxXmA7fvF2nX8Joc7qHo1YMZswbGj5Vqr+rovszMc=
X-Received: by 2002:ac2:4c37:: with SMTP id u23mr2255723lfq.119.1563318576304;
 Tue, 16 Jul 2019 16:09:36 -0700 (PDT)
MIME-Version: 1.0
References: <f824828c-5c9d-b91e-5cec-70ee7a45e760@schaufler-ca.com>
 <d1a237d3-4b72-48b0-27d6-fb168354ad31@schaufler-ca.com> <CAHC9VhTQLihNQ1iGjJB=LAn=C6BQokFsjsRcj8O_O9AjqQ7HBg@mail.gmail.com>
 <2517266.eHZzEmjMsX@x2>
In-Reply-To: <2517266.eHZzEmjMsX@x2>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 16 Jul 2019 19:09:25 -0400
Message-ID: <CAHC9VhS-WGuKYzG5AU01BN8tk8nzp+7qxk7Sz-hbHQGL+UXOfg@mail.gmail.com>
Subject: Re: Preferred subj= with multiple LSMs
To:     Steve Grubb <sgrubb@redhat.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        "linux-audit@redhat.com" <linux-audit@redhat.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Jul 16, 2019 at 5:46 PM Steve Grubb <sgrubb@redhat.com> wrote:
> On Tuesday, July 16, 2019 5:25:21 PM EDT Paul Moore wrote:

...

> > Agreed.  While I'm not going to be on a specific Linux release, I do
> > believe that at some point in the future the LSM stacking work is
> > going to land in Linus' tree.  Perhaps you'll never see it Steve, but
> > we need to prepare the code to handle it when it happens.
>
> And I agree with that. I'm saying that if we push it all in subj= then it is
> not a big penalty.

I'm going to disagree on that quite severely.  As I mentioned
previously there isn't an easy or sane way to delimit between the
different LSM labels which means sorting out the multiplexed "subj"
field is going to be a post processing nightmare.

> It saves major breakage. Every single event is required to
> have a subj= field if its a MAC system.

All of the options we've discussed still record the LSM credentials in
the audit record; no one is talking about *not* recording the LSM
credentials.  What we are discussing is *how* they are recorded.

> By changing it to lsm_subj= it changes
> the layout of every single event. And it make more to parse. And searching
> the labels is worse because it has to iterate over a list of *_subj to match
> it. This will hurt performance because it is for every single event.

I can almost guarantee that looking for subj/subj_X is going to be
much easier than safely parsing a multiplexed subj field.  Not to
mention the multiplexed approach is just awful to read compared to
some of the other suggestions.

> > For my own sanity, here is a quick summary of the constraints as I
> > currently see them, please feel free to add/disagree:
> >
> > * We can't have multiple "subj" fields in a single audit record.
> > * The different LSMs all have different label formats and allowed
> > characters.  Further, a given label format may not be unique for a
> > given LSM; for example, Smack could be configured with a subset of
> > SELinux labels.
> > * Steve's audit tools appear to require a "subj" and "obj" fields for
> > LSM information or else they break into tiny little pieces.
>
> It changes all knowledge of where to look for things. And considering
> considering that events could be aggregated from systems of different ages/
> distributions, audit userspace will always have to be backwards compatible.

The subj_X approach is still backwards compatible, the difference is
that old versions of the tools get a "?" for the LSM creds which is a
rather sane way of indicating something is different.  The multiplexed
approach would result in effectively garbage for the LSM creds unless
the higher layers of audit tooling are updated to understand the new
multiplexed format *and* *continuously* *updated* as new LSMs are
stacked because you need to understand each LSMs label format if you
are going to safely parse the multiplexed format.  With the subj_X
approach the higher layer tooling simply needs to look for subj_X
fields when it sees "subj=?", and then it can safely extract/parse
each LSM's label without needing to understand or inspect the labels
themselves.

> > What if we preserved the existing subj/obj fields in the case where
> > there is only one "major" LSM (SELinux, Smack, AppArmor, etc.):
> >
> >   subj=<lsm_label>
> >
> > ... and in the case of multiple major LSMs we set the subj value to
> > "?" and introduce new subj_X fields (as necessary) as discussed above:
> >
> >   subj=? subj_smack=<smack_label> subj_selinux=<selinux_label> ...
> >
> > ... I believe that Steve's old/existing userspace tools would simply
> > report "?"/unknown LSM credentials where new multi-LSM tools could
> > report the multiple different labels.
>
> Common Criteria as well as other standards require subject labels to be
> searchable. So, changing behavior based on how many modules will still cause
> problems with performance because I'll always have to assume it could be
> either way and try both.

Once again, I believe that the subj_X approach is going to be faster
than safely parsing the multiplexed format.

-- 
paul moore
www.paul-moore.com
