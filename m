Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD32DC25B06
	for <linux-security-module@archiver.kernel.org>; Sun, 14 Aug 2022 18:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbiHNSoi (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 14 Aug 2022 14:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiHNSoh (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 14 Aug 2022 14:44:37 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3F225B
        for <linux-security-module@vger.kernel.org>; Sun, 14 Aug 2022 11:44:36 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id uj29so10335884ejc.0
        for <linux-security-module@vger.kernel.org>; Sun, 14 Aug 2022 11:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=J/1Ppje2D4ygTtCi/v6sSl0bvuv22OreAgVk/52z4ls=;
        b=XP07/6x4E3GSkjXVhD0TElJ/Y1HCLXz8vjblL/ZLZye/XU4uBbY1qBm7E9w8zr9jA5
         wgNRWQ8DQZvsokoZtOwFRCLXZ0FXR0VDhKSMoquUTVqJCL+cuLLmOEvBIDsyZsTJSJ6y
         q/ByhRInYh+6bdddrIx/zoWXk/sCcLjORGb1Ga91H3imvgT6q9cxRBQo23KV9i7tJyFi
         sfboYKEZdRKCGEwmCpY6Kow4z+qOHCZBn+2Uz5FkwQ9djVtRqg7dNFnxPPgdnd+gOqVL
         3ZpMvtMEdu83dB1rvlEVmbpwWUu6VkydEW/Kqbw1WgqYOGBS7xBvHT8J8ei1lifjiBDy
         +70w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=J/1Ppje2D4ygTtCi/v6sSl0bvuv22OreAgVk/52z4ls=;
        b=jpIH1oBuTk1RiDkt9W2ejqbqL8YN5KSsr1xl8LaCsNHqfBo6IshETDPK2f/VGHrcrm
         Nk8noKllqhVcPzGEJjkMUAIc/eF6JH1MPj/MdTrIIVdtblGWjSoLz2ysEeg6pASKZRUN
         5oNHICF3YuVmsZr1/tFFZrKKND2RB0/j3J6cjW6xFalqqzwS2i+h+A7QkJUym0w9oG1j
         YNYTFiYBaAyGARGckd/Yua9y1TeDCgsro9Ea2G7QyXkoFMejPFi+WUjQU6S+2Gxo/jbR
         tP6gRTiLAnsaWUSuuJ/9jvx3uphU+2CPBhJ25bEvBIM4aeEEhVkH4/nBUEQ5iFqE3IiL
         lXUA==
X-Gm-Message-State: ACgBeo2n2cPsHDSBLes+quuG9fyHqcWgcrrIkK75hxtZ1urtJ90Oyazl
        Dau8m5korh6QI/VZjUokN+Y=
X-Google-Smtp-Source: AA6agR7p3I7+tYLdpVlPXMV+qmPjyqM4qJfdxJut0Ucv9fzUmKKvrhZ1FE80wLR38oM0QF4I+P0Tsw==
X-Received: by 2002:a17:906:8a45:b0:730:9715:369d with SMTP id gx5-20020a1709068a4500b007309715369dmr8294222ejc.105.1660502675056;
        Sun, 14 Aug 2022 11:44:35 -0700 (PDT)
Received: from nuc ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id u15-20020a056402064f00b0043a7c24a669sm5109917edx.91.2022.08.14.11.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 11:44:34 -0700 (PDT)
Date:   Sun, 14 Aug 2022 20:44:32 +0200
From:   =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH v3 2/4] selftests/landlock: Selftests for file truncation
 support
Message-ID: <YvlCkA37naEUoeMY@nuc>
References: <20220804193746.9161-1-gnoack3000@gmail.com>
 <20220804193746.9161-3-gnoack3000@gmail.com>
 <40ad7781-a94d-7be2-e5b9-64b6893a669e@digikod.net>
 <Yvd3+fy+mDBop+YA@nuc>
 <0e9d3b82-e08c-4f5d-012f-c3649da357bf@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0e9d3b82-e08c-4f5d-012f-c3649da357bf@digikod.net>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sat, Aug 13, 2022 at 02:45:12PM +0200, Mickaël Salaün wrote:
> On 13/08/2022 12:07, Günther Noack wrote:
> > On Thu, Aug 11, 2022 at 06:59:38PM +0200, Mickaël Salaün wrote:
> > > On 04/08/2022 21:37, Günther Noack wrote:
> > > > +/* Invokes creat(2) and returns the errno or 0. */
> > > > +static int test_creat(struct __test_metadata *const _metadata,
> > > > +		      const char *const path, mode_t mode)
> > > > +{
> > > > +	int fd = creat(path, mode);
> > > > +
> > > > +	if (fd < 0)
> > > > +		return errno;
> > > > +	ASSERT_EQ(0, close(fd));
> > >
> > > test_creat() contains an ASSERT, which would only print this line, which
> > > would not help much if it is called multiple times, which is the case. I
> > > prefer not passing _metadata but only returning errno or 0 and handling the
> > > ASSERT in layout1.truncate* . It is not the case everywhere but we should
> > > try to follow this rule as much as possible.
> >
> > Thanks, that's a good point that the line number attribution becomes confusing.
> >
> > I changed these ASSERT_EQ() calls to just return the errno directly.

Brief follow up on this; I changed it to return a special error EBADFD
in the places in the test_foo() helpers where I previously used
ASSERT_EQ. The errors checked there are errors from open() and close()
in cases where they are needed as prerequisites or cleanups to the
actual thing we want to test.

Specifically open() can also return EACCES due to Landlock policies,
and I don't want to confuse that with the EACCES that ftruncate() may
return.

I use EBADFD because it's a reasonably obscure error code and should
not overlap. (Suggestions welcome)

> > **To make a constructive proposal**:
> >
> > I think that using EXPECT improves debuggability in case of a test
> > failure, but both with EXPECT and with ASSERT, the tests will give the
> > same guarantee that the code works, so I feel that this should not be
> > blocking the truncate patch... so I'd just go and convert it all to
> > ASSERTs, it'll be consistent with the surrounding tests, and we can
> > have that EXPECT/ASSERT discussion separately if you like. Does that
> > sound good?
>
> You did the work to differentiate EXPECT from ASSERT, and as long as failing
> an EXPECT doesn't change the semantic of the next tests (i.e. not changing a
> common state, e.g. by creating or removing a file), I think we should keep
> your current code. This may be tricky to do correctly, hence my reluctance.
> I'll think a bit more about that but it will be much more easier to replace
> EXPECT with ASSERT than to re-add EXPECT, and it wouldn't require another
> patch series, so let's not change your patch. :)

Ack, thanks :)

--
