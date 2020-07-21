Return-Path: <SRS0=/BYZ=BA=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F57AC4345A
	for <linux-security-module@archiver.kernel.org>; Tue, 21 Jul 2020 21:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 794CF20729
	for <linux-security-module@archiver.kernel.org>; Tue, 21 Jul 2020 21:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="Xaiud0Qh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731447AbgGUVQh (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 21 Jul 2020 17:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731439AbgGUVQh (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 21 Jul 2020 17:16:37 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD52C0619DB
        for <linux-security-module@vger.kernel.org>; Tue, 21 Jul 2020 14:16:36 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id f12so23018596eja.9
        for <linux-security-module@vger.kernel.org>; Tue, 21 Jul 2020 14:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PpobAsBikcZzGgFnqaofvkVdzW58Lh6D10Z7oCD2icY=;
        b=Xaiud0QhSy/r6srFLC9er7wlzLNhJ+x9jBLOQzxfK7m29SgnF630tbPQWUQseBSCju
         KrbRcGXupe16toOUy2OYa4QUFGQX9PiooUt6HS9DnozThiOUAlqPGXju+FatS0zW4ftE
         ELnozaxPZcpw/WmxLFM9jhJByCd8ghT6F+37Xs1g5xjC3gc0h0ONPmGdii3xfZU520ie
         h+Ir66N4019gG+oX+irJky59fod5on6Qp0/XyMB/bWu45E6qpB2OLdNJoB7Qr3hTbwlV
         rNbBzuyU4ySKTnijMgsB8IYVo7aEAPYKOxBQp1Hq8havf/ISvWUYaT69UdGjqFYs+4PK
         90FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PpobAsBikcZzGgFnqaofvkVdzW58Lh6D10Z7oCD2icY=;
        b=q7XAcPEh9u5ovUviQdcb51LeqTtq6JCZlN6b4ZaJk80hKZTN1kApobiFBXOIJmyQMa
         RvAsickn2fZ5e8RKLfhLc73j8FmoL8eOUACVRU59fRgyQvkbUPzXTEDSlwzmIo0MVLQL
         lPg+ED7IO5t1H27N7X7wKtS3IX3MrjOr89T4D/0J1/0R+s++gIVOT1Mqeci93uZq7L8h
         cOF+3bAxxBXYLjmskHBSPb40+aLVzhn3HYuPBBTKzPPlwZS34NXEFaYeTjgBsj8cnlL3
         hIkgjazVGwNj79KQ8FnKug4gmZ9wYYui1ss8Ee5YdsapPkPxmi0HwfSbtUqaO4oImE/u
         iOhg==
X-Gm-Message-State: AOAM530MAykrt9Ys0/weOVMjzoBZ2Ba75A3ytJdzznan8bJOKaxiLtlT
        rvTXpdB/Gni/tn2KErVzcjTeAX3c2WLwYk4G2hZ1
X-Google-Smtp-Source: ABdhPJyY2Ce5NqMGMBhWAGWwnzWTH0+myvH3o2aHnpLX7WPIWCXYWZRi2c+CytjWBqS3on7CikdMRT1S93rvuO3HPGc=
X-Received: by 2002:a17:906:1a59:: with SMTP id j25mr25594636ejf.398.1595366195416;
 Tue, 21 Jul 2020 14:16:35 -0700 (PDT)
MIME-Version: 1.0
References: <6effbbd4574407d6af21162e57d9102d5f8b02ed.1594664015.git.rgb@redhat.com>
 <CAHC9VhSyq7yKQqwvHL5syU9+TFki6-__WfCrvqewbnU3xpND4Q@mail.gmail.com>
 <20200714174353.ds7lj3iisy67t2zu@madcap2.tricolour.ca> <CAHC9VhQusQsdQc7EfdjdH5mp6qqqYVPHnG9nNhUhf3DS_cdWwA@mail.gmail.com>
 <20200714210027.me2ieywjfcsf4v5r@madcap2.tricolour.ca> <CAHC9VhQgDGPutYxQawMPmezm1a+i1nXO5KSn9_7KPDZsRBJ4pw@mail.gmail.com>
 <e6eb37d5-ec6b-852a-74df-bbf453607fbe@canonical.com>
In-Reply-To: <e6eb37d5-ec6b-852a-74df-bbf453607fbe@canonical.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 21 Jul 2020 17:16:24 -0400
Message-ID: <CAHC9VhSoUBqXh7ikVdpr9-e2+3Wx-A05g5EBjD3ka1i1xF2vMg@mail.gmail.com>
Subject: Re: [PATCH ghak84 v4] audit: purge audit_log_string from the
 intra-kernel audit API
