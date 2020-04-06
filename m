Return-Path: <SRS0=ULH2=5W=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58350C2BA1E
	for <linux-security-module@archiver.kernel.org>; Mon,  6 Apr 2020 12:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BB1220801
	for <linux-security-module@archiver.kernel.org>; Mon,  6 Apr 2020 12:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.ch header.i=@protonmail.ch header.b="o8wQl2YY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbgDFMCf (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 6 Apr 2020 08:02:35 -0400
Received: from mail-40130.protonmail.ch ([185.70.40.130]:25187 "EHLO
        mail-40130.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgDFMCf (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 6 Apr 2020 08:02:35 -0400
Date:   Mon, 06 Apr 2020 12:02:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
        s=default; t=1586174552;
        bh=5WZ5+FLUh3mc2UsRwK/MWjgcY03tO2vIuA2n/70q2tk=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=o8wQl2YYnR8Gw0Lm3uYAL71gdAmvUeBjqXXf/X9DJmgauW1cM3LknS3QI1/qJ0VN3
         BxRzfZFTAy99T2RAGySkh2+Z1qkDndj9u6bfnOobcE5bZ/cFaGO4lwjKZMPE+VbBT/
         fPHQBjYCIRIgn1x9P2tqmozf7xIxOIssD8dWTSwg=
To:     LSM List <linux-security-module@vger.kernel.org>
From:   Jordan Glover <Golden_Miller83@protonmail.ch>
Cc:     "SMACK-discuss@lists.01.org" <SMACK-discuss@lists.01.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Reply-To: Jordan Glover <Golden_Miller83@protonmail.ch>
Subject: =?UTF-8?Q?[SMACK]_Build-time_warning_from_Linux_5.6.2:_unused_variable_?=
 =?UTF-8?Q?=E2=80=98sip=E2=80=99?=
Message-ID: <lTqravVBK9-oBbja6fvn3DqA3lv42gF_wg4Q9fC0FhfG1DbinZb4oKl7JV_meJYykJtkvN2gXhy-bCAgIlRglRT2z-oQ6wFF6aPx2vo-ZAs=@protonmail.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello, during build of Linux 5.6.2 (also happened on 5.5.x series)
gcc (9.3) prints following warning:

security/smack/smack_lsm.c: In function =E2=80=98smack_socket_connect=
=E2=80=99:
security/smack/smack_lsm.c:2838:24: warning: unused variable =E2=80=98sip=
=E2=80=99 [-Wunused-variable]
 2838 |   struct sockaddr_in6 *sip =3D (struct sockaddr_in6 *)sap;

My kernel has set CONFIG_IPV6=3Dn during build.

Jordan





