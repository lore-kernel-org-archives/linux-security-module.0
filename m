Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06784C072A2
	for <linux-security-module@archiver.kernel.org>; Wed, 15 Nov 2023 21:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344653AbjKOVEB (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 15 Nov 2023 16:04:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344830AbjKOVDj (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 15 Nov 2023 16:03:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917E726A4;
        Wed, 15 Nov 2023 13:03:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC40AC433C8;
        Wed, 15 Nov 2023 21:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700082199;
        bh=6iFkJ9CgOv8m2X+1Em1JMHhqIxyCZ6Qr3KSR13K3huM=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=dk4rDKxA0ItonubvGbIA6kOO4BQ/BxPKjEvuouQ3hBwft2YkQ1nM8EsubAujp6Rll
         VQaazriqth98JZ5XQk4K445Cepsy/FFEEQtYHDk8BHOyYDld+Td8jFeNHEVz/4ivWG
         G10fsUCTYPwf1EdKr2k8W3OJA0M2HQ3RcH0cK1eRdmk64soo+BxuEGzvc+y3rqtfc4
         hvOfAiGuGJp1BLqlUGtvB3lx3ayVs0StPc2jMLgduP9fgOPWv4pIZdjPnoat+PBRaa
         5x9z1UMoJaM3aG6Uz3G8Ne3GiYZWuMktXisQ00FWOK1UdPTvlb6+4swpdwJyRr6KSq
         GE5BnVtzL+Qpg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 15 Nov 2023 23:03:13 +0200
Message-Id: <CWZOU9WPLL2Y.30QYCUBCE0UQA@kernel.org>
Cc:     <linux-integrity@vger.kernel.org>, <keyrings@vger.kernel.org>,
        "James Bottomley" <James.Bottomley@hansenpartnership.com>,
        "William Roberts" <bill.c.roberts@gmail.com>,
        "Stefan Berger" <stefanb@linux.ibm.com>,
        "David Howells" <dhowells@redhat.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>,
        "Mimi Zohar" <zohar@linux.ibm.com>,
        "Peter Huewe" <peterhuewe@gmx.de>,
        "James Bottomley" <jejb@linux.ibm.com>,
        "Paul Moore" <paul@paul-moore.com>,
        "James Morris" <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Julien Gomes" <julien@arista.com>,
        "Mario Limonciello" <mario.limonciello@amd.com>,
        "open list" <linux-kernel@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v3 3/6] tpm: Detach tpm_buf_reset() from tpm_buf_init()
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Jerry Snitselaar" <jsnitsel@redhat.com>
X-Mailer: aerc 0.15.2
References: <20231024011531.442587-1-jarkko@kernel.org>
 <20231024011531.442587-4-jarkko@kernel.org>
 <xp2tdlw2qjg3pbazb3oye7poeh4r5neeqbsvamgiazdl2bouwa@qnxhvt7vzkpb>
In-Reply-To: <xp2tdlw2qjg3pbazb3oye7poeh4r5neeqbsvamgiazdl2bouwa@qnxhvt7vzkpb>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon Nov 6, 2023 at 9:31 PM EET, Jerry Snitselaar wrote:
> Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

Thanks.

BR, Jarkko
