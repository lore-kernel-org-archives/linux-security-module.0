Return-Path: <SRS0=vovI=D5=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A6FC388F7
	for <linux-security-module@archiver.kernel.org>; Thu, 22 Oct 2020 08:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 944A9223BF
	for <linux-security-module@archiver.kernel.org>; Thu, 22 Oct 2020 08:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hyGBvCMF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442839AbgJVIIG (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 22 Oct 2020 04:08:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30365 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2894367AbgJVIFC (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 22 Oct 2020 04:05:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603353900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZGO0QiRe3SK8XbObfJueMNzuBhBLo865IU+xMLvpc0g=;
        b=hyGBvCMFD4WmO4MEaMDGErrS0bU/NSWbMB/yS82QmYmCOClZRKRaEvrT2c9hVmcBIMQ4Go
        LQ85jGdmSnuEJDWMrh6dsABkeeaBHKUx/sPyHR/yQs+s2avE2Lsh/BA9v2oH8WaUqhIYto
        mhH2M5vfkSMi4UC0ePmEf9idKc3OSVw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-DsQE5tZ4MHukRExVt5o6Lw-1; Thu, 22 Oct 2020 04:04:56 -0400
X-MC-Unique: DsQE5tZ4MHukRExVt5o6Lw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD17664095;
        Thu, 22 Oct 2020 08:04:54 +0000 (UTC)
Received: from [10.36.113.152] (ovpn-113-152.ams2.redhat.com [10.36.113.152])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AE7CB60BFA;
        Thu, 22 Oct 2020 08:04:51 +0000 (UTC)
Subject: Re: [PATCH] mm, hugetlb: Avoid double clearing for hugetlb pages
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>
Cc:     "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        linux-mm@kvack.org, kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org, kernel@gpiccoli.net,
        cascardo@canonical.com, Alexander Potapenko <glider@google.com>,
        James Morris <jamorris@linux.microsoft.com>,
        Kees Cook <keescook@chromium.org>
References: <20201019182853.7467-1-gpiccoli@canonical.com>
 <20201020082022.GL27114@dhcp22.suse.cz>
 <9cecd9d9-e25c-4495-50e2-8f7cb7497429@canonical.com>
 <20201021061538.GA23790@dhcp22.suse.cz>
 <0ad2f879-7c72-3eef-5cb6-dee44265eb82@redhat.com>
 <20201021113114.GC23790@dhcp22.suse.cz>
 <7c47c5f1-2d7e-eb7a-b8ce-185d715f5cfe@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <dc49a38c-7be6-5f32-94f5-0de82ed77b53@redhat.com>
Date:   Thu, 22 Oct 2020 10:04:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <7c47c5f1-2d7e-eb7a-b8ce-185d715f5cfe@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 22.10.20 01:32, Mike Kravetz wrote:
> On 10/21/20 4:31 AM, Michal Hocko wrote:
>> On Wed 21-10-20 11:50:48, David Hildenbrand wrote:
>>> On 21.10.20 08:15, Michal Hocko wrote:
>>>> On Tue 20-10-20 16:19:06, Guilherme G. Piccoli wrote:
>>>>> On 20/10/2020 05:20, Michal Hocko wrote:
>>>>>>
>>>>>> Yes zeroying is quite costly and that is to be expected when the feature
>>>>>> is enabled. Hugetlb like other allocator users perform their own
>>>>>> initialization rather than go through __GFP_ZERO path. More on that
>>>>>> below.
>>>>>>
>>>>>> Could you be more specific about why this is a problem. Hugetlb pool is
>>>>>> usualy preallocatd once during early boot. 24s for 65GB of 2MB pages
>>>>>> is non trivial amount of time but it doens't look like a major disaster
>>>>>> either. If the pool is allocated later it can take much more time due to
>>>>>> memory fragmentation.
>>>>>>
>>>>>> I definitely do not want to downplay this but I would like to hear about
>>>>>> the real life examples of the problem.
>>>>>
>>>>> Indeed, 24s of delay (!) is not so harmful for boot time, but...64G was
>>>>> just my simple test in a guest, the real case is much worse! It aligns
>>>>> with Mike's comment, we have complains of minute-like delays, due to a
>>>>> very big pool of hugepages being allocated.
>>>>
>>>> The cost of page clearing is mostly a constant overhead so it is quite
>>>> natural to see the time scaling with the number of pages. That overhead
>>>> has to happen at some point of time. Sure it is more visible when
>>>> allocating during boot time resp. when doing pre-allocation during
>>>> runtime. The page fault path would be then faster. The overhead just
>>>> moves to a different place. So I am not sure this is really a strong
>>>> argument to hold.
>>>
>>> We have people complaining that starting VMs backed by hugetlbfs takes
>>> too long, they would much rather have that initialization be done when
>>> booting the hypervisor ...
>>
>> I can imagine. Everybody would love to have a free lunch ;) But more
>> seriously, the overhead of the initialization is unavoidable. The memory
>> has to be zeroed out by definition and somebody has to pay for that.
>> Sure one can think of a deferred context to do that but this just
>> spreads  the overhead out to the overall system overhead.
>>
>> Even if the zeroying is done during the allocation time then it is the
>> first user who can benefit from that. Any reuse of the hugetlb pool has
>> to reinitialize again.
> 
> I remember a conversation with some of our database people who thought
> it best for their model if hugetlb pages in the pool were already clear
> so that no initialization was done at fault time.  Of course, this requires
> clearing at page free time.  In their model, they thought it better to pay
> the price at allocation (pool creation) time and free time so that faults
> would be as fast as possible.
> 
> I wonder if the VMs backed by hugetlbfs pages would benefit from this
> behavior as well?

So what VMMs like qemu already do is prealloc/prefault all hugetlbfs
memory (if told to, because it's not desired when overcommitting memory)
- relevant for low-latency applications and similar.

https://github.com/qemu/qemu/blob/67e8498937866b49b513e3acadef985c15f44fb5/util/oslib-posix.c#L561

That's why starting a VM backed by a lot of huge pages is slow when
prefaulting: you wait until everything was zeroed before booting the VM.

> 
> If we track the initialized state (clean or not) of huge pages in the
> pool as suggested in Michal's skeleton of a patch, we 'could' then allow
> users to choose when hugetlb page clearing is done.

Right, in case of QEMU if there are zeroed pages
a) prealloc would be faster
b) page faults would be faster

Also we could do hugetlb page clearing from a background thread/process,
as also mentioned by Michal.

> 
> None of that would address the original point of this thread, the global
> init_on_alloc parameter.

Yes, but I guess we're past that: whatever leaves the buddy shall be
zeroed out. That's the whole point of that security hardening mechanism.


-- 
Thanks,

David / dhildenb

