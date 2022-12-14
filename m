Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF52C4332F
	for <linux-security-module@archiver.kernel.org>; Wed, 14 Dec 2022 22:14:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiLNWOo (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 14 Dec 2022 17:14:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiLNWOn (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 14 Dec 2022 17:14:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D046C396C4
        for <linux-security-module@vger.kernel.org>; Wed, 14 Dec 2022 14:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671056036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aW8p5rry295NkbefzP1yJqPHwKJ4e7g3eAuxYhpUnzE=;
        b=IJp3+KV+nakUD8Vhwa05F117HxERJ8sBy2y1hrQyVKbEXA/27GW32oJjr0Uwhqwxnue/wP
        0swYgW9rLmYl8XkKX54RX7dK9zxLO9kh0XQL2NMlltdM5V9TqdgZlq3bAwt6cWq/nK/y1B
        fJN49eJ6JRz07zUJCciJNZgvxoGrafQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-418-feJ9q6QpPgyrm31fTV0RtA-1; Wed, 14 Dec 2022 17:13:55 -0500
X-MC-Unique: feJ9q6QpPgyrm31fTV0RtA-1
Received: by mail-wm1-f72.google.com with SMTP id q21-20020a7bce95000000b003d236c91639so155327wmj.8
        for <linux-security-module@vger.kernel.org>; Wed, 14 Dec 2022 14:13:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aW8p5rry295NkbefzP1yJqPHwKJ4e7g3eAuxYhpUnzE=;
        b=3f/5VHQen7DSUwd/3bUlx8VzULA97byrEAQa3igmMkqRtDvxaPfLdTrH0TrTTWsnjw
         tWtyoFd31K6Aq2FaQuAP49euN+RjZS4GT4YD5lGBHpjnhmcWyRa925q+dMWPdJUmhL97
         FpEujFHCxtJ2V6iBAFpbUwjABjIEj+ZT1UZPb1FYFROrtdP00XvgDJawvLYJIQC3CxZa
         nIuBtLj2e8j7UWbwSI/Mb/MwzQ8QUH/2pjT6eLZgaV9l9em9Zuu+pwP3hEppcckpyTKN
         V+OEaoMRdhwYPx4W6UcwNPTCmANlDkf/LEbrIYo4KePe+pOLmVwMdLDbZBNT9EH88PXG
         vpaA==
X-Gm-Message-State: ANoB5pmOn+Z7qN9WmnGp2U605aiYOSFYQ7KVIj03TsVwaTpWSqyReAIy
        Ez2j9vwdW8/OIJbyVF5DjCDBVokkWmepluntJEBNMP87DHbi0030UnbKvtGNYgCghm2IeFlRyKT
        EJFIwFW1cJWE0KH/mlvev5bzosk3ElWcoSBnOx5h8VbOy+1pmVZxNcBbrSYMSH/fyV4W1HUf8Ae
        T+l0CKI3UKUg==
X-Received: by 2002:a05:600c:5386:b0:3cf:8155:2adc with SMTP id hg6-20020a05600c538600b003cf81552adcmr19884832wmb.33.1671056034307;
        Wed, 14 Dec 2022 14:13:54 -0800 (PST)
X-Google-Smtp-Source: AA0mqf68HKsZKNnRWxk2Lze71V2S9dTijIVMH9f0Wt6PD1jdQF6OZ5wOAj/Q1v+j8/lMDCgXi1f6KA==
X-Received: by 2002:a05:600c:5386:b0:3cf:8155:2adc with SMTP id hg6-20020a05600c538600b003cf81552adcmr19884817wmb.33.1671056034014;
        Wed, 14 Dec 2022 14:13:54 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-97-87.dyn.eolo.it. [146.241.97.87])
        by smtp.gmail.com with ESMTPSA id p11-20020a05600c430b00b003c6b70a4d69sm3502193wme.42.2022.12.14.14.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 14:13:53 -0800 (PST)
Message-ID: <401591eef86a3c47065e9873d3f25ff978f0a51d.camel@redhat.com>
Subject: Re: [PATCH 0/2] lsm: introduce and use security_mptcp_add_subflow()
From:   Paolo Abeni <pabeni@redhat.com>
To:     linux-security-module@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org,
        mptcp@lists.linux.dev
Date:   Wed, 14 Dec 2022 23:13:52 +0100
In-Reply-To: <cover.1671054577.git.pabeni@redhat.com>
References: <cover.1671054577.git.pabeni@redhat.com>
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, 2022-12-14 at 23:01 +0100, Paolo Abeni wrote:
> This series is an attempt to solve the LSM labeling breakage
> reported here:
> 
> https://lore.kernel.org/linux-security-module/CAHC9VhSQnhH3UL4gqzu+YiA1Q3YyLLCv88gLJOvw-0+uw5Lvkw@mail.gmail.com/
> 
> As per previous discussion, a new LSM hook is introduced and
> invoked by the mptcp code to let LSMs set the appropriate label
> for the newly created subflow.
> 
> I'm not sure the chosen hook name is a perfect fit, any suggestion
> more then welcome.
> The new hook requires both the mptcp socket reference and the
> subflow socket reference, even if the provided LSM implementation
> for selinux ends-up accessing only the subflow socket. Possibly
> other LSM implementation could need or use the addtional parameter.

I forgot to mention this has been tested vs the reproducer described in
the above link and vs the mptcp self-tests.

Cheers,

Paolo

