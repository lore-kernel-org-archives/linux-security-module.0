Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD2DC04A95
	for <linux-security-module@archiver.kernel.org>; Thu, 29 Sep 2022 08:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234864AbiI2INA (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 29 Sep 2022 04:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234950AbiI2IM6 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 29 Sep 2022 04:12:58 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48A0119193;
        Thu, 29 Sep 2022 01:12:57 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id E479C68BFE; Thu, 29 Sep 2022 10:12:53 +0200 (CEST)
Date:   Thu, 29 Sep 2022 10:12:53 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 03/29] fs: rename current get acl method
Message-ID: <20220929081253.GA3699@lst.de>
References: <20220928160843.382601-1-brauner@kernel.org> <20220928160843.382601-4-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928160843.382601-4-brauner@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Just wading throught the rest of the series - I think we should
also rename the get_acl() function to get_inode_acl() to match this.
