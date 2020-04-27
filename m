Return-Path: <SRS0=keSj=6L=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB19C54FD0
	for <linux-security-module@archiver.kernel.org>; Mon, 27 Apr 2020 15:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAFE620661
	for <linux-security-module@archiver.kernel.org>; Mon, 27 Apr 2020 15:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ixjl1U9Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbgD0PPi (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 27 Apr 2020 11:15:38 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60738 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727771AbgD0PPh (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 27 Apr 2020 11:15:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588000536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eSpYzJ8vruskzw1ixWuPTFKODIOCb1DdC0Y5Ypx1fB0=;
        b=Ixjl1U9ZxAd7CT3hUfVBj4OC3cNpxodUZOfnDT/R+PiEaqt/AILrKzUj5Eo/rzHioy9Oln
        cvJLzIAKJ6wHxC5CCF4L4yKtPq/EaBFl8TJ9vWTotACZe3HuIK/3lALMrWYOMCjppl2WFY
        7T3/PCaVB0U3AZ/R1FovAdsEF10h418=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-SmafezhaOCibwS6n0GxajA-1; Mon, 27 Apr 2020 11:15:34 -0400
X-MC-Unique: SmafezhaOCibwS6n0GxajA-1
Received: by mail-wm1-f69.google.com with SMTP id w2so26408wmc.3
        for <linux-security-module@vger.kernel.org>; Mon, 27 Apr 2020 08:15:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eSpYzJ8vruskzw1ixWuPTFKODIOCb1DdC0Y5Ypx1fB0=;
        b=fenqKknB5tfdkpfmuN070B8mJkl/6xw1mFSXII7PYu0mpEnqKtTz5CxZIZNL2gpP4m
         5p1eT6hBlVey0bVfhNi9v8anGtcqFOUTDS/doTsJsUXBeOUi38GbNHNoVwvRcSzNElh3
         EglvxQsdGEbAu9Ak1So226FgnRqwxangn3vXDJLXcrmop/5G7ZLCVlOtP7SycUy5GmcP
         a9jaOtyMos3NdY7Tsui0o/4ytltbqVzduBBiqjgLCnKbRR7Y5nEXRytPIKCESvxA/867
         n1lU3bXN8s40/nvJhzKxfz4oSDGUAFno2I46DaTZd0Jl2lOsnYkpk4tdRUp3Tt6/d3hW
         EDng==
X-Gm-Message-State: AGi0Pua4IJYLMjBJ4YhFrchKaqT8uVfAOOIkrw08K5gZJpJra5wuaibD
        wDvPUYrVwyqKPNphUyZGvFsYd2ihPsQuqOmI5bACA7byvskZUoZl4WGrfeUGyTQt+DKLw+0yTm0
        UAlrXooysyiOJIIlqZvVnKJMEpSOVR1K6qf39
X-Received: by 2002:a5d:670d:: with SMTP id o13mr29924471wru.29.1588000533360;
        Mon, 27 Apr 2020 08:15:33 -0700 (PDT)
X-Google-Smtp-Source: APiQypK+T+6Aj+dLlxq4HhKDwXzdqmOqUdriVVov3jgAPiPujwYcHZ4fNtTJwlwzd9NWqPh44afp5Q==
X-Received: by 2002:a5d:670d:: with SMTP id o13mr29924444wru.29.1588000533150;
        Mon, 27 Apr 2020 08:15:33 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ac19:d1fb:3f5f:d54f? ([2001:b07:6468:f312:ac19:d1fb:3f5f:d54f])
        by smtp.gmail.com with ESMTPSA id n6sm23226378wrs.81.2020.04.27.08.15.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2020 08:15:32 -0700 (PDT)
Subject: Re: [PATCH v2 6/7] debugfs: switch to simplefs inode creation API
To:     Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        linux-fsdevel@vger.kernel.org
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Manoj N. Kumar" <manoj@linux.ibm.com>,
        "Matthew R. Ochs" <mrochs@linux.ibm.com>,
        Uma Krishnan <ukrishn@linux.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Joel Becker <jlbec@evilplan.org>,
        Christoph Hellwig <hch@lst.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-scsi@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20200421135119.30007-1-eesposit@redhat.com>
 <20200421135741.30657-4-eesposit@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <167ebece-2e50-5186-3a42-2fa491fcb8a5@redhat.com>
Date:   Mon, 27 Apr 2020 17:15:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200421135741.30657-4-eesposit@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 21/04/20 15:57, Emanuele Giuseppe Esposito wrote:
> -	inode = debugfs_get_inode(dentry->d_sb);

You're not removing debugfs_get_inode so I think you're going to get a
warning (same in tracefs)?

You can wait a few more days for reviews and/or Acked-bys (especially
for patches 6 and 7) and then post v3.

Since the touch-everything patch (#2) has already been reviewed, and
it's mechanical and not introducing any semantic change, you can
probably reduce the To/Cc list to filesystem, debugfs and tracefs
maintainers.

Thanks,

Paolo