To:     John Johansen <john.johansen@canonical.com>
Cc:     Richard Guy Briggs <rgb@redhat.com>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Eric Paris <eparis@parisplace.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Jul 21, 2020 at 3:31 PM John Johansen
<john.johansen@canonical.com> wrote:
> On 7/21/20 8:19 AM, Paul Moore wrote:
> > On Tue, Jul 14, 2020 at 5:00 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> >> On 2020-07-14 16:29, Paul Moore wrote:
> >>> On Tue, Jul 14, 2020 at 1:44 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> >>>> On 2020-07-14 12:21, Paul Moore wrote:
> >>>>> On Mon, Jul 13, 2020 at 3:52 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> >>>>>>
> >>>>>> audit_log_string() was inteded to be an internal audit function and
> >>>>>> since there are only two internal uses, remove them.  Purge all external
> >>>>>> uses of it by restructuring code to use an existing audit_log_format()
> >>>>>> or using audit_log_format().
> >>>>>>
> >>>>>> Please see the upstream issue
> >>>>>> https://github.com/linux-audit/audit-kernel/issues/84
> >>>>>>
> >>>>>> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> >>>>>> ---
> >>>>>> Passes audit-testsuite.
> >>>>>>
> >>>>>> Changelog:
> >>>>>> v4
> >>>>>> - use double quotes in all replaced audit_log_string() calls
> >>>>>>
> >>>>>> v3
> >>>>>> - fix two warning: non-void function does not return a value in all control paths
> >>>>>>         Reported-by: kernel test robot <lkp@intel.com>
> >>>>>>
> >>>>>> v2
> >>>>>> - restructure to piggyback on existing audit_log_format() calls, checking quoting needs for each.
> >>>>>>
> >>>>>> v1 Vlad Dronov
> >>>>>> - https://github.com/nefigtut/audit-kernel/commit/dbbcba46335a002f44b05874153a85b9cc18aebf
> >>>>>>
> >>>>>>  include/linux/audit.h     |  5 -----
> >>>>>>  kernel/audit.c            |  4 ++--
> >>>>>>  security/apparmor/audit.c | 10 ++++------
> >>>>>>  security/apparmor/file.c  | 25 +++++++------------------
> >>>>>>  security/apparmor/ipc.c   | 46 +++++++++++++++++++++++-----------------------
> >>>>>>  security/apparmor/net.c   | 14 ++++++++------
> >>>>>>  security/lsm_audit.c      |  4 ++--
> >>>>>>  7 files changed, 46 insertions(+), 62 deletions(-)
> >>>>>
> >>>>> Thanks for restoring the quotes, just one question below ...
> >>>>>
> >>>>>> diff --git a/security/apparmor/ipc.c b/security/apparmor/ipc.c
> >>>>>> index 4ecedffbdd33..fe36d112aad9 100644
> >>>>>> --- a/security/apparmor/ipc.c
> >>>>>> +++ b/security/apparmor/ipc.c
> >>>>>> @@ -20,25 +20,23 @@
> >>>>>>
> >>>>>>  /**
> >>>>>>   * audit_ptrace_mask - convert mask to permission string
> >>>>>> - * @buffer: buffer to write string to (NOT NULL)
> >>>>>>   * @mask: permission mask to convert
> >>>>>> + *
> >>>>>> + * Returns: pointer to static string
> >>>>>>   */
> >>>>>> -static void audit_ptrace_mask(struct audit_buffer *ab, u32 mask)
> >>>>>> +static const char *audit_ptrace_mask(u32 mask)
> >>>>>>  {
> >>>>>>         switch (mask) {
> >>>>>>         case MAY_READ:
> >>>>>> -               audit_log_string(ab, "read");
> >>>>>> -               break;
> >>>>>> +               return "read";
> >>>>>>         case MAY_WRITE:
> >>>>>> -               audit_log_string(ab, "trace");
> >>>>>> -               break;
> >>>>>> +               return "trace";
> >>>>>>         case AA_MAY_BE_READ:
> >>>>>> -               audit_log_string(ab, "readby");
> >>>>>> -               break;
> >>>>>> +               return "readby";
> >>>>>>         case AA_MAY_BE_TRACED:
> >>>>>> -               audit_log_string(ab, "tracedby");
> >>>>>> -               break;
> >>>>>> +               return "tracedby";
> >>>>>>         }
> >>>>>> +       return "";
> >>>>>
> >>>>> Are we okay with this returning an empty string ("") in this case?
> >>>>> Should it be a question mark ("?")?
> >>>>>
> >>>>> My guess is that userspace parsing should be okay since it still has
> >>>>> quotes, I'm just not sure if we wanted to use a question mark as we do
> >>>>> in other cases where the field value is empty/unknown.
> >>>>
> >>>> Previously, it would have been an empty value, not even double quotes.
> >>>> "?" might be an improvement.
> >>>
> >>> Did you want to fix that now in this patch, or leave it to later?  As
> >>> I said above, I'm not too bothered by it with the quotes so either way
> >>> is fine by me.
> >>
> >> I'd defer to Steve, otherwise I'd say leave it, since there wasn't
> >> anything there before and this makes that more evident.
> >>
> >>> John, I'm assuming you are okay with this patch?
> >
> > With no comments from John or Steve in the past week, I've gone ahead
> > and merged the patch into audit/next.
>
> sorry, for some reason I thought a new iteration of this was coming.
>
> the patch is fine, the empty unknown value should be possible here
> so changing it to "?" won't affect anything.

Yeah, I was kind of on the fence about requiring a new version from
Richard.  I think "?" is arguably the right approach, but I don't
think it matters enough to force the issue.  If it proves to be
problematic we can fix it later.

Regardless, it's in audit/next now.

-- 
paul moore
www.paul-moore.com
