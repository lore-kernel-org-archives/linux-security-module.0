Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3826C25B08
	for <linux-security-module@archiver.kernel.org>; Sat, 20 Aug 2022 18:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiHTSKm (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 20 Aug 2022 14:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiHTSKl (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 20 Aug 2022 14:10:41 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD363F338;
        Sat, 20 Aug 2022 11:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=UCEL7pAe29ST7v5wLOwqf+kjBdiXLKyV4Iu1lfQptWU=; b=OcWSDB4nYGvNO+WR9QnNIG04jb
        pHpYtVk37phwELYI5oghFtwW4GAwaAR57o9LAuxguhmIvQXfsVf2Utjd8qKfx3xNneV2XO+LFJJ4W
        oa1slhPwyFPd7CniFRgY1JjuwO09ZSX5aG7QhaILFKhs362Qf3zn5KJ2yp+YFbAJ92OIEmfCE5mGS
        JMT7cVmymMwBi13oFPQwM1IjXITTQT/1FP3fHgC8qmaxdzAGeTGv2HDznXW9aMiIg1PgoLFauoT+k
        MPPvkU2ocUcaATZeyxjjNp+M4gR5s27OEszGbzBwxgTg0rsJAcgm1cmN9Qyf6bEmaLanZLTfRhR4b
        +xpgHgfg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oPSve-006RT5-Uf;
        Sat, 20 Aug 2022 18:10:39 +0000
Date:   Sat, 20 Aug 2022 19:10:38 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org
Subject: [PATCHES] struct path constification
Message-ID: <YwEjnoTgi7K6iijN@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

	This is mostly whack-a-mole stuff - a bunch of places
are passing struct path pointers around, without bothering
to mark them const, even though they are not going to try
and modify the contents of struct path.

	It's a bad practice, since there are invariants along
the lines of "file->f_path stays unchanged open-to-release"
and verifying those can get very unpleasant when you are
forced to take detours down the long call chains that could've
been avoided.

	Patches in that pile are independent from each other
and if anyone wants to grab some of them into subsystem's
tree - just say so; I'll be happy to exclude those from the
vfs.git branch if they go into another tree.

	Currently they are in vfs.git#work.path; individual
patches in followups.
