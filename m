Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC0EEC07E9D
	for <linux-security-module@archiver.kernel.org>; Thu, 29 Sep 2022 07:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234300AbiI2H5Q (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 29 Sep 2022 03:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234848AbiI2H5N (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 29 Sep 2022 03:57:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2EB913A977;
        Thu, 29 Sep 2022 00:57:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4BF2FB82397;
        Thu, 29 Sep 2022 07:57:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86519C433C1;
        Thu, 29 Sep 2022 07:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664438230;
        bh=j2pxJdoysyL6hCxYN9WCuufsuJoj7N+jOwsUTsjDzKo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cQJ3q8oRzRJIQgGSi3NQ9/l2ftI/F52yI1ZvF9ck52Tt7sa6aOIvPaQ2JikCBgkNH
         oX0lAr1lcxjtycSIaB+Qvj9A5b/941BiIbNRG//WU1MsbL43rUmw2MIqkJcpx7vfdq
         UT85eyJVlMAMdNTf6EK9CxG4PJk3qDNWE46x4URFxlAkfjUKCOHOZSdfSsm2ZnLdVH
         53L8fBhY4phzRW2O3e0Z5ODjcvXC2QUzsFNj+Qrx7ZDivZskJ3byxwIiThDiFIBpCo
         oFZ9xHCCAa4Cz9fUtY6cv3HXT8x9awmIFdTIAdrpBndBnsz9VQj578+Uq/n7OMdE+f
         4QOmwNDqM8zcA==
Date:   Thu, 29 Sep 2022 09:57:05 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 02/29] fs: pass dentry to set acl method
Message-ID: <20220929075705.ajxs5ltdpryjcrts@wittgenstein>
References: <20220928160843.382601-1-brauner@kernel.org>
 <20220928160843.382601-3-brauner@kernel.org>
 <20220929075153.GB3097@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220929075153.GB3097@lst.de>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Sep 29, 2022 at 09:51:53AM +0200, Christoph Hellwig wrote:
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> (except that as usual I'd prefer to not add externs on any new
> or changed prototype.  But I'm not going to repeat that for every
> patch)

I'll remove the "extern" keyword in my tree. I have the habit of just
following the header file...
