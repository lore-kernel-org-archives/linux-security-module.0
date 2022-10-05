Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4378C433F5
	for <linux-security-module@archiver.kernel.org>; Wed,  5 Oct 2022 20:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbiJEUpA (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 5 Oct 2022 16:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiJEUo7 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 5 Oct 2022 16:44:59 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8888A27DCF
        for <linux-security-module@vger.kernel.org>; Wed,  5 Oct 2022 13:44:57 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-132555b7121so48662fac.2
        for <linux-security-module@vger.kernel.org>; Wed, 05 Oct 2022 13:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=HxKDra6grJcWD9CqHYMkRMp+vE+Qyi1aeN+LauRdjq4=;
        b=u+3ecqY1nx8e0ZshkkP0b2uySRbILkUIxFh5s8rISRBxLuj+MR/2ZUi8TOHp5CF/Tr
         WPR4yfgljwIagRkXG/TsSYmI0tpFdS/hmQ5YMPdpFd3uuF/XG9J05L5Noy3meoMir+L3
         uG76c/pzEEv9RHioeJu4MpzaFUKCX1ZOAHBlXVO+Tld09SRP/dczI+R7dPni7/MjQMuA
         qaDOF1yTATVwCXHaxCt1o3W2y8Go/aAPcYRvIdp4IXubdf66GBxsYbiMgQeuklJVpCJJ
         ereRKliPGfQX3ack9O5tbzUb4nRdq3o+pRpzhhqY5A0V7RWzWPaqQrjgPv/aHOVcCceP
         hkzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=HxKDra6grJcWD9CqHYMkRMp+vE+Qyi1aeN+LauRdjq4=;
        b=KzwXqcCc8bADPV/7xyzzE/izXLtr9WnIokgRVV2QLIQmSaiH1y4PMqn+F7QDRG1EpP
         B4XsLysn7ehZNt8YeALQrKA6R+X04M1UMSaUuPm6pfSswZH+yeODS/Ypo4q56B3Q+kyw
         UH7/gIkJ4O0okgMSUqOzE0sm+zbhjBycBtl6reFC9nMJDXyQNBewoBMVcy6HcxWq8Ron
         rnZjd79o1D9K3IXvvh1EsuXwyGd+bjdfDJcm7uqdM700VABMp9xnlyGxH9zvQQM1gK1A
         4VMbQDxHLyfLmRLzMlC8AWm4gMc4lo9DnbREXUjIpPxVPGzA2eBUI12/Iv5102m36rgq
         tR9g==
X-Gm-Message-State: ACrzQf1vpnvtcBSOZQAyF5wqNRcqnFOcvU7NLqCFUFd9Gj5VateaVN1M
        e2yrjey+O/VjfBc8VTMxrbs9HXqgCLeswm+R3sU8wRXyt31H
X-Google-Smtp-Source: AMsMyM7oCOUKqnFgeWu0J+edPTN5UWcgccxor+gfSCZhi7qgSbllRBCRaxT4WOKCYdwJzSmzf1A0EjK3mntCtiWcFB0=
X-Received: by 2002:a05:6870:a916:b0:131:9361:116a with SMTP id
 eq22-20020a056870a91600b001319361116amr812898oab.172.1665002696779; Wed, 05
 Oct 2022 13:44:56 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 5 Oct 2022 16:44:46 -0400
Message-ID: <CAHC9VhTGE1cf_WtDn4aDUY=E-m--4iZXWiNTwPZrP9AVoq17cw@mail.gmail.com>
Subject: SO_PEERSEC protections in sk_getsockopt()?
To:     Martin KaFai Lau <martin.lau@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Martin,

In commit 4ff09db1b79b ("bpf: net: Change sk_getsockopt() to take the
sockptr_t argument") I see you wrapped the getsockopt value/len
pointers with sockptr_t and in the SO_PEERSEC case you pass the
sockptr_t:user field to avoid having to update the LSM hook and
implementations.  I think that's fine, especially as you note that
eBPF does not support fetching the SO_PEERSEC information, but I think
it would be good to harden this case to prevent someone from calling
sk_getsockopt(SO_PEERSEC) with kernel pointers.  What do you think of
something like this?

  static int sk_getsockopt(...)
  {
    /* ... */
    case SO_PEERSEC:
      if (optval.is_kernel || optlen.is_kernel)
        return -EINVAL;
      return security_socket_getpeersec_stream(...);
    /* ... */
  }

-- 
paul-moore.com
