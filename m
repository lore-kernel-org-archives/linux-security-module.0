Return-Path: <SRS0=gDDV=6W=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55CFDC38A2A
	for <linux-security-module@archiver.kernel.org>; Fri,  8 May 2020 09:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E3DE208CA
	for <linux-security-module@archiver.kernel.org>; Fri,  8 May 2020 09:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RmPbrrz6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbgEHJW1 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 8 May 2020 05:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbgEHJWZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 8 May 2020 05:22:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0C8C05BD43;
        Fri,  8 May 2020 02:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=AKGiii+IEqZ9gOggsApEG4tziI6/WJ3l0tT79BlKIwg=; b=RmPbrrz6Kk0e6owaqjS+q2eHbU
        G5BKQrZTgzS+1A3FFzmk3b7wy4DTLWkQd8a7NAuzT8d8t14rR1vTvys767YOwnPVrGwqgrtuE+vyX
        YaxjCyrnZtyyrQ1/6nJ8rhvBdFhERzYQjcrxS0L0bx8HWNmofhBq5k6fjzMIL78fTlIAejMv8n9vW
        HNWb1r/s9cojIFQwCUsY6eONwjWH0xupnhlBHcOdOzRL4cvHlagNARHeQ2qr+9IYpnKc8kgThYFXO
        1u4Mym4f3mrlfPIReyhTB4vp3yD8s4Tj3iC8R84YnlaKZFTivOFjQbyPOH6doWYfEp/V7qE3w8GNu
        YpFgMDdA==;
Received: from [2001:4bb8:180:9d3f:90d7:9df8:7cd:3504] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWzD6-0008IN-P0; Fri, 08 May 2020 09:22:25 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: clean up kernel_{read,write} & friends
Date:   Fri,  8 May 2020 11:22:11 +0200
Message-Id: <20200508092222.2097-1-hch@lst.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Al,

this series fixes a few issues and cleans up the helpers that read from
or write to kernel space buffers, and ensures that we don't change the
address limit if we are using the ->read_iter and ->write_iter methods
that don't need the changed address limit.
