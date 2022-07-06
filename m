Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF58CCCA473
	for <linux-security-module@archiver.kernel.org>; Wed,  6 Jul 2022 19:15:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233471AbiGFTPJ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 6 Jul 2022 15:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233872AbiGFTPI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 6 Jul 2022 15:15:08 -0400
Received: from mail.namei.org (namei.org [65.99.196.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A490024956
        for <linux-security-module@vger.kernel.org>; Wed,  6 Jul 2022 12:15:07 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.namei.org (Postfix) with ESMTPS id A5D632A7
        for <linux-security-module@vger.kernel.org>; Wed,  6 Jul 2022 18:56:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.namei.org A5D632A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=namei.org; s=2;
        t=1657133791; bh=G9MqzLuX5918a4N/2lOhLaJCQN4CebpnTdB8X6D+dVs=;
        h=Date:From:To:Subject:From;
        b=aPbRyB5eZYDKTVS5H4xVA5KKoaQbQRFJNEo5WDfeVxOnHB2RQETrFEMF697JQCGro
         x3HCL4epgI5VXCfJDSnNNBdcpQXLCWY1QiXWfY67MnYXiCX2LVx6aDQ1nVP57C6CiV
         yC58enMbO6964z7jVK1WjgU1TLdqg4cA5Fn5Kcuc=
Date:   Thu, 7 Jul 2022 04:56:31 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     linux-security-module@vger.kernel.org
Subject: Maintainer update
Message-ID: <c513dcdb-17f9-377a-1329-2b8fee8dc28c@namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Folks,

I'm now a manager and don't get as much time to focus directly on 
development work.

I'd like to propose that we add Paul Moore as a maintainer of the Security 
Subsystem, and for him to take the lead on that, in addition to his 
SELinux and other maintainer work.

With LSMs pushing directly to Linus, this maintainer role is now mostly 
about merging new LSMs and major LSM changes, and integrating bugfixes.

Paul has been taking many LSM bugfixes through his SELinux tree for a 
while, so this would be somewhat a formalization of things there. In terms 
of new LSMs and major changes, this is and will remain a collaborative 
process with the LSM community.


Any thoughts, concerns, objections?


-- 
James Morris
<jmorris@namei.org>

