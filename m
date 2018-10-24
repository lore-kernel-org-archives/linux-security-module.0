Return-Path: <SRS0=JlTe=NE=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E66ECDE44
	for <linux-security-module@archiver.kernel.org>; Wed, 24 Oct 2018 20:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B0632082F
	for <linux-security-module@archiver.kernel.org>; Wed, 24 Oct 2018 20:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FgNSvNZT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B0632082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725873AbeJYElu (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 25 Oct 2018 00:41:50 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:43937 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbeJYElu (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 25 Oct 2018 00:41:50 -0400
Received: by mail-yb1-f196.google.com with SMTP id g75-v6so2683419yba.10
        for <linux-security-module@vger.kernel.org>; Wed, 24 Oct 2018 13:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TsdzQEsCFRB5ZvlDDE9nNL5K9y4g+QaqTv54PLCe7kA=;
        b=FgNSvNZTM6k8BDFlft3do1gGJGEjgfhqRCLx2EMcFcYNiHAhNERWCbUgZUOndN9ToK
         LbZY1/jlAHvd/IqrDvOBV1d5rlyDewiY+i32BsjpjdR3/vz+V/FZPA4O70PhNzHf7ARL
         fmypCoDLv9yDoeNJPNPCJ7hGmTK7B9W0lhrSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TsdzQEsCFRB5ZvlDDE9nNL5K9y4g+QaqTv54PLCe7kA=;
        b=lP6HiLivWlKbGKxpQtEhhKy3/ugLTQ0BKIBrBQ1Yhl+CujrpQB+TtC6jO2p2F6PG5c
         DozTO75zDD5+zZWfhJSKzNpoq5kXoDgWrHC7ReBk2c+LTu82iyHXljc61ZJAZMjVoJIR
         ikC/AfoCZDGtEuUUD3OntD9872ar/6cXLS/ZJmAmz1bLT6mNeTY6rjK19iC9TqYcAhw7
         GtujuqFt97KkKysj4BxJqwYzn+r3bg7fFpueFjwH5gk+0uXGt4Soa4rwCGZwQC7fZgXE
         IuO8gpjULQ5fLrBsnH9GCqAmd4TVtMbGYfOPnq0vrDfH+R5M9YJQiGb962AoWtDI9J30
         z0tw==
X-Gm-Message-State: AGRZ1gK1q4EfqB/XzX+LmvZui+/OzhbTK0GWxHwMkkVrEHqrBQW9RRxl
        sBa4O7Nslo4dCjrdx74744Bv/8VPWp8=
X-Google-Smtp-Source: AJdET5emFDZox9f7SByJzhI1Tw+eN8F8WoeSHA4/7CgS83t1ZOirDNzQiBQuoKqX2MZGz2rxI6GU7g==
X-Received: by 2002:a25:ba0f:: with SMTP id t15-v6mr3630201ybg.334.1540411940823;
        Wed, 24 Oct 2018 13:12:20 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id p7-v6sm3838616ywd.75.2018.10.24.13.12.16
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 13:12:17 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id e16-v6so2684888ybk.8
        for <linux-security-module@vger.kernel.org>; Wed, 24 Oct 2018 13:12:16 -0700 (PDT)
X-Received: by 2002:a25:3588:: with SMTP id c130-v6mr3791627yba.410.1540411936234;
 Wed, 24 Oct 2018 13:12:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:3990:0:0:0:0:0 with HTTP; Wed, 24 Oct 2018 13:12:15
 -0700 (PDT)
In-Reply-To: <33754ab5-5c7a-b174-0ad6-195323a169f1@schaufler-ca.com>
References: <20181011001846.30964-1-keescook@chromium.org> <CAGXu5jLBaHj5MhXaK-8zdu6Rgo2B6rEq+at17xZ1Puct+YUajQ@mail.gmail.com>
 <ZhaXhoElmWQlsxHmgFHpB2xSWzJYFZWBasrSKQNjGj4_T2A4AY2F9v1rP9LkUfilUbZ0ExWXX9koLNjUM8S6baX6xfSSMPXY_CpihbCetVc=@protonmail.ch>
 <CAGXu5j+kekUdcE2EhUu__8MXJ1O+D=-zTXLGNCRVa_VyDxePpw@mail.gmail.com>
 <f68e5f4b-6360-a9e7-597f-89d1d3ca73c1@canonical.com> <32stV62RmME8Dj5jKB8Z03zPe_Et72kMo71D8SpgSOHUo6SaROc8DomMWdk5jDGpyqVd8T63NIIK2NdDw95clpF8Uj47Wca2FBFItXDRh7E=@protonmail.ch>
 <38dde301-d77e-35fd-88d4-5cdc5b570ee8@canonical.com> <_CkJnKYmEZ4ZF0JtsSYuahAd9sgnX9OtcstjXaeqb8wn5uxfimc6S4jomly7If9VqnOXqXwaiCbJ9ttS6NiqE7n6cQUlwLvfO53paLmacvU=@protonmail.ch>
 <8251564f-ba7a-1777-a606-dec472b32f35@canonical.com> <CAGXu5j+2yVZ5DQHyqvJKnSYYqRCzeMtEabBwYFOWkTcwMUWhEw@mail.gmail.com>
 <96e92224-aedf-5026-d6dd-b29121b4dc0d@schaufler-ca.com> <CAGXu5jKFqtV_NFRaXPKVgNQt3F1pwFqopDLp1ZQJDGM_Bdid6Q@mail.gmail.com>
 <63410d08-d0d1-8cd9-5d9e-70d95a1a8ca0@schaufler-ca.com> <33754ab5-5c7a-b174-0ad6-195323a169f1@schaufler-ca.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 24 Oct 2018 13:12:15 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLyn6mLKFK+RuBkYWenm8sXXR+yqJ3VzVCpUqOVmru_XA@mail.gmail.com>
Message-ID: <CAGXu5jLyn6mLKFK+RuBkYWenm8sXXR+yqJ3VzVCpUqOVmru_XA@mail.gmail.com>
Subject: Re: [PATCH security-next v5 00/30] LSM: Explict ordering
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     John Johansen <john.johansen@canonical.com>,
        Jordan Glover <Golden_Miller83@protonmail.ch>,
        James Morris <jmorris@namei.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Paul Moore <paul@paul-moore.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        LSM <linux-security-module@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Oct 24, 2018 at 1:56 AM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 10/23/2018 12:05 PM, Casey Schaufler wrote:
>> On 10/23/2018 11:50 AM, Kees Cook wrote:
>>
>>> Did you poke around at my combined series?
>>> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=lsm/ordering-v6-blob-sharing
>> I hope to do that on the plane later today.
>
> I had a chance to poke at the combined series and it
> all seems to work as advertised.

/me stares at John, Paul, and Stephen. Hurry up and get off your planes! ;)

-Kees

-- 
Kees Cook
