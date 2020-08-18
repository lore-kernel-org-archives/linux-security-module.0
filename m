Return-Path: <SRS0=wQ8B=B4=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FFC3C433E3
	for <linux-security-module@archiver.kernel.org>; Tue, 18 Aug 2020 15:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56D5E2245C
	for <linux-security-module@archiver.kernel.org>; Tue, 18 Aug 2020 15:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbgHRPyI (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 18 Aug 2020 11:54:08 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49103 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbgHRPyD (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 18 Aug 2020 11:54:03 -0400
Received: from ip5f5af70b.dynamic.kabel-deutschland.de ([95.90.247.11] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1k83vr-0003fb-1J; Tue, 18 Aug 2020 15:53:51 +0000
Date:   Tue, 18 Aug 2020 17:53:50 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     krzysztof.struczynski@huawei.com
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, zohar@linux.ibm.com,
        stefanb@linux.vnet.ibm.com, sunyuqiong1988@gmail.com,
        mkayaalp@cs.binghamton.edu, dmitry.kasatkin@gmail.com,
        serge@hallyn.com, jmorris@namei.org, christian@brauner.io,
        silviu.vlasceanu@huawei.com, roberto.sassu@huawei.com
Subject: Re: [RFC PATCH 00/30] ima: Introduce IMA namespace
Message-ID: <20200818155350.oy3axodt3vj5k7ij@wittgenstein>
References: <N>
 <20200818152037.11869-1-krzysztof.struczynski@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200818152037.11869-1-krzysztof.struczynski@huawei.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Aug 18, 2020 at 05:20:07PM +0200, krzysztof.struczynski@huawei.com wrote:
> From: Krzysztof Struczynski <krzysztof.struczynski@huawei.com>
> 
> IMA has not been designed to work with containers. It handles every
> process in the same way, and it cannot distinguish if a process belongs to
> a container or not.
> 
> Containers use namespaces to make it appear to the processes in the
> containers that they have their own isolated instance of the global
> resource. For IMA as well, it is desirable to let processes in the
> containers have IMA functionality independent from other containers:
> separate policy rules, measurement list, additional appraisal keys to
> verify the container image, separate audit logs.
> 
> As previous work done in this area, this patch series introduces the IMA
> namespace, which is a separate instance of IMA to handle a subset of
> processes that belong to a container.
> 
> The IMA namespace is created using clone3() or unshare() system calls. It
> is important to configure the namespace before any process appears in it,
> so that the new policy rules apply to the very first process in the
> namespace. To achieve that, the intermediate namespace ima_ns_for_children
> is used. It stores the configuration and becomes active on the next fork
> or when the first process enters it using the setns() system call. The
> similar process is used for the time namespace.
> 
> The IMA namespace can be configured using the new securityfs directory
> entries that allow the user to set the policy rules, x509 certificate for
> appraisal and pass IMA configuration parameters normally included in the
> kernel command line parameters. It is intended to extend the clone_args to
> allow configuration from clone3() syscall.

Not to be the downer right away but just as an fyi, if this patchset
makes it, clone3() will not allow to be extended with any real
second-level pointers. That will see a hard NAK from me and several
other maintainers.

Christian
