Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A44E0C77B76
	for <linux-security-module@archiver.kernel.org>; Mon, 17 Apr 2023 11:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjDQLv0 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 17 Apr 2023 07:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjDQLvZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 17 Apr 2023 07:51:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D077A84
        for <linux-security-module@vger.kernel.org>; Mon, 17 Apr 2023 04:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681732089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oVc9uxy2kIdreOR/jYYEkHBdj+2RYiJitTncQTj92Ak=;
        b=EK1Q0z3fnLQeuiJ750sdA2A8hWi26nX2XQl8ENCSkDDVckzzcuFflgzSPLbtf8qo/fniGR
        N3mzGGMoZrYb88PmmBh51AadcKWLrezluvQv1Y+iAOITkYqFVPY9ErE/u2wmZ4GMLGSIGt
        dehvirPgCn5gHBFPfaK5Nh/3vThxcWo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-9tbGJ2WPNXyCTpsNi7m5sA-1; Mon, 17 Apr 2023 07:01:22 -0400
X-MC-Unique: 9tbGJ2WPNXyCTpsNi7m5sA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f16f50aeb5so4645135e9.3
        for <linux-security-module@vger.kernel.org>; Mon, 17 Apr 2023 04:01:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681729281; x=1684321281;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oVc9uxy2kIdreOR/jYYEkHBdj+2RYiJitTncQTj92Ak=;
        b=Nald2gawBXaICZkobKPUtygdPVFMBX8PNomY8mCO4bCJRy23Ww7sl1Ff3VZOBDD2w/
         fEQ6T+wDRJxDHWDBAkD+EXrgxnIQYzLGOAHowRaI73pOWO9wrfGw2kB95KYcVxhNATxU
         ii7j9z678Y0LJr7g6Fx5ne2ROCp51uamn38GlzBkB3Cc1FugHYTjkU5ll+rfMmR4z7kZ
         Prf+8lh0nH3VD9k984IvfyXExUgsWQ7I/z6WCxnUE2qAqfHSpew+CHzQda/auz8Cu1NJ
         2MNioZFgFn3hgmW7VpG4pb6FK804FDZSWLajKbUsz7MxCFXU30aTT3WpROSqYEqDTBo7
         USiA==
X-Gm-Message-State: AAQBX9dRW4dzTF3Gzs5P0qEkS++kJi+HjSV6aUKWVCHb9n/Fjdtlvsfg
        vAn56H9gyLnf6CJe1NxKynq8sOuPbbURWoXF/kf3cTfQiNDi8I3mLylcC56yFnDJXa4CW2FpH6s
        q4cqfVFlA1i209399RoRRu58le/dib/N02Lo8
X-Received: by 2002:a05:6000:1376:b0:2f7:fb78:9694 with SMTP id q22-20020a056000137600b002f7fb789694mr5066289wrz.17.1681729281619;
        Mon, 17 Apr 2023 04:01:21 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZQIa4sVrexrjBGWt+x2dl05vD2C7OxIO4qZKWXoX9kbiyotAMI/EdKnSlVTtQjGuOSPjILbQ==
X-Received: by 2002:a05:6000:1376:b0:2f7:fb78:9694 with SMTP id q22-20020a056000137600b002f7fb789694mr5066215wrz.17.1681729280958;
        Mon, 17 Apr 2023 04:01:20 -0700 (PDT)
Received: from ?IPV6:2003:cb:c700:fc00:db07:68a9:6af5:ecdf? (p200300cbc700fc00db0768a96af5ecdf.dip0.t-ipconnect.de. [2003:cb:c700:fc00:db07:68a9:6af5:ecdf])
        by smtp.gmail.com with ESMTPSA id h12-20020a5d4fcc000000b002f22c44e974sm10214704wrw.102.2023.04.17.04.01.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 04:01:20 -0700 (PDT)
Message-ID: <8a323d9f-f54e-065d-d611-0a07aea170c8@redhat.com>
Date:   Mon, 17 Apr 2023 13:01:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v3 3/7] mm/gup: remove vmas parameter from
 get_user_pages_remote()
To:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Paolo Bonzini <pbonzini@redhat.com>
References: <cover.1681558407.git.lstoakes@gmail.com>
 <523f0764f4979276a6d4b89cbad9af9124e4bf0a.1681558407.git.lstoakes@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <523f0764f4979276a6d4b89cbad9af9124e4bf0a.1681558407.git.lstoakes@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 15.04.23 14:09, Lorenzo Stoakes wrote:
> The only instances of get_user_pages_remote() invocations which used the
> vmas parameter were for a single page which can instead simply look up the
> VMA directly. In particular:-
> 
> - __update_ref_ctr() looked up the VMA but did nothing with it so we simply
>    remove it.
> 
> - __access_remote_vm() was already using vma_lookup() when the original
>    lookup failed so by doing the lookup directly this also de-duplicates the
>    code.
> 
> This forms part of a broader set of patches intended to eliminate the vmas
> parameter altogether.
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> ---

I guess we should never drop the mmap lock temporarily in these cases, 
so it's fine.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

