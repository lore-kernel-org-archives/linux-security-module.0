Return-Path: <SRS0=p2Kc=SF=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C84FC10F0B
	for <linux-security-module@archiver.kernel.org>; Wed,  3 Apr 2019 13:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51CA52147C
	for <linux-security-module@archiver.kernel.org>; Wed,  3 Apr 2019 13:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="br3O5vKO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbfDCNQe (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 3 Apr 2019 09:16:34 -0400
Received: from usfb19pa12.eemsg.mail.mil ([214.24.26.83]:31870 "EHLO
        USFB19PA12.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbfDCNQe (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 3 Apr 2019 09:16:34 -0400
X-EEMSG-check-017: 268861643|USFB19PA12_EEMSG_MP8.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USFB19PA12.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 03 Apr 2019 13:16:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1554297391; x=1585833391;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=rba3VkU5pEO0rwXWn7+aLnzAw5rmdFbE3bMrtGC4ITc=;
  b=br3O5vKO7E4WMagmC0z/cFL9qgfGTL0XiXqbDXHQ/hZOSDpYv23iss+W
   AI6ELJgTpYXDHVYeHpGp4HMQIrTJm1XaN7lRMFozzkahV/GVcdFifFPEs
   aKE8xnaUW21eILXgCk3B5nOXRkzw0v5IzDCm9OPya83zWbjAb3qxLeKSW
   LVslkTOSoqR2WtUw+8aansdpYIdc8UdDCpoEFPVeuVv3j7lObLhkAGE+1
   T18OSkpUg8i6/pVqfT1WpGzGNVl+yNfoTX2ylHYGm5/qWfBQkONpzF+8i
   RPLKNnCsZwxpK5b1uaykzD+gRTGfezLI1j6W8f2HTKirhsxegvC4NhoLu
   Q==;
X-IronPort-AV: E=Sophos;i="5.60,304,1549929600"; 
   d="scan'208";a="25814778"
IronPort-PHdr: =?us-ascii?q?9a23=3A5UYVZB8Kp1mlX/9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B+1e0VIJqq85mqBkHD//Il1AaPAdyCraofwLGK++C4ACpcuM7H6ChDOLV3FD?=
 =?us-ascii?q?Y9wf0MmAIhBMPXQWbaF9XNKxIAIcJZSVV+9Gu6O0UGUOz3ZlnVv2HgpWVKQk?=
 =?us-ascii?q?a3OgV6PPn6FZDPhMqrye+y54fTYwJVjzahfL9+Nhq7oRjMusUMnYdvJKk9xx?=
 =?us-ascii?q?XGr3BVf+ha2X5kKUickhrh+su85oJv/zhVt/k868NOTKL2crgiQ7dFFjomKW?=
 =?us-ascii?q?c15MPqtRnHUwSC42YXX3sVnBRVHQXL9Qn2UZjtvCT0sOp9wzSaMtbtTb8oQz?=
 =?us-ascii?q?Si7rxkRwHuhSwaKjM26mDXish3jKJGvBKsogF0zoDIbI2JMvd1Y7jQds0GS2?=
 =?us-ascii?q?VfQslRVjRBAoKiYIsJE+oBJvtTo43kq1cTsReyGQygCeXhxT9Sgn/9wLM03e?=
 =?us-ascii?q?IvHwrb2AAsBtwDvXDRoNjzKawcU/26zLPQwDvecf1W1zfz5ovGfB8vrv6DX6?=
 =?us-ascii?q?5/f8XKxEkzFA7IlEmcpZDrMj6X0OkGrmiV7/BnVeKqk2Mpth1xrSa3xscslI?=
 =?us-ascii?q?bJgJ8exE3B9SpjxIY1IcO3SU5matOjC5tfqjqaOpBqQsIiX25ouCE6xqcAuZ?=
 =?us-ascii?q?6gZicG0psnxxnBa/GedYWD/xztVOGUIThihXJlfqqyhxmo8Ui71OLzStS00E?=
 =?us-ascii?q?xLripZktjArHYN2ALP6sWBV/Bz/V+h1C6S2w3c5exIO0A5mbfBJ5I/zbM8iI?=
 =?us-ascii?q?AfvVnFEyTrgkv5lrWWeV8h+uWw7uTnZajpqYGEOo9vjwH+LrwumsuiAeQkKg?=
 =?us-ascii?q?QOX3aU+eC71LD74U32Wq9KjvwrkqnCqpzaOcQaqbK5Aw9SyIoj7QqwDyy639?=
 =?us-ascii?q?gCmHkHLVZFdAqGj4jvJV7OPOj1Aeqwjlmjijtmx+3KMqf/DpjCMHTPiqrtca?=
 =?us-ascii?q?5460FGyQozyd5f54hTCrEEOP/zQVL+tMfDAx8lMw273+bnCNJn2oMYQmKAGL?=
 =?us-ascii?q?WVMKzVsV+W/u4vOfWDZJcJuDbhLPgo///vjXg5mVAHZ6mkxp8XaHG+HvR7LE?=
 =?us-ascii?q?SVe3vsjcwEEWsQogU+S+nqgkWYUTFPf3ayQ7485jYjBYKnF4vCR4Ctj6eb0y?=
 =?us-ascii?q?e9GZ1WeHtLCleJEXfwbYWERuwMaDmTIsB7iDAET6WhQZc71R6yrA/616ZnLu?=
 =?us-ascii?q?3M9y0dt5Lj29h46unImBE98jx0CMud02WTQG1ugmwIQDo21rhloUNh0leDzb?=
 =?us-ascii?q?R4g/tAGNxQ+fxGTBw6OoLbz+x9CND/QR7OfteTSFahR9WmACwxTtcrz98JeU?=
 =?us-ascii?q?Z9FM2ojgrf0CqyH78Vi7uLCYQo/a3GxHj+OcZ8xm3d1KY9j1kpWNZPNWOihq?=
 =?us-ascii?q?Fh7QjfHpLGnF+Dm6m2cqQc2TbH9H2fwmqWoEFYTAlwXL3dXX8Fe0vWqc/05l?=
 =?us-ascii?q?vYQL+zDbQrKw5BycmFKqtQdNLll0lJRPDmON7GeWK+h3+wBQqUxrOLdIfqeW?=
 =?us-ascii?q?Id3CXbCEQekQAT+naGOhI4Bie6vW3eCidjGk71bEPq9ul+rnK7QVMuwAGOdU?=
 =?us-ascii?q?Fuy721+hsNj/yGV/wTxq4EuDsmqzhsGFa93tTWC8ePpgZ4faVcZ88970lI1W?=
 =?us-ascii?q?LDtgx9IpyhIrt8hl4RbQt3pVni1xZpBYVal8glsncqwBB1KaKC31NLbymY0o?=
 =?us-ascii?q?zoOr3LNmny+wiia6zM1VHY1taW+rwC6Ps/q1XkswGpElQt/2973NlS1nuW/o?=
 =?us-ascii?q?/KAxYKUZLtTkY38AB3p7XbYik7+oPV2mRgMbKqvTDextIpHuolygqgfttGNa?=
 =?us-ascii?q?OEExL9E9AeB8ewM+EqhVepYQwePOxI9647Idmmd/2Y166vJupgmyimjWsUqL?=
 =?us-ascii?q?x6h2eN8is0eOnI1oxNl+Of3gKdfzP9ikqx9MH9nMZPYjREWiKexi/+TLxRbK?=
 =?us-ascii?q?R0ephDXWboMc29z9N5mbbqXmZC6UW4BlpAwtL/PVK3ZkDh3QBPnWseu2aqhT?=
 =?us-ascii?q?fwmzl2nGx4hqWY2yPKzqLpcx9RfiZoSWR5xXzrJov829MXUVOjaA8qvBCl/0?=
 =?us-ascii?q?H/xrVe4qNlID+XCWxBZCXnZ1ppUqKtuL6PeYYb45ozvDR/S++8aE2UTrPn5h?=
 =?us-ascii?q?ATlSjkGj0ajAgyajXin5L+hREy3HqUMXJbtHPEfYR1whDF6ZrXQvsHmnIkQy?=
 =?us-ascii?q?l+wRvQBlG6JNSvtYGWkJfF9OK5V2unTZBVWSLiy4SGtSCy4SthBhjpzN6pnd?=
 =?us-ascii?q?iyKhQ3yS/20ZFRUCzMqBvtKt3w27+SLfNsfk4uAkT1rcV9BNctwcMLmJgM1C?=
 =?us-ascii?q?1C1d2u9n0dnDK2aI4K1A=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2BGAADBsaRc/wHyM5BlGwEBAQEDAQEBBwMBAQGBUwQBA?=
 =?us-ascii?q?QELAYFmKmiBAyeEDpM1TAEBAQEBAQaBNYlGjnmBezMIAYRAAoVEIjYHDQEBA?=
 =?us-ascii?q?wEBAQgBAwIBbBwMgjopAYJnAQUjBAsBBTYLEAsYAgImAgJXBgEMCAEBgl8/A?=
 =?us-ascii?q?YFoDQ+rbhqBJnwzhAUBP0FAhF8FgQskAYhogkoXeIEHgTiCaz6HToJXA6VjC?=
 =?us-ascii?q?Yd+i3QGGoIFiWyGU4ICLYsehhqPSgUsgVYrCAIYCCEPO4JsilGFQwFSIwMwA?=
 =?us-ascii?q?Qt5AQGPOAEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 03 Apr 2019 13:16:28 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x33DGPsA003577;
        Wed, 3 Apr 2019 09:16:25 -0400
Subject: Re: Should mprotect(..., PROT_EXEC) be checked by IMA?
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Igor Zhbanov <i.zhbanov@omprussia.ru>,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Paul Moore <paul@paul-moore.com>,
        John Johansen <john.johansen@canonical.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        linux-security-module <linux-security-module@vger.kernel.org>
References: <cce2c4c7-5333-41c3-aeef-34d43e63acb0@omprussia.ru>
 <1552945715.8658.299.camel@linux.ibm.com>
 <452752df-98f9-c361-878a-5df84ab36847@omprussia.ru>
 <1552994559.4899.26.camel@linux.ibm.com>
 <84145490-6f70-214f-8241-42d556590240@omprussia.ru>
 <1553015134.4899.82.camel@linux.ibm.com>
 <a9830bde-8157-6078-b544-fcffb20d2501@omprussia.ru>
 <CACdnJut6YfLnq-nCC1hHTrKYXabHoSEXN1wMuCyVybU+o_iwCg@mail.gmail.com>
 <1553167318.4899.382.camel@linux.ibm.com>
 <dab923ca-ef53-4af2-034a-bea4151a4e25@omprussia.ru>
 <CACdnJuvVqibDdd+MLKOHqEfdngTk=GSkfybj1jS3MpmC7rjyHg@mail.gmail.com>
 <07347317-ee71-83c1-384a-0c3439980af7@omprussia.ru>
 <1553793463.8711.26.camel@linux.ibm.com>
 <92718382-8669-748f-10d8-02fa21225210@omprussia.ru>
 <1553857187.9420.49.camel@linux.ibm.com>
 <b5a89692-4c93-80b3-37e5-41265765cdc3@tycho.nsa.gov>
 <cb46d5ba-30de-664f-67d4-646da4592a6f@omprussia.ru>
 <1554292678.7309.47.camel@linux.ibm.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <648f1a64-e95d-d929-62dc-06decaf5a14b@tycho.nsa.gov>
Date:   Wed, 3 Apr 2019 09:10:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <1554292678.7309.47.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 4/3/19 7:57 AM, Mimi Zohar wrote:
> On Fri, 2019-03-29 at 15:50 +0300, Igor Zhbanov wrote:
>> On 29.03.2019 15:28, Stephen Smalley wrote:
>>> On 3/29/19 6:59 AM, Mimi Zohar wrote:
>>>> [Cc'ing the LSM mailing list and others]
>>>>
>>>> On Fri, 2019-03-29 at 13:00 +0300, Igor Zhbanov wrote:
>>>>> Hi Mimi,On 28.03.2019 20:17, Mimi Zohar wrote:
>>>>
>>>>>> I just came across the grsecurity article on mprotect.[1]
>>>>>>    Has anyone looked at it? Would it make sense to make it a minor LSM?
>>>>>>
>>>>>> [1]https://pax.grsecurity.net/docs/mprotect.txt
>>>>>
>>>>> Interesting article. It is almost exactly of what I wanted to be
>>>>> implemented.
>>>>>
>>>>> If this minor LSM would be stackable to allow combining with e.g. SELinux
>>>>> then why not.
>>>>
>>>> Stacking shouldn't be a problem.  Other LSMs are already on the
>>>> mprotect hook.  Let's hear what others think.
>>>
>>> SELinux already provides a set of controls over executable mappings;
>>> see selinux_mmap_file and selinux_file_mprotect. Other major security
>>> modules may do likewise but I can't speak to that. Is there some gap
>>> you are trying to address that isn't already covered, or are you just
>>> trying to provide such restrictions without requiring one of the
>>> major modules?
>>
>> I want to be sure that no unsigned code page could be executed. So exploits
>> could only be of ROP kind and not being able to download any extra code
>> from their servers. That's why I found that disabling of anonymous executable
>> pages could be useful for that (as well as disabling of making executable
>> pages writable to modify already mapped code). In conjunction with IMA it
>> should guarantee that no untrusted code could be executed.
> 
> Let's separate the different types of attacks.  From an IMA
> perspective, memory attacks are out of scope.  That leaves mmap'ed
> files, possibly just mmap'ed shared files.  Currently IMA can be
> configured to verify a file's integrity, based on signatures, being
> mmap'ed execute.  Assuming that not all files opened require a file
> signature, a file could be mmap'ed read/write and later changed to
> execute to circumvent the mmap'ed execute signature requirement.  If
> the existing LSMs are able to prevent this sort of attack, we could
> just document this requirement.

I guess I don't understand why IMA isn't already being called from 
security_file_mprotect(). security_file_mprotect() could just call 
ima_file_mmap(vma->vm_file, prot) if all of the security hooks pass.

SELinux can be used to prevent unauthorized mprotect PROT_EXEC but it 
won't perform a measurement of the file if it is allowed by policy.
