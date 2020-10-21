Return-Path: <SRS0=8N7l=D4=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB8EAC55178
	for <linux-security-module@archiver.kernel.org>; Wed, 21 Oct 2020 23:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89036223C7
	for <linux-security-module@archiver.kernel.org>; Wed, 21 Oct 2020 23:33:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PG+HyUmC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506855AbgJUXdD (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 21 Oct 2020 19:33:03 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:58918 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2506626AbgJUXdC (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 21 Oct 2020 19:33:02 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09LNTtBp180649;
        Wed, 21 Oct 2020 23:32:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=m0zgEX0pk4lY35wu/1smQ/InxNkemHewjbSlvWtt6RI=;
 b=PG+HyUmCj21+Pj1Sp3vTNUfzTARWYAqFD57RwAMM898TTq7T7vt0lT9C357B5ic/JDKq
 ytrBC+s+dVC7eUVxG7zp1wiPghYXLJfzUX9fRZXIBjTHlp/v4dRhCKkEzIqiXpe5/p5q
 MaGcIL7w5nwrEZs7iVEdT2LyzNoaB5dY06fjq1HYOR3qtKFwt1CarYHrLXUQZ2+ecxSV
 0Q1fNPF78CK6FXoeWtsWEqbeNFlK2zhh4cmPbExix/sKx9DFUxG20cLZEre1FdiCAVOF
 XOiVjWVqQuVpklJVQUDVGLC5HF13pCz4j+ULTa1Xk9n0VnBpSOX0gPKVMSlYR+ZoLEz4 Hg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 349jrpuc8j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 21 Oct 2020 23:32:34 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09LNQLa5050419;
        Wed, 21 Oct 2020 23:32:34 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 348a6pyw7v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Oct 2020 23:32:34 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09LNWTsv030733;
        Wed, 21 Oct 2020 23:32:29 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 21 Oct 2020 16:32:29 -0700
Subject: Re: [PATCH] mm, hugetlb: Avoid double clearing for hugetlb pages
To:     Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>
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
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <7c47c5f1-2d7e-eb7a-b8ce-185d715f5cfe@oracle.com>
Date:   Wed, 21 Oct 2020 16:32:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201021113114.GC23790@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9781 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 spamscore=0 adultscore=0 suspectscore=2 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010210162
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9781 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=2 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010210162
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 10/21/20 4:31 AM, Michal Hocko wrote:
> On Wed 21-10-20 11:50:48, David Hildenbrand wrote:
>> On 21.10.20 08:15, Michal Hocko wrote:
>>> On Tue 20-10-20 16:19:06, Guilherme G. Piccoli wrote:
>>>> On 20/10/2020 05:20, Michal Hocko wrote:
>>>>>
>>>>> Yes zeroying is quite costly and that is to be expected when the feature
>>>>> is enabled. Hugetlb like other allocator users perform their own
>>>>> initialization rather than go through __GFP_ZERO path. More on that
>>>>> below.
>>>>>
>>>>> Could you be more specific about why this is a problem. Hugetlb pool is
>>>>> usualy preallocatd once during early boot. 24s for 65GB of 2MB pages
>>>>> is non trivial amount of time but it doens't look like a major disaster
>>>>> either. If the pool is allocated later it can take much more time due to
>>>>> memory fragmentation.
>>>>>
>>>>> I definitely do not want to downplay this but I would like to hear about
>>>>> the real life examples of the problem.
>>>>
>>>> Indeed, 24s of delay (!) is not so harmful for boot time, but...64G was
>>>> just my simple test in a guest, the real case is much worse! It aligns
>>>> with Mike's comment, we have complains of minute-like delays, due to a
>>>> very big pool of hugepages being allocated.
>>>
>>> The cost of page clearing is mostly a constant overhead so it is quite
>>> natural to see the time scaling with the number of pages. That overhead
>>> has to happen at some point of time. Sure it is more visible when
>>> allocating during boot time resp. when doing pre-allocation during
>>> runtime. The page fault path would be then faster. The overhead just
>>> moves to a different place. So I am not sure this is really a strong
>>> argument to hold.
>>
>> We have people complaining that starting VMs backed by hugetlbfs takes
>> too long, they would much rather have that initialization be done when
>> booting the hypervisor ...
> 
> I can imagine. Everybody would love to have a free lunch ;) But more
> seriously, the overhead of the initialization is unavoidable. The memory
> has to be zeroed out by definition and somebody has to pay for that.
> Sure one can think of a deferred context to do that but this just
> spreads  the overhead out to the overall system overhead.
> 
> Even if the zeroying is done during the allocation time then it is the
> first user who can benefit from that. Any reuse of the hugetlb pool has
> to reinitialize again.

I remember a conversation with some of our database people who thought
it best for their model if hugetlb pages in the pool were already clear
so that no initialization was done at fault time.  Of course, this requires
clearing at page free time.  In their model, they thought it better to pay
the price at allocation (pool creation) time and free time so that faults
would be as fast as possible.

I wonder if the VMs backed by hugetlbfs pages would benefit from this
behavior as well?

If we track the initialized state (clean or not) of huge pages in the
pool as suggested in Michal's skeleton of a patch, we 'could' then allow
users to choose when hugetlb page clearing is done.

None of that would address the original point of this thread, the global
init_on_alloc parameter.
-- 
Mike Kravetz
